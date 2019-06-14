ITEM.name = "«Душа»"
ITEM.desc = "Уникальный органический артефакт с не менее уникальными свойствами. Неизвестным пока образом увеличивает общую скорость восстановления организма. Из-за особенностей воздействия на организм и приятного внешнего вида представляет особый интерес для коллекционеров. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +4 / сек"
ITEM.price = 25662
ITEM.isAnomaly = true
ITEM.weight = 0.82

ITEM.model = "models/kek1ch/soul.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(187.89283752441, 157.68478393555, 121.12998199463),
	ang = Angle(25, 220, 0),
	fov = 4
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
			client:getChar():getInv():add("simk_soul")
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