local NUT_CVAR_LOWER2 = CreateClientConVar("nut_usealtlower", "0", true)

function GM:ForceDermaSkin()
	return "nutscript"
end
function IsKeyPressed(key, pressed)
    local ply = LocalPlayer()
	if (!gui.IsGameUIVisible()) and (!gui.IsConsoleVisible()) then
		if input.IsKeyDown(key) then

			return true
		end
	end
end

function GM:ScoreboardShow()
	if (IsValid(nut.gui.score)) then
		nut.gui.score:SetVisible(true)
	else
		vgui.Create("nutScoreboard")
	end

	gui.EnableScreenClicker(true)
end

function GM:ScoreboardHide()
	if (IsValid(nut.gui.score)) then
		nut.gui.score:SetVisible(false)
		CloseDermaMenus()
	end

	gui.EnableScreenClicker(false)
end

function GM:LoadFonts(font, genericFont)
	surface.CreateFont("nut3D2DFont", {
		font = font,
		size = 2048,
		extended = true,
		weight = 1000
	})

	surface.CreateFont("nutTitleFont", {
		font = font,
		size = ScreenScale(30),
		extended = true,
		weight = 1000
	})

	surface.CreateFont("nutSubTitleFont", {
		font = font,
		size = ScreenScale(18),
		extended = true,
		weight = 500
	})

	surface.CreateFont("nutMenuButtonFont", {
		font = font,
		size = ScreenScale(14),
		extended = true,
		weight = 1000
	})

	surface.CreateFont("nutMenuButtonLightFont", {
		font = font,
		size = ScreenScale(14),
		extended = true,
		weight = 200
	})

	surface.CreateFont("nutToolTipText", {
		font = font,
		size = 20,
		extended = true,
		weight = 500
	})

	surface.CreateFont("nutDynFontSmall", {
		font = font,
		size = ScreenScale(22),
		extended = true,
		weight = 1000
	})

	surface.CreateFont("nutDynFontMedium", {
		font = font,
		size = ScreenScale(28),
		extended = true,
		weight = 1000
	})

	surface.CreateFont("nutDynFontBig", {
		font = font,
		size = ScreenScale(48),
		extended = true,
		weight = 1000
	})

	font = genericFont
	
	surface.CreateFont("nutCleanTitleFont", {
		font = font,
		size = 200,
		extended = true,
		weight = 1000
	})

	surface.CreateFont("nutHugeFont", {
		font = font,
		size = 72,
		extended = true,
		weight = 1000
	})

	surface.CreateFont("nutBigFont", {
		font = font,
		size = 36,
		extended = true,
		weight = 1000
	})

	surface.CreateFont("nutMediumFont", {
		font = font,
		size = 25,
		extended = true,
		weight = 1000
	})

	surface.CreateFont("nutMediumLightFont", {
		font = font,
		size = 25,
		extended = true,
		weight = 200
	})

	surface.CreateFont("nutGenericFont", {
		font = font,
		size = 20,
		extended = true,
		weight = 1000
	})

	surface.CreateFont("nutChatFont", {
		font = font,
		size = math.max(ScreenScale(7), 17),
		extended = true,
		weight = 200
	})

	surface.CreateFont("nutChatFontItalics", {
		font = font,
		size = math.max(ScreenScale(7), 17),
		extended = true,
		weight = 200,
		italic = true
	})

	surface.CreateFont("nutSmallFont", {
		font = font,
		size = math.max(ScreenScale(6), 17),
		extended = true,
		weight = 500
	})

	surface.CreateFont("nutSmallBoldFont", {
		font = font,
		size = math.max(ScreenScale(8), 20),
		extended = true,
		weight = 800
	})

	font = "Cambria"

	surface.CreateFont("nutIntroTitleFont", {
		font = font,
		size = 200,
		extended = true,
		weight = 1000
	})

	surface.CreateFont("nutIntroBigFont", {
		font = font,
		size = 48,
		extended = true,
		weight = 1000
	})

	surface.CreateFont("nutIntroMediumFont", {
		font = font,
		size = 28,
		extended = true,
		weight = 1000
	})

	surface.CreateFont("nutIntroSmallFont", {
		font = font,
		size = 22,
		extended = true,
		weight = 1000
	})

	surface.CreateFont("nutIconsSmall", {
		font = "fontello",
		size = 22,
		extended = true,
		weight = 500
	})
	
		surface.CreateFont("nutIconFont", {
		font = font,
		size = math.max(ScreenScale(10), 17),
		weight = 200,
		extended = true
	})

	surface.CreateFont("nutIconsMedium", {
		font = "fontello",
		extended = true,
		size = 28,
		weight = 500
	})

	surface.CreateFont("nutInvName", {
        font = "Courier New",
        size = 22,
        extended = true,
        weight = 1000
    })

    surface.CreateFont("nutInvFac", {
        font = "Courier New",
        size = 18,
        extended = true,
        weight = 1000
    })

    surface.CreateFont("nutInvWeight", {
        font = "Courier New",
        size = 16,
        extended = true,
        weight = 1000
    })
	
	surface.CreateFont("nutIconsBig", {
		font = "fontello",
		extended = true,
		size = 48,
		weight = 500
	})
end

local LOWERED_ANGLES = Angle(30, -30, -25)

function GM:CalcViewModelView(weapon, viewModel, oldEyePos, oldEyeAngles, eyePos, eyeAngles)
	if (!IsValid(weapon)) then
		return
	end

	local client = LocalPlayer()
	local value = 0

	if (!client:isWepRaised()) then
		value = 100
	end

	local fraction = (client.nutRaisedFrac or 0) / 100
	local rotation = weapon.LowerAngles or LOWERED_ANGLES
	
	if (NUT_CVAR_LOWER2:GetBool() and weapon.LowerAngles2) then
		rotation = weapon.LowerAngles2
	end
	
	eyeAngles:RotateAroundAxis(eyeAngles:Up(), rotation.p * fraction)
	eyeAngles:RotateAroundAxis(eyeAngles:Forward(), rotation.y * fraction)
	eyeAngles:RotateAroundAxis(eyeAngles:Right(), rotation.r * fraction)

	client.nutRaisedFrac = Lerp(FrameTime() * 2, client.nutRaisedFrac or 0, value)

	viewModel:SetAngles(eyeAngles)

	if (weapon.GetViewModelPosition) then
		local position, angles = weapon:GetViewModelPosition(eyePos, eyeAngles)

		oldEyePos = position or oldEyePos
		eyeAngles = angles or eyeAngles
	end
	
	if (weapon.CalcViewModelView) then
		local position, angles = weapon:CalcViewModelView(viewModel, oldEyePos, oldEyeAngles, eyePos, eyeAngles)

		oldEyePos = position or oldEyePos
		eyeAngles = angles or eyeAngles
	end

	return oldEyePos, eyeAngles
end

function GM:LoadIntro()
	-- If skip intro is on
	if (true) then 
		if (IsValid(nut.gui.char)) then
			vgui.Create("nutCharMenu")
		end
	else

	end
end

function GM:InitializedConfig()
	hook.Run("LoadFonts", nut.config.get("font"), nut.config.get("genericFont"))
	
	if (!nut.config.loaded and !IsValid(nut.gui.loading)) then
		local loader = vgui.Create("EditablePanel")
		loader:ParentToHUD()
		loader:Dock(FILL)
		loader.Paint = function(this, w, h)
			surface.SetDrawColor(0, 0, 0)
			surface.DrawRect(0, 0, w, h)
		end

		local label = loader:Add("DLabel")
		label:Dock(FILL)
		label:SetText(L"loading")
		label:SetFont("nutTitleFont")
		label:SetContentAlignment(5)
		label:SetTextColor(color_white)

		timer.Simple(5, function()
			if (IsValid(nut.gui.loading)) then
				local fault = getNetVar("dbError")

				if (fault) then
					label:SetText(fault and L"dbError" or L"loading")

					local label = loader:Add("DLabel")
					label:DockMargin(0, 64, 0, 0)
					label:Dock(TOP)
					label:SetFont("nutSubTitleFont")
					label:SetText(fault)
					label:SetContentAlignment(5)
					label:SizeToContentsY()
					label:SetTextColor(Color(255, 50, 50))
				end
			end
		end)

		nut.gui.loading = loader
		nut.config.loaded = true

		hook.Run("LoadIntro")
	end
end

function GM:InitPostEntity()
	nut.joinTime = RealTime() - 0.9716
end

local vignette = nut.util.getMaterial("nutscript/gui/vignette.png")
local vignetteAlphaGoal = 0
local vignetteAlphaDelta = 0
local blurGoal = 0
local blurDelta = 0
local hasVignetteMaterial = vignette != "___error"

timer.Create("nutVignetteChecker", 1, 0, function()
	local client = LocalPlayer()

	if (IsValid(client)) then
		local data = {}
			data.start = client:GetPos()
			data.endpos = data.start + Vector(0, 0, 768)
			data.filter = client
		local trace = util.TraceLine(data)

		if (trace.Hit) then
			vignetteAlphaGoal = 80
		else
			vignetteAlphaGoal = 0
		end
	end
end)

local OFFSET_NORMAL = Vector(0, 0, 80)
local OFFSET_CROUCHING = Vector(0, 0, 48)

paintedEntitiesCache = {}

function GM:CalcView(client, origin, angles, fov)
	local view = self.BaseClass:CalcView(client, origin, angles, fov) or {}
	local entity = Entity(client:getLocalVar("ragdoll", 0))
	local ragdoll = client:GetRagdollEntity()

	if ((!client:ShouldDrawLocalPlayer() and IsValid(entity) and entity:IsRagdoll()) or 
		(!LocalPlayer():Alive() and IsValid(ragdoll))) then
	 	local ent = LocalPlayer():Alive() and entity or ragdoll
		local index = ent:LookupAttachment("eyes")

		if (index) then
			local data = ent:GetAttachment(index)

			if (data) then
				view.origin = data.Pos
				view.angles = data.Ang
			end
			
			return view
		end
	end

	return self.BaseClass:CalcView(client, origin, angles, fov)
end

local nextUpdate = 0
local lastTrace = {}
local lastEntity
local mathApproach = math.Approach
local surface = surface
local hookRun = hook.Run
local toScreen = FindMetaTable("Vector").ToScreen

function GM:HUDPaintBackground()
	local localPlayer = LocalPlayer()

	if (!localPlayer.getChar(localPlayer)) then
		return
	end
	
	local realTime = RealTime()
	local frameTime = FrameTime()
	local scrW, scrH = surface.ScreenWidth(), surface.ScreenHeight()

	if (hasVignetteMaterial) then
		vignetteAlphaDelta = mathApproach(vignetteAlphaDelta, vignetteAlphaGoal, frameTime * 30)

		surface.SetDrawColor(0, 0, 0, 175 + vignetteAlphaDelta)
		surface.SetMaterial(vignette)
		surface.DrawTexturedRect(0, 0, scrW, scrH)
	end

	if (localPlayer.getChar(localPlayer) and nextUpdate < realTime) then
		nextUpdate = realTime + 0.5

		lastTrace.start = localPlayer.GetShootPos(localPlayer)
		lastTrace.endpos = lastTrace.start + localPlayer.GetAimVector(localPlayer)*160
		lastTrace.filter = localPlayer		
		lastTrace.mins = Vector( -4, -4, -4 )
		lastTrace.maxs = Vector( 4, 4, 4 )
		lastTrace.mask = MASK_SHOT_HULL

		lastEntity = util.TraceHull(lastTrace).Entity

		if (IsValid(lastEntity) and (lastEntity.DrawEntityInfo or (lastEntity.onShouldDrawEntityInfo and lastEntity:onShouldDrawEntityInfo()) or hookRun("ShouldDrawEntityInfo", lastEntity))) then
			paintedEntitiesCache[lastEntity] = true
		end
	end
    
	for entity, drawing in pairs(paintedEntitiesCache) do
		if (IsValid(entity)) then
			local goal = drawing and 255 or 0
			local alpha = mathApproach(entity.nutAlpha or 0, goal, frameTime * 1000)

			if (lastEntity != entity) then
				paintedEntitiesCache[entity] = false
			end

			if (alpha > 0) then
				local client = entity.getNetVar(entity, "player")

				if (IsValid(client)) then
					local position = toScreen(entity.LocalToWorld(entity, entity.OBBCenter(entity)))

					hookRun("DrawEntityInfo", client, alpha, position)
				elseif (entity.onDrawEntityInfo) then
					entity.onDrawEntityInfo(entity, alpha)
				else
					hookRun("DrawEntityInfo", entity, alpha)
				end
			end

			entity.nutAlpha = alpha

			if (alpha == 0 and goal == 0) then
				paintedEntitiesCache[entity] = nil
			end
		else
			paintedEntitiesCache[entity] = nil
		end
	end

	blurGoal = localPlayer.getLocalVar(localPlayer, "blur", 0) + (hookRun("AdjustBlurAmount", blurGoal) or 0)

	if (blurDelta != blurGoal) then
		blurDelta = mathApproach(blurDelta, blurGoal, frameTime * 20)
	end

	if (blurDelta > 0 and !localPlayer.ShouldDrawLocalPlayer(localPlayer)) then
		nut.util.drawBlurAt(0, 0, scrW, scrH, blurDelta)
	end

	if (hook.Run("CanDrawAmmoHUD") != false) then
		local weapon = localPlayer.GetActiveWeapon(localPlayer)

		if (IsValid(weapon) and weapon.DrawAmmo != false) then
			local clip = weapon.Clip1(weapon)
			local count = localPlayer.GetAmmoCount(localPlayer, weapon.GetPrimaryAmmoType(weapon))
			local secondary = localPlayer.GetAmmoCount(localPlayer, weapon.GetSecondaryAmmoType(weapon))
			local x, y = scrW - 80, scrH - 80

			if (secondary > 0) then
				nut.util.drawBlurAt(x, y, 64, 64)

				surface.SetDrawColor(255, 255, 255, 5)
				surface.DrawRect(x, y, 64, 64)
				surface.SetDrawColor(255, 255, 255, 3)
				surface.DrawOutlinedRect(x, y, 64, 64)

				nut.util.drawText(secondary, x + 32, y + 32, nil, 1, 1, "nutBigFont")
			end

			if (weapon.GetClass(weapon) != "weapon_slam" and clip > 0 or count > 0) then
				x = x - (secondary > 0 and 144 or 64)

				nut.util.drawBlurAt(x, y, 128, 64)

				surface.SetDrawColor(255, 255, 255, 5)
				surface.DrawRect(x, y, 128, 64)
				surface.SetDrawColor(255, 255, 255, 3)
				surface.DrawOutlinedRect(x, y, 128, 64)

				nut.util.drawText(clip == -1 and count or clip.."/"..count, x + 64, y + 32, nil, 1, 1, "nutBigFont")
			end
		end
	end
	
	if (localPlayer.getLocalVar(localPlayer, "restricted") and !localPlayer.getLocalVar(localPlayer, "restrictNoMsg")) then
		nut.util.drawText(L"restricted", scrW * 0.5, scrH * 0.33, nil, 1, 1, "nutBigFont")
	end

	nut.menu.drawAll()
	nut.bar.drawAll()
	nut.hud.drawAll(false)
end

function GM:PostDrawHUD()
	nut.hud.drawAll(true)
end

function GM:ShouldDrawEntityInfo(entity)
	if (entity:IsPlayer() or IsValid(entity:getNetVar("player"))) then
		if (entity == LocalPlayer() and !LocalPlayer():ShouldDrawLocalPlayer()) then
			return false
		end

		return true
	end

	return false
end

local injTextTable = {
	[.3] = {"injMajor", Color(192, 57, 43)},
	[.6] = {"injLittle", Color(231, 76, 60)},
}

function GM:GetInjuredText(client)
	local health = client:Health()

	for k, v in pairs(injTextTable) do
		if ((health / LocalPlayer():GetMaxHealth()) < k) then
			return v[1], v[2]
		end
	end
end

local colorAlpha = ColorAlpha
local teamGetColor = team.GetColor
local drawText = nut.util.drawText

function GM:DrawCharInfo(client, character, info)
	local injText, injColor = hookRun("GetInjuredText", client)
    local reptext = client:getNetVar("rep", "Я робот долбаеб")
    local ranktext = client:getNetVar("rank", "Здесь должен быть ваш ранг")
    if (ranktext) then

    	if (ranktext > 12000) then
			info[#info + 1] = {"Ранг: Легенда", Color(230,255,25)}
		
		elseif (ranktext > 5200 and ranktext < 11999) then
			info[#info + 1] = {"Ранг: Мастер", Color(230,255,25)}
		
		elseif (ranktext > 3200 and ranktext < 5199) then
			info[#info + 1] = {"Ранг: Эксперт", Color(230,255,25)}
	
		elseif (ranktext > 2000 and ranktext < 3199) then
			info[#info + 1] = {"Ранг: Ветеран", Color(230,255,25)}
		
		elseif (ranktext > 1000 and ranktext < 1999) then
			info[#info + 1] = {"Ранг: Профессионал", Color(230,255,25)}
		
		elseif (ranktext > 600 and ranktext < 999) then
			info[#info + 1] = {"Ранг: Опытный", Color(230,255,25)}
		
		elseif (ranktext > 200 and ranktext < 599) then
			info[#info + 1] = {"Ранг: Стажер", Color(230,255,25)}
		
		elseif (ranktext < 199) then
			info[#info + 1] = {"Ранг: Новичок", Color(230,255,25)}
		end

		--info[#info + 1] = {ranktext, Color(230,255,25)}
	end
	if (reptext) then

		if (reptext > 2000) then
			info[#info + 1] = {"Репутация: Великолепно", Color(230,255,25)}
		
		elseif (reptext > 1000 and reptext < 1999) then
			info[#info + 1] = {"Репутация: Отлично", Color(230,255,25)}
		
		elseif (reptext > 500 and reptext < 999) then
			info[#info + 1] = {"Репутация: Оч. Хорошо", Color(230,255,25)}
		
		elseif (reptext > 100 and reptext < 499) then
			info[#info + 1] = {"Репутация: Хорошо", Color(230,255,25)}
		
		elseif (reptext > -29 and reptext < 99) then
			info[#info + 1] = {"Репутация: Безразлично", Color(230,255,25)}
		
		elseif (reptext > -79 and reptext < -30) then
			info[#info + 1] = {"Репутация: Плохо", Color(230,255,25)}
		
		elseif (reptext > -299 and reptext < -80) then
			info[#info + 1] = {"Репутация: Оч. Плохо", Color(230,255,25)}
		
		elseif (reptext > -599 and reptext < -300) then
			info[#info + 1] = {"Репутация: Ужасно", Color(230,255,25)}
		
		elseif (reptext < -600) then
			info[#info + 1] = {"Репутация: Хуже всех", Color(230,255,25)}
		end

		--info[#info + 1] = {reptext, Color(230,255,25)}
	end
	if (injText) then
		info[#info + 1] = {L(injText), injColor}
	end
end

local charInfo = {}

function GM:DrawEntityInfo(entity, alpha, position)
	if (entity.IsPlayer(entity)) then
		local localPlayer = LocalPlayer()
		local character = entity.getChar(entity)
		
		position = position or toScreen(entity.GetPos(entity) + (entity.Crouching(entity) and OFFSET_CROUCHING or OFFSET_NORMAL))

		if (character) then
			local x, y = position.x, position.y
			local ty = 0

			charInfo = {}   
			charInfo[1] = {hookRun("GetDisplayedName", entity) or character.getName(character), teamGetColor(192, 192, 192)}

			local description = character.getDesc(character)

			if (description != entity.nutDescCache) then
				entity.nutDescCache = description
				entity.nutDescLines = nut.util.wrapText(description, ScrW() * 0.7, "nutSmallFont")
			end

			for i = 1, #entity.nutDescLines do
				charInfo[#charInfo + 1] = {entity.nutDescLines[i]}
			end

			hookRun("DrawCharInfo", entity, character, charInfo)

			for i = 1, #charInfo do
				local info = charInfo[i]
				
				_, ty = drawText(info[1], x, y, colorAlpha(info[2] or color_white, alpha), 1, 1, "nutSmallFont")
				y = y + ty
			end
		end
	end
end

--[[if (bind:find("gm_showhelp") and pressed) then
		if (!:Loca;Player():Alive()) then
				if (IsValid(nut.gui.menu)) then
				nut.gui.menu:remove()
			end
			return
		end
		if (IsValid(nut.gui.menu)) then
			nut.gui.menu:remove()
		elseif (LocalPlayer():getChar()) then
			vgui.Create("nutMenu")
		end]]

function GM:PlayerBindPress(client, bind, pressed)
	bind = bind:lower()
	
	if (bind:find("gm_showhelp") and pressed) then
		if (!LocalPlayer():Alive()) then
				if (IsValid(nut.gui.menu)) then
				nut.gui.menu:remove()
			end
			return
		end
		if (IsValid(nut.gui.menu)) then
			nut.gui.menu:remove()
		elseif (LocalPlayer():getChar()) then
			vgui.Create("nutMenu")
		end

		return true
	elseif ((bind:find("use") or bind:find("attack")) and pressed) then
		local menu, callback = nut.menu.getActiveMenu()

		if (menu and nut.menu.onButtonPressed(menu, callback)) then
			return true
		elseif (bind:find("use") and pressed) then
			local data = {}
				data.start = client:GetShootPos()
				data.endpos = data.start + client:GetAimVector()*96
				data.filter = client
			local trace = util.TraceLine(data)
			local entity = trace.Entity

			if (IsValid(entity) and entity:GetClass() == "nut_item") then
				hook.Run("ItemShowEntityMenu", entity)
			end
		end
	elseif (bind:find("jump")) then
		nut.command.send("chargetup")
	elseif (bind:find("speed") and client:KeyDown(IN_WALK) and pressed) then
		if (LocalPlayer():Crouching()) then
			RunConsoleCommand("-duck")
		else
			RunConsoleCommand("+duck")
		end
	end
end

-- Called when use has been pressed on an item.
function GM:ItemShowEntityMenu(entity)
	for k, v in ipairs(nut.menu.list) do
		if (v.entity == entity) then
			table.remove(nut.menu.list, k)
		end
	end

	local options = {}
	local itemTable = entity:getItemTable()

	if (!itemTable) then
		nut.util.notifyLocalized("tellAdmin", "wid!xt_cl")
		return false
	end

	local function callback(index)
		if (IsValid(entity)) then
			netstream.Start("invAct", index, entity)
		end
	end

	itemTable.player = LocalPlayer()
	itemTable.entity = entity

	for k, v in SortedPairs(itemTable.functions) do
		if (k == "combine") then continue end -- yeah, noob protection

		if (v.onCanRun) then
			if (v.onCanRun(itemTable) == false) then
				continue
			end
		end

		options[L(v.name or k)] = function()
			local send = true

			if (v.onClick) then
				send = v.onClick(itemTable)
			end

			if (v.sound) then
				surface.PlaySound(v.sound)
			end

			if (send != false) then
				callback(k)
			end
		end
	end

	if (table.Count(options) > 0) then
		entity.nutMenuIndex = nut.menu.add(options, entity)
	end

	itemTable.player = nil
	itemTable.entity = nil
end

local hidden = {}
hidden["CHudHealth"] = true
hidden["CHudBattery"] = true
hidden["CHudAmmo"] = true
hidden["CHudSecondaryAmmo"] = true
hidden["CHudCrosshair"] = true
hidden["CHudHistoryResource"] = true

function GM:HUDShouldDraw(element)
	if (hidden[element]) then
		return false
	end

	return true
end

function GM:SetupQuickMenu(menu)
	-- Performance
	menu:addCheck(L"cheapBlur", function(panel, state)
		if (state) then
			RunConsoleCommand("nut_cheapblur", "1")
		else
			RunConsoleCommand("nut_cheapblur", "0")
		end
	end, NUT_CVAR_CHEAP:GetBool())

	-- Language settings
	menu:addSpacer()

	local current

	for k, v in SortedPairs(nut.lang.stored) do
		local name = nut.lang.names[k]
		local name2 = k:sub(1, 1):upper()..k:sub(2)
		local enabled = NUT_CVAR_LANG:GetString():match(k)

		if (name) then
			name = name.." ("..name2..")"
		else
			name = name2
		end

		local button = menu:addCheck(name, function(panel)
			panel.checked = true
			
			if (IsValid(current)) then
				if (current == panel) then
					return
				end

				current.checked = false
			end

			current = panel
			RunConsoleCommand("nut_language", k)
		end, enabled)

		if (enabled and !IsValid(current)) then
			current = button
		end
	end

	-- Appearance
	menu:addSpacer()

	menu:addCheck(L"altLower", function(panel, state)
		if (state) then
			RunConsoleCommand("nut_usealtlower", "1")
		else
			RunConsoleCommand("nut_usealtlower", "0")
		end
	end, NUT_CVAR_LOWER2:GetBool())
end

function GM:ShouldDrawLocalPlayer(client)
	if (IsValid(nut.gui.char) and nut.gui.char:IsVisible()) then
		return false
	end
end

function GM:OnCharInfoSetup(infoPanel)
	if (infoPanel.model) then
		-- Get the F1 ModelPanel.
		local mdl = infoPanel.model
		local ent = mdl.Entity
		local client = LocalPlayer()

		if (client and client:Alive() and IsValid(client:GetActiveWeapon())) then
			local weapon = client:GetActiveWeapon()
			local weapModel = ClientsideModel(weapon:GetModel(), RENDERGROUP_BOTH)

			if (weapModel) then
				weapModel:SetParent(ent)
				weapModel:AddEffects(EF_BONEMERGE)
				weapModel:SetSkin(weapon:GetSkin())
				weapModel:SetColor(weapon:GetColor())
				weapModel:SetNoDraw(true)
				ent.weapon = weapModel

				local act = ACT_MP_STAND_IDLE
				local model = ent:GetModel():lower()
				local class = nut.anim.getModelClass(model)
				local tree = nut.anim[class]

				if (tree) then
					local subClass = weapon.HoldType or weapon:GetHoldType()
					subClass = HOLDTYPE_TRANSLATOR[subClass] or subClass

					if (tree[subClass] and tree[subClass][act]) then
						local branch = tree[subClass][act]
						local act2 = type(branch) == "table" and branch[1] or branch

						if (type(act2) == "string") then
							act2 = ent:LookupSequence(act2)

							return
						else
							act2 = ent:SelectWeightedSequence(act2)
						end

						ent:ResetSequence(act2)
					end
				end
			end
		end
	end
end

function GM:ShowPlayerOptions(client, options)
	options["viewProfile"] = {"icon16/user.png", function()
		if (IsValid(client)) then
			client:ShowProfile()
		end	
	end}
	options["Copy Steam ID"] = {"icon16/user.png", function()
		if (IsValid(client)) then
			SetClipboardText(client:SteamID())
		end
	end}
end

function GM:DrawNutModelView(panel, ent, client)

	--	local weapon = LocalPlayer():GetActiveWeapon()
	--	local weapon = ClientsideModel( "models/thrusters/jetpack.mdl" )

		if (weapon or IsValid(weapon)) then
			weapon:DrawModel()
		end

	--[[if (ent.weapon and IsValid(ent.weapon)) then
		ent.weapon:DrawModel()
	end]]
end

netstream.Hook("strReq", function(time, title, subTitle, default)
	if (title:sub(1, 1) == "@") then
		title = L(title:sub(2))
	end

	if (subTitle:sub(1, 1) == "@") then
		subTitle = L(subTitle:sub(2))
	end

	Derma_StringRequest(title, subTitle, default or "", function(text)
		netstream.Start("strReq", time, text)
	end)
end)

function GM:PostPlayerDraw(client)
	if (client and client:getChar() and client:GetNoDraw() != true) then
		local wep = client:GetActiveWeapon()
		local curClass = ((wep and wep:IsValid()) and wep:GetClass():lower() or "")

		for k, v in ipairs(client:GetWeapons()) do
			if (v and IsValid(v)) then
				local class = v:GetClass():lower()
				local drawInfo = HOLSTER_DRAWINFO[class]

				if (drawInfo and drawInfo.model) then
					client.holsteredWeapons = client.holsteredWeapons or {}

					if (!client.holsteredWeapons[class] or !IsValid(client.holsteredWeapons[class])) then
						client.holsteredWeapons[class] = ClientsideModel(drawInfo.model, RENDERGROUP_TRANSLUCENT)
						client.holsteredWeapons[class]:SetNoDraw(true)
					end

					local drawModel = client.holsteredWeapons[class]
					local boneIndex = client:LookupBone(drawInfo.bone)

					if (boneIndex and boneIndex > 0) then
						local bonePos, boneAng = client:GetBonePosition(boneIndex)

						if (curClass != class and drawModel and IsValid(drawModel)) then
							local Right 	= boneAng:Right()
							local Up 		= boneAng:Up()
							local Forward 	= boneAng:Forward()	

							boneAng:RotateAroundAxis(Right, drawInfo.ang[1])
							boneAng:RotateAroundAxis(Up, drawInfo.ang[2])
							boneAng:RotateAroundAxis(Forward, drawInfo.ang[3])

							bonePos = bonePos + drawInfo.pos[1] * Right
							bonePos = bonePos + drawInfo.pos[2] * Forward
							bonePos = bonePos + drawInfo.pos[3] * Up

							drawModel:SetRenderOrigin(bonePos)
							drawModel:SetRenderAngles(boneAng)
							drawModel:DrawModel()
						end
					end
				end
			end
		end

		if (client.holsteredWeapons) then
			for k, v in pairs(client.holsteredWeapons) do
				local weapon = client:GetWeapon(k)

				if (!weapon or !IsValid(weapon)) then
					v:Remove()
				end
			end
		end
	end
end

function GM:ScreenResolutionChanged(oldW, oldH)
	RunConsoleCommand("fixchatplz")
	hook.Run("LoadFonts", nut.config.get("font"), nut.config.get("genericFont"))
end

function GM:DrawDeathNotice()
	return false
end

function GM:HUDAmmoPickedUp()
	return false
end

function GM:HUDDrawPickupHistory()
	return false
end

function GM:HUDDrawTargetID()
	return false
end

surface.CreateFont("nut_MenuButtonFont", {
	font = mainFont,
	size = ScreenScale(10),
	weight = 1000,
	antialias = true
})

surface.CreateFont("nut_MenuButtonFont2", {
	font = mainFont,
	size = ScreenScale(11),
	weight = 1000,
	antialias = true
})

	local gradient = surface.GetTextureID("gui/gradient_up")
	local gradient2 = surface.GetTextureID("gui/gradient_down")
	local gradient3 = surface.GetTextureID("gui/center_gradient")
	local gradient4 = surface.GetTextureID("gui/gradient")
	
	local PANEL = {}

	function PANEL:Init()
		surface.SetFont("nut_MenuButtonFont")
		local _, height = surface.GetTextSize("W")

		self:SetTall(height + 16)
		self:DockMargin(0, 0, 0, 8)
		self:Dock(TOP)
		self:SetDrawBackground(false)
		self:SetContentAlignment( 5 )
		self:SetFont("nut_MenuButtonFont2")
		self:SetTextColor(Color(240, 240, 240))
		self:SetExpensiveShadow(1, color_black)
		self.colorApproach = 0
		self.colore = 0
	end
	function PANEL:OnHover() end
	function PANEL:OnUnHover() end
	function PANEL:OnCursorEntered()
		surface.PlaySound("weapons/smg1/switch_single.wav")
		self.colore = 1
		self:OnHover()
	end
	function PANEL:OnCursorExited()
		self.colore = 0
		self:OnUnHover()
	end
	function PANEL:Paint(w, h)
		self.colorApproach = math.Approach(self.colorApproach, self.colore, FrameTime() * 4)
		local blink = 0
		if (self.alphaApproach == HOVER_COLOR) then
			blink = math.abs(math.sin(RealTime() * 2))/2
		end			
		surface.SetDrawColor(100*self.colorApproach, 100*self.colorApproach, 0, 120)
		surface.SetTexture(gradient3)
		surface.DrawTexturedRect(0, h*.1, w, h*.8)
	end
	vgui.Register("nut_MainMenuButton", PANEL, "DButton")



	local PANEL = {}
	
	local line = .1

	function PANEL:Init()
		self:SetSize(ScrW(), ScrH())
		self:SetDrawBackground(false)
		self:DockPadding(ScrW()*line/2,ScrH()*line*1.5,ScrW()*line/2,ScrH()*line*1.5)
							self:MakePopup()

		self.title = self:Add("DLabel")
		self.title:Dock(TOP)
		self.title:SetText(SCHEMA.name)
		self.title:SetFont("nut_TitleFont")
		self.title:SizeToContents()
		self.title:SetContentAlignment( 5 )
		self.title:SetTextColor(color_white)
		self.title:SetExpensiveShadow(3, color_black)
		self.title.Paint = function(panel, w, h)
			surface.SetDrawColor(0, 0, 0, 125)
			surface.SetTexture(gradient3)
			surface.DrawTexturedRect(w * 0.25, 0, w * 0.5, h)
		end
		
		self.subTitle = self:Add("DLabel")
		self.subTitle:Dock(TOP)
		self.subTitle:SetText(SCHEMA.desc)
		self.subTitle:SetFont("nut_SubTitleFont")
		self.subTitle:SizeToContents()
		self.subTitle:SetContentAlignment( 5 )
		self.subTitle:SetTextColor(color_white)
		self.subTitle:SetExpensiveShadow(2, color_black)

		self.rightPanel = self:Add("DPanel")
		self.rightPanel:Dock(LEFT)
		self.rightPanel:DockMargin(0, 0, 0, 0)
		self.rightPanel:SetWide(ScrW() * 0.1)
		self.rightPanel.Paint = function(panel, w, h)
		end
		
		self.selectPanel = self:Add("DPanel")
		self.selectPanel:Dock(RIGHT)
		self.selectPanel:DockMargin(32, 0, 0, 0)
		self.selectPanel:SetWide(ScrW() * 0.2)
		self.selectPanel.Paint = function(panel, w, h)
		end
		
		local MODEL_ANGLE = Angle(0, 30, 0)
		local MODEL_VECTOR = Vector(0, 0, -2)
		self.model = self:Add("DModelPanel")
		self.model:SetSize( self:GetWide()/3, self:GetTall()-self:GetTall()*(line*2) )
		self.model:SetPos( self:GetWide()/3*1.7, self:GetTall()*line)
		self.model:ParentToHUD( )
	--	self.model:DockMargin(ScrW() * 0.175, ScrH() * 0.05, 0, ScrH() * 0.05)
		self.model:SetFOV(40)
		self.model.OnCursorEntered = function() end
		self.model:SetDisabled(true)
		self.model:SetCursor("none")
		local SetModel = self.model.SetModel

		self.model.SetModel = function(panel, model)
			SetModel(panel, model)

			local entity = panel.Entity
			local sequence = entity:LookupSequence("idle")

			if (sequence <= 0) then
				sequence = entity:LookupSequence("idle_subtle")
			end

			if (sequence <= 0) then
				sequence = entity:LookupSequence("batonidle2")
			end

			if (sequence <= 0) then
				sequence = entity:LookupSequence("idle_unarmed")
			end

			if (sequence <= 0) then
				sequence = entity:LookupSequence("idle01")
			end

			if (sequence > 0) then
				entity:ResetSequence(sequence)
			end
		end	
	
		self.model.LayoutEntity = function(panel, entity)
			if (!IsValid(self)) then
				panel:Remove()
			
				return
			end
			
			local xRatio = gui.MouseX() / ScrW()
			local yRatio = gui.MouseY() / ScrH()

			entity:SetPoseParameter("head_pitch", yRatio*60 - 30)
			entity:SetPoseParameter("head_yaw", (xRatio - 0.75)*60)
			entity:SetIK( false )
			entity:SetAngles(MODEL_ANGLE)
			entity:SetPos(MODEL_VECTOR)

			panel:RunAnimation()
		end
	
		
		local function addMainButton(variable, text)
			local button = self.rightPanel:Add("nut_MainMenuButton")
			button:Dock(BOTTOM)
			button:DockMargin(0, 0, 0, 0)
			button:SetText(text)
			button:SetTall(ScrH()*.05)
	
			self[variable] = button
		end
	
		addMainButton("leave", nut.loaded and nut.lang.Get("return") or nut.lang.Get("leave"))
		self.leave:SetTextColor( Color( 240, 160, 160 ) )
		self.leave.DoClick = function()
			if (LocalPlayer().character) then
				if (IsValid(nut.gui.charCreate)) then
					return false
				end

				self:FadeOutMusic()

				if (IsValid(self.model)) then
					self.model:Remove()
				end

				self:Remove()
			else
				RunConsoleCommand("disconnect")
			end
		end
		
		if (LocalPlayer().characters and table.Count(LocalPlayer().characters) > 0) then -- (nut.faction.Count() > 0)
			addMainButton("delete", nut.lang.Get("delete"))
			self.delete.DoClick = function()
				surface.PlaySound("buttons/lightswitch2.wav")
				self.selectPanel:Clear()
				
				for _, v in pairs(LocalPlayer().characters) do
					if !v.name then continue end
					local button = self.selectPanel:Add("nut_MainMenuButton")
					button:Dock(BOTTOM)
					button:DockMargin(0, 0, 0, 0)
					button:SetTextColor( Color( 255, 199, 199 ) )
					button:SetText(v.name)
					button:SetTall(ScrH()*.05)
					button.id = v.id
					button.DoClick = function()
						if (IsValid(nut.gui.charCreate)) then
							return false
						end
						
						if (!v.id) then
							return false
						end

						Derma_Query("Are you sure you want to delete this character? It can not be undone.", "Confirm", "No", nil, "Yes", function()
							button:Remove()
							button = nil

							netstream.Start("nut_CharDelete", v.id)

							for k, a in pairs(LocalPlayer().characters) do
								if (a.id == v.id) then
									LocalPlayer().characters[k] = nil
								end
							end

							surface.PlaySound("buttons/button9.wav")

							timer.Simple(0, function()
								if (IsValid(nut.gui.charMenu)) then
									nut.gui.charMenu:FadeOutMusic()
									nut.gui.charMenu:Remove()
								end
								nut.gui.charMenu = vgui.Create("nut_CharMenu")
							end)
						end)
					end
					button.OnHover = function()		
						surface.PlaySound("buttons/lightswitch2.wav")
						self.model:SetModel(v.model)
					end
					button.OnUnHover = function()
						self.model:SetModel("models/effects/teleporttrail.mdl")
					end
				end
			end
		end
		if (LocalPlayer().characters and table.Count(LocalPlayer().characters) > 0) then -- (nut.faction.Count() > 0)
			addMainButton("load", nut.lang.Get("choose"))
			self.load.DoClick = function()
				surface.PlaySound("buttons/lightswitch2.wav")
				self.selectPanel:Clear()
				
				for _, v in pairs(LocalPlayer().characters) do
					if !v.name then continue end
					local button = self.selectPanel:Add("nut_MainMenuButton")
					button:Dock(BOTTOM)
					button:DockMargin(0, 0, 0, 0)
					button:SetText(v.name)
					button:SetTall(ScrH()*.05)
					button.id = v.id
					button.DoClick = function()
						surface.PlaySound("buttons/button4.wav")	

						if (v.id) then
							netstream.Start("nut_CharChoose", v.id)
						else
							return false
						end
					end
					button.OnHover = function()		
						surface.PlaySound("buttons/lightswitch2.wav")
						self.model:SetModel(v.model)
					end
					button.OnUnHover = function()
						self.model:SetModel("models/effects/teleporttrail.mdl")
					end
				end
			end
		end
	
		if (nut.faction.Count() > 0) then -- (nut.faction.Count() > 0)
			addMainButton("create", nut.lang.Get("create"))
			self.create.DoClick = function()
				surface.PlaySound("buttons/lightswitch2.wav")
				self.selectPanel:Clear()
				
				for k, v in ipairs(nut.faction.GetAll()) do
					if (nut.faction.CanBe(LocalPlayer(), v.index)) then
						local button = self.selectPanel:Add("nut_MainMenuButton")
						button:Dock(BOTTOM)
						button:DockMargin(0, 0, 0, 0)
						button:SetText(v.name)
						button:SetTall(ScrH()*.05)
						button.DoClick = function()
							surface.PlaySound("buttons/button4.wav")	

							if (LocalPlayer().characters and table.Count(LocalPlayer().characters) >= nut.config.maxChars) then
								return false
							end
							nut.gui.charCreate = vgui.Create("nut_CharCreate")
							nut.gui.charCreate:SetupFaction(k)
						end
					end
				end
			end
		end

		if (nut.config.menuMusic) then
			if (nut.menuMusic) then
				nut.menuMusic:Stop()
				nut.menuMusic = nil
			end

			local lower = string.lower(nut.config.menuMusic)

			if (string.Left(lower, 4) == "http") then
				local function createMusic()
					if (!IsValid(nut.gui.charMenu)) then
						return
					end

					local nextAttempt = 0

					sound.PlayURL(nut.config.menuMusic, "noplay", function(music)
						if (music) then
							nut.menuMusic = music
							nut.menuMusic:Play()

							timer.Simple(0.5, function()
								if (!nut.menuMusic) then
									return
								end
								
								nut.menuMusic:SetVolume(nut.config.menuMusicVol / 100)
							end)
						elseif (nextAttempt < CurTime()) then
							nextAttempt = CurTime() + 1
							createMusic()
						end
					end)
				end

				createMusic()
			else
				nut.menuMusic = CreateSound(LocalPlayer(), nut.config.menuMusic)
				nut.menuMusic:Play()
				nut.menuMusic:ChangeVolume(nut.config.menuMusicVol / 100, 0)
			end
		end

		nut.loaded = true
	end

	function PANEL:FadeOutMusic()
		if (!nut.menuMusic) then
			return
		end

		if (nut.menuMusic.SetVolume) then
			local start = CurTime()
			local finish = CurTime() + nut.config.menuMusicFade

			if (timer.Exists("nut_FadeMenuMusic")) then
				timer.Remove("nut_FadeMenuMusic")

				if (nut.menuMusic) then
					nut.menuMusic:Stop()
					nut.menuMusic = nil
				end
			end

			timer.Create("nut_FadeMenuMusic", 0, 0, function()
				local fraction = (1 - math.TimeFraction(start, finish, CurTime())) * nut.config.menuMusicVol

				if (nut.menuMusic) then
					nut.menuMusic:SetVolume(fraction / 100)

					if (fraction <= 0) then
						nut.menuMusic:SetVolume(0)
						nut.menuMusic:Stop()
						nut.menuMusic = nil
					end
				end
			end)
		else
			nut.menuMusic:FadeOut(nut.config.menuMusicFade)
			nut.menuMusic = nil
		end
	end

	
	function PANEL:Paint(w, h)		
		surface.SetDrawColor(0, 0, 0,255)
		surface.DrawRect(0, 0, w, h*line)
		surface.DrawRect(0, h-h*line, w, h*line)
	end
vgui.Register("nut_CharMenu", PANEL, "DPanel")