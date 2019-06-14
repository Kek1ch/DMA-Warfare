ITEM.name = "«Компас»"
ITEM.desc = "Редкий артефакт - последний раз его находили много месяцев назад. Обладает способностью показывать разрывы в аномальных полях. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n-телепортирует на базу"
ITEM.price = 37218
ITEM.isAnomaly = true
ITEM.weight = 1.14

ITEM.model = "models/kek1ch/compass_copass.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(191, 160.07429504395, 126),
	ang = Angle(25, 220, 0),
	fov = 4.727992361538
}

local FactionPosition = {
	[FACTION_LONER] = "2214.674072, 7333.380859, -413.968750",
	[FACTION_CLEARSKY] = "2214.674072, 7333.380859, -413.968750",
	[FACTION_RAIDERS] = "2214.674072, 7333.380859, -413.968750",
	[FACTION_MERCENARIES] = "9697.375977, -11994.286133, 416.031250",
	[FACTION_MILITARY] = "2508.905029, -4846.111816, -545.583740",
	[FACTION_FREEDOM] = "13639.939453, 3499.473633, 549.373657",
	[FACTION_DUTY] = "-5520.668945, -11324.980469, 576.031250",
	[FACTION_SCIENTISTS] = "2480.347168, 7423.814941, -533.968750",
	[FACTION_MONOLIT] = "-12005.487305, 1396.467896, -2103.968750",
	[FACTION_MERCHANTS] = "2214.674072, 7333.380859, -413.968750",
	[FACTION_RENEGAT] = "2214.674072, 7333.380859, -413.968750",
	[FACTION_NATO] = "-12917.313477, 14167.952148, 387.438354",
	[FACTION_ZOMBIED] = "-8920.458984, 13143.669922, 62.298744",
	[FACTION_LASTDAY] = "1411.977417, 11923.082031, 109.227142",
}

ITEM.functions.Use = {
	onRun = function(item)
		local client = item.player
		client:SetPos(Vector(FactionPosition[client:Team()]))
	return false
end 
}

