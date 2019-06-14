local PLUGIN = PLUGIN
local find, ipairs, IsValid = ents.FindByClass, ipairs, IsValid
local tSimple = timer.Simple

if (PLUGIN.showAnom) then	
	function PLUGIN:PlayerLoadedChar(player)
		netstream.Start(player, "showAnomalyChecked", false)
		if (timer.Exists("checkedAnom_"..player:SteamID())) then --safe
			timer.Remove("checkedAnom_"..player:SteamID())
		end
		
		timer.Create("checkedAnom_"..player:SteamID(), 5, 0, function()
			for _, v in ipairs(find("nut_item")) do
				if (IsValid(v) and v.nutItemID) then
					local itm = nut.item.instances[v.nutItemID]
					if (itm and itm.isAnomaly and itm:getData("anomPickup")) then
						netstream.Start(player, "showAnomalyResult", v, true)
					end
				end
			end
		end)
	end
	
	function PLUGIN:OnCharDisconnect(player)
		if (timer.Exists("checkedAnom_"..player:SteamID())) then
			timer.Remove("checkedAnom_"..player:SteamID())
		end
	end
	
	function PLUGIN:OnEntityCreated(entity)
		local class = entity:GetClass()
		tSimple(0.01, function()
			if (class == "nut_item") then
				local id = entity.nutItemID
				if (id) then
					local item = nut.item.instances[id]
					if (item and item.isAnomaly and !item:getData("anomPickup")) then
						entity:SetCollisionGroup(20)
						netstream.Start(nil, "showAnomalyResult", entity, false)
					end
				end
			end
		end)
	end
	
	function PLUGIN:OnItemSpawned(entity)
		tSimple(0.1, function() --safe
			local id = entity.nutItemID
			if (id) then
				local item = nut.item.instances[id]
				if (item and item.isAnomaly and item:getData("anomPickup")) then
					netstream.Start(nil, "showAnomalyResult", entity, true)
				end
			end
		end)
	end
	
	if (PLUGIN.clearAnom) then
		function PLUGIN:Tick()
			for _, v in ipairs(find("nut_item")) do
				if (IsValid(v) and v.nutItemID) then
					local itm = nut.item.instances[v.nutItemID]
					if (itm and itm.isAnomaly) then
						if (itm.delArtif and CurTime() >= itm.delArtif) then
							v:Remove()
						end
					end
				end
			end
		end
	end
	
	local time = nut.config.get("clearAnom", 3600)
	function PLUGIN:OnPlayerInteractItem(client, action, item)
		if (action == "take" or action == "drop") then
			if (type(item) == "Entity") then
				if (IsValid(item)) then
					local itemID = item.nutItemID
					item = nut.item.instances[itemID]
				end
			elseif (type(item) == "number") then
				item = nut.item.instances[item]
			end
			
			if (!item or !item.isAnomaly) then return end
			if (!item:getData("anomPickup")) then item:setData("anomPickup", true) end
			if (self.clearAnom) then
				if (action == "drop") then item.delArtif = CurTime() + time
				elseif (action == "take") then item.delArtif = nil end
			end
		end
	end
end