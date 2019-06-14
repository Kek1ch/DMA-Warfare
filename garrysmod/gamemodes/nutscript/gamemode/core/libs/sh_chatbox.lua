nut.chat = nut.chat or {}
nut.chat.classes = nut.char.classes or {}

local DUMMY_COMMAND = {syntax = "<string text>", onRun = function() end}

if (!nut.command) then
	include("sh_command.lua")
end

function nut.chat.register(chatType, data)
	if (!data.onCanHear) then
		data.onCanHear = function(speaker, listener)
			return true
		end
	elseif (type(data.onCanHear) == "number") then
		local range = data.onCanHear ^ 2

		data.onCanHear = function(speaker, listener)
			return (speaker:GetPos() - listener:GetPos()):Length2DSqr() <= range
		end
	end

	if (!data.onCanSay) then
		data.onCanSay = function(speaker, text)
			if (!data.deadCanChat and !speaker:Alive()) then
				speaker:notifyLocalized("noPerm")

				return false
			end

			return true
		end
	end
	
	if (!data.onChatAdd) then
		data.format = data.format or "%s: \"%s\""
		data.onChatAdd = function(speaker, text, anonymous)
			local name = anonymous and "Неизвестного" or hook.Run("GetDisplayedName", speaker, chatType) or (IsValid(speaker) and speaker:Name() or "Console")
			local format = "%X"
			local date = os.date(format, nut.date.get())

			--local limit = 70
			--local description = speaker:getChar():getDesc()
			--description = ((#description > limit and description:sub(1, limit - 3)..'...') or description)

			--chat.AddText(Color(255, 255, 255), date, Color(192, 192, 192), " Сообщение от ", Color(255, 186, 0), name, Color(192, 192, 192), " ("..description..")", color_white, ": "..text)
			chat.AddText(Color(255, 255, 255), date, Color(192, 192, 192), " Сообщение от ", Color(255, 186, 0), name, color_white, ": "..text)
		end
	end

	if (CLIENT) then
		if (type(data.prefix) == "table") then
			for k, v in ipairs(data.prefix) do
				if (v:sub(1, 1) == "/") then
					nut.command.add(v:sub(2), DUMMY_COMMAND)
				end
			end
		else
			nut.command.add(chatType, DUMMY_COMMAND)
		end
	end

	data.filter = data.filter or "ic"

	nut.chat.classes[chatType] = data
end

function nut.chat.parse(client, message, noSend)
	local anonymous = false
	local chatType = "ic"

	if (message:sub(1, 1) == "?" and message:sub(2):find("%S")) then
		anonymous = true
		message = message:sub(2)
	end

	for k, v in pairs(nut.chat.classes) do
		local isChosen = false
		local chosenPrefix = ""
		local noSpaceAfter = v.noSpaceAfter

		if (type(v.prefix) == "table") then
			for _, prefix in ipairs(v.prefix) do
				if (message:sub(1, #prefix + (noSpaceAfter and 0 or 1)):lower() == prefix..(noSpaceAfter and "" or " "):lower()) then
					isChosen = true
					chosenPrefix = prefix..(v.noSpaceAfter and "" or " ")

					break
				end
			end

		elseif (type(v.prefix) == "string") then
			isChosen = message:sub(1, #v.prefix + (noSpaceAfter and 1 or 0)):lower() == v.prefix..(noSpaceAfter and "" or " "):lower()
			chosenPrefix = v.prefix..(v.noSpaceAfter and "" or " ")
		end

		if (isChosen) then
			chatType = k
			message = message:sub(#chosenPrefix + 1)

			if (nut.chat.classes[k].noSpaceAfter and message:sub(1, 1):match("%s")) then
				message = message:sub(2)
			end	

			break
		end
	end

	if (!message:find("%S")) then
		return
	end
	
	if (SERVER and !noSend) then
		nut.chat.send(client, chatType, hook.Run("PlayerMessageSend", client, chatType, message, anonymous) or message, anonymous)
	end

	return chatType, message, anonymous
end

if (SERVER) then
	function nut.chat.send(speaker, chatType, text, anonymous, receivers)
		local class = nut.chat.classes[chatType]

		if (class and class.onCanSay(speaker, text) != false) then
			if (class.onCanHear and !receivers) then
				receivers = {}

				for k, v in ipairs(player.GetAll()) do
					if (v:getChar() and class.onCanHear(speaker, v) != false) then
						receivers[#receivers + 1] = v
					end
				end

				if (#receivers == 0) then
					return
				end
			end

			netstream.Start(receivers, "cMsg", speaker, chatType, hook.Run("PlayerMessageSend", speaker, chatType, text, anonymous, receivers) or text, anonymous)
		end
	end
else

	netstream.Hook("cMsg", function(client, chatType, text, anonymous)
		if (IsValid(client)) then
			local class = nut.chat.classes[chatType]
			text = hook.Run("OnChatReceived", client, chatType, text, anonymous) or text

			if (class) then
				CHAT_CLASS = class
					class.onChatAdd(client, text, anonymous)
				CHAT_CLASS = nil
			end
		end
	end)
end

do
	hook.Add("InitializedConfig", "nutChatTypes", function()
		nut.chat.register("ic", {
			format = "%s says \"%s\"",
			onGetColor = function(speaker, text)
				if (LocalPlayer():GetEyeTrace().Entity == speaker) then
					return nut.config.get("chatListenColor")
				end

				return nut.config.get("chatColor")
			end,
			onCanHear = nut.config.get("chatRange", 280)
		})

		nut.chat.register("me", {
			format = "**%s %s",
			onGetColor = nut.chat.classes.ic.onGetColor,
			onCanHear = nut.config.get("chatRange", 280),
			prefix = {"/me", "/action"},
			font = "nutChatFontItalics",
			filter = "actions",
			deadCanChat = true
		})

		nut.chat.register("it", {
			onChatAdd = function(speaker, text)
				chat.AddText(nut.config.get("chatColor"), "**"..text)
			end,
			onCanHear = nut.config.get("chatRange", 280),
			prefix = {"/it"},
			font = "nutChatFontItalics",
			filter = "actions",
			deadCanChat = true
		})

		nut.chat.register("w", {
			format = "%s whispers \"%s\"",
			onGetColor = function(speaker, text)
				local color = nut.chat.classes.ic.onGetColor(speaker, text)

				return Color(color.r - 35, color.g - 35, color.b - 35)
			end,
			onCanHear = nut.config.get("chatRange", 280) * 0.25,
			prefix = {"/w", "/whisper"}
		})

		nut.chat.register("y", {
			format = "%s yells \"%s\"",
			onGetColor = function(speaker, text)
				local color = nut.chat.classes.ic.onGetColor(speaker, text)

				return Color(color.r + 35, color.g + 35, color.b + 35)
			end,
			onCanHear = nut.config.get("chatRange", 280) * 2,
			prefix = {"/y", "/yell"}
		})

		nut.chat.register("ooc", {
			onCanSay =  function(speaker, text)
				local delay = nut.config.get("oocDelay", 10)

				if (delay > 0 and speaker.nutLastOOC) then
					local lastOOC = CurTime() - speaker.nutLastOOC

					if (lastOOC <= delay) then
						speaker:notifyLocalized("oocDelay", delay - math.ceil(lastOOC))

						return false
					end
				end

				speaker.nutLastOOC = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X"
				local date = os.date(format, nut.date.get())
				chat.AddText(Color(192, 192, 192), "", date.." Глобальный НОН-РП чат. ", Color(255, 140, 0), speaker:Name(), Color(255, 255, 255), ": "..text)
			end,
			
			prefix = {"//", "/ooc"},
			noSpaceAfter = true,
			filter = "ooc"
		})
		
		nut.chat.register("pda", {
			onCanSay = function(speaker, text)
		        local character = speaker:getChar()

		        if character:getInv():hasItem("pda") then
		            return true
		        end

		        speaker:notify("У вас нет ПДА, для возможности отправлять сообщения в этот канал")
		        return false
		    end,
			onCanHear = function(speaker, listener)
		        local speakCharacter = speaker:getChar()
		        local listenCharacter = listener:getChar()
		        return listenCharacter:getInv():hasItem("pda")
		    end,
			onChatAdd = function(speaker, text)
				local format = "%X"
				local date = os.date(format, nut.date.get())
				chat.AddText(Color(255, 255, 255), "", date.." Общий канал. ", Color(255, 140, 0), Color(255, 140, 0), speaker:getChar():getName(), Color(255, 255, 255), ": "..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_news.ogg") end
			end,
			
			prefix = {"/pda"},
			noSpaceAfter = true,
			filter = "pda"
		})

		nut.chat.register("anon",
		{
		    onCanSay = function(speaker, text)
		        local character = speaker:getChar()

		        if character:getInv():hasItem("pda") then
		            return true
		        end

		        speaker:notify("У вас нет ПДА, для возможности отправлять сообщения в этот канал")

		        return false
		    end,

		    onCanHear = function(speaker, listener)
		        local speakCharacter = speaker:getChar()
		        local listenCharacter = listener:getChar()
		        return listenCharacter:getInv():hasItem("pda")
		    end,

		    onChatAdd = function(speaker, text)
		        local format = "%X"
		        local date = os.date(format, nut.date.get())
		        chat.AddText(Color(255, 255, 255), "", date.." Общий канал.", color_white, " Анонимно", Color(255, 255, 255), ": "..text)
		        for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_news.ogg") end
		    end,

		    prefix = {"/anon"},
		    noSpaceAfter = true,
		    filter = "anon"
		})

		nut.chat.register("dead", {
			onCanSay =  function(speaker, text)
				local delay = nut.config.get("deadDelay", 1)

				if (delay > 0 and speaker.nutLastDEAD) then
					local lastDEAD = CurTime() - speaker.nutLastDEAD

					if (lastDEAD <= delay) then
						speaker:notifyLocalized("deadDelay", delay - math.ceil(lastDEAD))

						return false
					end
				end

				speaker.nutLastDEAD = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(Color(192, 192, 192), "",date.." ", "Погиб сталкер: ", Color(255, 255, 255),""..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda_tip.mp3") end 
			end,
			prefix = {"/zdead", "/zdead1"},
			noSpaceAfter = true,
			deadCanChat = true
		})

		nut.chat.register("looc", {
			onCanSay =  function(speaker, text)
				local delay = nut.config.get("loocDelay", 0)

				if (delay > 0 and speaker.nutLastLOOC) then
					local lastLOOC = CurTime() - speaker.nutLastLOOC

					if (lastLOOC <= delay) then
						speaker:notifyLocalized("loocDelay", delay - math.ceil(lastLOOC))

						return false
					end
				end

				speaker.nutLastLOOC = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X"
		        local date = os.date(format, nut.date.get())
				chat.AddText(Color(255, 255, 255), date, Color(192, 192, 192), " Локальный НОН-РП чат. ", Color(255, 140, 0), speaker:Name(), Color(255, 255, 255), ": "..text)
			end,
			onCanHear = nut.config.get("chatRange", 280),
			prefix = {".//", "[[", "/looc"},
			noSpaceAfter = true,
			filter = "ooc"
		})
		
		nut.chat.register("takemoney", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
			
				chat.AddText(Color(192, 192, 192), "", " Денег получено: ", color_white, ""..text)
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/ztakemoney"},
			noSpaceAfter = true
		})
		
		nut.chat.register("lostmoney", {
			onCanSay =  function(speaker, text)
			if (speaker:Team() == FACTION_LONER) then	
			return false 
			end 
				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				chat.AddText(Color(192, 192, 192), "", " Денег потеряно: ", color_white, ""..text)
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zlostmoney"},
			noSpaceAfter = true
		})
		
		nut.chat.register("charconnect", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get())
				chat.AddText(color_white, date, Color(192, 192, 192), " Сообщение: Идет подключение, подождите... ", Color(255, 140, 0), speaker:Name(), Color(192, 192, 192), ""..text)
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zcharconnect"},
			noSpaceAfter = true
		})
		
		nut.chat.register("lostmoney", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				chat.AddText(Color(192, 192, 192), "", " Денег потеряно: ", color_white, ""..text)
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zlostmoney"},
			noSpaceAfter = true
		})
		
		nut.chat.register("lostitem", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				chat.AddText(Color(192, 192, 192), "", " Предмет потерян: ", color_white, ""..text)
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zlostitem"},
			noSpaceAfter = true
		})
		
		nut.chat.register("takeitem", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				chat.AddText(Color(192, 192, 192), "", " Предмет получен: ", color_white, ""..text)		
				for k, v in pairs(player.GetAll()) do v:EmitSound("interface/inv_take_7.ogg") end 
			end, 
			
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/ztakeitem"},
			noSpaceAfter = true
		})
		
		nut.chat.register("uprank", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(color_white, date, Color(192, 192, 192), "", " Сообщение: ", color_white, " Ранг повышен"..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zupnewrank"},
			noSpaceAfter = true
		})
		
		nut.chat.register("checkrep", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(color_white, date, Color(192, 192, 192), "", " Сообщение: ", color_white, "Ваша репутация "..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zchecknewrep"},
			noSpaceAfter = true
		})
		
		nut.chat.register("checkrank", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(color_white, date, Color(192, 192, 192), "", " Сообщение: ", color_white, "Ваш ранг "..text,"                                                                                                                                 ")
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zchecrank"},
			noSpaceAfter = true
		})
		
		nut.chat.register("downrep", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local date = os.date(format, nut.date.get()) 
				chat.AddText(color_white, date, Color(192, 192, 192), "", " Изменение репутации: ", color_white, "Ваша репутация теперь "..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zdwonnewrep"},
			noSpaceAfter = true
		})
		
		nut.chat.register("gunquest", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(color_white, " Новое задание: ", color_white, ""..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zgunquest"},
			noSpaceAfter = true
		})
		
		nut.chat.register("gunquestc", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(color_white, " Задание выполнено: ", color_white, ""..text)
			for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zgunquestc"},
			noSpaceAfter = true
		})
		
		nut.chat.register("toolquest", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(color_white, " Новое задание: ", color_white, ""..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/ztoolquest"},
			noSpaceAfter = true
		})
		
		nut.chat.register("toolquestc", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(color_white, " Задание выполнено: ", color_white, ""..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/ztoolquestc"},
			noSpaceAfter = true
		})
		
		nut.chat.register("artquest", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(color_white, " Новое задание: ", color_white, ""..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zartquest"},
			noSpaceAfter = true
		})
		
		nut.chat.register("artquestc", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(color_white, " Задание выполнено: ", color_white, ""..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zartquestc"},
			noSpaceAfter = true
		})
		
		nut.chat.register("mutquest", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(color_white, " Новое задание: ", color_white, ""..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zmutquest"},
			noSpaceAfter = true
		})
		
		nut.chat.register("mutquestc", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(color_white, " Задание выполнено: ", color_white, ""..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zmutquestc"},
			noSpaceAfter = true
		})
		
		nut.chat.register("armorquest", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(color_white, " Новое задание: ", color_white, ""..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zarmorquest"},
			noSpaceAfter = true
		})
		
		nut.chat.register("armorquestc", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(color_white, " Задание выполнено: ", color_white, ""..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zarmorquestc"},
			noSpaceAfter = true
		})
		
		nut.chat.register("docquest", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(color_white, " Новое задание: ", color_white, ""..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zdocquest"},
			noSpaceAfter = true
		})

		nut.chat.register("docquest", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText( color_white, date, Color(169, 169, 169), " Исполнитель желаний: ", color_white, text)
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zispjel"},
			noSpaceAfter = true
		})
		
		nut.chat.register("docquestc", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText( color_white, " Задание выполнено: ", color_white, ""..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zdocquestc"},
			noSpaceAfter = true
		})
		
		nut.chat.register("itemsquest", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText( color_white, " Новое задание: ", color_white, ""..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zitemsquest"},
			noSpaceAfter = true
		})
		
		nut.chat.register("itemsquestc", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText( color_white, " Задание выполнено: ", color_white, ""..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zitemsquestc"},
			noSpaceAfter = true
		})
		
		nut.chat.register("fracquestc", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText( "", color_white, date, Color(192, 192, 192), " Сообщение: ", color_white, "Вы вступили в группировку «"..text.."»")
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zfracquestc"},
			noSpaceAfter = true
		})
		
		nut.chat.register("renegata", {
			onCanSay =  function(speaker, text)

				speaker.nutLastTM = CurTime()
			end,
			onChatAdd = function(speaker, text)
				local format = "%X" 
				local date = os.date(format, nut.date.get()) 
				chat.AddText(color_white, date, Color(192, 192, 192), " Сообщение: ", color_white, " "..text)
				for k, v in pairs(player.GetAll()) do v:EmitSound("pda/pda_objective.ogg") end
			end,
			onCanHear = nut.config.get("chatRange1", 1),
			prefix = {"/zrenegata"},
			noSpaceAfter = true
		})
		
		nut.chat.register("roll", {
			format = "%s has rolled %s.",
			color = Color(155, 111, 176),
			filter = "actions",
			font = "nutChatFontItalics",
			onCanHear = nut.config.get("chatRange", 280),
			deadCanChat = true
		})
	end)
end

nut.chat.register("pm", {
	format = "[PM] %s: %s.",
	color = Color(249, 211, 89),
	filter = "pm",
	deadCanChat = true
})

nut.chat.register("event", {
	onCanSay =  function(speaker, text)
		return speaker:IsSuperAdmin()
	end,
	onCanHear = 1000000,
	onChatAdd = function(speaker, text)
		chat.AddText(Color(255, 150, 0), text)
	end,
	prefix = {"/event"}
})

hook.Remove("PlayerSay", "ULXMeCheck")