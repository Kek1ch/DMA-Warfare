ITEM.name = "СИМК с «Мамиными бусами»"
ITEM.desc = "«Мамины бусы» в свинцово-изолированном металлическом контейнере. Артефакт кристаллизуется в аномальных зонах с высокой термальной активностью. Активно поглощает избыточное тепло, при этом оставаясь прохладным на ощупь. Многое в этом артефакте остаётся полной загадкой для учёных. Впрочем, точно установлено, что излучение, возникающее при пульсации утолщений «Маминых бус», ускоряет протекание метаболических процессов в организме. \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-высокая ценность \n-не требует подзарядки \n-максимальная вместимость - 1 \n-состояние: заполнен (содержит артефакт «Мамины бусы»)"
ITEM.category = "СИМК"
ITEM.price = 36800
ITEM.exRender = false

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
		if (IsValid(client) && client:Alive()) then
			client:EmitSound( Sound( "interface/inv_iam_open.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			client:getChar():getInv():add("momboosy")
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