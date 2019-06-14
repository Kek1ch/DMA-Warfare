if (!nut.char) then include("sh_character.lua") end

nut.crafting = nut.crafting or {}
nut.crafting.list = nut.crafting.list or {}

function nut.crafting.loadFromDir(directory)
	for k, v in ipairs(file.Find(directory.."/*.lua", "LUA")) do
		local niceName = v:sub(4, -5)

		CRAFTING = nut.crafting.list[niceName] or {}
			if (PLUGIN) then
				CRAFTING.plugin = PLUGIN.uniqueID
			end

			nut.util.include(directory.."/"..v)

			CRAFTING.name = CRAFTING.name or "Unknown"
			CRAFTING.desc = CRAFTING.desc or "No description availalble."

			nut.crafting.list[niceName] = CRAFTING
		CRAFTING = nil
	end
end

function nut.crafting.setup(client)
	local character = client:getChar()

	if (character) then
		for k, v in pairs(nut.crafting.list) do
			if (v.onSetup) then
				v:onSetup(client, character:getCrafting(k, 0))
			end
		end
	end
end

-- Add updating of attributes to the character metatable.
do
	local charMeta = nut.meta.character
	
	if (SERVER) then
		function charMeta:updateCrafting(key, value)
			local crafting = nut.crafting.list[key]

			if (crafting) then
				local crafting = self:getCrafting()
				local client = self:getPlayer()

				--crafting[key] = math.min((crafting[key] or 0) + value, crafting.maxValue or nut.config.get("maxAttribs", 30))

				if (IsValid(client)) then
					netstream.Start(client, "crafting", self:getID(), key, crafting[key])

					--[[if (crafting.setup) then
						crafting.setup(crafting[key])
					end]]
				end
			end

			hook.Run("OnCharAttribUpdated", client, self, key, value)
		end

		function charMeta:setCrafting(key, value)
			local crafting = nut.crafting.list[key]

			if (crafting) then
				local crafting = self:getCrafting()
				local client = self:getPlayer()

				crafting[key] = value

				if (IsValid(client)) then
					netstream.Start(client, "crafting", self:getID(), key, crafting[key])

					if (crafting.setup) then
						crafting.setup(crafting[key])
					end
				end
			end
			
			hook.Run("OnCharAttribUpdated", client, self, key, value)
		end

		function charMeta:addBoost(boostID, attribID, boostAmount)
			local boosts = self:getVar("boosts", {})

			boosts[attribID] = boosts[attribID] or {}
			boosts[attribID][boostID] = boostAmount

			hook.Run("OnCharAttribBoosted", self:getPlayer(), self, attribID, boostID, boostAmount)

			return self:setVar("boosts", boosts, nil, self:getPlayer())
		end
		
		function charMeta:removeBoost(boostID, attribID)
			local boosts = self:getVar("boosts", {})

			boosts[attribID] = boosts[attribID] or {}
			boosts[attribID][boostID] = nil

			hook.Run("OnCharAttribBoosted", self:getPlayer(), self, attribID, boostID, true)

			return self:setVar("boosts", boosts, nil, self:getPlayer())
		end
	else
		netstream.Hook("crafting", function(id, key, value)
			local character = nut.char.loaded[id]

			if (character) then
				character:getCrafting()[key] = value
			end
		end)
	end

	function charMeta:getBoost(attribID)
		local boosts = self:getBoosts()

		return boosts[attribID]
	end

	function charMeta:getBoosts()
		return self:getVar("boosts", {})
	end

	function charMeta:getCrafting(key, default)
		local att = self:getCrafting()[key] or default
		local boosts = self:getBoosts()[key]

		if (boosts) then
			for k, v in pairs(boosts) do
				att = att + v
			end
		end 
	
		return att
	end
end