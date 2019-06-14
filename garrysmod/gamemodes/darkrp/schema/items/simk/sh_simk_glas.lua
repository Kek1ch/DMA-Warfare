ITEM.name = "СИМК с «Мамиными бусами»"
ITEM.desc = "«Глаз» — название своё получил из-за внешнего сходства с органом зрения. Не так часто появляется, поэтому торговцы платят за него неплохие деньги. Сталкерами ценится за поверье, будто он приносит удачу. Ускоряет метаболизм организма, вследствие чего раны заживают быстрее. Образуется в аномалии типа «жарка» и в архианомалии «Симбионт».  \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-высокая ценность \n-не требует подзарядки \n-максимальная вместимость - 1 \n-состояние: заполнен (содержит артефакт «Глаз»)"
ITEM.category = "СИМК"
ITEM.price = 20235
ITEM.exRender = false
ITEM.weight = 3.65

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
			client:getChar():getInv():add("glas")
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