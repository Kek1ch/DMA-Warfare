local PLUGIN = PLUGIN

function UpdatePower(client)
	local weight, maxweight = client:GetWeight(), (nut.config.get("maxWeight") + client:GetWeightAddition())

	client:setNetVar("invWeight", weight)
		
	if weight > maxweight then
		client:SetWalkSpeed(1)
		client:SetRunSpeed(1)
		client:SetMaxSpeed(1)
		client:SetJumpPower(1)
	elseif weight > (maxweight / 2) then
		client:SetWalkSpeed(nut.config.get("walkSpeed") - 10)
		client:SetRunSpeed(nut.config.get("runSpeed") - 10)
		client:SetMaxSpeed(125)
		client:SetJumpPower(125)
	elseif weight > (maxweight / 4) then
		client:SetWalkSpeed(nut.config.get("walkSpeed"))
		client:SetRunSpeed(nut.config.get("runSpeed") + 10)
		client:SetMaxSpeed(200)
		client:SetJumpPower(200)
	end
end

function PLUGIN:CanPlayerTakeItem(client, item)
	local weight, maxweight = client:GetWeight(), (nut.config.get("maxWeight") + client:GetWeightAddition())
	local ItemTable = nut.item.list[item:getNetVar("id", "")]
	if weight > maxweight then
			
		return false
	elseif (type(item) == "Entity") then
		if (ItemTable) and (ItemTable.weight + weight) > maxweight then
			return false
		elseif ItemTable.weight then 
			UpdatePower(client) 
		end

		return true
	end
end

function PLUGIN:PostPlayerLoadout(client)
	UpdatePower(client)
end

function PLUGIN:OnPlayerInteractItem(client, action, item)
	if (action == "drop") then
		UpdatePower(client) 
	elseif (action == "equip") then
		UpdatePower(client) 
	elseif (action == "buy") or (action == "sell") then
		UpdatePower(client)
	end
end
