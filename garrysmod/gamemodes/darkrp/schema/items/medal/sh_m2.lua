ITEM.name = "Первенство «Сталкера»"
ITEM.desc = "Награда за достижение ранга. Выдается, если текущий ранг более 250. Для преобразования в капитал - необходимо использовать.\n\nХАРАКТЕРИСТИКИ: \n-выоская стоимость"
ITEM.price = 5000
ITEM.weight = 0.02
ITEM.exRender = false

ITEM.model = "models/kek1ch/dev_money.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-0.050000000745058, 0, 200),
	ang = Angle(90, 0, -90),
	fov = 0.8
}

ITEM.functions.Use = {
	onRun = function(item)
		item.player:getChar():giveMoney(5000)
	end
}
