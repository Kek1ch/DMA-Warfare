hook.Add("PlayerDeath", "SCHEMA.PlayerDeathThing", function(victim, inflictor, attacker) 
	local character = victim:getChar() 
	if !character then return end 
	local faction = nut.faction.indices[character:getFaction()] 
	nut.chat.send(victim, "dead", character:getName().." «"..faction.name.."»", nil, player.GetAll()) 
end)

do
ALWAYS_RAISED["weapon_cop_binoculars"] = true
ALWAYS_RAISED["weapon_cop_bolt"] = true
ALWAYS_RAISED["weapon_cop_veles"] = true
ALWAYS_RAISED["weapon_cop_medved"] = true
ALWAYS_RAISED["weapon_cop_echo"] = true
ALWAYS_RAISED["weapon_cop_knife"] = true
ALWAYS_RAISED["weapon_cop_flashlight"] = true
ALWAYS_RAISED["weapon_cop_f1"] = true
ALWAYS_RAISED["weapon_cop_rgd5"] = true
end


function SCHEMA:PlayerNoClip(ply)
	return (ply:Team() == FACTION_ADMIN) and (ply:IsAdmin())
end