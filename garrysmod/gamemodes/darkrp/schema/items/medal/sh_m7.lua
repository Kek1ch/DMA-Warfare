ITEM.name = "Первенство «Героя Зоны»"
ITEM.desc = "Награда за достижение ранга. Выдается, если текущий ранг более 1500. Для преобразования в капитал - необходимо использовать.\n\nХАРАКТЕРИСТИКИ: \n-выоская стоимость"
ITEM.price = 30000
ITEM.exRender = false
ITEM.weight = 0.02

ITEM.model = "models/kek1ch/dev_money3.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-0.050000000745058, 0, 200),
	ang = Angle(90, 0, -90),
	fov = 0.8
}

ITEM.functions.Use = {
	onRun = function(item)
		item.player:getChar():giveMoney(30000)
	end
}