ITEM.name = "«Вспышка»"
ITEM.desc = "«Вспышка» — артефакт, образующийся в местах, насыщенных электромагнитным полем. Не так редок, но и не так распространён. Имеет удивительное свойство поглощать электрический ток, перенаправляя разряды с организма на себя. «Заряженные» Вспышки в быту используют в качестве «маленьких электростанций».Образуется в аномалиях типа «электра». \n\nХАРАКТЕРИСТИКИ: \n-артефакт \nРадиация +2 / сек"
ITEM.price = 8964
ITEM.isAnomaly = true
ITEM.weight = 0.82

ITEM.model = "models/kek1ch/electra_flash.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(478.31607055664, 401.55526733398, 291.64785766602),
	ang = Angle(25, 220, 0),
	fov = 1.7197452229299
}

ITEM.functions.Use = {
	name = "положить в СИМК",
	onRun = function(item)
		local client = item.player
		if (IsValid(item.player) && client:Alive()) then
			if not client:getChar():getInv():hasItem("simkemp") then
				client:notify("Вам нужны СИМК (пустой).")
				return false
			end
			client:EmitSound( Sound( "interface/inv_iam_close.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			client:getChar():getInv():add("simk_flash")
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