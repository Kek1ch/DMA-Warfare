ITEM.name = "«Пузырь»"
ITEM.desc = "Артефакт представляет собой несколько полых образований органической природы, соединённых между собой. Выделяет газообразное вещество, способное нейтрализовать химические или токсичные частицы в организме человека. Ввиду высокой эффективности пользуется огромным спросом, но и обладает многочисленными отрицательными свойствами. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +2 / сек"
ITEM.price = 23752
ITEM.isAnomaly = true
ITEM.weight = 0.31

ITEM.model = "models/kek1ch/ballon.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(167, 139.68508911133, 106.67984008789),
	ang = Angle(25, 220, 0),
	fov = 4.6365419239949
}

ITEM.functions.Use = {
	name = "положить в СИМК",
	onRun = function(item)
		local client = item.player
		if (IsValid(client) and client:Alive()) then
			if not client:getChar():getInv():hasItem("simkemp") then
				client:notify("Вам нужны СИМК (пустой).")
				return false
			end

			client:EmitSound( Sound( "interface/inv_iam_close.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			client:getChar():getInv():add("simk_pyzir")
			client:getChar():getInv():remove(client:getChar():getInv():hasItem("simkemp"):getID()) 
			item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
			timer.Simple(1,function()
				client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
			end)
		end
	end,

	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}