local PLUGIN = PLUGIN

netstream.Hook("take_my_money", function(client, amount)
	client:getChar():takeMoney(amount)
end)

netstream.Hook("give_my_money", function(client, amount)
	client:getChar():giveMoney(amount*2)
	client:getChar():setData("two4ko", client:getChar():getData("two4ko", 0) + 1)
end)

netstream.Hook("win_4_friend", function(client, amount)
	client:getChar():giveMoney(amount)
end)

