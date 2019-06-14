PLUGIN.name = "NightVision"
PLUGIN.author = "CaptJack92a x Neon"
PLUGIN.desc = "Adds a simple wearable item that toggles on a night vision mode, да ваще пиздец."

nut.util.include("sv_plugin.lua")

if (CLIENT) then
	hook.Add("Think", "Nvision", function() 
		local ply = LocalPlayer() 
		if ply:getChar() then
			for k, v in pairs(ply:getChar():getInv():getItems()) do
				if v:getData("equip") then
	        		if (v.category == "Броня") then
						if not ply.delay1 or ply.delay1 < CurTime() then 
							if input.IsKeyDown(KEY_N) and not LocalPlayer():getNetVar("typing") then 
								if ply:getNetVar("nvision") then
									ply:EmitSound("interface/nv_offdks.ogg")
								else
									ply:EmitSound("interface/nv_startdks.ogg")
								end
								netstream.Start("nvision")
							end 
							ply.delay1 = CurTime() + 0.1
						end
					end
				end
			end
		end
	end)

	function PLUGIN:HUDPaint()
		if LocalPlayer():getNetVar("nvision", false) then
			local dlight = DynamicLight( LocalPlayer():EntIndex() )
			if ( dlight ) then
				dlight.pos = LocalPlayer():GetShootPos()
				dlight.r = 255
				dlight.g = 255
				dlight.b = 255
				dlight.brightness = 2
				dlight.Decay = 1000
				dlight.Size = 362
				dlight.DieTime = CurTime() + 1

				local color = {}
				color["$pp_colour_addr"] = 0
				color["$pp_colour_addg"] = 0.11
				color["$pp_colour_addb"] = 0
				color["$pp_colour_brightness"] = 0
				color["$pp_colour_contrast"] = 0.9
				color["$pp_colour_colour"] = 0.75
				color["$pp_colour_mulr"] = 0
				color["$pp_colour_mulg"] = 0
				color["$pp_colour_mulb"] = 0
				DrawColorModify(color)
				surface.SetDrawColor(160,160,160,255)
				local client = LocalPlayer()
				for k, v in pairs(player.GetAll()) do
					if (v != client and v.character and v:GetPos():Distance(client:GetPos()) <= 2000) then
						local position = v:LocalToWorld(v:OBBCenter()):ToScreen()
						local x, y = position.x, position.y
						local mat = Material("models/wireframe")
						surface.SetDrawColor(255, 255, 255, 220)
						surface.SetMaterial(mat)
						surface.DrawTexturedRect(x - 10, y - 10, 20, 20)
					end
				end
			end
		end
	end
end

