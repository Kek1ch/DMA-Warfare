ITEM.name = "Свежий хлеб (привозной)"
ITEM.desc = "Свежий хлеб, испеченной женой Шустрого, которая живет за пределами Зоны Отчуждения. Это было первое дело Шустрого, до того как его бизнес расширился. В настоящее время он снабжает бармена этим хлебом, а не продает его сам, как было раньше. \n\nХАРАКТЕРИСТИКИ \n-пища \n-здоровое питание \n\nНасыщение 35"
ITEM.category = "Еда"
ITEM.price = 1146
ITEM.hunger = 35
ITEM.thirst = 0
ITEM.weight = 0.10
ITEM.exRender = false
ITEM.empty = false

ITEM.model = "models/kek1ch/dev_bred.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(111.42967224121, 90.897361755371, 68.352897644043),
	ang = Angle(25, 220, 0),
	fov = 4
}

ITEM.functions.use = {
	onRun = function(item)
		local client = item.player
		if item.hunger > 0 then client:restoreHunger(item.hunger) end
		if item.thirst > 0 then client:restoreThirst(item.thirst) end
		client:EmitSound( "interface/inv_eat_paperwrap.ogg", 75, 200 )
		client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
			client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
		return true
	end,
	onCanRun = function(item)
		return (!item.empty)
	end,
	name = "употребить"
}

