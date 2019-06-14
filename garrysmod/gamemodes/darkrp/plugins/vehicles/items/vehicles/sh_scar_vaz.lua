ITEM.name = "ВАЗ-2121"
ITEM.physDesc = ""
ITEM.maxGas = 1000
ITEM.price = 219080
ITEM.weight = 0.05
ITEM.exRender = false

ITEM.vehicleData = {
	type = TYPE_GENERIC,
	model = "models/kek1ch/niva/niva_fixed.mdl",
	script = "scripts/vehicles/lada/vaz/niva_fixed.txt",
	name = ITEM.name,
	physDesc = ITEM.physDesc,
	maxGas = ITEM.maxGas,
	seats = { --чем больше, темп правее | чем больше, тем вперед | чем больше, тем выше
		{
			pos = Vector(17.7, -16.0, 24.0),
			ang = Angle(0, 0, 0)
		},
		{
			pos = Vector(-14.0, -52.0, 25.0),
			ang = Angle(0, 0, 0)
		},
		{
			pos = Vector(18.0, -52.0, 25.0),
			ang = Angle(0, 0, 0)
		},
	}
}

ITEM.iconCam = {
	pos = Vector(0.10000000149012, 0.20000000298023, 200),
	ang = Angle(90, 0, -141.17646789551),
	fov = 2
}

