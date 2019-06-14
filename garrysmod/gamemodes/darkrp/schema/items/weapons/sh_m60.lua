ITEM.name = "M60"
ITEM.desc = "Боеприпасы 5.56х45"
ITEM.price = 66112
ITEM.class = "weapon_cop_m60"
ITEM.weaponCategory = "1"
ITEM.category = "Оружие"
ITEM.exRender = false
ITEM.weight = 5.13

ITEM.model = "models/weapons/wick/stcopwep/m60_model_world.mdl"
ITEM.width = 5
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-7, 200, 1),
	ang = Angle(0, 270, 0),
	fov = 11.5
}

--[[ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end]]