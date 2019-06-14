ITEM.name = "Водка Казаки"
ITEM.desc = "Довольно популярная на территории Зоны водка укринского производства. Хорошо пьётся, хаметно снижает воздействие радиации, однако злоупотреблять ей не следует. \n-крепкий алкоголь \n-напиток \n\nЖажда +60" 
ITEM.category = "Еда" 
ITEM.price = 1280 
ITEM.thirst = 40
ITEM.hunger = 0
ITEM.quantity = 1
ITEM.exRender = false
ITEM.empty = true
ITEM.weight = 0.80

ITEM.model = "models/kek1ch/dev_vodka2.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(115.70365905762, 97.124000549316, 75.816535949707),
	ang = Angle(25, 220, -38.980892181396),
	fov = 4
}

ITEM.functions.use = {
	name = "употребить",
	icon = "icon16/cup.png",
	onRun = function(item)
		local client = item.player
		client:EmitSound( "interface/inv_drink_flask.ogg", 75, 200 )
		if item.hunger > 0 then client:restoreHunger(item.hunger) end
		if item.thirst > 0 then client:restoreThirst(item.thirst) end
		item:setData("quantity", item:getData("quantity", item.quantity or 0) - 1)
		client:setNetVar("radioactive", client:getNetVar("radioactive", 0) - 9)
		client:ScreenFade(1, Color(255, 255, 255, 255), 3, 0)
		client:setNetVar("drunk", true)
		timer.Simple(10, function()
			client:setNetVar("drunk", false)
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