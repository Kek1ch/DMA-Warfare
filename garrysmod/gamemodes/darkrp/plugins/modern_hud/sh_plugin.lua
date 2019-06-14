local PLUGIN = PLUGIN

PLUGIN.name = "STALKER Modern HUD"
PLUGIN.author = "Kek1ch"
PLUGIN.desc = "Не воруй"

nut.util.include("cl_plugin.lua")

AddCSLuaFile()

if (CLIENT) then
	function surface.DrawPartialTexturedRect( x, y, w, h, partx, party, partw, parth, texw, texh )
		if not( x && y && w && h && partx && party && partw && parth && texw && texh ) then
			ErrorNoHalt("surface.DrawPartialTexturedRect: Missing argument!")	
			
			return	
		end	
		
		local percX, percY = partx / texw, party / texh	
		local percW, percH = partw / texw, parth / texh	
		
		local vertexData = {
			{
				x = x,
				y = y,
				u = percX,
				v = percY
			},
			{
				x = x + w,
				y = y,
				u = percX + percW,
				v = percY
			},
			{
				x = x + w,
				y = y + h,
				u = percX + percW,
				v = percY + percH
			},
			{
				x = x,
				y = y + h,
				u = percX,
				v = percY + percH
			}
		}	
			
		surface.DrawPoly( vertexData )	
	end	  

	function surface.DrawPartialTexturedRectRotated( x, y, w, h, partx, party, partw, parth, texw, texh, rot )
		local matrix = Matrix()
		matrix:Rotate( Angle( 0,-rot,0 ) )  
		cam.PushModelMatrix( matrix )
		surface.DrawPartialTexturedRect( x, y, w, h, partx, party, partw, parth, texw, texh )
		cam.PopModelMatrix()
	end

	local	showHUD = true
	local	function VNT_STALKERHUD_Toggle()	showHUD = !showHUD	end
	concommand.Add("VNT_STALKERHUD_Toggle", VNT_STALKERHUD_Toggle)

	local HideHudElements = {
		CAchievementNotificationPanel   = false;
		CHudAmmo                        = true;
		CHudBattery                     = true;
		CHudChat                        = false;
		CHudCloseCaption                = false;
		CHudCredits                     = false;
		CHudCrosshair                   = true;
		CHudDeathNotice                 = true;
		CHudHealth                      = true;
		CHudHintDisplay                 = true;
		CHudHistoryResource             = true;
		CHudSecondaryAmmo               = true;
		CHudSuitPower                   = false;
		CHudTrain                       = false;
		CHudMessage                     = false;
		CHudMenu                        = false;
		CHudWeapon                      = false;
		CHudWeaponSelection             = false;
		CHudGMod                        = false;
		CHudDamageIndicator             = false;
		CHudVehicle                     = false;
		CHudVoiceStatus                 = false;
		CHudVoiceSelfStatus             = false;
		CHudSquadStatus                 = false;
		CHudZoom                        = false;
		CHudCommentary                  = false;
		CHudGeiger                      = false;
		CHudAnimationInfo               = false;
		CHUDAutoAim                     = false;
		CHudFilmDemo                    = false;
		CHudHDRDemo                     = false;
		CHudPoisonDamageIndicator       = false;
		CPDumpPanel						= false;
		VNTHUDStalker					= false;
	}	

	local	function HUDShouldDraw( _name )	
		if(!showHUD) then return end
		return !HideHudElements[ _name ]	
	end
	hook.Add("HUDShouldDraw", "VNTSTALKERHUDDisabler", HUDShouldDraw)
	
	hook.Add("HUDPaint", "VNTHUDStalker", function( )
		if(!showHUD) then return end
		local _P = LocalPlayer()
		if ((_P:Alive() == false) or (IsValid(_P)) == false) then return end
		local _SHOULDDRAW = hook.Call( "HUDShouldDraw", GAMEMODE, "VNTHUDStalker" )	
		local _W = _P:GetActiveWeapon()	
		if IsValid(_W) and _W:GetClass() == "gmod_camera" then return end

		------------------------------------------------------------
		--	HUD Base (Health/Armour/Ammo)
		------------------------------------------------------------
		local hudBaseXSize	= 256
		local hudBaseYSize	= 128
		local hudBaseXPos1 	= ScrW()
		local hudBaseYPos1 	= ScrH()
		local hudBaseXPos 	= ScrW() - (hudBaseXSize + 12)
		local hudBaseYPos 	= ScrH() - (hudBaseYSize + 12)

		local Tex_HudBack = Material("daui/modernhud_v3.png", "noclamp")

		------------------------------------------------------------
		--	HUD Stuff
		------------------------------------------------------------
		surface.SetMaterial(Material( "daui/LensDB.png", "noclamp" ))
		surface.SetDrawColor(255, 255, 255, 1)
		surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

		DrawMaterialOverlay( "jessev92/ui/vignette", 0.5 )

		draw.DrawText("DMA Warfare Open Beta", "Roh14", ScrW() * 0.01, ScrH() * 0.976, Color(255, 255, 255, 40), TEXT_ALIGN_LEFT)
		--draw.DrawText(LocalPlayer():GetPos(), "Roh14", ScrW() * 0.01, ScrH() * 0.946, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)

		------------------------------------------------------------
		--	HUD Health
		------------------------------------------------------------
		local HPInt = _P:Health()
		local HPIntMax = 100
		if HPInt <= 0 then HPInt = 0 end
		if HPInt >= 100 then HPInt = 100 end		
		local HP_X = ScrW()-0	local HP_Y = ScrH()
		local HPBar_X = -4		local HPBar_Y = (HP_Y-164)
		if HPInt > 0 then
			surface.SetMaterial( Tex_HudBack )   
			surface.SetDrawColor(255, 255, 255, 130)
			surface.DrawPartialTexturedRect ( 
				ScrW() * 0.86,
				ScrH() * 0.92, 
				ScrW() * 0.09 / (HPIntMax/HPInt),
				ScrH() * 0.017,
				0,
				136,
				90 / (HPIntMax/HPInt),
				16, 
				256, 
				256 )
		end

		surface.SetDrawColor(255,255,255,170) 
		surface.SetMaterial(Material( "daui/hp_icon_v3.png", "noclamp smooth" ))
		surface.DrawTexturedRect(ScrW() * 0.851, ScrH()*0.928, ScrW()*0.007, ScrH()*0.013)
		
		------------------------------------------------------------
		--	HUD STAMINA
		------------------------------------------------------------
		local APInt = LocalPlayer():getLocalVar("stm") or 0
		local APIntMax = 100 
		if APInt <= 0 then APInt = 0 end
		if APInt >= 100 then APInt = 100 end
		local ArmorBar_X = -4	local ArmorBar_Y = (HPBar_Y+23)	

		if APInt > 0 then
			surface.SetMaterial( Tex_HudBack )   
			surface.SetDrawColor(255, 255, 255, 130)
			surface.DrawPartialTexturedRect ( 
				ScrW() * 0.86,
				ScrH() * 0.94,
				ScrW() * 0.09 / (APIntMax/APInt),
				ScrH() * 0.011, 
				1,	
				142,
				90 / (APIntMax/APInt),
				10,
				256, 
				256 )
		end

		surface.SetDrawColor(255,255,255,170) 
		surface.SetMaterial(Material( "daui/stamina_icon.png", "noclamp smooth" ))
		surface.DrawTexturedRect(ScrW() * 0.851, ScrH()*0.944, ScrW()*0.007, ScrH()*0.013)

		------------------------------------------------------------
		--	HUD Ammo
		------------------------------------------------------------
		local mag = -1			
		local store = 0				
		if IsValid(_W) then
			mag = _W:Clip1()
			store = _P:GetAmmoCount( _W:GetPrimaryAmmoType() ) + _W:Clip1()
			if mag > 999 then mag = 999 end
			if store > 999 then store = 999 end
			if mag >= 0 or store > 0 then
				if !(mag == -1) then
					draw.DrawText( mag.."/"..store, "Roh14", ScrW()*0.86, ScrH()*0.912, Color( 255, 255, 255, 210 ), TEXT_ALIGN_LEFT)
				end
			else
				draw.DrawText( "", "Roh14", ScrW()*0.86, ScrH()*0.912, Color( 255, 255, 255, 210 ), TEXT_ALIGN_LEFT)
				draw.DrawText( "", "Roh14", ScrW()*0.86, ScrH()*0.912, Color( 255, 255, 255, 210 ), TEXT_ALIGN_LEFT)
			end
		end


	if LocalPlayer():getChar() then
		------------------------------------------------------------
		--	HUD Hunger
		------------------------------------------------------------

		if (LocalPlayer():getLocalVar("hunger") or 0) <= 80 and (LocalPlayer():getLocalVar("hunger") or 0) >= 60 then 
			surface.SetMaterial(Material( "daui/food_1.png", "noclamp smooth" ))
			surface.SetDrawColor(255,255,255,255) 
			surface.DrawTexturedRect(ScrW() * 0.86, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		elseif (LocalPlayer():getLocalVar("hunger") or 0) <= 60 and (LocalPlayer():getLocalVar("hunger") or 0) >= 40 then 
			surface.SetMaterial(Material( "daui/food_1.png", "noclamp smooth" ))
			surface.SetDrawColor(34,139,34,255) 
			surface.DrawTexturedRect(ScrW() * 0.86, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		elseif (LocalPlayer():getLocalVar("hunger") or 0) <= 40 and (LocalPlayer():getLocalVar("hunger") or 0) >= 20 then 
			surface.SetMaterial(Material( "daui/food_1.png", "noclamp smooth" ))
			surface.SetDrawColor(204,168,23,255) 
			surface.DrawTexturedRect(ScrW() * 0.86, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		elseif (LocalPlayer():getLocalVar("hunger") or 0) <= 20 then 
			surface.SetMaterial(Material( "daui/food_1.png", "noclamp smooth" ))
			surface.SetDrawColor(169,29,17,255) 
			surface.DrawTexturedRect(ScrW() * 0.86, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		end

		------------------------------------------------------------
		--	HUD Thirst
		------------------------------------------------------------
		if (LocalPlayer():getLocalVar("thirst") or 0) <= 80 and (LocalPlayer():getLocalVar("thirst") or 0) >= 60 then 
			surface.SetMaterial(Material( "daui/jajda_1.png", "noclamp smooth" ))
			surface.SetDrawColor(255,255,255,255) 
			surface.DrawTexturedRect(ScrW() * 0.87, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		elseif (LocalPlayer():getLocalVar("thirst") or 0) <= 60 and (LocalPlayer():getLocalVar("thirst") or 0) >= 40 then 
			surface.SetMaterial(Material( "daui/jajda_1.png", "noclamp smooth" ))
			surface.SetDrawColor(34,139,34,255) 
			surface.DrawTexturedRect(ScrW() * 0.87, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		elseif (LocalPlayer():getLocalVar("thirst") or 0) <= 40 and (LocalPlayer():getLocalVar("thirst") or 0) >= 20 then 
			surface.SetMaterial(Material( "daui/jajda_1.png", "noclamp smooth" ))
			surface.SetDrawColor(204,168,23,255) 
			surface.DrawTexturedRect(ScrW() * 0.87, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		elseif (LocalPlayer():getLocalVar("thirst") or 0) <= 20 then 
			surface.SetMaterial(Material( "daui/jajda_1.png", "noclamp smooth" ))
			surface.SetDrawColor(169,29,17,255) 
			surface.DrawTexturedRect(ScrW() * 0.87, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		end

		------------------------------------------------------------
		--	HUD Rad
		------------------------------------------------------------
		if (LocalPlayer():getChar():getData("rad") or 0) > 80 and (LocalPlayer():getChar():getData("rad") or 0) <= 60 then 
			surface.SetMaterial(Material( "daui/rad_1.png", "noclamp smooth" ))
			surface.SetDrawColor(169,29,17,255) 
			surface.DrawTexturedRect(ScrW() * 0.88, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		elseif (LocalPlayer():getChar():getData("rad") or 0) > 60 and (LocalPlayer():getChar():getData("rad") or 0) <= 40 then 
			surface.SetMaterial(Material( "daui/rad_1.png", "noclamp smooth" ))
			surface.SetDrawColor(204,168,23,255) 
			surface.DrawTexturedRect(ScrW() * 0.88, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		elseif (LocalPlayer():getChar():getData("rad") or 0) > 40 and (LocalPlayer():getChar():getData("rad") or 0) <= 20 then 
			surface.SetMaterial(Material( "daui/rad_1.png", "noclamp smooth" ))
			surface.SetDrawColor(34,139,34,255) 
			surface.DrawTexturedRect(ScrW() * 0.88, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		elseif (LocalPlayer():getChar():getData("rad") or 0) > 20 then 
			surface.SetMaterial(Material( "daui/rad_1.png", "noclamp smooth" ))
			surface.SetDrawColor(255,255,255,255) 
			surface.DrawTexturedRect(ScrW() * 0.88, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		end

		------------------------------------------------------------
		--	HUD Equipment
		------------------------------------------------------------
			for k, v in pairs(LocalPlayer():getChar():getInv():getItems()) do
				if v.category == "Шлем" and v:getData("equip") then
					if v:getData("durabilityarmor") <= 80 and v:getData("durabilityarmor") >= 60 then
						surface.SetMaterial(Material( "daui/helmet_1.png", "noclamp smooth" ))
						surface.SetDrawColor(255,255,255,255) 
						surface.DrawTexturedRect(ScrW() * 0.89, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
					elseif v:getData("durabilityarmor") <= 60 and v:getData("durabilityarmor") >= 40 then
						surface.SetMaterial(Material( "daui/helmet_1.png", "noclamp smooth" ))
						surface.SetDrawColor(34,139,34,255) 
						surface.DrawTexturedRect(ScrW() * 0.89, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
					elseif v:getData("durabilityarmor") <= 40 and v:getData("durabilityarmor") >= 20 then
						surface.SetMaterial(Material( "daui/helmet_1.png", "noclamp smooth" ))
						surface.SetDrawColor(204,168,23,255) 
						surface.DrawTexturedRect(ScrW() * 0.89, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
					elseif v:getData("durabilityarmor") <= 20 then
						surface.SetMaterial(Material( "daui/helmet_1.png", "noclamp smooth" ))
						surface.SetDrawColor(169,29,17,255) 
						surface.DrawTexturedRect(ScrW() * 0.89, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
					end
				end
				if v.category == "Броня" and v:getData("equip") then
					if v:getData("durabilityarmor") <= 80 and v:getData("durabilityarmor") >= 60 then
						surface.SetMaterial(Material( "daui/armor_1.png", "noclamp smooth" ))
						surface.SetDrawColor(255,255,255,255) 
						surface.DrawTexturedRect(ScrW() * 0.90, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
					elseif v:getData("durabilityarmor") <= 60 and v:getData("durabilityarmor") >= 40 then
						surface.SetMaterial(Material( "daui/armor_1.png", "noclamp smooth" ))
						surface.SetDrawColor(34,139,34,255) 
						surface.DrawTexturedRect(ScrW() * 0.90, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
					elseif v:getData("durabilityarmor") <= 40 and v:getData("durabilityarmor") >= 20 then
						surface.SetMaterial(Material( "daui/armor_1.png", "noclamp smooth" ))
						surface.SetDrawColor(204,168,23,255) 
						surface.DrawTexturedRect(ScrW() * 0.90, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
					elseif v:getData("durabilityarmor") <= 20 then
						surface.SetMaterial(Material( "daui/armor_1.png", "noclamp smooth" ))
						surface.SetDrawColor(169,29,17,255) 
						surface.DrawTexturedRect(ScrW() * 0.90, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
					end
				end
				if v.weaponCategory and (v.weaponCategory != "flashlight") and v:getData("equip") then
					if v:getData("durability") <= 80 and v:getData("durability") >= 60 then
						surface.SetMaterial(Material( "daui/gun_1.png", "noclamp smooth" ))
						surface.SetDrawColor(255,255,255,255) 
						surface.DrawTexturedRect(ScrW() * 0.91, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
					elseif v:getData("durability") <= 60 and v:getData("durability") >= 40 then
						surface.SetMaterial(Material( "daui/gun_1.png", "noclamp smooth" ))
						surface.SetDrawColor(34,139,34,255) 
						surface.DrawTexturedRect(ScrW() * 0.91, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
					elseif v:getData("durability") <= 40 and v:getData("durability") >= 20 then
						surface.SetMaterial(Material( "daui/gun_1.png", "noclamp smooth" ))
						surface.SetDrawColor(204,168,23,255) 
						surface.DrawTexturedRect(ScrW() * 0.91, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
					elseif v:getData("durability") <= 20 then
						surface.SetMaterial(Material( "daui/gun_1.png", "noclamp smooth" ))
						surface.SetDrawColor(169,29,17,255) 
						surface.DrawTexturedRect(ScrW() * 0.91, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
					end
				end
			end

		------------------------------------------------------------
		--	HUD Weight
		------------------------------------------------------------
		if (LocalPlayer():GetWeight() or 0) > 50 then
			surface.SetMaterial(Material( "daui/weight_1.png", "noclamp smooth" ))
			surface.SetDrawColor(255,255,255,255) 
			surface.DrawTexturedRect(ScrW() * 0.92, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		end

		------------------------------------------------------------
		--	HUD Sleep
		------------------------------------------------------------
		if (LocalPlayer():getChar():getData("sleep_need") or 0) <= 40 and (LocalPlayer():getChar():getData("sleep_need") or 0) >= 30 then 
			surface.SetMaterial(Material( "daui/sleep_1.png", "noclamp smooth" ))
			surface.SetDrawColor(255,255,255,255) 
			surface.DrawTexturedRect(ScrW() * 0.93, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		elseif (LocalPlayer():getChar():getData("sleep_need") or 0) <= 30 and (LocalPlayer():getChar():getData("sleep_need") or 0) >= 20 then 
			surface.SetMaterial(Material( "daui/sleep_1.png", "noclamp smooth" ))
			surface.SetDrawColor(34,139,34,255) 
			surface.DrawTexturedRect(ScrW() * 0.93, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		elseif (LocalPlayer():getChar():getData("sleep_need") or 0) <= 20 and (LocalPlayer():getChar():getData("sleep_need") or 0) >= 10 then 
			surface.SetMaterial(Material( "daui/sleep_1.png", "noclamp smooth" ))
			surface.SetDrawColor(204,168,23,255) 
			surface.DrawTexturedRect(ScrW() * 0.93, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		elseif (LocalPlayer():getChar():getData("sleep_need") or 0) <= 10 then 
			surface.SetMaterial(Material( "daui/sleep_1.png", "noclamp smooth" ))
			surface.SetDrawColor(169,29,17,255) 
			surface.DrawTexturedRect(ScrW() * 0.93, ScrH()*0.955, ScrW()*0.008, ScrH()*0.014)
		end
	end

	end)
end

