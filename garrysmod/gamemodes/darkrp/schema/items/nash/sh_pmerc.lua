ITEM.name = "Нашивка «Наемников»"
ITEM.desc = "Самая загадочная и скрытная группировка в Зоне, в существование которых даже не верят. Кое-что постоянно пользуется услугами наемников: профессионалы в своей области, они быстро расправятся с любым сталкером и даже могут полностью ликвидировать небольшую группировку. \n\nХАРАКТЕРИСТИКИ: \n-личная вещь\n-высокая ценность"
ITEM.category = "Нашивки"
ITEM.price = 2202
ITEM.exRender = false
ITEM.weight = 0.02

ITEM.model = "models/kek1ch/tfw_badge_merc.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 1.4
}

ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end