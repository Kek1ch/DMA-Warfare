ITEM.name = "Мясо плоти"
ITEM.desc = "Довольно популярный продукт в Зоне, мясо плоти имеет хороший вкус и большую пищевую ценнность. Ученые уже достаточно много провели исслоедований над принесенными сталкерами образцами, поэтому спрос как таковой на такие куски мяса упал. \n\nВНИМАНИЕ:\n\nСталкерам рекомендуется воздержаться от употребления такого рода мяса. \n\nХАРАКТЕРИСТИКИ: \n-мясо мутанта низкого"
ITEM.price = 319
ITEM.exRender = false
ITEM.weight = 0.41
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