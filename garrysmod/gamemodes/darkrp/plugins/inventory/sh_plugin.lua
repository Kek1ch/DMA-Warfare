PLUGIN.name = "Hotkey menus XXX"
PLUGIN.author = "Kek1ch + Hikka"
PLUGIN.desc = "Для быстрого вызова менюшек Flex$$"

if (CLIENT) then
	hook.Add("Think", "Inventory Menu Kek1ch", function()
		if !IsValid(LocalPlayer()) then return end

		if LocalPlayer():IsTyping() or (IsValid(vgui.GetKeyboardFocus()) and vgui.GetKeyboardFocus():GetClassName( ) == "TextEntry") or gui.IsGameUIVisible() or gui.IsConsoleVisible() then
			if IsValid(nut.gui.inv1) and IsValid(invent_info_kek) and IsValid(equipment_panel) and !IsValid(safebox_menuINV) then
				nut.gui.inv1:Remove()
				invent_info_kek:Remove()
				equipment_panel:Remove()
			end
			return
		end

		if (LocalPlayer():getChar()) then
			if (LocalPlayer().nextUseMenu or 0) < CurTime() and input.IsKeyDown(KEY_I) and !LocalPlayer():getNetVar("typing") then
				if IsValid(nut.gui.inv1) and IsValid(invent_info_kek) then
					nut.gui.inv1:Remove()
					invent_info_kek:Remove()
					equipment_panel:Remove()
					if IsValid(safebox_menuINV)  then
						safebox_menuINV:Remove()
					end
					if IsValid(case_info_kek)  then
						case_info_kek:Remove()
						case_info_kek:OnRemove()
					end
				else
					nut.gui.inv1 = vgui.Create("nutInventory")
					nut.gui.inv1:ShowCloseButton(false)
					local inventory2 = LocalPlayer():getChar():getInv()
					if (inventory2) then nut.gui.inv1:setInventory(inventory2) end
					nut.gui.inv1:SetSize(nut.gui.inv1:GetWide(), nut.gui.inv1:GetTall())
					nut.gui.inv1:SetPos(ScrW()*0.6592, ScrH()*0.29)

					invent_info_kek = vgui.Create("invent_info_kek")
					invent_info_kek:SetPos(ScrW()*0.6592, ScrH()*0.067)
					invent_info_kek:SetSize(invent_info_kek:GetSize())

					equipment_panel = vgui.Create("equipment_panel")
					equipment_panel:SetPos(ScrW()*0.35, ScrH()*0.29)
					equipment_panel:SetSize(equipment_panel:GetSize())
				end
			LocalPlayer().nextUseMenu = CurTime() + 0.1
			end
			if (LocalPlayer().nextUseMenu_second or 0) < CurTime() and input.IsKeyDown(KEY_E) and !LocalPlayer():getNetVar("typing") then
				if IsValid(nut.gui.inv1) and IsValid(invent_info_kek) and IsValid(equipment_panel) and IsValid(safebox_menuINV) and IsValid(case_info_kek) then
					nut.gui.inv1:Remove()
					invent_info_kek:Remove()
					equipment_panel:Remove()
					safebox_menuINV:Remove()
					case_info_kek:Remove()
				end
			LocalPlayer().nextUseMenu_second = CurTime() + 0.1
			end
		end
	end)
end
