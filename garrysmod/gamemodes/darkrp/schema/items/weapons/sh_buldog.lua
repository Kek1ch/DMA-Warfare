ITEM.name = "РГ-6 «Бульдог» (заказной)"
ITEM.desc = "Гранатомет револьверного тип используется для повышения огневой мощи пехоты в условиях городского боя. Применялся в некоторых локальных конфликтах, например в Чечне. Камеры барабана переднего заряжания, образованы шестью нарезными стволами, идентичными используемым в подствольных гранатометах. \n\nБоеприпасы ВОГ-25"
ITEM.price = 71072
ITEM.class = "weapon_cop_rg6"
ITEM.weaponCategory = "1"
ITEM.category = "Оружие"
ITEM.model = "models/wick/weapons/stalker/stcopwep/w_rg6_model_stcop.mdl"
ITEM.width = 4
ITEM.height = 2
ITEM.weight = 7.76
ITEM.exRender = false
ITEM.iconCam = {
	pos = Vector(-4, 200, -1),
	ang = Angle(0, 270, 0),
	fov = 9
}

ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end

