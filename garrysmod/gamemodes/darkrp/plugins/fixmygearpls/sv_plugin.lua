local PLUGIN = PLUGIN

netstream.Hook("fix_my_gear", function(client, data)
	local items = client:getChar():getInv():getItems()

	if not (data.cost_helmet_button == 0) then
		for _, v in pairs(items) do
			if v.category == "Шлем" and v:getData("equip") then
				v:setData("durabilityarmor", 100)
			end
		end
	end

	if not (data.cost_armor_button == 0) then
		for _, v in pairs(items) do
			if v.category == "Броня" and v:getData("equip") then
				v:setData("durabilityarmor", 100)
			end
		end
	end

	if not (data.cost_siderman_button == 0) then
		for _, v in pairs(items) do
			if v.weaponCategory == "1.5" and v:getData("equip") then
				v:setData("durability", 100)
			end
		end
	end

	if not (data.cost_pistol_button == 0) then
		for _, v in pairs(items) do
			if v.weaponCategory == "2" and v:getData("equip") then
				v:setData("durability", 100)
			end
		end
	end

	if not (data.cost_main_button == 0) then
		for _, v in pairs(items) do
			if v.weaponCategory == "1" and v:getData("equip") then
				v:setData("durability", 100)
			end
		end
	end

	client:getChar():takeMoney(data.cost_main)
	PrintTable(data)
	print(data.cost_main)
end)


