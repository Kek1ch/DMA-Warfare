local PLUGIN = PLUGIN

netstream.Hook("msg", function(client, text)
	if ((client.nutNextChat or 0) < CurTime() and text:find("%S")) then
		
		if utf8.len( text ) >= 600 then
			return false
		else
		hook.Run("PlayerSay", client, text)
		client.nutNextChat = CurTime() + math.max(#text / 250, 0.4)
		end
			
	end
end)
