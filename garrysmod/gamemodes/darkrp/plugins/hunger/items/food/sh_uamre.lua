ITEM.name = "Украинский рацион питания" 
ITEM.desc = "Украинский боевой рацион питания основан на российском аналоге ИРП-Б, состоящий лишь из коммерчески доступных консервов и сущеных продуктов питания. \n\nХАРАКТЕРИСТИКИ: \n-военный рацион \n-здоровое питание \n\nНасыщение 90 \nЖажда 90"
ITEM.price = 14574
ITEM.hunger = 90
ITEM.thirst = 90
ITEM.quantity = 4
ITEM.weight = 1.72
ITEM.exRender = false

ITEM.model = "models/kek1ch/ration_ukr.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, -91.719741821289),
	fov = 6.7
}

function ITEM:getDesc()
	local str
	str = self.desc.."\n\nОсталось %s порций."
	return Format(str, self:getData("quantity"))
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		local quantity = item:getData("quantity", item.quantity or 1)
		draw.SimpleText(quantity, "NameFactionFont", 4, y, Color(210, 180, 140, 180))
	end
end

ITEM.functions.use = {
	name = "употребить",
	tip = "useTip",
	icon = "icon16/cup.png",
	onRun = function(item)
		local client = item.player
		client:EmitSound("ration_using/us_ration.wav", 80, 110)	
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

function ITEM:onInstanced()
	if not self:getData("quantity") then
		self:setData("quantity", self.quantity)
	end
end
