ITEM.name = "Мясо тушкана"
ITEM.desc = "Небольшой кусочек мяса с тела мутировавшего грызуна. Дешевая и часто встречаемая пища, которая как поговаривают сталкера, укрепляет сердечную мышццу будучи приготовленной на огне. Может заинтересовать ученых. \n\nВНИМАНИЕ: \n\nСталкерам рекомендуется воздержаться от употребления такого рода мяса. \n\nХАРАКТЕРИСТИКИ: \n-мясо мутанта «низкого происхождения» \n-возможно приготовить \n-ядовитая пища \n-радиационное облучение: +17 м3в \n\nНасыщенеие 14 ккал экв."
ITEM.price = 69
ITEM.exRender = false
ITEM.weight = 0.1
ITEM.hunger = 10
ITEM.thirst = 2

ITEM.model = "models/kek1ch/raw_tushkano.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(53.877891540527, 45.455871582031, 33.413673400879),
	ang = Angle(25, 220, 0),
	fov = 4.2079302680872
}

ITEM.functions.use = {
	onRun = function(item)
		local client = item.player
		if item.hunger > 0 then client:restoreHunger(item.hunger) end
		if item.thirst > 0 then client:restoreThirst(item.thirst) end
		client:EmitSound( "interface/inv_eat_paperwrap.ogg", 75, 200 )
		client:setNetVar("radioactive", client:getNetVar("radioactive", 0) + 40)
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