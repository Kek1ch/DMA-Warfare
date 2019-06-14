local PLUGIN = PLUGIN

netstream.Hook("isp_jel", function(client)
	timer.Simple(3, function()
		client:TakeDamage(100)
		timer.Simple(3, function()
			client:getChar():ban()
		end)
	end)
end)
