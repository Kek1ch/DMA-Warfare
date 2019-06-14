ITEM.name = "Американский MRE"
ITEM.desc = "Сухой паек, готовый к употреблению является автономным, индивидуальным рационом питания вооруженных сил Соединенных Штатов в полевых условиях, при проведении боевых операций или при других сложных условиях, когда нет поблизости источников нормальной пищи. \n\nХАРАКТЕРИСТИКИ: \n-военный \n-высококачественное изделие \n-здоровое питание \n\nНасыщение 100 \nЖажда 100" --Его описание
ITEM.price = 6435
ITEM.hunger = 100
ITEM.quantity = 3
ITEM.thirst = 100
ITEM.weight = 0.70
ITEM.empty = false
ITEM.exRender = false

ITEM.model = "models/kek1ch/ration_mre.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, -2.2929935455322),
	fov = 3
}

ITEM.functions.use = {
	name = "употребить",
	icon = "icon16/cup.png",
	onRun = function(item)
		local client = item.player
		client:EmitSound( "ration_using/us_ration.wav", 75, 200 )
		if item.hunger > 0 then client:restoreHunger(item.hunger) end
		if item.thirst > 0 then client:restoreThirst(item.thirst) end
		item:setData("quantity", item:getData("quantity", item.quantity or 0) - 1)
		client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
			client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)

		if item:getData("quantity") < 1 then
			return true
		end
		return false;
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
