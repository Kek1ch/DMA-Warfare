ITEM.name = "«Глаз»"
ITEM.desc = "«Глаз» — название своё получил из-за внешнего сходства с органом зрения. Не так часто появляется, поэтому торговцы платят за него неплохие деньги. Сталкерами ценится за поверье, будто он приносит удачу. Ускоряет метаболизм организма, вследствие чего раны заживают быстрее. Образуется в аномалии типа «жарка» и в архианомалии «Симбионт». \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +3 / сек"
ITEM.model = "models/kek1ch/eye.mdl"
ITEM.price = 17235
ITEM.isAnomaly = true
ITEM.weight = 0.82

ITEM.model = "models/kek1ch/eye.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(113.03336334229, 94.391189575195, 70.900405883789),
	ang = Angle(25, 220, 0),
	fov = 4.4331783507675
}

ITEM.functions.Use = {
	name = "положить в СИМК",
	onRun = function(item)
		local client = item.player
		if (IsValid(client) && client:Alive()) then
			if not client:getChar():getInv():hasItem("simkemp") then
				client:notify("Вам нужны СИМК (пустой).")
				return false
			end
			
			client:EmitSound( Sound( "interface/inv_iam_close.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			client:getChar():getInv():add("simk_glas")
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