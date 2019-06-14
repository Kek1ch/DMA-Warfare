local PLUGIN = PLUGIN

netstream.Hook("nvision", function(client, amount)
	client:setNetVar("nvision", !client:getNetVar("nvision"))
end)

function PLUGIN:PlayerDeath(victim, weapon, attacker)
	victim:setNetVar("nvision", false)
end
