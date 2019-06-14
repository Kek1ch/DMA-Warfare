ITEM.name = "УАЗИК"
ITEM.physDesc = ""
ITEM.maxGas = 1500
ITEM.price = 598990
ITEM.weight = 0.05
ITEM.exRender = false

ITEM.vehicleData = {
	type = TYPE_GENERIC,
	model = "models/tails models/dayz/Uaz/Uaz.mdl",
	script = "scripts/vehicles/uaz/uaz.txt",
	name = ITEM.name,
	physDesc = ITEM.physDesc,
	maxGas = ITEM.maxGas,
	seats = { --чем больше, темп правее | чем больше, тем вперед | чем больше, тем выше
		{
			pos = Vector(16, -15.0, 37.0), 
			ang = Angle(0, 0, 0)
		},
		{
			pos = Vector(-16.0, -44.0, 37.0),
			ang = Angle(0, 0, 0)
		},
		{
			pos = Vector(18.0, -44.0, 37.0), 
			ang = Angle(0, 0, 0)
		},
	}
}

