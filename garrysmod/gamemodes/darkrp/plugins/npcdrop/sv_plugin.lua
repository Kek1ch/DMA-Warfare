local PLUGIN = PLUGIN

--[[PLUGIN.itemDrops = {
	drop = {
		{items = {"food_ruchkasamodrochka8"}, chance = 55, class = "npc_mutant_boar"},
		{items = {"food_ruchkasamodrochka7"}, chance = 55, class = "npc_bloods"},
		{items = {"food_ruchkasamodrochka2"}, chance = 55, class = "npc_zombies"},
		{items = {"food_ruchkasamodrochka9"}, chance = 55, class = "npc_plot"},
		{items = {"food_ruchkasamodrochka"}, chance = 55, class = "npc_stalker_burer"},
		{items = {"food_ruchkasamodrochka4"}, chance = 55, class = "npc_mutant_pseudodog"},
		{items = {"food_ruchkasamodrochka5"}, chance = 55, class = "npc_rat"},
		{items = {"food_ruchkasamodrochka3"}, chance = 55, class = "npc_blinddog"},
	}
}

if (SERVER) then
	function PLUGIN:OnNPCKilled(entity, attacker)
		if (!IsValid(entity)) then
			return
		end

		if (!IsValid(attacker) and !attacker:IsPlayer()) then
			return
		end
		
		for k, v in ipairs(self.itemDrops.drop) do
			if (entity:GetClass() == v.class) then
				if (100 * math.random() > v.chance) then
					break
				end
				
				nut.item.spawn(table.Random(v.items), entity:GetPos() + Vector(0, 0, 15))
				break
			end
		end
	end
end]]
