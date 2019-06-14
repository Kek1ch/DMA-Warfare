local PLUGIN = PLUGIN

netstream.Hook("noteSendText", function(client, id, contents)
	if (string.len(contents) <= NOTELIMIT) then
		for k, v in pairs(nut.item.instances) do
			if v.uniqueID == "note" and v.id == id then
				v:setData("text", contents)
			end
		end
	end
end)	

