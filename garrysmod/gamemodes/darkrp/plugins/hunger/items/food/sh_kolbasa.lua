ITEM.name = "Копченая колбаса (привозная)"
ITEM.desc = "Колбаса, изготовленная из говядины и свинины. Закопченная и упакованная в вакумную упаковку, они может храниться в течении длительного времени. Данная палка колбасы импортирована из России. Такие обычно пользуются спросом среди русской мафии за свой исключительный аромат и вкус. \n\nХАРАКТЕРИСТИКИ: \n-пища \n-здоровое питание \n\nНасыщение 50" --Его описание
ITEM.category = "Еда" 
ITEM.price = 1971 
ITEM.hunger = 50
ITEM.thirst = 0
ITEM.weight = 0.40
ITEM.exRender = false
ITEM.empty = false

ITEM.model = "models/kek1ch/dev_kolbasa.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(99.05802154541, 81.936004638672, 60.716087341309),
	ang = Angle(25, 220, 0),
	fov = 4.3749786370389
}

ITEM.functions.use = {
	onRun = function(item)
		local client = item.player
		if item.hunger > 0 then client:restoreHunger(item.hunger) end
		if item.thirst > 0 then client:restoreThirst(item.thirst) end
		client:EmitSound( "interface/inv_eat_paperwrap.ogg", 75, 200 )
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
