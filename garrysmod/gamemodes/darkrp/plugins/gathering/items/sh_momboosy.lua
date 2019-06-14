ITEM.name = "«Мамины бусы»"
ITEM.desc = "Артефакт кристаллизуется в аномальных зонах с высокой термальной активностью. Активно поглощает избыточное тепло, при этом оставаясь прохладным на ощупь. Многое в этом артефакте остаётся полной загадкой для учёных. Впрочем, точно установлено, что излучение, возникающее при пульсации утолщений «Маминых бус», ускоряет протекание метаболических процессов в организме. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +3 / сек"
ITEM.model = "models/kek1ch/dummy_glassbeads.mdl"
ITEM.price = 33048
ITEM.width = 1
ITEM.height = 1
ITEM.isAnomaly = true
ITEM.iconCam = {
pos = Vector(182.3424987793, 152.55667114258, 114.61862945557),
ang = Angle(25, 220, 0),
fov = 4.7003422456651
}
ITEM.weight = 0.82

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
			client:getChar():getInv():add("simk_momboosy")
			client:getChar():getInv():remove(client:getChar():getInv():hasItem("simkemp"):getID()) 
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