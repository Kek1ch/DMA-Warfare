local PLUGIN = PLUGIN
PLUGIN.name = "ACTS V2.0"
PLUGIN.author = "Kek1ch&WickedRabbit"
PLUGIN.desc = "Sample text"

if (CLIENT) then
	hook.Add("Think", "Act Menu Derma", function() 
		if not (LocalPlayer().act_delay) or (LocalPlayer().act_delay < CurTime()) then 
			if input.IsKeyDown( KEY_F2 ) then 
				if IsValid(ActDerma) then
					ActDerma:Remove() 
				else
					ActDerma = vgui.Create("act4flexx")
					ActDerma:SetPos(ActDerma:GetPos())
					ActDerma:SetSize(ActDerma:GetSize())
				end
			end 
		LocalPlayer().act_delay = CurTime() + 0.1
		end 
	end)
end

