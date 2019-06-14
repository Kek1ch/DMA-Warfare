local PLUGIN = PLUGIN

PLUGIN.name = "3D PDA"
PLUGIN.author = "Kek1ch"
PLUGIN.desc = "ADD PDA ON KEY_P"

if (CLIENT) then
	hook.Add("Think", "OLD MENU CONFIG", function()
		if (LocalPlayer().nextUseMenu or 0) < CurTime() then
			if LocalPlayer():getChar() then
				if not LocalPlayer():getChar():hasFlags("O") then return end
				if (LocalPlayer().nextUseMenu or 0) < CurTime() and input.IsKeyDown(KEY_M) and not LocalPlayer():getNetVar("typing") then
					nutMenu_old = vgui.Create("nutMenu_old")
					nutMenu_old:SetSize(nutMenu_old:GetWide(), nutMenu_old:GetTall())
				end
			end
			LocalPlayer().nextUseMenu = CurTime() + 0.1
		end
	end)
end

