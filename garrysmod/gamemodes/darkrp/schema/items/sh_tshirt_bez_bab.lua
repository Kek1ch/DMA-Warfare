ITEM.name = "Футболка Без Баб"
ITEM.desc = "Футболка, сделанная на заказ. Только лучшие достойны ее носить, не боясь мнение окружающих. \n\nХАРАКТЕРИСТИКИ: \n-очень редкое издеолие \n-дает +9999 к харизме \n\nВыбор подписчиков!"
ITEM.price = 8765
ITEM.exRender = false
ITEM.weight = 0.25

ITEM.functions.Use = {
	onRun = function(item)
		local client = item.player
		client:ScreenFade(SCREENFADE.OUT, Color(0, 0, 0), 1, 3)
		timer.Simple(1, function()
			client:ScreenFade(SCREENFADE.IN, Color(0, 0, 0), 1, 3)
		end)
		client:getChar():setModel("models/hdmodels/kek1ch/podpiwek_baz_baz_1.mdl")
		client:EmitSound("interface/inv_bandage_3p7.ogg", 50, 100)
		return false
	end
}

