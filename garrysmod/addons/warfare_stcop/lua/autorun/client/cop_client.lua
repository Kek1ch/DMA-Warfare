local COP_Addons

local function COP_GiveAddon(um)
	local att = um:ReadString()

	if not COP_Addons then
		COP_Addons = {}
	end

	if not table.HasValue(COP_Addons, att) then
		table.insert(COP_Addons, att)

		surface.PlaySound("weapons/stalker_cop/inv_ruck.wav")
		hook.Run("HUDItemPickedUp", "COP_ADDON_" .. string.upper(att))
	end
end

usermessage.Hook("COP_GIVEADDON", COP_GiveAddon)

function stalker_cop.GetAddons()
	local t = {}

	if COP_Addons then
		for i = 1, #COP_Addons do
			table.insert(t, COP_Addons[i])
		end
	end

	return t
end

function stalker_cop.HasAddon(att)
	if not COP_Addons then
		return false
	end

	return table.HasValue(COP_Addons, att)
end



local function CreateSlider(text, cvar, min, max, dec)
	local slider = vgui.Create("DNumSlider")
	slider:SetMin(min)
	slider:SetMax(max)
	slider:SetDecimals(dec or 0)
	slider:SetConVar(cvar)
	slider:SetValue(GetConVarNumber(cvar))
	slider:SetText(text)
	return slider
end

local function CreateDropBox(text, convar, choices, func)
	local ComboBox = vgui.Create("DComboBox")
	ComboBox:SetText(tostring(text))
	for k, v in pairs(choices) do
		ComboBox:AddChoice(v)
	end
	ComboBox.OnSelect = function(panel, index, value, data)
		RunConsoleCommand(convar, tonumber(index))
		func(convar, tonumber(index), value, data)
	end
	return ComboBox
end

local function COP_CLPanel(panel)
	panel:ClearControls()

	local Hands    = { "Default", "Exoskeleton" }
	local TexCount = { 11, 3 }

	local item2 = CreateSlider("SLEEVES: Texture", "cop_handtex", 0, 11)
	local item1 = CreateDropBox("SLEEVES: Style",   "cop_hands",   Hands, function(cvar, index, value)
		local tex_count = TexCount[index]

		if tex_count then
			item2:SetMax(tex_count)
		end
	end)

	panel:AddItem(item1)
	panel:AddItem(item2)

	panel:AddControl("CheckBox", { Label = "CROSSHAIR: Dynamic", Command = "cop_crosshair_dynamic" })
end

local function COP_SVPanel(panel)
	panel:ClearControls()

	if not LocalPlayer():IsAdmin() then
		panel:AddControl("Label", { Text = "RESTRICTED" })
		return
	end

	for k, v in pairs(stalker_cop.Addons) do
		panel:AddControl("CheckBox", { Label = "Spawn with a " .. v.name .. "?", Description = "", Command = "cop_upgrade_" .. k })
	end

	panel:AddControl("Label",    { Text = "" })
	panel:AddControl("CheckBox", { Label = "CROSSHAIR: Enabled", Command = "cop_crosshair_enabled" })
end

local function COP_PopulateToolMenu()
	spawnmenu.AddToolMenuOption("Utilities", "Call of Pripyat SWEPs", "Client", "Client", "", "", COP_CLPanel)
	spawnmenu.AddToolMenuOption("Utilities", "Call of Pripyat SWEPs", "Admin",  "Admin",  "", "", COP_SVPanel)
end

hook.Add("PopulateToolMenu", "COP_PopulateToolMenu", COP_PopulateToolMenu)