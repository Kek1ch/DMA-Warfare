ITEM.name = "Чай Бороды (произведено в Зоне, 1 литр)" 
ITEM.desc = "Популярный среди сталкеров горячий чай Бороды, настоянный на съедобных сушенных грибах в кипяченной воде (поговаривают, что не радиоактивной) с добавлением сахара. Сталкеры. которые могут позволить покупать данный напиток, часто берут его с собой в длительные ходки по Зоне. Это довольно хороший и относительно здоровый способ оставаться на ногах, когда устанешь или когда пережидаешь холодные темные ночи. \n\nХАРАКТЕРИСТИКИ \n-напиток \n-здоровое питание \n\nРадиация -13 м3d / сек \nНасыщение 226 ккал экв." --Его описание
ITEM.price = 6709
ITEM.thirst = 90
ITEM.hunger = 10
ITEM.quantity = 3
ITEM.weight = 1.03
ITEM.empty = true
ITEM.exRender = false

ITEM.model = "models/kek1ch/drink_tea.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(101.74163818359, 85.371360778809, 66.62133026123),
	ang = Angle(25, 220, 0),
	fov = 2.7
}

ITEM.functions.use = {
	name = "употребить",
	tip = "useTip",
	onRun = function(item)
		local client = item.player
		client:EmitSound( "interface/inv_drink_tea.ogg", 75, 200 )
		if item.hunger > 0 then client:restoreHunger(item.hunger) end
		if item.thirst > 0 then client:restoreThirst(item.thirst) end
		item:setData("quantity", item:getData("quantity", item.quantity or 0) - 1)
		client:setNetVar("radioactive", client:getNetVar("radioactive", 0) - 5)
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
