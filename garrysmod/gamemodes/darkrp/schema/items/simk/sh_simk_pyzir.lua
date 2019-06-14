ITEM.name = "СИМК с «Пузырем»"
ITEM.desc = "Артефакт представляет собой несколько полых образований органической природы, соединённых между собой. Выделяет газообразное вещество, способное нейтрализовать химические или токсичные частицы в организме человека. Ввиду высокой эффективности пользуется огромным спросом, но и обладает многочисленными отрицательными свойствами. \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-высокая ценность \n-не требует подзарядки \n-максимальная вместимость - 1 \n-состояние: заполнен (содержит артефакт «Пузырь»)"
ITEM.category = "СИМК"
ITEM.price = 26752
ITEM.exRender = false
ITEM.weight = 2.31

ITEM.model = "models/kek1ch/lead_box_closed.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(216.7789001464,8, 181.60939025879, 142.37495422363),
	ang = Angle(25, 220, 0),
	fov = 3.7
}

ITEM.functions.Use = {
	name = "использовать",
	icon = "icon16/cup.png",
	onRun = function(item)
		local client = item.player
		if (IsValid(item.player) && client:Alive()) then
			client:EmitSound( Sound( "interface/inv_iam_open.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			client:getChar():getInv():add("pyzir")
			client:getChar():getInv():add("simkemp")
			client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
			timer.Simple(1,function()
				client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
			end)
		end
	end,
	
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}