local PLUGIN = PLUGIN

local MutantTable = {
	["models/hdmodels/kek1ch/new_izlom_spen.mdl"] = "food_ruchkasamodrochka10",
	["models/hdmodels/kek1ch/new_zombi_spen.mdl"] = "food_ruchkasamodrochka2",
	["models/hdmodels/kek1ch/new_tush_spen.mdl"] = "food_ruchkasamodrochka5",
	["models/hdmodels/kek1ch/new_snork_spen.mdl"] = "food_ruchkasamodrochka6",
	["models/hdmodels/kek1ch/new_psydog_spen.mdl"] = "fooddrop2",
	["models/hdmodels/kek1ch/new_krovo_spen.mdl"] = "fooddrop3",
	["models/hdmodels/kek1ch/new_plot_spen.mdl"] = "fooddrop6",
	["models/hdmodels/kek1ch/new_dog_spen.mdl"] = "fooddrop5",
	["models/hdmodels/kek1ch/new_boar_spen.mdl"] = "fooddrop1",
	["models/hdmodels/kek1ch/new_chimer_spen.mdl"] = "ruchkasamodrochka11",
}

function PLUGIN:KeyPress(client, key)
	if (client:getChar()) then
		if (client:Alive()) then
			local Hit = client:GetEyeTraceNoCursor()
			local npc = Hit.Entity
			if (key == IN_USE) then
				if (npc:IsRagdoll() and MutantTable[npc:GetModel()]) then
					client:Freeze(true) 
					client:forceSequence("dinamit_0")
					npc:EmitSound( "interface/inv_mutant_loot_animal.ogg", 50, 100 )
					client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 ) 
					timer.Simple(1,function() 
						client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 ) 
					end)
					timer.Simple(5, function() 
						client:Freeze(false)
						if IsValid(npc) then
							npc:Remove()
						end
						if (client:GetActiveWeapon():GetClass() == "weapon_cop_knife" and npc:GetPos():Distance( client:GetPos() ) <= 55) then
							for i = 1,2 do
								nut.item.spawn(MutantTable[npc:GetModel()], npc:GetPos() + Vector(0, 0, 8) )
							end
						end
					end)
				end
			end
		end
	end
end

