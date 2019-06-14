local PLUGIN = PLUGIN

function PLUGIN:PlayerLoadout(client)
	client:setNetVar("restricted")
end

function PLUGIN:PlayerUse(client, entity)
	if (!client:getNetVar("restricted") and entity:IsPlayer() and entity:getNetVar("restricted") and !entity.nutBeingUnTied) then
		entity.nutBeingUnTied = true
		entity:setAction("@beingUntied", 5)

		client:setAction("@unTying", 5)
		client:doStaredAction(entity, function()
			entity:setRestricted(false)
			entity.nutBeingUnTied = false

		client:EmitSound("npc/roller/blade_in.wav")
		end, 5, function()
			if (IsValid(entity)) then
				entity.nutBeingUnTied = false
				entity:setAction()
			end

			if (IsValid(client)) then
				client:setAction()
			end
		end)
	end
end

function PLUGIN:searchPlayer(client, target)
	if (IsValid(target:getNetVar("searcher")) or IsValid(client.nutSearchTarget)) then
		return false
	end

	if (!target:getChar() or !target:getChar():getInv()) then
		return false
	end

	local inventory = target:getChar():getInv()

	-- Permit the player to move items from their inventory to the target's inventory.
	inventory.oldOnAuthorizeTransfer = inventory.onAuthorizeTransfer
	inventory.onAuthorizeTransfer = function(inventory, client2, oldInventory, item)
		if (IsValid(client2) and client2 == client) then
			return true
		end

		return false
	end
	inventory:sync(client)
	inventory.oldGetReceiver = inventory.getReceiver
	inventory.getReceiver = function(inventory)
		return {client, target}
	end
	inventory.onCheckAccess = function(inventory, client2)
		if (client2 == client) then
			return true
		end
	end

	-- Permit the player to move items from the target's inventory back into their inventory.
	local inventory2 = client:getChar():getInv()
	inventory2.oldOnAuthorizeTransfer = inventory2.onAuthorizeTransfer
	inventory2.onAuthorizeTransfer = function(inventory3, client2, oldInventory, item)
		if (oldInventory == inventory) then
			return true
		end

		return inventory2.oldOnAuthorizeTransfer(inventory3, client2, oldInventory, item)
	end

	-- Show the inventory menu to the searcher.
	netstream.Start(client, "searchPly", target, target:getChar():getInv():getID())

	client.nutSearchTarget = target
	target:setNetVar("searcher", client)

	return true
end

function PLUGIN:CanPlayerInteractItem(client, action, item)
	if (IsValid(client:getNetVar("searcher"))) then
		return false
	end
end

netstream.Hook("searchExit", function(client)
	local target = client.nutSearchTarget

	if (IsValid(target) and target:getNetVar("searcher") == client) then
		local inventory = target:getChar():getInv()
		inventory.onAuthorizeTransfer = inventory.oldOnAuthorizeTransfer
		inventory.oldOnAuthorizeTransfer = nil
		inventory.getReceiver = inventory.oldGetReceiver
		inventory.oldGetReceiver = nil
		inventory.onCheckAccess = nil
				
		local inventory2 = client:getChar():getInv()
		inventory2.onAuthorizeTransfer = inventory2.oldOnAuthorizeTransfer
		inventory2.oldOnAuthorizeTransfer = nil

		target:setNetVar("searcher", nil)
		client.nutSearchTarget = nil
	end
end)

