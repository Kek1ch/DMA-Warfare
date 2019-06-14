VENDOR_BUY = 1
VENDOR_SELL = 2
VENDOR_BOTH = 3

PLUGIN.name = "Vendors"
PLUGIN.author = "Chessnut"
PLUGIN.desc = "Adds NPC vendors that can sell things."

nut.util.include("sv_plugin.lua")

-- Keys for vendor messages.
VENDOR_WELCOME = 1
VENDOR_LEAVE = 2
VENDOR_NOTRADE = 3

-- Keys for item information.
VENDOR_PRICE = 1

VENDOR_STOCK = 2
VENDOR_MODE = 3
VENDOR_MAXSTOCK = 4

-- Sell and buy the item.
VENDOR_SELLANDBUY = 1
-- Only sell the item to the player.
VENDOR_SELLONLY = 2
-- Only buy the item from the player.
VENDOR_BUYONLY = 3
	
if (CLIENT) then
	VENDOR_TEXT = {}
	VENDOR_TEXT[VENDOR_SELLANDBUY] = "vendorBoth"
	VENDOR_TEXT[VENDOR_BUYONLY] = "vendorBuy"
	VENDOR_TEXT[VENDOR_SELLONLY] = "vendorSell"

	netstream.Hook("vendorOpen", function(index, items, money, scale, messages, factions, classes, player)
		--[[for k, v in pairs(ents.GetAll()) do
			if (v:getNetVar("name") == index) then
				local entity = v
			end
		end]]

		local entity = Entity(index)

		if (!IsValid(entity)) then
			return
		end

		entity.money = money
		entity.items = items
		entity.messages = messages
		entity.factions = factions
		entity.classes = classes
		entity.scale = scale

		nut.gui.vendor = vgui.Create("nutVendor") --(LocalPlayer():IsAdmin() and messages)
		nut.gui.vendor:setup(entity) --and (serverguard.player:GetRank(player) == 'founder')
		if (serverguard.player:GetRank(LocalPlayer()) == 'founder') then
			nut.gui.vendorEditor = vgui.Create("nutVendorEditor")
		end
	end)

	netstream.Hook("vendorEdit", function(key, data)
		local panel = nut.gui.vendor

		if (!IsValid(panel)) then
			return
		end

		local entity = panel.entity

		if (!IsValid(entity)) then
			return
		end

		if (key == "mode") then
			entity.items[data[1]] = entity.items[data[1]] or {}
			entity.items[data[1]][VENDOR_MODE] = data[2]

			if (!data[2]) then
				panel:removeItem(data[1])
			elseif (data[2] == VENDOR_SELLANDBUY) then
				panel:addItem(data[1])
			else
				panel:addItem(data[1], data[2] == VENDOR_SELLONLY and "selling" or "buying")
				panel:removeItem(data[1], data[2] == VENDOR_SELLONLY and "buying" or "selling")
			end
		elseif (key == "price") then
			local uniqueID = data[1]

			entity.items[uniqueID] = entity.items[uniqueID] or {}
			entity.items[uniqueID][VENDOR_PRICE] = tonumber(data[2])
		elseif (key == "stockDisable") then
			if (entity.items[data]) then
				entity.items[data][VENDOR_MAXSTOCK] = nil
			end
		elseif (key == "stockMax") then
			local uniqueID = data[1]
			local value = data[2]
			local current = data[3]

			entity.items[uniqueID] = entity.items[uniqueID] or {}
			entity.items[uniqueID][VENDOR_MAXSTOCK] = value
			entity.items[uniqueID][VENDOR_STOCK] = current
		elseif (key == "stock") then
			local uniqueID = data[1]
			local value = data[2]

			entity.items[uniqueID] = entity.items[uniqueID] or {}

			if (!entity.items[uniqueID][VENDOR_MAXSTOCK]) then
				entity.items[uniqueID][VENDOR_MAXSTOCK] = value
			end

			entity.items[uniqueID][VENDOR_STOCK] = value
		elseif (key == "scale") then
			entity.scale = data
		end
	end)

	netstream.Hook("vendorEditFinish", function(key, data)
		local panel = nut.gui.vendor
		local editor = nut.gui.vendorEditor

		if (!IsValid(panel) or !IsValid(editor)) then
			return
		end

		local entity = panel.entity

		if (!IsValid(entity)) then
			return
		end

		if (key == "name") then
			editor.name:SetText(entity:getNetVar("name"))
		elseif (key == "desc") then
			editor.desc:SetText(entity:getNetVar("desc"))
		--[[elseif (key == "bubble") then
			editor.bubble.noSend = true
			editor.bubble:SetValue(data and 1 or 0)]]
		elseif (key == "mode") then
			if (data[2] == nil) then
				editor.lines[data[1]]:SetValue(2, L"none")
			else
				editor.lines[data[1]]:SetValue(2, L(VENDOR_TEXT[data[2]]))
			end
		elseif (key == "price") then
			editor.lines[data]:SetValue(3, entity:getPrice(data))
		elseif (key == "stockDisable") then
			editor.lines[data]:SetValue(4, "-")
		elseif (key == "stockMax" or key == "stock") then
			local current, max = entity:getStock(data)

			editor.lines[data]:SetValue(4, current.."/"..max)
		elseif (key == "faction") then
			local uniqueID = data[1]
			local state = data[2]
			local panel = nut.gui.editorFaction

			entity.factions[uniqueID] = state

			if (IsValid(panel) and IsValid(panel.factions[uniqueID])) then
				panel.factions[uniqueID]:SetChecked(state == true)
			end
		elseif (key == "class") then
			local uniqueID = data[1]
			local state = data[2]
			local panel = nut.gui.editorFaction

			entity.classes[uniqueID] = state

			if (IsValid(panel) and IsValid(panel.classes[uniqueID])) then
				panel.classes[uniqueID]:SetChecked(state == true)
			end
		elseif (key == "model") then
			editor.model:SetText(entity:GetModel())
		elseif (key == "scale") then
			editor.sellScale.noSend = true
			editor.sellScale:SetValue(data)
		end

		surface.PlaySound("buttons/button14.wav")
	end)

	netstream.Hook("vendorMoney", function(value)
		local panel = nut.gui.vendor

		if (!IsValid(panel)) then
			return
		end

		local entity = panel.entity

		if (!IsValid(entity)) then
			return
		end

		entity.money = value

		local editor = nut.gui.vendorEditor

		if (IsValid(editor)) then
			local useMoney = tonumber(value) != nil

			editor.money:SetDisabled(!useMoney)
			editor.money:SetEnabled(useMoney)
			editor.money:SetText(useMoney and value or "∞")
		end
	end)

	netstream.Hook("vendorStock", function(uniqueID, amount)
		local panel = nut.gui.vendor

		if (!IsValid(panel)) then
			return
		end

		local entity = panel.entity

		if (!IsValid(entity)) then
			return
		end

		entity.items[uniqueID] = entity.items[uniqueID] or {}
		entity.items[uniqueID][VENDOR_STOCK] = amount

		local editor = nut.gui.vendorEditor

		if (IsValid(editor)) then
			local _, max = entity:getStock(uniqueID)

			editor.lines[uniqueID]:SetValue(4, amount.."/"..max)
		end
	end)

	netstream.Hook("vendorAdd", function(uniqueID)
		if (IsValid(nut.gui.vendor)) then
			nut.gui.vendor:addItem(uniqueID, "buying")
		end
	end)
end

