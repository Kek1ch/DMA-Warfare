ITEM.name = "РПГ-7 (заказная)"
ITEM.desc = "Простота, прочность, низкая стоимость и эффективность РПГ-7 сделало его самым популярным безотказным противотанковым орудием в мире. В настоящее время он выпускаетсяв разных модификциях девятью странами и состоит на вооружении более 40 стран мира. \n\nБоеприпасы ОГ-7В"
ITEM.price = 60364
ITEM.class = "weapon_cop_rpg7"
ITEM.weaponCategory = "1"
ITEM.category = "Оружие"
ITEM.width = 6
ITEM.height = 1
ITEM.weight = 8.26
ITEM.exRender = false

ITEM.model = "models/wick/weapons/stalker/stcopwep/w_rpg_model_stcop.mdl"
ITEM.width = 5
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(3, 200, 0),
	ang = Angle(0, 270, 0),
	fov = 18.917197452229
}

ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end

