ITEM.name = "Аккумулятор"
ITEM.desc = "Источник электричества для автономного питания. Рабочее напряжение: 1.5V. Продолжительность работы: 300 секунд. \n\nХАРАКТЕРИСТИКИ: \n-электроника \n-используется для: работы фонарика"
ITEM.price = 1040
ITEM.permit = "Разное"
ITEM.weight = 0.17

ITEM.model = "models/kek1ch/battery.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(52.070404052734, 43.692253112793, 32.759872436523),
	ang = Angle(25, 220, 0),
	fov = 2.6
}

--[[ITEM.functions.Use = {
	onRun = function(item)
		local character = item.player:getChar()
		character:setData("flashlightzarad", 300)
	end
}]]

