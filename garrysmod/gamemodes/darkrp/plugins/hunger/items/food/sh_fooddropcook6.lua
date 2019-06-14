ITEM.name = "Сало плоти (произведено в Зоне)"
ITEM.desc = "Два ломтика сала и жирного бекона из мутировавших свиней, более известных, как плоти. Завернуто в толстую коричневую бумагу, чтобы жир не стекал. \n\nХАРАКТЕРИСТИКИ: \n-вредная пища \n-радиационное облучение: 15 м3в \n\nНасыщенеие 48"
ITEM.price = 997
ITEM.exRender = false
ITEM.weight = 0.41
ITEM.hunger = 48
ITEM.thirst = 5

ITEM.model = "models/kek1ch/meat_flesh.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(58.272296905518, 48.844135284424, 35.863288879395),
	ang = Angle(25, 220, 0),
	fov = 4
}

ITEM.functions.use = {
	onRun = function(item)
		local client = item.player
		if item.hunger > 0 then client:restoreHunger(item.hunger) end
		if item.thirst > 0 then client:restoreThirst(item.thirst) end
		client:EmitSound( "interface/inv_eat_paperwrap.ogg", 75, 200 )
		client:setNetVar("radioactive", client:getNetVar("radioactive", 0) + 14)
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