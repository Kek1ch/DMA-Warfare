ITEM.name = "«Огненый шар»"
ITEM.desc = "«Огненный шар» — часто использующийся сталкерами артефакт из-за его способности поддерживать приемлемую температуру в радиусе пяти метров. Однако у торговцев спросом похвастаться не может. Он образуется в высокотемпературных средах, но каким образом — никто ещё не выяснил. Образуется в аномалиях типа Жарка. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +3 / сек"
ITEM.price = 14900
ITEM.isAnomaly = true
ITEM.weight = 0.82

ITEM.model = "models/kek1ch/fireball.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(146.4425201416, 123.03157806396, 95.019195556641),
	ang = Angle(25, 220, 0),
	fov = 4.5627383011566
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
			client:getChar():getInv():add("simk_fireball")
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