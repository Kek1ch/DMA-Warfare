ITEM.name = "Нашивка «Одиночек»"
ITEM.desc = "Иногда сталкеры, не желающие примыкать ни к одной из существующих группировок, объединяются в кланы, скооперировавшись с друзьями и проверенными знакомыми. Главный принцип такого объекдинения двержаться вместе, чтобы не истребили по одиночке. \n\nХАРАКТЕРИСТИКИ: \n-личная вещь \n-высокая ценность"
ITEM.category = "Нашивки"
ITEM.price = 2202
ITEM.exRender = false
ITEM.weight = 0.02

ITEM.model = "models/kek1ch/tfw_badge_defiance.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 1.3
}

ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end