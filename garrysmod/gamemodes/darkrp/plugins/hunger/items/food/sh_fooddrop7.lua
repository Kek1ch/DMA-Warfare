ITEM.name = "Рука снорка"
ITEM.desc = "По общепринятому мнение, снорки мутировали из людей, поэтому употреблять их масо в пищу считается рюдоедством и весьма аморально. Тем не менее, некоторые группировки, такие, как бандиты и наемники включают такого рода мясо в рацион своих бойцов, тем самым как проявляя превосходство над другими группировками. \n\nХАРАКТЕРИСТИКИ: \n-мясо мутанта низкого \n-возможно приготовить"
ITEM.price = 248
ITEM.model = "models/kek1ch/raw_snork.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0.40000000596046, -0.10000000149012, 200),
	ang = Angle(90, 0, -134.11764526367),
	fov = 2.5
}
ITEM.exRender = false
ITEM.weight = 0.27
ITEM.hunger = 10
ITEM.thirst = 2

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