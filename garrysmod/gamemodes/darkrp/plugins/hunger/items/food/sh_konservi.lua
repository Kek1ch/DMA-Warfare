ITEM.name = "Тушенка из говядины «Абакан» (привозная)"
ITEM.desc = "Тушенка - это общее название из тушеного мяса, производимая в Советском Союзе и других странах Варшавского договора. Ирония заключается в том, что идея такого продукта пришла в Россию во время Второй мировой войны в форме помощи от Соединенных Штатов. \n\nХАРАКТЕРИСТИКИ: \n-пища \n-здоровое питание \n-для употребления нужен: Нож \n\nНасыщение 80" --Его описание
ITEM.category = "Еда"
ITEM.price = 2769 
ITEM.hunger = 80
ITEM.thirst = 10
ITEM.weight = 0.34
ITEM.exRender = false

ITEM.model = "models/kek1ch/dev_chili.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(52.070404052734, 43.692253112793, 33.886013031006),
	ang = Angle(25, 220, 0),
	fov = 4.9
}

ITEM.functions.use = {
	onRun = function(item)
		local client = item.player
		if not client:getChar():getInv():hasItem("knife") then
			client:notify("Вам нужен Нож для открытия консервов.")
			return false
		end
		
		if item.hunger > 0 then client:restoreHunger(item.hunger) end
		if item.thirst > 0 then client:restoreThirst(item.thirst) end
		client:EmitSound( "interface/inv_eat_can.ogg", 75, 200 )
		client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
			client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
		return true
	end,
	onCanRun = function(item)
		return (!item.empty)
	end,
	name = "Употребить"
}
ITEM.empty = false