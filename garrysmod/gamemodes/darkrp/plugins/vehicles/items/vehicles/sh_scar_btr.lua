ITEM.name = "БТР-70"
ITEM.physDesc = ""
ITEM.maxGas = 3000
ITEM.price = 1200000
ITEM.weight = 0.05
ITEM.exRender = false

ITEM.vehicleData = {
	type = TYPE_GENERIC,
	model = "models/kek1ch/btr70/btr70_remake.mdl",
	script = "scripts/vehicles/stalker/btr70_remake.txt",
	name = ITEM.name,
	physDesc = ITEM.physDesc,
	maxGas = ITEM.maxGas,
	seats = { --чем больше, темп правее | чем больше, тем вперед | чем больше, тем выше
		{
			pos = Vector(-30.0,-30.0,65.0),
			ang = Angle(0,90,0)
		},
		{
			pos = Vector(30.0,-30.0,65.0),
			ang = Angle(0,-90,0)
		},
		{
			pos = Vector(-30.0,-0.0,65.0),
			ang = Angle(0,90,0)
		},
		{
			pos = Vector(-30.0,30.0,65.0),
			ang = Angle(0,90,0)
		},
		{
			pos = Vector(-30.0,60.0,65.0),
			ang = Angle(0,90,0)
		},
		{
			pos = Vector(-30.0,-0.0,65.0),
			ang = Angle(0,-90,0)
		},
		{
			pos = Vector(30.0,30.0,65.0),
			ang = Angle(0,-90,0)
		},
		{
			pos = Vector(30.0,60.0,65.0),
			ang = Angle(0,-90,0) --места на броне
		},
		{
			pos = Vector(17.0,92.0,29.0), --переднее место
			ang = Angle(0,0,0)
		},
		{
			pos = Vector(30.0,61.0,26.0),
			ang = Angle(0,90,0)
		},
		{
			pos = Vector(30.0,39.0,26.0),
			ang = Angle(0,90,0)
		},
		{
			pos = Vector(-30.0,39.0,26.0),
			ang = Angle(0,-90,0)
		},
		{
			pos = Vector(-30.0,61.0,26.0),
			ang = Angle(0,-90,0)
		},
	}
}
