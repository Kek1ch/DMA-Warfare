local PLUGIN = PLUGIN
PLUGIN.name = "Детекторы для Артефактов"
PLUGIN.author = "Патринка"
PLUGIN.desc = "Add Detectors sweps"
PLUGIN.warningAnom = false -- предупреждении если типо близко аномалия  true включить false выключить
PLUGIN.showAnom = true -- Видно артефакт если нету детектора в руках? 
PLUGIN.clearAnom = false-- Если артефакт выкинуть из инвентаря, спустя какое то время, он удалиться.
PLUGIN.wepDetectors = { ["weapon_cop_detector"] = true, ["weapon_cop_echo"] = true, ["weapon_cop_medved"] = true, ["weapon_cop_veles"] = true, }

nut.config.add("clearAnom", 300, "Через сколько сек. удалять выброшенный артефакт", nil, {
	data = {min = 1, max = 3600},
	category = "artifacts"
})

nut.util.include("sv_plugin.lua")

local find, ipairs, IsValid = ents.FindByClass, ipairs, IsValid
if (CLIENT) then
	if (PLUGIN.warningAnom) then
		local detRange = { ["weapon_cop_detector"] = 300, ["weapon_cop_echo"] = 400, ["weapon_cop_medved"] = 500, ["weapon_cop_veles"] = 600, }
		
		local indicator = surface.GetTextureID("effects/select_ring")
		local SCRW, SCRH, clamp = ScrW(), ScrH(), math.Clamp
		function PLUGIN:HUDPaint()
			local ply = LocalPlayer()
			
			if (!IsValid(ply) or !ply:getChar()) then return end
			local wep = ply:GetActiveWeapon()
			if (IsValid(wep) and self.wepDetectors[wep:GetClass()]) then
				local range = detRange[wep:GetClass()]
				local scale, pos, col
				surface.SetTexture(indicator)
				for _, a in ipairs(find("anom_*")) do
					if a:GetPos():Distance(ply:GetPos()) > range then continue end
					scale = 1 - clamp(a:GetPos():Distance(ply:GetPos()) / range, 0, 1)
					pos = a:GetPos():ToScreen()
					pos.x = clamp(pos.x, 25, SCRW - 25)
					pos.y = clamp(pos.y, 25, SCRH - 25)
					col = Color(210, 105, 30, scale * 255)
					surface.SetDrawColor(col)
					surface.DrawTexturedRect(pos.x - 25, pos.y - 25, 50, 50)
					draw.SimpleText("!", "nutMediumLightFont", pos.x, pos.y, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			end
		end
	end
	
	if (PLUGIN.showAnom) then
		local function findArtifacts(bool)
			netstream.Start("showAnomalyChecked", bool)
		end
		
		local CurTime = CurTime
		local nThink = 0
		function PLUGIN:PlayerPostThink(player)
			if (nThink <= CurTime()) then
				if (IsValid(player) and player:getChar()) then
					local wep = player:GetActiveWeapon()
					if (IsValid(wep) and self.wepDetectors[wep:GetClass()]) then
						findArtifacts(true)
					else
						findArtifacts(false)
					end
				end
				nThink = CurTime() + 1
			end
		end
		
		netstream.Hook("showAnomalyResult", function(v, bool)
			if (!IsValid(v)) then return end
			--if (!getItemTable) then return end
			local itm = v:getItemTable()
			if (itm and itm.isAnomaly) then
				if (bool == true) then
					function v:Draw() v:DrawModel() end
					v:SetNoDraw(false)
					v.DrawEntityInfo = true
					itm.functions.take = { onCanRun = function(item) IsValid(item.entity) end }
				elseif (bool == false) then
					function v:Draw() return false end
					v:SetNoDraw(true)
					v.DrawEntityInfo = false
					itm.functions.take = { onCanRun = function() return false end }
				end
			end
		end)
	end
end

if (PLUGIN.showAnom) then
	netstream.Hook("showAnomalyChecked", function(player, bool)
		if (!player) then return end
		for _, v in ipairs(find("nut_item")) do
			if (IsValid(v) and v.nutItemID) then
				local itm = nut.item.instances[v.nutItemID]
				if (itm and itm.isAnomaly and !itm:getData("anomPickup")) then
					netstream.Start(player, "showAnomalyResult", v, bool)
				end
			end
		end
	end)
end