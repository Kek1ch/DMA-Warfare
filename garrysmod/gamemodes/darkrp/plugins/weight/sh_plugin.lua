local PLUGIN = PLUGIN
PLUGIN.name = "STALKER | Weight"
PLUGIN.author = "Neon, DrodA"
PLUGIN.desc = "Le Weight"

nut.config.add("maxWeight", 60, "The maximum number of weight a player can take.", nil,
{
	data = {min = 10, max = 100},
	category = "characters",
})

nut.util.include("sv_plugin.lua")

local PlayerMeta = FindMetaTable("Player")
function PlayerMeta:GetWeight()
	weight = 0

	local char = self:getChar()
	if (self:Alive() and char) then
		local inventory = char:getInv():getItems()

		for k, v in pairs(inventory) do
			if v.weight then 
				weight = (weight + v.weight) 
			end

			local index = v:getID()
			local bagInventory = nut.item.inventories[index]

			if (bagInventory) then
				for k2, v2 in pairs(bagInventory:getItems()) do
					if v2.weight then 
						weight = (weight + v2.weight) 
					end
				end
			end
		end
	end

	return weight
end

function PlayerMeta:GetWeightAddition()
	addition = 0

	local char = self:getChar()
	if (self:Alive() and char) then
		local inventory = char:getInv():getItems()

		for k, v in pairs(inventory) do
			if v:getData("equip") then
				if v.addition then 
					addition = (addition + v.addition) 
				end
			end	
		end
	end

	return addition
end
