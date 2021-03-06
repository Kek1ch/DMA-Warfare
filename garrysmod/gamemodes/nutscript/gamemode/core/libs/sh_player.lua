local playerMeta = FindMetaTable("Player")

-- nutData information for the player.
do
	if (SERVER) then
		function playerMeta:getNutData(key, default)
			if (key == true) then
				return self.nutData
			end
			
			local data = self.nutData and self.nutData[key]

			if (data == nil) then
				return default
			else
				return data
			end
		end
	else
		function playerMeta:getNutData(key, default)
			local data = nut.localData and nut.localData[key]

			if (data == nil) then
				return default
			else
				return data
			end
		end

		netstream.Hook("nutDataSync", function(data, playTime)
			nut.localData = data
			nut.playTime = playTime
		end)

		netstream.Hook("nutData", function(key, value)
			nut.localData = nut.localData or {}
			nut.localData[key] = value
		end)
	end
end

-- Whitelist networking information here.
do	
	function playerMeta:hasWhitelist(faction)
		local data = nut.faction.indices[faction]

		if (data) then
			if (data.isDefault) then
				return true
			end

			local nutData = self:getNutData("whitelists", {})

			return nutData[SCHEMA.folder] and nutData[SCHEMA.folder][data.uniqueID] == true or false
		end

		return false
	end
end