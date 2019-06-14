ITEM.name = "Собачья отбивная (произведено в Зоне)"
ITEM.desc = "Небольшая горячая отбивная из слепого пса смешанная с чесноком, перцем и грибами. Упакована в старую жестяную коробку. Дешевая альтернатива популярным кабаньим стейкам. \n\nХАРАКТЕРИСТИКИ: \n-вредная пища \n-радиационное облучение: 11 \n\nНасыщенеие 32"
ITEM.price = 676
ITEM.exRender = false
ITEM.weight = 0.21
ITEM.hunger = 32
ITEM.thirst = 5

ITEM.model = "models/kek1ch/meat_dog.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(58.984310150146, 49.493705749512, 37.502128601074),
	ang = Angle(25, 220, 0),
	fov = 5
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

