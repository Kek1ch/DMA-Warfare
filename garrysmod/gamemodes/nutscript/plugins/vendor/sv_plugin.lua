local PLUGIN = PLUGIN

netstream.Hook("try_combine", function(client, data)
	for _, v in pairs(ents.GetAll()) do 
		if (v:GetClass() == "nut_vendor") then
			if v:getNetVar("name") == data then
				local items = {}

				--v:addItem("aksu", "selling")

				for k, t in pairs(v.items) do
					if (table.Count(t) > 0 and (client:IsAdmin() or t[VENDOR_MODE])) then
						items[k] = t --k - айди итемов, t - их количество
						--print(k)
					end
				end
				v.scale = v.scale or 0.5

				local data = {}
				data[1] = items
				data[2] = v.money
				data[3] = v.scale

				if (client:IsAdmin()) then
					data[4] = v.messages
					data[5] = v.factions
					data[6] = v.classes
				end

				client.nutVendor = v

				--PrintTable(v.items)

				netstream.Start(client, "vendorOpen", v:EntIndex(), unpack(data))
				break
			end
		end
	end
end)

function PLUGIN:SaveData()
	local data = {}
		for k, v in ipairs(ents.FindByClass("nut_vendor")) do
			data[#data + 1] = {
				name = v:getNetVar("name"),
				desc = v:getNetVar("desc"),
				pos = v:GetPos(),
				angles = v:GetAngles(),
				model = v:GetModel(),
				--bubble = v:getNetVar("noBubble"),
				items = v.items,
				factions = v.factions,
				classes = v.classes,
				money = v.money,
				scale = v.scale
			}
		end
	self:setData(data)
end

function PLUGIN:LoadData()
	for k, v in ipairs(self:getData() or {}) do
		local entity = ents.Create("nut_vendor")
		entity:SetPos(v.pos)
		entity:SetAngles(v.angles)
		entity:Spawn()
		entity:SetModel(v.model)
		--entity:setNetVar("noBubble", v.bubble)
		entity:setNetVar("name", v.name)
		entity:setNetVar("desc", v.desc)

		entity.items = v.items or {}
		entity.factions = v.factions or {}
		entity.classes = v.classes or {}
		entity.money = v.money
		entity.scale = v.scale or 0.5
	end
end

function PLUGIN:CanVendorSellItem(client, vendor, itemID)
	local tradeData = vendor.items[itemID]
	local char = client:getChar()

	if (!tradeData or !char) then
		print("Not Valid Item or Client Char.")
		return false
	end

	if (!char:hasMoney(tradeData[1] or 0)) then
		print("Insufficient Fund.")
		return false
	end

	return true
end

function PLUGIN:OnCharTradeVendor(client, vendor, x, y, invID, price, isSell)
end

netstream.Hook("vendorExit", function(client)
	local entity = client.nutVendor

	if (IsValid(entity)) then
		for k, v in ipairs(entity.receivers) do
			if (v == client) then
				table.remove(entity.receivers, k)

				break
			end
		end

		client.nutVendor = nil
	end
end)

netstream.Hook("vendorEdit", function(client, key, data)
	if (client:IsAdmin()) then
		local entity = client.nutVendor

		if (!IsValid(entity)) then
			return
		end

		local feedback = true

		if (key == "name") then
			entity:setNetVar("name", data)
		elseif (key == "desc") then
			entity:setNetVar("desc", data)
		elseif (key == "anim") then
			entity:setNetVar("anim", data)
		elseif (key == "sound") then
			entity:setNetVar("sound", data)
		--[[elseif (key == "bubble") then
			entity:setNetVar("noBubble", data)]]
		elseif (key == "mode") then
			local uniqueID = data[1]

			entity.items[uniqueID] = entity.items[uniqueID] or {}
			entity.items[uniqueID][VENDOR_MODE] = data[2]

			netstream.Start(entity.receivers, "vendorEdit", key, data)
		elseif (key == "price") then
			local uniqueID = data[1]
			data[2] = tonumber(data[2])

			if (data[2]) then
				data[2] = math.Round(data[2])
			end

			entity.items[uniqueID] = entity.items[uniqueID] or {}
			entity.items[uniqueID][VENDOR_PRICE] = data[2]

			netstream.Start(entity.receivers, "vendorEdit", key, data)
			data = uniqueID
		elseif (key == "stockDisable") then
			entity.items[data] = entity.items[uniqueID] or {}
			entity.items[data][VENDOR_MAXSTOCK] = nil

			netstream.Start(entity.receivers, "vendorEdit", key, data)
		elseif (key == "stockMax") then
			local uniqueID = data[1]
			data[2] = math.max(math.Round(tonumber(data[2]) or 1), 1)

			entity.items[uniqueID] = entity.items[uniqueID] or {}
			entity.items[uniqueID][VENDOR_MAXSTOCK] = data[2]
			entity.items[uniqueID][VENDOR_STOCK] = math.Clamp(entity.items[uniqueID][VENDOR_STOCK] or data[2], 1, data[2])

			data[3] = entity.items[uniqueID][VENDOR_STOCK]

			netstream.Start(entity.receivers, "vendorEdit", key, data)
			data = uniqueID
		elseif (key == "stock") then
			local uniqueID = data[1]

			entity.items[uniqueID] = entity.items[uniqueID] or {}

			if (!entity.items[uniqueID][VENDOR_MAXSTOCK]) then
				data[2] = math.max(math.Round(tonumber(data[2]) or 0), 0)
				entity.items[uniqueID][VENDOR_MAXSTOCK] = data[2]
			end

			data[2] = math.Clamp(math.Round(tonumber(data[2]) or 0), 0, entity.items[uniqueID][VENDOR_MAXSTOCK])
			entity.items[uniqueID][VENDOR_STOCK] = data[2]

			netstream.Start(entity.receivers, "vendorEdit", key, data)
			data = uniqueID
		elseif (key == "faction") then
			local faction = nut.faction.teams[data]

			if (faction) then
				entity.factions[data] = !entity.factions[data]

				if (!entity.factions[data]) then
					entity.factions[data] = nil
				end
			end

			local uniqueID = data
			data = {uniqueID, entity.factions[uniqueID]}
		elseif (key == "class") then
			local class

			for k, v in ipairs(nut.class.list) do
				if (v.uniqueID == data) then
					class = v

					break
				end
			end

			if (class) then
				entity.classes[data] = !entity.classes[data]

				if (!entity.classes[data]) then
					entity.classes[data] = nil
				end
			end

			local uniqueID = data
			data = {uniqueID, entity.classes[uniqueID]}
		elseif (key == "model") then
			entity:SetModel(data)
		elseif (key == "useMoney") then
			if (entity.money) then
				entity:setMoney()
			else
				entity:setMoney(0)
			end
		elseif (key == "money") then
			data = math.Round(math.abs(tonumber(data) or 0))

			entity:setMoney(data)
			feedback = false
		elseif (key == "scale") then
			data = tonumber(data) or 0.5

			entity.scale = data
			netstream.Start(entity.receivers, "vendorEdit", key, data)
		end

		PLUGIN:SaveData()

		if (feedback) then
			local receivers = {}

			for k, v in ipairs(entity.receivers) do
				if (v:IsAdmin()) then
					receivers[#receivers + 1] = v
				end
			end

			netstream.Start(receivers, "vendorEditFinish", key, data)
		end
	end
end)

netstream.Hook("vendorTrade", function(client, uniqueID, isSellingToVendor, player)
	if ((client.nutVendorTry or 0) < CurTime()) then
		client.nutVendorTry = CurTime() + 0.33
	else
		return
	end

	local found
	local entity = client.nutVendor

	if (!IsValid(entity) and client:GetPos():Distance(entity:GetPos()) > 199) then --client:GetPos():Distance(entity:GetPos()) > 199
		return
	end

	if (entity.items[uniqueID] and hook.Run("CanPlayerTradeWithVendor", client, entity, uniqueID, isSellingToVendor) != false) then

		local price = entity:getPrice(uniqueID, isSellingToVendor)
		if serverguard.player:GetRank(client) == 'vip' then -- Kek
			price = price * 0.7
		else
			if client:getChar():getData("rep") <= -100 then
				price = price * (-client:getChar():getData("rep")) * 0.0105
			else
				price = price
			end
		end

		if (isSellingToVendor) then
			
			local found = false
			local name
				
			if (!entity:hasMoney(price)) then
				return client:notifyLocalized("vendorNoMoney")
			end

			local invOkay = true
			for k, v in pairs(client:getChar():getInv():getItems()) do
				if (v.uniqueID == uniqueID and v:getID() != 0 and istable(nut.item.instances[v:getID()])) then
					invOkay = v:remove()
					found = true
					name = L(v.name, client)

					break
				end
			end

			if (!found) then
				return
			end
				
			if (!invOkay) then
				client:getChar():getInv():sync(client, true)
				return client:notifyLocalized("tellAdmin", "trd!iid")
			end

			client:getChar():giveMoney(price)
			client:notifyLocalized("businessSell", name, nut.currency.get(price))
			entity:takeMoney(price)
			entity:addStock(uniqueID)

			PLUGIN:SaveData()
			hook.Run("OnCharTradeVendor", client, entity, uniqueID, isSellingToVendor)
		else
			local stock = entity:getStock(uniqueID)

			if (stock and stock < 1) then
				return client:notifyLocalized("vendorNoStock")
			end

			if (!client:getChar():hasMoney(price)) then
				return client:notifyLocalized("canNotAfford")
			end

			local name = L(nut.item.list[uniqueID].name, client)
			
			client:getChar():takeMoney(price)
			client:notifyLocalized("businessPurchase", name, nut.currency.get(price))
				
			entity:giveMoney(price)

			if (!client:getChar():getInv():add(uniqueID)) then
				nut.item.spawn(uniqueID, client:getItemDropPos())
			else
				netstream.Start(client, "vendorAdd", uniqueID)
			end

			entity:takeStock(uniqueID)

			PLUGIN:SaveData()
			hook.Run("OnCharTradeVendor", client, entity, uniqueID, isSellingToVendor)
		end
	else
		client:notifyLocalized("vendorNoTrade")
	end
end)


--[[netstream.Hook("takeitemkek", function(client, uniqueID, isSellingToVendor, player)
	if  client:getChar():getData("craftmaska", 10) then
		client:getChar():getInv():add("mp3")
		client:getChar():setData("craftmaska", 0)
		client:ConCommand("say /zchecknewrep "..client:getChar():getData("craftmaska", 0))
	end
end)
	
netstream.Hook("craftmaska", function(client, uniqueID, isSellingToVendor, player)
	client:getChar():setData("craftmaska", 10)
	client:ConCommand("say /zchecknewrep "..client:getChar():getData("craftmaska", 0))
end)]]
