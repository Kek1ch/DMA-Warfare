local PLUGIN = PLUGIN

netstream.Hook("goto_craft", function(client, data)
	--PrintTable(data)
	if not (data.toggle_1 == 0) then
		client:getChar():getInv():remove(client:getChar():getInv():hasItem(data.toggle_1):getID()) 
	end

	if not (data.toggle_2 == 0) then
		client:getChar():getInv():remove(client:getChar():getInv():hasItem(data.toggle_2):getID()) 
	end

	if not (data.toggle_3 == 0) then
		client:getChar():getInv():remove(client:getChar():getInv():hasItem(data.toggle_3):getID()) 
	end

	if not (data.toggle_4 == 0) then
		client:getChar():getInv():remove(client:getChar():getInv():hasItem(data.toggle_4):getID()) 
	end

	if not (data.itog == 0) then
		client:getChar():getInv():add(data.itog)
	end
end)