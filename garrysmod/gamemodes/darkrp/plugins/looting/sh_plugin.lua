PLUGIN.name = "Looting"
PLUGIN.author = "orc, thadah, hikka (fix), kek1ch"
PLUGIN.desc = "A plugin for dropping player inventory on death."

PLUGIN.ignored = PLUGIN.ignored or {}
PLUGIN.ignored = PLUGIN.equip or {}

nut.util.include("sh_ignored.lua")
nut.util.include("sv_plugin.lua")

nut.config.add("lootTime", 360, "Number of seconds before loot disappears.", nil, {
	data = {min = 1, max = 86400},
	category = "Looting"
})

if (CLIENT) then
	netstream.Hook("lootOpen", function(entity, index)
		local inventory = nut.item.inventories[index]
		local ply = LocalPlayer()
		local char = ply:getChar()

		if (IsValid(nut.gui.inv1)) or (IsValid(invent_info_kek)) or (IsValid(equipment_panel)) or (IsValid(equipment)) then return false end

		if (IsValid(entity) and inventory and inventory.slots) and (char) then
			nut.gui.inv1 = vgui.Create("nutInventory")
			nut.gui.inv1:ShowCloseButton(false)
			local inventory2 = char:getInv()
			if (inventory2) then nut.gui.inv1:setInventory(inventory2) end
			nut.gui.inv1:SetSize(nut.gui.inv1:GetWide(), nut.gui.inv1:GetTall())
			nut.gui.inv1:SetPos(ScrW()*0.6592, ScrH()*0.29)

			invent_info_kek = vgui.Create("invent_info_kek")
			invent_info_kek:SetPos(ScrW()*0.6592, ScrH()*0.067)
			invent_info_kek:SetSize(invent_info_kek:GetSize())

			case_info_kek = vgui.Create("safe_info_kek")
			case_info_kek:SetPos(ScrW()*0.035, ScrH()*0.067)
			case_info_kek:SetSize(case_info_kek:GetSize())
			--case_info_kek:setup()

			equipment_panel = vgui.Create("equipment_panel")
			equipment_panel:SetPos(ScrW()*0.35, ScrH()*0.29)
			equipment_panel:SetSize(equipment_panel:GetSize())

			safebox_menuINV = vgui.Create("nutInventory")
			safebox_menuINV:ShowCloseButton(false)
			safebox_menuINV:SetTitle("")
			safebox_menuINV:setInventory(inventory)
			safebox_menuINV:SetPos(ScrW()*0.035, ScrH()*0.29)
			safebox_menuINV.OnClose = function(this)
				if (IsValid(nut.gui.inv1) and !IsValid(nut.gui.menu)) then
					nut.gui.inv1:Remove()
					invent_info_kek:Remove()
					equipment_panel:Remove()
					case_info_kek:Remove()
				end
				netstream.Start("lootExit", entity)
			end

			function safebox_menuINV:Paint(w, h)
				nut.util.drawBlur(self, 10)
				surface.SetDrawColor(Color( 20, 20, 20, 220))
				surface.DrawRect( 0, 0, w, h )
				surface.DrawOutlinedRect(0, 0, w, h)

				surface.SetDrawColor(0, 0, 14, 150)
				surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033)

				surface.SetDrawColor(Color( 30, 30, 30, 90))
				surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033) --шапка

				draw.DrawText("Инвентарь", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

				surface.SetDrawColor(Color( 138, 149, 151, 60))
				surface.DrawLine(ScrW() * 0.018, ScrH() * 0.0325, ScrW() * 0.29, ScrH() * 0.0325)

				surface.SetDrawColor(Color(  0, 33, 55, 210))
				surface.DrawRect(ScrW() * 0.017, ScrH() * 0.059, ScrW() * 0.2715, ScrH() * 0.027) --верхняя панель крафта

				draw.DrawText("Рюкзак", "Roh20", ScrW() * 0.02, ScrH() * 0.06, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

				surface.SetDrawColor(Color( 0, 0, 0, 255))
				surface.DrawOutlinedRect(ScrW() * 0.0165, ScrH() * 0.059, ScrW() * 0.273, ScrH() * 0.53) --обводка модели игрока

				surface.SetDrawColor( Color(125, 105, 0, 40) )
				surface.SetMaterial( Material("lgh/circle_gradient.png") )
				surface.DrawTexturedRectUV( -ScrW() * 0.01, ScrH() * 0.657, ScrW() * 0.35, ScrH() * 0.032, 1, 0.9, 0, 0.3 )
			end

			local oldClose = nut.gui.inv1.OnClose
			nut.gui.inv1.OnClose = function()
				if (IsValid(safebox_menuINV) and !IsValid(nut.gui.menu)) then
					safebox_menuINV:Remove()
					invent_info_kek:Remove()
					equipment_panel:Remove()
					case_info_kek:Remove()
				end

				netstream.Start("lootExit", entity)

				nut.gui.inv1.OnClose = oldClose
			end

			nut.gui["inv"..index] = safebox_menuINV
		end
	end)

	netstream.Hook("closeLootMenuSafe", function()
		if (IsValid(nut.gui.inv1) and !IsValid(nut.gui.menu)) then
			nut.gui.inv1:Remove()
			invent_info_kek:Remove()
			equipment_panel:Remove()
			if IsValid(case_info_kek) then
				case_info_kek:Remove()
			end
		end
		if (IsValid(safebox_menuINV) and !IsValid(nut.gui.menu)) then
			safebox_menuINV:Remove()
			invent_info_kek:Remove()
			equipment_panel:Remove()
			case_info_kek:Remove()
		end
	end)
end

