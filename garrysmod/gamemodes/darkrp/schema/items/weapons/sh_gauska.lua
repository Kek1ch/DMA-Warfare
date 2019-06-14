ITEM.name = "Гаусс-винтовка «Изделие 62» (заказной)"
ITEM.desc = "Сверхточное высокотхнологическое оружие, известное как «Изделие №62», было разработано конструкторами секретных лабараторий внутри Зоны. Принцип его действия основан на разгоне пули системной электромагнитов; пуля при этом способна развивать сверхточность, что обеспечивает колоссальную пробивную способность при почти полном отсутствии отдачи. Для обеспечения достаточной энергоемкости аккумуляторов используются частицы некоторых артефактов. \n\nБоеприпасы Аккумуляторы"
ITEM.price = 459504
ITEM.class = "weapon_cop_gauss"
ITEM.weaponCategory = "1"
ITEM.category = "Оружие"
ITEM.exRender = false
ITEM.weight = 8.15

ITEM.model = "models/weapons/wick/stcopwep/w_gaus_model_stcop.mdl"
ITEM.width = 4
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-8, 200, 1.7000000476837),
	ang = Angle(0, 270, 0),
	fov = 13
}

ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end