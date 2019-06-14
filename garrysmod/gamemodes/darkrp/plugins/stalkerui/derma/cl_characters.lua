local PANEL = {}
local PLUGIN = PLUGIN

local font = "Dma13"
local smallFont = "LFontForSafe"

local lerpDuration = 0.1

local function paintDPanel(s, w, h)
	surface.SetDrawColor(Color( 30, 30, 30, 190))
	surface.DrawRect( 0, 0, w, h )
	surface.DrawOutlinedRect(0, 0, w, h)

	surface.SetDrawColor(0, 0, 14, 150) 
	surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.4, ScrH() * 0.033)

	surface.SetDrawColor(Color( 30, 30, 30, 50))
	surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.4, ScrH() * 0.033)

	draw.DrawText("Создание персонажа", "Roh20", ScrW() * 0.008, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

	draw.DrawText("Группировка «"..urfaction.name.."»" or "Группировка «Одиночки»", "Roh20", ScrW() * 0.39, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT )

	draw.DrawText("Имя персонажа", "Roh20", ScrW() * 0.008, ScrH() * 0.04, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )
	draw.DrawText("Описание персонажа", "Roh20", ScrW() * 0.008, ScrH() * 0.09, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )
	draw.DrawText("Модель персонажа", "Roh20", ScrW() * 0.008, ScrH() * 0.137, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

	surface.SetDrawColor( 0, 33, 55, 160)
	surface.DrawRect(ScrW() * 0.008, ScrH() * 0.21, ScrW() * 0.1735, ScrH() * 0.024)

	surface.SetDrawColor(Color( 0, 0, 0, 150))
	surface.DrawRect(ScrW() * 0.008, ScrH() * 0.234, ScrW() * 0.1735, ScrH() * 0.31)

	surface.SetDrawColor(Color( 0, 0, 0, 235))
	surface.DrawOutlinedRect(ScrW() * 0.008, ScrH() * 0.21, ScrW() * 0.1735, ScrH() * 0.334)

	draw.DrawText("Выбор группировки", "Roh20", ScrW() * 0.0135, ScrH() * 0.208, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)

	surface.SetDrawColor(Color( 0, 0, 0, 220))
	surface.DrawRect(ScrW() * 0.01, ScrH() * 0.468, ScrW() * 0.1675, ScrH() * 0.037)

	draw.DrawText("Can be blocked by WL;", "Roh20", ScrW() * 0.0135, ScrH() * 0.473, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)
end

local function paintDtextEntry(s, w, h)
	surface.SetDrawColor(Color(0, 0, 0, 200))
	surface.DrawRect( 0, 0, w, h )
	s:DrawTextEntryText(color_white, color_white, color_white)
end

local function PaintFactionButton(s, w, h)
	local IconTable = {
	[characterFrame.loner] = "interface/lon_"..string.format("%s", s.selected)..".png",
	[characterFrame.bandit] = "interface/bandit_"..string.format("%s", s.selected)..".png",
	[characterFrame.clearsky] = "interface/clearsky_"..string.format("%s", s.selected)..".png",
	[characterFrame.dolg] = "interface/dolg_"..string.format("%s", s.selected)..".png",
	[characterFrame.freedom] = "interface/freedom_"..string.format("%s", s.selected)..".png",
	[characterFrame.merc] = "interface/merc_"..string.format("%s", s.selected)..".png",
	[characterFrame.military] = "interface/military_"..string.format("%s", s.selected)..".png",
	[characterFrame.scientist] = "interface/scientist_"..string.format("%s", s.selected)..".png",
	[characterFrame.monolit] = "interface/monolit_"..string.format("%s", s.selected)..".png",
	[characterFrame.trader] = "interface/merchants_"..string.format("%s", s.selected)..".png",
	[characterFrame.lastday] = "interface/lastday_"..string.format("%s", s.selected)..".png",
	[characterFrame.greh] = "interface/greh_"..string.format("%s", s.selected)..".png"
	}

	surface.SetMaterial(Material(IconTable[s]))
	surface.SetDrawColor(Color(255, 255, 255, 255))
	surface.DrawTexturedRect(0, 0, w, h)
end

local function BPaint( s, w, h )
	if s:IsDown() then 
		if not (TempId) then
			surface.SetDrawColor( Color(255, 255, 255, 220) )
			surface.SetMaterial( Material("daui/locked_button.png") )
			surface.DrawTexturedRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 176, 46, 40))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 178, 34, 34, 45))
			surface.DrawOutlinedRect(0, 0, w, h)
		else
			surface.SetDrawColor(Color( 255, 176, 46, 40))
			surface.DrawRect(0, 0, w, h)
			
			surface.SetDrawColor(Color( 178, 34, 34, 45))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
	elseif s:IsHovered() then 
		if not (TempId) then
			surface.SetDrawColor( Color(255, 255, 255, 220) )
			surface.SetMaterial( Material("daui/locked_button.png") )
			surface.DrawTexturedRect(0, 0, w, h)

			surface.SetDrawColor(Color( 178, 34, 34, 20))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 176, 46, 25))
			surface.DrawOutlinedRect(0, 0, w, h)
		else
			surface.SetDrawColor(Color( 178, 34, 34, 20))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 176, 46, 25))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
	else
		if not (TempId) then
			surface.SetDrawColor( Color(255, 255, 255, 220) )
			surface.SetMaterial( Material("daui/locked_button.png") )
			surface.DrawTexturedRect(0, 0, w, h)

			surface.SetDrawColor(Color( 30, 30, 30, 200))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 0, 0, 0, 235))
			surface.DrawOutlinedRect(0, 0, w, h)
		else
			surface.SetDrawColor(Color( 30, 30, 30, 200))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 0, 0, 0, 235))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
	end
end

local function AddHeader(text, parent)
	local header = parent:Add("DLabel")
	header:Dock(TOP)
	header:DockMargin(10, 20, 2, 2)
	header:SetContentAlignment(1)
	header:SetTextColor(Color(255, 255, 255))
	header:SetFont("StalkerSmallFont")
	header:SetText(text)

	return header
end

function PANEL:Init()
	netstream.Start("save_my_sound")

	self.scrW, self.scrH = ScrW(), ScrH()

	if (IsValid(nut.gui.char)) then nut.gui.char:Remove() end
	if (IsValid(nut.gui.loading)) then nut.gui.loading:Remove() end
	if (!nut.gui.charLoaded) then nut.gui.charLoaded = true end

	nut.gui.char = self
	urfaction = nut.faction.teams["stalkers"]

	self:Dock(FILL)
	self:MakePopup()
	self:Center()
	self:ParentToHUD()
	self.buttons = {}
	self.fadePanels = {}
	self:PlayMusic()

	self.playermodel = self:Add("nutModelPanel")
	self.playermodel:SetSize(ScrW() * 0.5, ScrH() * 1)
	self.playermodel:SetPos(ScrW() * 0.25, ScrH() * 0)
	self.playermodel:SetFOV(45) --70
	self.playermodel.enableHook = false
	self.playermodel.copyLocalSequence = false
	self.playermodel:SetColor(Color(211, 211, 211))
	self.playermodel:SetZPos(-9999)

	local RandomNovice = {
		"models/spenser/kek1ch/stalker_neutrala1.mdl",
		"models/spenser/kek1ch/stalker_neutral_1_face_2.mdl",
		"models/spenser/kek1ch/stalker_neutral_a.mdl",
		"models/spenser/kek1ch/stalker_neutral_1_mask.mdl",
		"models/spenser/kek1ch/stalker_neutral_1_mask.mdl",
		"models/spenser/kek1ch/stalker_neutral_1_hq.mdl",
		"models/spenser/kek1ch/stalker_merc_0.mdl",
		"models/spenser/kek1ch/stalker_bandit1b.mdl"
	}

	for k, v in ipairs(nut.characters) do
		local character = nut.char.loaded[v]
		if LocalPlayer().getChar and IsValid(LocalPlayer():getChar()) then
			self.playermodel:SetModel(string.gsub(LocalPlayer():getChar():GetModel(), "spenser", "hdmodels"))
		else
			if IsValid(character) then
				self.playermodel:SetModel(string.gsub(character:GetModel(), "spenser", "hdmodels"))
			else
				self.playermodel:SetModel(string.gsub(table.Random(RandomNovice), "spenser", "hdmodels"))
			end
		end

		print(v)
		print(character)

		if self.playermodel.Entity:LookupBone("bip01_head") then
			local headpos = self.playermodel.Entity:GetBonePosition( self.playermodel.Entity:LookupBone("bip01_head"))
			self.playermodel:SetLookAt(headpos)

			self.playermodel:SetCamPos(headpos - Vector(-23, -30, 4)) --(-18, -15, 4)
		end
	end

	self.steambutton = self:Add("DButton")
	self.steambutton:SetSize(ScrW() * 0.035, ScrH() * 0.06)
	self.steambutton:SetPos(ScrW() * 0.955, ScrH() * 0.006)
	self.steambutton:SetText("")
	self.steambutton.DoClick = function(client)
		gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=1513109120")
	end

	function self.steambutton:Paint(w,h)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Material("kek1ch/menu/right_steam_icon_v3.png"))
		surface.DrawTexturedRect(0, 0, w, h)

		surface.SetDrawColor(Color( 0, 0, 0, 235))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	self.vkbutton = self:Add("DButton")
	self.vkbutton:SetSize(ScrW() * 0.035, ScrH() * 0.06)
	self.vkbutton:SetPos(ScrW() * 0.915, ScrH() * 0.006)
	self.vkbutton:SetText("")
	self.vkbutton.DoClick = function(client)
		gui.OpenURL("https://vk.com/cocrpstalker")
	end

	function self.vkbutton:Paint(w,h)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Material("kek1ch/menu/right_vk_icon_v3.png"))
		surface.DrawTexturedRect(0, 0, w, h)

		surface.SetDrawColor(Color( 0, 0, 0, 235))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	self.warning = self:Add("DLabel")
	self.warning:SetSize(0, ScrH() * 0.105)
	self.warning:SetPos(ScrW() * 0.21, ScrH() * 0.85)
	self.warning:SetText("")
	self.warning:SizeTo( ScrW() * 0.585, ScrH() * 0.105, 0.3, 0, 1 )
	function self.warning:Paint( w, h )
		surface.SetDrawColor(245, 130, 0, 130)  
		surface.DrawRect(0, 0, w, h) 

		surface.SetMaterial(Material("daui/info_warning.png"))
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.DrawTexturedRect(ScrW()*0.01, ScrH()*0.023, ScrW()*0.036, ScrH()*0.065)

		local x, y = ScrW() * 0.0445, ScrH() * 0.245 --позиция текста по x, больше влезает вертикально
		local lines = nut.util.wrapText("Внимание! Это бета версия сборки DMA Warfare, прездазначенная для тестирования. Она не отображает финального качества продукта. Спасибо за понимание и поддержу. Удачи!", ScrW() * 0.515, "Roh25")
		for i = 1, #lines do
			y = ScrW() * 0 + (i * 18)
			nut.util.drawText(lines[i], x, y, Color(0, 0, 0), ScrW() * 0, ScrH() * 0, "Roh20", TEXT_ALIGN_CENTER) --позиция, не ебу
		end
	end

	self.warning_plus = self:Add("DLabel")
	self.warning_plus:SetSize(0, ScrH() * 0.03)
	self.warning_plus:SetPos(ScrW() * 0.21, ScrH() * 0.96)
	self.warning_plus:SetText("")
	self.warning_plus:SizeTo( ScrW() * 0.585, ScrH() * 0.03, 0.3, 0, 1 )
	function self.warning_plus:Paint( w, h )
		surface.SetDrawColor(0, 0, 0, 240)  
		surface.DrawRect(0, 0, w, h) 

		draw.DrawText("0.451 Бета версия ", "Roh20", ScrW() * 0.005, ScrH() * 0.001, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )
	end

	local buttonW, buttonH = self.scrW * 0.2, self.scrH * 0.035
	local buttonX, buttonY = (self.scrW * 0.185) - (buttonW * 0.5), self.scrH * 0.44
	local buttonOffset = self.scrH * 0.05

	local i = 0.5
	local function AddLabel(name, callback)
		local label = self:Add("DButton")
		label:SetSize(buttonW, buttonH)
		label:SetPos(buttonX, buttonY)
		label:SetAlpha(0)
		label:AlphaTo(255, 0.35, 0.35 * i)
		label:SetColor(color_white)
		label:SetFont(font)
		label:SetText(name)
		label.OnCursorEntered = function(s)
			if (PLUGIN.hoverSound) then
				surface.PlaySound(PLUGIN.hoverSound)
			end
		end

		local PaintButtonsLeft = {}
		PaintButtonsLeft["Войти в Зону"] = {Icon = "kek1ch/menu/play_menu_icon.png", PosX = ScrW()*0.0155, PosY = ScrH()*0.024}
		PaintButtonsLeft["Загрузить игру"] = {Icon = "kek1ch/menu/save_menu_icon.png", PosX = ScrW()*0.0155, PosY = ScrH()*0.024}
		PaintButtonsLeft["Настройки"] = {Icon = "kek1ch/menu/settings_menu_icon.png", PosX = ScrW()*0.0155, PosY = ScrH()*0.024}
		PaintButtonsLeft["Вернуться в игру"] = {Icon = "kek1ch/menu/goback_menu_icon.png", PosX = ScrW()*0.0155, PosY = ScrH()*0.024}
		PaintButtonsLeft["Назад"] = {Icon = "kek1ch/menu/goback_menu_icon.png", PosX = ScrW()*0.0155, PosY = ScrH()*0.024}
		PaintButtonsLeft["Покинуть сервер"] = {Icon = "kek1ch/menu/exit_menu_icon.png", PosX = ScrW()*0.0155, PosY = ScrH()*0.024}

		for k, v in ipairs(nut.characters) do
			local character = nut.char.loaded[v]
			PaintButtonsLeft[character:getName()] = {Icon = "kek1ch/menu/character_menu_icon_v2.png", PosX = ScrW()*0.0155, PosY = ScrH()*0.024}
		end

		function label:Paint(w,h)
			surface.SetDrawColor(Color(255, 255, 255, 255))
			surface.SetMaterial(Material(PaintButtonsLeft[label:GetText()].Icon))
			surface.DrawTexturedRect(ScrW()*0.0045, ScrH()*0.0043, ScrW()*0.0155, ScrH()*0.024)
		end

		if (callback) then
			label.DoClick = function(s)
				callback(s)

				surface.PlaySound(PLUGIN.clickSound)
			end
		end

		i = i + 0.32
		buttonY = buttonY + buttonOffset

		self.buttons[#self.buttons + 1] = label

		return label
	end

	local function ClearAllButtons(callback)
		buttonX, buttonY = (self.scrW * 0.185) - (buttonW * 0.5), self.scrH * 0.44

		local i = 0
		local max = table.Count(self.buttons)

		for k, v in pairs(self.buttons) do
			local reachedMax = i == (max - 1)

			//print(i.." "..max) -- debug

			v:AlphaTo(0, 0.3, 0.15 * i, function()
				if (reachedMax and callback) then
					callback()
				end

				v.noClick = true
				v:Remove()
			end)

			i = i + 1
		end

		self.buttons = {}
	end

	local function CreateReturnButton()
		AddLabel("Назад", function()
			for k, v in pairs(self.fadePanels) do
				if (IsValid(v)) then
					v:AlphaTo(0, 0.25, 0, function()
						v:Remove()
					end)
				end
			end

			ClearAllButtons(function()
				CreateMainButtons()
			end)
		end)
	end

	local NamesFirst = {"Антон", "Олег", "Олесь", "Рома", "Руслан", "Саша", "Слава", "Толик", "Юра", "Богдан", "Вениамин", "Виталий", "Вова", "Дима", "Иван", "Костя",
	"Леша", "Санек", "Шурик", "Вадя", "Васян", "Васек"}

	local NamesSecond = {"Резкий", "Рвач", "Рваный", "Работяга", "Псих", "Простак", "Праведный", "Покойник", "Подлец", "Плут", "Неуязвимый", "Пижон", "Одноглазый", "Нытик", "Нудный", 
	"Неумеха", "Неудачник", "Небрежный", "Черный", "Нарцисс", "Мятый", "Мутный", "Мрачный", "Местный", "Мертвый", "Мертвец", "Малыш", "Лютый", "Любимчик", "Косой", "Фантом",
	"Упырь", "Туз", "Опер"}

	local Desc = "Мужчина среднего роста, на вид лет 25, особо ничем не выделяется, но что-то в нем точно есть... Или нет?"

	function CreateMainButtons()
		local count = 0

		for k, v in pairs(nut.faction.teams) do
			if (nut.faction.hasWhitelist(v.index)) then
				count = count + 1
			end
		end

		local maxChars = hook.Run("GetMaxPlayerCharacter", LocalPlayer()) or nut.config.get("maxChars", 5)
		if (count > 0 and #nut.characters < maxChars and hook.Run("ShouldMenuButtonShow", "create") != false) then
			AddLabel("Войти в Зону", function()
				for k, v in SortedPairs(nut.faction.teams) do
					if not IsValid(characterFrame) then

						characterFrame = self:Add("DPanel")
						characterFrame:SetAlpha(0)
						characterFrame:AlphaTo(255, 0.4, 0.4)
						characterFrame:SetSize(ScrW()*0.4, ScrH()*0.6)
						characterFrame:SetPos(ScrW()*0.3, ScrH()*0.25)
						characterFrame.Paint = paintDPanel

						characterFrame.name = characterFrame:Add("DTextEntry")
						characterFrame.name:SetSize(ScrW() * 0.1735, ScrH() * 0.025)
						characterFrame.name:SetPos(ScrW() * 0.008, ScrH() * 0.066)
						characterFrame.name:SetAllowNonAsciiCharacters(true)
						characterFrame.name:SetFont("Roh20")
						characterFrame.name:SetText(table.Random(NamesFirst).." "..table.Random(NamesSecond))
						characterFrame.name.Paint = paintDtextEntry

						characterFrame.desc = characterFrame:Add("DTextEntry")
						characterFrame.desc:SetSize(ScrW() * 0.1735, ScrH() * 0.025)
						characterFrame.desc:SetPos(ScrW() * 0.008, ScrH() * 0.115)
						characterFrame.desc:SetAllowNonAsciiCharacters(true)
						characterFrame.desc:SetFont("Roh20")
						characterFrame.desc:SetText(Desc)
						characterFrame.desc.Paint = paintDtextEntry

						characterFrame.models = characterFrame:Add("DComboBox")
						characterFrame.models:SetSize(ScrW() * 0.1735, ScrH() * 0.025)
						characterFrame.models:SetPos(ScrW() * 0.008, ScrH() * 0.164)
						characterFrame.models:SetValue( "Выберите модель" )
						characterFrame.models:SetFont("Roh20")

						function characterFrame.models:Paint( w, h )
							surface.SetDrawColor(Color(0, 0, 0, 200))
							surface.DrawRect( 0, 0, w, h )
						end

						characterFrame.loner = characterFrame:Add("DButton")
						characterFrame.loner:SetSize(ScrW()*0.041, ScrH()*0.07)
						characterFrame.loner:SetPos(ScrW()*0.01, ScrH()*0.241)
						characterFrame.loner:SetText("")
						characterFrame.loner.Paint = PaintFactionButton
						characterFrame.loner.DoClick = function(client)
							if (nut.faction.hasWhitelist(nut.faction.teams["stalkers"].index)) then
								urfaction = nut.faction.teams["stalkers"]
								characterFrame.loner.selected = true
								characterFrame.greh.selected, characterFrame.lastday.selected, characterFrame.trader.selected, characterFrame.bandit.selected, characterFrame.clearsky.selected, characterFrame.dolg.selected, characterFrame.freedom.selected, characterFrame.merc.selected, characterFrame.military.selected, characterFrame.scientist.selected, characterFrame.monolit.selected = nil
							end
						end

						characterFrame.bandit = characterFrame:Add("DButton")
						characterFrame.bandit:SetSize(ScrW()*0.041, ScrH()*0.07) --(ScrW()*0.038, ScrH()*0.066)
						characterFrame.bandit:SetPos(ScrW()*0.053, ScrH()*0.241)
						characterFrame.bandit:SetText("")
						characterFrame.bandit.Paint = PaintFactionButton
						characterFrame.bandit.DoClick = function(client)
							if (nut.faction.hasWhitelist(nut.faction.teams["bandits"].index)) then
								urfaction = nut.faction.teams["bandits"]
								characterFrame.bandit.selected = true
								characterFrame.greh.selected, characterFrame.lastday.selected, characterFrame.trader.selected, characterFrame.loner.selected, characterFrame.clearsky.selected, characterFrame.dolg.selected, characterFrame.freedom.selected, characterFrame.merc.selected, characterFrame.military.selected, characterFrame.scientist.selected, characterFrame.monolit.selected = nil
							end
						end

						characterFrame.clearsky = characterFrame:Add("DButton")
						characterFrame.clearsky:SetSize(ScrW()*0.041, ScrH()*0.07)
						characterFrame.clearsky:SetPos(ScrW()*0.095, ScrH()*0.241)
						characterFrame.clearsky:SetText("")
						characterFrame.clearsky.Paint = PaintFactionButton
						characterFrame.clearsky.DoClick = function(client)
							if (nut.faction.hasWhitelist(nut.faction.teams["clearsky"].index)) then
								urfaction = nut.faction.teams["clearsky"]
								characterFrame.clearsky.selected = true
								characterFrame.greh.selected, characterFrame.lastday.selected, characterFrame.trader.selected, characterFrame.loner.selected, characterFrame.bandit.selected, characterFrame.dolg.selected, characterFrame.freedom.selected, characterFrame.merc.selected, characterFrame.military.selected, characterFrame.scientist.selected, characterFrame.monolit.selected = nil
							end
						end

						characterFrame.dolg = characterFrame:Add("DButton")
						characterFrame.dolg:SetSize(ScrW()*0.041, ScrH()*0.07)
						characterFrame.dolg:SetPos(ScrW()*0.01, ScrH()*0.315)
						characterFrame.dolg:SetText("")
						characterFrame.dolg.Paint = PaintFactionButton
						characterFrame.dolg.DoClick = function(client)
							if (nut.faction.hasWhitelist(nut.faction.teams["dolg"].index)) then
								urfaction = nut.faction.teams["dolg"]
								characterFrame.dolg.selected = true
								characterFrame.greh.selected, characterFrame.lastday.selected, characterFrame.trader.selected, characterFrame.loner.selected, characterFrame.bandit.selected, characterFrame.clearsky.selected, characterFrame.freedom.selected, characterFrame.merc.selected, characterFrame.military.selected, characterFrame.scientist.selected, characterFrame.monolit.selected = nil
							end
						end

						characterFrame.freedom = characterFrame:Add("DButton")
						characterFrame.freedom:SetSize(ScrW()*0.041, ScrH()*0.07)
						characterFrame.freedom:SetPos(ScrW()*0.053, ScrH()*0.315)
						characterFrame.freedom:SetText("")
						characterFrame.freedom.Paint = PaintFactionButton
						characterFrame.freedom.DoClick = function(client)
							if (nut.faction.hasWhitelist(nut.faction.teams["freedom"].index)) then
								urfaction = nut.faction.teams["freedom"]
								characterFrame.freedom.selected = true
								characterFrame.lastday.selected, characterFrame.trader.selected, characterFrame.loner.selected, characterFrame.bandit.selected, characterFrame.clearsky.selected, characterFrame.dolg.selected, characterFrame.merc.selected, characterFrame.military.selected, characterFrame.scientist.selected, characterFrame.monolit.selected = nil
							end
						end

						characterFrame.merc = characterFrame:Add("DButton")
						characterFrame.merc:SetSize(ScrW()*0.041, ScrH()*0.07)
						characterFrame.merc:SetPos(ScrW()*0.095, ScrH()*0.315)
						characterFrame.merc:SetText("")
						characterFrame.merc.Paint = PaintFactionButton
						characterFrame.merc.DoClick = function(client)
							if (nut.faction.hasWhitelist(nut.faction.teams["mercenary"].index)) then
								urfaction = nut.faction.teams["mercenary"]
								characterFrame.merc.selected = true
								characterFrame.greh.selected, characterFrame.lastday.selected, characterFrame.trader.selected, characterFrame.loner.selected, characterFrame.bandit.selected, characterFrame.clearsky.selected, characterFrame.dolg.selected, characterFrame.freedom.selected, characterFrame.military.selected, characterFrame.scientist.selected, characterFrame.monolit.selected = nil
							end
						end

						characterFrame.military = characterFrame:Add("DButton")
						characterFrame.military:SetSize(ScrW()*0.041, ScrH()*0.07)
						characterFrame.military:SetPos(ScrW()*0.01, ScrH()*0.39)
						characterFrame.military:SetText("")
						characterFrame.military.Paint = PaintFactionButton
						characterFrame.military.DoClick = function(client)
							if (nut.faction.hasWhitelist(nut.faction.teams["voenniy"].index)) then
								urfaction = nut.faction.teams["voenniy"]
								characterFrame.military.selected = true
								characterFrame.greh.selected, characterFrame.lastday.selected, characterFrame.trader.selected, characterFrame.loner.selected, characterFrame.bandit.selected, characterFrame.clearsky.selected, characterFrame.dolg.selected, characterFrame.freedom.selected, characterFrame.merc.selected, characterFrame.scientist.selected, characterFrame.monolit.selected = nil
							end
						end

						characterFrame.scientist = characterFrame:Add("DButton")
						characterFrame.scientist:SetSize(ScrW()*0.041, ScrH()*0.07)
						characterFrame.scientist:SetPos(ScrW()*0.053, ScrH()*0.39)
						characterFrame.scientist:SetText("")
						characterFrame.scientist.Paint = PaintFactionButton
						characterFrame.scientist.DoClick = function(client)
							if (nut.faction.hasWhitelist(nut.faction.teams["scientist"].index)) then
								urfaction = nut.faction.teams["scientist"]
								characterFrame.scientist.selected = true
								characterFrame.greh.selected, characterFrame.lastday.selected, characterFrame.trader.selected, characterFrame.loner.selected, characterFrame.bandit.selected, characterFrame.clearsky.selected, characterFrame.dolg.selected, characterFrame.freedom.selected, characterFrame.merc.selected, characterFrame.military.selected, characterFrame.monolit.selected = nil
							end
						end

						characterFrame.monolit = characterFrame:Add("DButton")
						characterFrame.monolit:SetSize(ScrW()*0.041, ScrH()*0.07)
						characterFrame.monolit:SetPos(ScrW()*0.095, ScrH()*0.39)
						characterFrame.monolit:SetText("")
						characterFrame.monolit.Paint = PaintFactionButton
						characterFrame.monolit.DoClick = function(client)
							if (nut.faction.hasWhitelist(nut.faction.teams["monolit"].index)) then
								urfaction = nut.faction.teams["monolit"]
								characterFrame.monolit.selected = true
								characterFrame.greh.selected, characterFrame.lastday.selected, characterFrame.trader.selected, characterFrame.loner.selected, characterFrame.bandit.selected, characterFrame.clearsky.selected, characterFrame.dolg.selected, characterFrame.freedom.selected, characterFrame.merc.selected, characterFrame.military.selected, characterFrame.scientist.selected = nil
							end
						end

						characterFrame.trader = characterFrame:Add("DButton")
						characterFrame.trader:SetSize(ScrW()*0.041, ScrH()*0.07)
						characterFrame.trader:SetPos(ScrW()*0.137, ScrH()*0.241)
						characterFrame.trader:SetText("")
						characterFrame.trader.Paint = PaintFactionButton
						characterFrame.trader.DoClick = function(client)
							if (nut.faction.hasWhitelist(nut.faction.teams["merchants"].index)) then
								urfaction = nut.faction.teams["merchants"]
								characterFrame.trader.selected = true
								characterFrame.greh.selected, characterFrame.lastday.selected, characterFrame.loner.selected, characterFrame.bandit.selected, characterFrame.monolit, characterFrame.clearsky.selected, characterFrame.dolg.selected, characterFrame.freedom.selected, characterFrame.merc.selected, characterFrame.military.selected, characterFrame.scientist.selected = nil
							end
						end

						characterFrame.lastday = characterFrame:Add("DButton")
						characterFrame.lastday:SetSize(ScrW()*0.041, ScrH()*0.07)
						characterFrame.lastday:SetPos(ScrW()*0.137, ScrH()*0.315)
						characterFrame.lastday:SetText("")
						characterFrame.lastday.Paint = PaintFactionButton
						characterFrame.lastday.DoClick = function(client)
							if (nut.faction.hasWhitelist(nut.faction.teams["lastday"].index)) then
								urfaction = nut.faction.teams["lastday"]
								characterFrame.lastday.selected = true
								characterFrame.greh.selected, characterFrame.trader.selected, characterFrame.loner.selected, characterFrame.bandit.selected, characterFrame.monolit, characterFrame.clearsky.selected, characterFrame.dolg.selected, characterFrame.freedom.selected, characterFrame.merc.selected, characterFrame.military.selected, characterFrame.scientist.selected = nil
							end
						end

						characterFrame.greh = characterFrame:Add("DButton")
						characterFrame.greh:SetSize(ScrW()*0.041, ScrH()*0.07)
						characterFrame.greh:SetPos(ScrW()*0.137, ScrH()*0.39)
						characterFrame.greh:SetText("")
						characterFrame.greh.Paint = PaintFactionButton
						characterFrame.greh.DoClick = function(client)
							if (nut.faction.hasWhitelist(nut.faction.teams["greh"].index)) then
								urfaction = nut.faction.teams["greh"]
								characterFrame.greh.selected = true
								characterFrame.trader.selected, characterFrame.loner.selected, characterFrame.bandit.selected, characterFrame.monolit, characterFrame.clearsky.selected, characterFrame.dolg.selected, characterFrame.freedom.selected, characterFrame.merc.selected, characterFrame.military.selected, characterFrame.scientist.selected = nil
							end
						end

						local faction = urfaction or nut.faction.teams["stalkers"]

						for k, v in SortedPairs(faction.models) do
							local icon = characterFrame.models:AddChoice(v)
						end

						function characterFrame.models:Think()
							if (!LocalPlayer().ComboBoxThink or LocalPlayer().ComboBoxThink < CurTime()) then
								if not (characterFrame.models.cur == urfaction) then
									characterFrame.models:Clear()
		
									local faction = urfaction or nut.faction.teams["stalkers"]
									for k, v in SortedPairs(faction.models) do
										local icon = characterFrame.models:AddChoice(v)
										characterFrame.models.cur = urfaction
									end
								end
								LocalPlayer().ComboBoxThink = CurTime() + 0.1
							end
						end

						characterFrame.scroll = characterFrame:Add("DScrollPanel")
						characterFrame.scroll:SetPos(ScrW() * 0.19,  ScrH() * 0.066)
						characterFrame.scroll:SetSize(ScrW() * 0.2, ScrH() * 0.476)
						characterFrame.scroll:SetDrawBackground(false)

						local sbar = characterFrame.scroll:GetVBar()
						function sbar:Paint( w, h )
							surface.SetDrawColor(Color( 30, 30, 30, 200))
							surface.DrawRect(0, 0, w, h)
						end
						function sbar.btnUp:Paint( w, h )
							surface.SetDrawColor(Color( 0, 0, 0, 0))
							surface.DrawRect(0, 0, w, h)
						end
						function sbar.btnDown:Paint( w, h )
							surface.SetDrawColor(Color( 0, 0, 0, 0))
							surface.DrawRect(0, 0, w, h)
						end
						function sbar.btnGrip:Paint( w, h )
							surface.SetDrawColor(Color( 60, 60, 60, 200))
							surface.DrawRect(0, 0, w, h)
						end 

						characterFrame.rigtpanel = characterFrame.scroll:Add("DLabel")
						characterFrame.rigtpanel:SetSize(ScrW() * 0.2, ScrH() * 3)
						characterFrame.rigtpanel:SetTextColor(Color ( 255, 255, 255, 255 ) )
						characterFrame.rigtpanel:Dock(FILL)
						characterFrame.rigtpanel:SetText( "" )
						function characterFrame.rigtpanel:Paint( w, h )
							surface.SetDrawColor(Color(0, 0, 0, 200))
							surface.DrawRect( 0, 0, w, h )

							draw.DrawText( characterFrame.name:GetText(), "Roh20", ScrW() * 0.099, ScrH() * 0.135, color_white, TEXT_ALIGN_CENTER )
							local x, y = ScrW() * 0.005, ScrH() * 0.4 --позиция текста по x, больше влезает вертикально
							local lines = nut.util.wrapText(characterFrame.desc:GetText(), ScrW() * 0.14, "Roh20") --сколько влезает горизонтально
							for i = 1, #lines do
								y = ScrW() * 0.08 + (i * 18) --положение по y
								nut.util.drawText(lines[i], x, y, color_white, ScrW() * 0.05, ScrH() * 0.1, "Roh20", TEXT_ALIGN_LEFT) --не ебу
							end
						end

						characterFrame.icon = characterFrame.rigtpanel:Add("nutModelPanel")
						characterFrame.icon:SetModel(string.gsub("models/spenser/kek1ch/stalker_neutral_1_hq.mdl", "spenser", "hdmodels"))
						characterFrame.icon:SetSize(ScrW() * 0.10, ScrH() * 0.115)
						characterFrame.icon:SetPos((ScrW() * 0.093) - (ScrW() * 0.10 * 0.5), ScrH() * 0.015)
						function characterFrame.icon:LayoutEntity( Entity ) return end
						if characterFrame.icon.Entity:LookupBone( "bip01_head" ) then
							local headpos = characterFrame.icon.Entity:GetBonePosition( characterFrame.icon.Entity:LookupBone( "bip01_head" ) )
							characterFrame.icon:SetLookAt( headpos )
							characterFrame.icon:SetCamPos( headpos-Vector( -18, -2, 4 ) )
						end
						characterFrame.icon:SetFOV(70)
						characterFrame.icon:SetZPos(9999)

						characterFrame.models.OnSelect = function(this, value)
							charmodel = value
							characterFrame.icon:SetModel(string.gsub(characterFrame.models:GetOptionText(value), "spenser", "hdmodels"))
						end

						characterFrame.choosecr = characterFrame:Add("DButton")
						characterFrame.choosecr:SetPos(ScrW()*0.11, ScrH()*0.56)
						characterFrame.choosecr:SetSize(ScrW()*0.06, ScrH()*0.03)
						characterFrame.choosecr:SetTextColor(color_white)
						characterFrame.choosecr:SetExpensiveShadow(1, Color(0, 0, 0, 100))
						characterFrame.choosecr:SetFont("Roh20")
						characterFrame.choosecr:SetText("Применить")
						characterFrame.choosecr.Paint = BPaint
						characterFrame.choosecr.DoClick = function(client)
							characterFrame:Remove()
							local payload = {} 
							payload["faction"] = urfaction.index
							payload["name"] = characterFrame.name:GetText()
							payload["desc"] = characterFrame.desc:GetText()
							payload["model"] = charmodel
							--payload["attribs"] = AttribsFrame.payload.attribs

							--PrintTable(payload) -- debug

							netstream.Hook("charAuthed", function(fault, ...)
								timer.Remove("nutCharTimeout")

								if (type(fault) == "string") then return end
								if (type(fault) == "table") then nut.characters = fault end
							end)

							timer.Create("nutCharTimeout", 20, 1, function()
								return ErrorNoHalt("We have problemerino here")
							end)

							netstream.Start("charCreate", payload)

							--AttribsFrame:AlphaTo(0, .30, 0.5)
							characterFrame:AlphaTo(0, .30, 0.5, function()
								ClearAllButtons(function() CreateMainButtons() end)
							end)
						end

						self.fadePanels[#self.fadePanels + 1] = characterFrame
						--self.fadePanels[#self.fadePanels + 1] = AttribsFrame

						if (#nut.characters == 1) then
							AddLabel("Загрузить игру", function()
								if not IsValid(characterFrame) then --не робит
									local characterFrame = self:Add("DPanel")
									characterFrame:SetAlpha(0)
									characterFrame:AlphaTo(255, 0.4, 0.4)
									characterFrame:SetSize(ScrW() * 0.22, ScrH() * 0.45)
									characterFrame:SetPos(ScrW() * 0.75, ScrH() * 0.2)

									function characterFrame:Paint(w,h)
										nut.util.drawBlur(self, 10)
										surface.SetDrawColor(Color( 30, 30, 30, 190))
										surface.DrawRect( 0, 0, w, h )
										surface.DrawOutlinedRect(0, 0, w, h)

										surface.SetDrawColor(0, 0, 14, 150)
										surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033)

										surface.SetDrawColor(Color( 30, 30, 30, 50))
										surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033) --шапка

										draw.DrawText("Загрузка игры", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT ) --надпись шапки

										surface.SetDrawColor(Color( 138, 149, 151, 100))
										surface.DrawLine(ScrW() * 0.009, ScrH() * 0.0325, ScrW() * 0.2, ScrH() * 0.0325)

										surface.SetDrawColor(Color( 0, 33, 55, 160))
										surface.DrawRect(ScrW() * 0.009, ScrH() * 0.057, ScrW() * 0.2, ScrH() * 0.024) --верхняя панель крафта

										surface.SetDrawColor(Color( 0, 0, 0, 200))
										surface.DrawRect(ScrW() * 0.009, ScrH() * 0.08, ScrW() * 0.2, ScrH() * 0.3) --основная панель крафта 145

										draw.DrawText("Список персонажей", "Roh20", ScrW() * 0.015, ScrH() * 0.055, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT ) --надпись шапки

										surface.SetDrawColor( Color(125, 105, 0, 100) )
										surface.SetMaterial( Material("lgh/circle_gradient.png") )
										surface.DrawTexturedRectUV(-ScrW() * 0.05, ScrH() * 0.425, ScrW() * 0.3, ScrH() * 0.032, 1, 0.9, 0, 0.3)
									end

									characterFrame.dscroll = characterFrame:Add( "DScrollPanel" )
									characterFrame.dscroll:SetSize(ScrW() * 0.2, ScrH() * 0.3)
									characterFrame.dscroll:SetPos(ScrW() * 0.009, ScrH() * 0.08)
									characterFrame.dscroll:SetDrawBackground(false)

									local sbar = characterFrame.dscroll:GetVBar()
									function sbar:Paint( w, h )
										surface.SetDrawColor(Color( 30, 30, 30, 200))
										surface.DrawRect(0, 0, w, h)
										end
									function sbar.btnUp:Paint( w, h )
										surface.SetDrawColor(Color( 0, 0, 0, 0))
										surface.DrawRect(0, 0, w, h)
									end
									function sbar.btnDown:Paint( w, h )
										surface.SetDrawColor(Color( 0, 0, 0, 0))
										surface.DrawRect(0, 0, w, h)
									end
									function sbar.btnGrip:Paint( w, h )
										surface.SetDrawColor(Color( 60, 60, 60, 200))
										surface.DrawRect(0, 0, w, h)
									end

									self.characters = {}

									for k, v in ipairs(nut.characters) do
										local character = nut.char.loaded[v]

										local buttoncharacter = characterFrame.dscroll:Add("DButton")
										buttoncharacter:Dock(TOP)
										buttoncharacter:DockMargin(3, 3, 3, 0)
										buttoncharacter:SetTall(ScrH() * 0.07)
										buttoncharacter:SetFont("Roh20")
										buttoncharacter:SetText("")
										buttoncharacter.DoClick = function(client)
											TempId = nut.char.loaded[v]
											self.playermodel:SetModel(string.gsub(nut.char.loaded[v]:getModel(), "spenser", "hdmodels"))
										end

										buttoncharacter.model = buttoncharacter:Add("nutModelPanel")
										buttoncharacter.model:SetSize(ScrW() * 0.05, ScrH() * 0.065)
										buttoncharacter.model:SetPos(ScrW() * 0.005, ScrH() * 0.00505)
										timer.Simple(0.3, function()
											if (character) then
												buttoncharacter.model:SetModel(string.gsub(character:getModel(), "spenser", "hdmodels"))

												function buttoncharacter.model:LayoutEntity( Entity ) return end

												if buttoncharacter.model.Entity:LookupBone("bip01_head") then
													local headpos = buttoncharacter.model.Entity:GetBonePosition( buttoncharacter.model.Entity:LookupBone("bip01_head"))

													buttoncharacter.model:SetLookAt(headpos)
													buttoncharacter.model:SetCamPos(headpos-Vector( -18, 2.5, 4 ))
												end
												buttoncharacter.model:SetFOV(70)
											end
										end)

										function buttoncharacter:Paint(w,h)
											if self:IsDown() then 
												surface.SetDrawColor(Color( 255, 176, 46, 40))
												surface.DrawRect(0, 0, w, h)

												surface.SetDrawColor(Color( 255, 176, 46, 45))
												surface.DrawOutlinedRect(0, 0, w, h)
											elseif self:IsHovered() then 
												surface.SetDrawColor(Color( 255, 176, 46, 20))
												surface.DrawRect(0, 0, w, h)

												surface.SetDrawColor(Color( 255, 176, 46, 25))
												surface.DrawOutlinedRect(0, 0, w, h)
											else
												surface.SetDrawColor(Color( 30, 30, 30, 200))
												surface.DrawRect(0, 0, w, h)

												surface.SetDrawColor(Color( 0, 0, 0, 235))
												surface.DrawOutlinedRect(0, 0, w, h)
											end
											draw.DrawText(character:getName(), "Roh20", ScrW() * 0.06, ScrH() * 0.001, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )
											draw.DrawText(team.GetName(character:getFaction()), "Roh20", ScrW() * 0.06, ScrH() * 0.021, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )
											draw.DrawText(character:getMoney().." RU", "Roh20", ScrW() * 0.06, ScrH() * 0.043, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )
										end

									end

									characterFrame.choose = characterFrame:Add("DButton")
									characterFrame.choose:SetPos(ScrW()*0.009, ScrH()*0.4)
									characterFrame.choose:SetSize(ScrW()*0.06, ScrH()*0.03)
									characterFrame.choose:SetTextColor(color_white)
									characterFrame.choose:SetExpensiveShadow(1, Color(0, 0, 0, 100))
									characterFrame.choose:SetFont("Roh20")
									characterFrame.choose:SetText("Выбрать")
									characterFrame.choose.Paint = BPaint
									characterFrame.choose.DoClick = function(s)
										LocalPlayer():ConCommand("stopsound")
										if (TempId) then
											if ((self.nextUse or 0) < CurTime()) then
												self.nextUse = CurTime() + 1
											else
												return
											end

											local status, result = hook.Run("CanPlayerUseChar", client, TempId)

											if (status == false) then
												if (result:sub(1, 1) == "@") then
													nut.util.notifyLocalized(result:sub(2))
												else
													nut.util.notify(result)
												end
												return
											end

											if (TempId:getID()) then
												self:Remove()

												local curChar = LocalPlayer():getChar() and LocalPlayer():getChar():getID()

												netstream.Hook("charLoaded", function()
													if (IsValid(darkness)) then
														darkness:AlphaTo(0, 5, 0.5, function()
															darkness:Remove()
														end)
													end
												end)
												netstream.Start("charChoose", TempId:getID())
											end
										end
									end

									characterFrame.delete = characterFrame:Add("DButton")
									characterFrame.delete:SetPos(ScrW()*0.077, ScrH()*0.4)
									characterFrame.delete:SetSize(ScrW()*0.06, ScrH()*0.03)
									characterFrame.delete:SetTextColor(color_white)
									characterFrame.delete:SetExpensiveShadow(1, Color(0, 0, 0, 100))
									characterFrame.delete:SetFont("Roh20")
									characterFrame.delete:SetText("Удалить")
									characterFrame.delete.Paint = BPaint
									characterFrame.delete.DoClick = function(s)
										if (TempId) then
											local menu = DermaMenu()
												local confirm = menu:AddSubMenu(L("delConfirm", TempId:getName()))
												confirm:AddOption(L"no"):SetImage("icon16/cross.png")
												confirm:AddOption(L"yes", function()
													netstream.Start("charDel", TempId:getID())
												end):SetImage("icon16/tick.png")
											menu:Open()
										end
									end

									characterFrame.close = characterFrame:Add("DButton")
									characterFrame.close:SetPos(ScrW()*0.147, ScrH()*0.4)
									characterFrame.close:SetSize(ScrW()*0.06, ScrH()*0.03)
									characterFrame.close:SetTextColor(color_white)
									characterFrame.close:SetExpensiveShadow(1, Color(0, 0, 0, 100))
									characterFrame.close:SetFont("Roh20")
									characterFrame.close:SetText("Закрыть")
									characterFrame.close.Paint = BPaint
									characterFrame.close.DoClick = function(s)
										characterFrame:Remove()
									end

									self.fadePanels[#self.fadePanels + 1] = characterFrame
									self.fadePanels[#self.fadePanels + 1] = characterList
								end
							end)
						end
					end

					characterFrame.closecr = characterFrame:Add("DButton")
					characterFrame.closecr:SetPos(ScrW()*0.20, ScrH()*0.56)
					characterFrame.closecr:SetSize(ScrW()*0.06, ScrH()*0.03)
					characterFrame.closecr:SetTextColor(color_white)
					characterFrame.closecr:SetExpensiveShadow(1, Color(0, 0, 0, 100))
					characterFrame.closecr:SetFont("Roh20")
					characterFrame.closecr:SetText("Закрыть")
					characterFrame.closecr.Paint = BPaint
					characterFrame.closecr.DoClick = function(s)
						characterFrame:Remove()
					end
				end
			end)
		end

		if (#nut.characters > 0 and hook.Run("ShouldMenuButtonShow", "load") != false) then
			AddLabel("Загрузить игру", function()
				if not IsValid(characterFrame) then --не робит
					local characterFrame = self:Add("DPanel")
					characterFrame:SetAlpha(0)
					characterFrame:AlphaTo(255, 0.4, 0.4)
					characterFrame:SetSize(ScrW() * 0.22, ScrH() * 0.45)
					characterFrame:SetPos(ScrW() * 0.75, ScrH() * 0.2)

					function characterFrame:Paint(w,h)
						nut.util.drawBlur(self, 10)
						surface.SetDrawColor(Color( 30, 30, 30, 190))
						surface.DrawRect( 0, 0, w, h )
						surface.DrawOutlinedRect(0, 0, w, h)

						surface.SetDrawColor(0, 0, 14, 150)
						surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033)

						surface.SetDrawColor(Color( 30, 30, 30, 50))
						surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033) --шапка

						draw.DrawText("Загрузка игры", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT ) --надпись шапки

						surface.SetDrawColor(Color( 138, 149, 151, 100))
						surface.DrawLine(ScrW() * 0.009, ScrH() * 0.0325, ScrW() * 0.2, ScrH() * 0.0325)

						surface.SetDrawColor(Color( 0, 33, 55, 160))
						surface.DrawRect(ScrW() * 0.009, ScrH() * 0.057, ScrW() * 0.2, ScrH() * 0.024) --верхняя панель крафта

						surface.SetDrawColor(Color( 0, 0, 0, 200))
						surface.DrawRect(ScrW() * 0.009, ScrH() * 0.08, ScrW() * 0.2, ScrH() * 0.3) --основная панель крафта 145

						draw.DrawText("Список персонажей", "Roh20", ScrW() * 0.015, ScrH() * 0.055, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT ) --надпись шапки

						surface.SetDrawColor( Color(125, 105, 0, 100) )
						surface.SetMaterial( Material("lgh/circle_gradient.png") )
						surface.DrawTexturedRectUV(-ScrW() * 0.05, ScrH() * 0.425, ScrW() * 0.3, ScrH() * 0.032, 1, 0.9, 0, 0.3)
					end

					characterFrame.dscroll = characterFrame:Add( "DScrollPanel" )
					characterFrame.dscroll:SetSize(ScrW() * 0.2, ScrH() * 0.3)
					characterFrame.dscroll:SetPos(ScrW() * 0.009, ScrH() * 0.08)
					characterFrame.dscroll:SetDrawBackground(false)

					local sbar = characterFrame.dscroll:GetVBar()
					function sbar:Paint( w, h )
						surface.SetDrawColor(Color( 30, 30, 30, 200))
						surface.DrawRect(0, 0, w, h)
						end
					function sbar.btnUp:Paint( w, h )
						surface.SetDrawColor(Color( 0, 0, 0, 0))
						surface.DrawRect(0, 0, w, h)
					end
					function sbar.btnDown:Paint( w, h )
						surface.SetDrawColor(Color( 0, 0, 0, 0))
						surface.DrawRect(0, 0, w, h)
					end
					function sbar.btnGrip:Paint( w, h )
						surface.SetDrawColor(Color( 60, 60, 60, 200))
						surface.DrawRect(0, 0, w, h)
					end

					self.characters = {}

					for k, v in ipairs(nut.characters) do
						local character = nut.char.loaded[v]

						local buttoncharacter = characterFrame.dscroll:Add("DButton")
						buttoncharacter:Dock(TOP)
						buttoncharacter:DockMargin(3, 3, 3, 0)
						buttoncharacter:SetTall(ScrH() * 0.07)
						buttoncharacter:SetFont("Roh20")
						buttoncharacter:SetText("")
						buttoncharacter.DoClick = function(client)
							TempId = nut.char.loaded[v]
							self.playermodel:SetModel(string.gsub(nut.char.loaded[v]:getModel(), "spenser", "hdmodels"))
						end

						buttoncharacter.model = buttoncharacter:Add("nutModelPanel")
						buttoncharacter.model:SetSize(ScrW() * 0.05, ScrH() * 0.065)
						buttoncharacter.model:SetPos(ScrW() * 0.005, ScrH() * 0.00505)
						timer.Simple(0.3, function()
							if (character) then
								buttoncharacter.model:SetModel(string.gsub(character:getModel(), "spenser", "hdmodels"))

								function buttoncharacter.model:LayoutEntity( Entity ) return end
								if buttoncharacter.model.Entity:LookupBone("bip01_head") then
									local headpos = buttoncharacter.model.Entity:GetBonePosition( buttoncharacter.model.Entity:LookupBone("bip01_head"))

									buttoncharacter.model:SetLookAt(headpos)
									buttoncharacter.model:SetCamPos(headpos-Vector( -18, 2.5, 4 ))
								end
								buttoncharacter.model:SetFOV(70)
							end
						end)

						function buttoncharacter:Paint(w,h)
							if self:IsDown() then 
								surface.SetDrawColor(Color( 255, 176, 46, 40))
								surface.DrawRect(0, 0, w, h)

								surface.SetDrawColor(Color( 255, 176, 46, 45))
								surface.DrawOutlinedRect(0, 0, w, h)
							elseif self:IsHovered() then 
								surface.SetDrawColor(Color( 255, 176, 46, 20))
								surface.DrawRect(0, 0, w, h)

								surface.SetDrawColor(Color( 255, 176, 46, 25))
								surface.DrawOutlinedRect(0, 0, w, h)
							else
								surface.SetDrawColor(Color( 30, 30, 30, 200))
								surface.DrawRect(0, 0, w, h)

								surface.SetDrawColor(Color( 0, 0, 0, 235))
								surface.DrawOutlinedRect(0, 0, w, h)
							end
							draw.DrawText(character:getName(), "Roh20", ScrW() * 0.06, ScrH() * 0.001, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )
							draw.DrawText(team.GetName(character:getFaction()), "Roh20", ScrW() * 0.06, ScrH() * 0.021, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )
							draw.DrawText(character:getMoney().." RU", "Roh20", ScrW() * 0.06, ScrH() * 0.043, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )
						end

					end

					characterFrame.choose = characterFrame:Add("DButton")
					characterFrame.choose:SetPos(ScrW()*0.009, ScrH()*0.4)
					characterFrame.choose:SetSize(ScrW()*0.06, ScrH()*0.03)
					characterFrame.choose:SetTextColor(color_white)
					characterFrame.choose:SetExpensiveShadow(1, Color(0, 0, 0, 100))
					characterFrame.choose:SetFont("Roh20")
					characterFrame.choose:SetText("Выбрать")
					characterFrame.choose.Paint = BPaint
					characterFrame.choose.DoClick = function(s)
						if (TempId) then
							if ((self.nextUse or 0) < CurTime()) then
								self.nextUse = CurTime() + 1
							else
								return
							end

							local status, result = hook.Run("CanPlayerUseChar", client, TempId)

							if (status == false) then
								if (result:sub(1, 1) == "@") then
									nut.util.notifyLocalized(result:sub(2))
								else
									nut.util.notify(result)
								end
								return
							end

							if (TempId:getID()) then
								self:Remove()

								local curChar = LocalPlayer():getChar() and LocalPlayer():getChar():getID()

								netstream.Hook("charLoaded", function()
									if (IsValid(darkness)) then
										darkness:AlphaTo(0, 5, 0.5, function()
											darkness:Remove()
										end)
									end

									--[[if (curChar != TempId:getID()) then
										hook.Run("CharacterLoaded", TempId)
									end]]
								end)

								netstream.Start("charChoose", TempId:getID())
							end
						end
					end

					characterFrame.delete = characterFrame:Add("DButton")
					characterFrame.delete:SetPos(ScrW()*0.077, ScrH()*0.4)
					characterFrame.delete:SetSize(ScrW()*0.06, ScrH()*0.03)
					characterFrame.delete:SetTextColor(color_white)
					characterFrame.delete:SetExpensiveShadow(1, Color(0, 0, 0, 100))
					characterFrame.delete:SetFont("Roh20")
					characterFrame.delete:SetText("Удалить")
					characterFrame.delete.Paint = BPaint
					characterFrame.delete.DoClick = function(s)
						if (TempId) then
							local menu = DermaMenu()
								local confirm = menu:AddSubMenu(L("delConfirm", TempId:getName()))
								confirm:AddOption(L"no"):SetImage("icon16/cross.png")
								confirm:AddOption(L"yes", function()
									netstream.Start("charDel", TempId:getID())
								end):SetImage("icon16/tick.png")
							menu:Open()
						end
					end

					characterFrame.close = characterFrame:Add("DButton")
					characterFrame.close:SetPos(ScrW()*0.147, ScrH()*0.4)
					characterFrame.close:SetSize(ScrW()*0.06, ScrH()*0.03)
					characterFrame.close:SetTextColor(color_white)
					characterFrame.close:SetExpensiveShadow(1, Color(0, 0, 0, 100))
					characterFrame.close:SetFont("Roh20")
					characterFrame.close:SetText("Закрыть")
					characterFrame.close.Paint = BPaint
					characterFrame.close.DoClick = function(s)
						characterFrame:Remove()
					end

					self.fadePanels[#self.fadePanels + 1] = characterFrame
					self.fadePanels[#self.fadePanels + 1] = characterList
				end
			end)
		end

		AddLabel("Настройки", function()
		end)

		local char = LocalPlayer().getChar and LocalPlayer():getChar()

		AddLabel(!char and "Покинуть сервер" or "Вернуться в игру", function()
			if (!char) then
				RunConsoleCommand("disconnect")
				return
			end

			self:AlphaTo(0, 0.5, 0, function()
				self:Remove()
			end)
		end)
	end

	CreateMainButtons()
end


function PANEL:Paint(w, h)
	surface.SetDrawColor(Color(0, 0, 0))
	surface.DrawRect(0, 0, w, h)

	local x, y = gui.MousePos()
	surface.SetDrawColor(Color(255,255,255,255))
	surface.SetMaterial(Material("kek1ch/menu/blyad_kak_je_mne_bolno_1.png"))
	surface.DrawTexturedRect(-0.02 * x, -0.02 * y, w * 1.02, h * 1.02)

	surface.SetDrawColor(Color(255,255,255,245))
	surface.SetMaterial(Material("kek1ch/menu/shapka_warfare.png"))
	surface.DrawTexturedRect(-ScrW()*0.02, ScrH()*0.27, ScrW()*0.39, ScrH()*0.17)
end

function PANEL:PaintOver(w, h)
	local selectW = ScrW() * 0.265
	local selectX = (ScrW() * 0.1815) - (selectW * 0.5)

	surface.SetDrawColor(Color(255,255,255,255))
end

function PANEL:Think()
	if (input.IsKeyDown(KEY_F1) and LocalPlayer():getChar()) then
		self:Remove()
	end

	if (lerpTarget) then
		local fraction = (CurTime() - lerpStart) / lerpDuration
		lerpTarget = nil
	end
end

function PANEL:PlayMusic()
	if (nut.menuMusic) then
		nut.menuMusic:Stop()
		nut.menuMusic = nil
	end

	timer.Remove("nutMusicFader")

	timer.Simple(3, function()
		local source = table.Random(PLUGIN.backgroundSounds):lower()
		if (source:find("%S")) then
			local function callback(music, errorID, fault)
				if (music) then
					music:SetVolume(PLUGIN.soundVolume)

					nut.menuMusic = music
					nut.menuMusic:Play()
				else
					MsgC(Color(255, 50, 50), errorID.." ")
					MsgC(color_white, fault.."\n")
				end
			end

			sound.PlayFile("sound/"..source, "noplay", callback)
		end
	end)
end

function PANEL:OnRemove()
	if (nut.menuMusic) then
		local fraction = 1
		local start, finish = RealTime(), RealTime() + 5

		timer.Create("nutMusicFader", 0.1, 0, function()
			if (nut.menuMusic) then
				fraction = 1 - math.TimeFraction(start, finish, RealTime())
				nut.menuMusic:SetVolume(fraction * PLUGIN.soundVolume)

				if (fraction <= 0) then
					nut.menuMusic:Stop()
					nut.menuMusic = nil

					timer.Remove("nutMusicFader")
				end
			else
				timer.Remove("nutMusicFader")
			end
		end)
	end

	TempId = nil
	urfaction = nil
	collectgarbage()
end

vgui.Register("nutCharMenu", PANEL, "EditablePanel")