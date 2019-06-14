local PLUGIN = PLUGIN

function PLUGIN:PostPlayerLoadout(client)
	client:setLocalVar("hunger", 100)
	client:setLocalVar("thirst", 100)

	local hungID = "nutHung"..client:SteamID()
	local thirID = "nutThir"..client:SteamID()
	local hungSpeed = 2
	local thirSpeed = 3

	timer.Create(hungID, 160, 0, function()
		if (IsValid(client)) then
		local character = client:getChar()
			if client:GetVelocity():Length() < 1 then
				client:setLocalVar("hunger", client:getLocalVar("hunger") - hungSpeed)
				client:setLocalVar("thirst", client:getLocalVar("thirst") - thirSpeed)
			end
		else
			timer.Remove(hungID)
		end
	end)

	timer.Create(thirID, 5, 0, function()
		if (IsValid(client)) then
			if (client:getLocalVar("hunger") <= 0) or (client:getLocalVar("thirst") <= 0) then
				client:SetHealth(math.Clamp(client:Health() - 1, 1, client:GetMaxHealth()))
			end
		else
			timer.Remove(thirID)
		end
	end)
end

local playerMeta = FindMetaTable("Player")

function playerMeta:restoreHunger(amount)
	local current = self:getLocalVar("hunger", 0)
	local value = math.Clamp(current + amount, 0, 100)

	self:setLocalVar("hunger", value)
end
	
function playerMeta:restoreThirst(amount)
	local current = self:getLocalVar("thirst", 0)
	local value = math.Clamp(current + amount, 0, 100)

	self:setLocalVar("thirst", value)
end

