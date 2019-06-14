ITEM.name = "Сумка СМВ"
ITEM.desc = "Представляет собой набор медицинского оборудования и лекарственных препаратов, предназначенных для оказания первой медицинской помощи. \nХАРАКТЕРИСТИКИ: \n-высокая ценность"
ITEM.category = "Прочее"
ITEM.price = 13212
ITEM.exRender = false
ITEM.weight = 4.25

ITEM.model = "models/kek1ch/dev_med_bag.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 94.012741088867),
	fov = 4.0127388535032
}

local RandomItems = {
	"bighealth",
	"bint",
	"mediumhealth",
	"scienmediumhealth"
}

ITEM.functions.Use = {
	onRun = function(item)
		for i = 4, 7 do
			item.player:getChar():getInv():add(RandomItems[math.random( 1, #drops_t )])	
		end
	end
}

