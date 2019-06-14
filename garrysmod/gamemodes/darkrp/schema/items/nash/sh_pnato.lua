ITEM.name = "Нашивка «Миротворцев»"
ITEM.desc = "\n\nХАРАКТЕРИСТИКИ: \n-личная вещь \n-высокая ценность"
ITEM.category = "Нашивки"
ITEM.price = 2202
ITEM.exRender = false
ITEM.weight = 0.02

ITEM.model = "models/kek1ch/tfw_badge_nato.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 2.2929935455322),
	fov = 1.2
}

ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end

