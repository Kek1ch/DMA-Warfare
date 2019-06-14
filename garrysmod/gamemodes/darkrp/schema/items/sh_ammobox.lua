ITEM.name = "Коробка с патронами"
ITEM.desc = "Выдает все виды патрон при активации. \n\nХАРАКТЕРИСТИКИ: \n-высокая ценность"
ITEM.price = 41976
ITEM.exRender = false
ITEM.weight = 0.1

ITEM.model = "models/kek1ch/ammo.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 200, 1),
	ang = Angle(0, 270, 0),
	fov = 1.7197452229299
}

ITEM.functions.Use = {
	onRun = function(item)
		local client = item.player
		client:GiveAmmo(60, "9x18")
		client:GiveAmmo(60, "9x19")
		client:GiveAmmo(60, "9x39")
		client:GiveAmmo(60, "762x54")
		client:GiveAmmo(60, "556x45")
		client:GiveAmmo(60, "545x39")
		client:GiveAmmo(60, "45acp")
		client:GiveAmmo(60, "12x70")
		client:GiveAmmo(60, "338")
		client:GiveAmmo(60, "grenate")
		client:GiveAmmo(60, "762x25")
		client:GiveAmmo(60, "57x28")
		client:GiveAmmo(60, "gaus")
		client:GiveAmmo(60, "vog")
		client:EmitSound("interface/inv_properties.ogg", 110)
		return false
	end
}
