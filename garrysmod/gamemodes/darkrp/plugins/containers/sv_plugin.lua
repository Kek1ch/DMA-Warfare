local PLUGIN = PLUGIN

function PLUGIN:StorageItemRemoved(entity, inventory)
	self:saveContainer()
end
	
function PLUGIN:StorageCanTransfer(inventory, client, oldX, oldY, x, y, newInvID)
	local inventory2 = nut.item.inventories[newInvID]

	print(inventory2)
end
	
netstream.Hook("invExit", function(client)
	local entity = client.nutBagEntity

	if (IsValid(entity)) then
		entity.receivers[client] = nil
	end

	client.nutBagEntity = nil
end)
	
netstream.Hook("TakeMoney", function(client, value)
	client:getChar():takeMoney(value)
end)
	
netstream.Hook("GiveMoney", function(client, value)
	client:getChar():giveMoney(value)
end)
	
netstream.Hook("EntTakeMoney", function(client, entity, value)
	entity:takeMoney(value)
end)
	
netstream.Hook("EntGiveMoney", function(client, entity, value)
	entity:giveMoney(value)
end)
