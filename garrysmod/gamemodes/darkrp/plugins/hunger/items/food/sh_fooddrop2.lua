ITEM.name = "Мясо псевдособаки"
ITEM.desc = "Мясо псевдособаки - весьма диетический продукт в Зоне. Довольно вкусное, с большой пищевой ценностью, сталкеры часто выбирают его в прожаренном виде. Может заинтересовать ученых. Из куска мяса при нехитрых манипуляциях можно добыть немного животного жира, пригодного для смазки оружия. \n\nВНИМАНИЕ: \n\nСталкерам рекомендуется воздержаться от употребления такого рода мяса \n\nХАРАКТЕРИСТИКИ: \n-мясо мутанта низкого происхождения \n-возможно приготовить \n-ядовитая пища \n-радиационное облучение: +27 мЗв \n\nНасыщение 19 ккал экв"
ITEM.price = 240
ITEM.exRender = false
ITEM.weight = 0.2
ITEM.hunger = 10
ITEM.thirst = 2

ITEM.model = "models/kek1ch/raw_flesh.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(90, 76.264152526855, 56.137489318848),
	ang = Angle(25, 220, 0),
	fov = 4.3485409317371
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