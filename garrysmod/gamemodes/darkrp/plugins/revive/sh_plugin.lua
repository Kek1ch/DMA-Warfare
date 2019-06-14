PLUGIN.name = "DrawDeathHud"
PLUGIN.author = "Какие авторы тут могут быть?"
PLUGIN.desc = "Sample text"

local PLUGIN = PLUGIN

if (CLIENT) then
	local aprg, aprg2 = 0, 0

	function nut.hud.drawDeath()
		if (LocalPlayer():getChar()) then
			if (LocalPlayer():Alive()) then
				if (aprg != 0) then
					aprg2 = math.Clamp(aprg2 - FrameTime()*1.3, 0, 1)
					if (aprg2 == 0) then
						aprg = math.Clamp(aprg - FrameTime()*.7, 0, 1)
					end
				end
			else
				if (aprg2 != 1) then
					aprg = math.Clamp(aprg + FrameTime()*.5, 0, 1)
					if (aprg == 1) then
						aprg2 = math.Clamp(aprg2 + FrameTime()*.4, 0, 1)
					end
				end 
			end
		end

		if (IsValid(nut.char.gui) and nut.gui.char:IsVisible() or !LocalPlayer():getChar()) then
			return
		end

		local tx, ty = nut.util.drawText("Потерян в", ScrW()/2, ScrH()/2.2, Color(255, 140, 0, aprg2 * 255), 1, 1, "DeadBigFontForSafe", aprg2 * 255)
		local tx, ty = nut.util.drawText("Зоне...", ScrW()/2, ScrH()/1.9, Color(255, 140, 0, aprg2 * 255), 1, 1, "DeadBigFontForSafe", aprg2 * 255)
	end
end
