ITEM.name = "Очищенная вода (произведено в Зоне, 1 литр)" --Название предмета
ITEM.desc = "Военные фляжки предназначены для питья воды небольшими глотками. Произведена и очищена медиками и учеными. \n\nХАРАКТЕРИСТИКИ: \n-напиток \n-здоровое питание \n\nРадиация -12 \nЖажда 70" --Его описание
ITEM.category = "Еда"
ITEM.price = 987
ITEM.hunger = 0
ITEM.thirst = 10
ITEM.quantity = 3
ITEM.weight = 0.45
ITEM.empty = true
ITEM.exRender = false

ITEM.model = "models/kek1ch/drink_flask.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 22, 3.4000000953674),
	ang = Angle(0, 270, -9.1719741821289),
	fov = 24
}

ITEM.functions.use = {
	name = "употребить",
	icon = "icon16/cup.png",
	onRun = function(item)
		local client = item.player
		client:EmitSound( "interface/inv_drink_can2.ogg", 75, 200 )
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
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

