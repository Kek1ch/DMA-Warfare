local PLUGIN = PLUGIN

function PLUGIN:PlayerGetFistDamage(client, damage, context)
	if (client:getChar()) then
		context.damage = context.damage + (client:getChar():getAttrib("str", 0) * nut.config.get("strMultiplier"))
	end
end

function PLUGIN:PlayerThrowPunch(client, hit)
	if (client:getChar()) then
		client:getChar():updateAttrib("str", 0.001)
	end
end
