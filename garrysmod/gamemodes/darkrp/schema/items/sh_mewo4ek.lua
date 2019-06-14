ITEM.name = "Мешочек с деньгами"
ITEM.desc = "Для преобразования в капитал - необходимо использовать. \n\nХАРАКТЕРИСТИКИ: \n-высокая ценность"
ITEM.price = 1000
ITEM.exRender = false
ITEM.weight = 0.22

ITEM.model = "models/kek1ch/money_meshochek.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(122.65649414063, 102.77194976807, 76.6015625),
	ang = Angle(25, 220, -13.757962226868),
	fov = 5
}

ITEM.functions.Use = {
	icon = "icon16/cup.png",
	onRun = function(item)
		if (IsValid(item.player) && item.player:Alive()) then
			item.player:getChar():giveMoney(math.random(150, 22000))
			item.player:EmitSound("interface/money_"..math.random(1, 2)..".ogg")
		end
	end,
	
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}