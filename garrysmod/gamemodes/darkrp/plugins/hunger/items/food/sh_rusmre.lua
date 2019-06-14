ITEM.name = "Российский рацион питания ИРП-Б" 
ITEM.desc = "Завтрак, обед и ужин- все в одном пакете. Поставляется в полимерных коробках. \n\nХАРАКТЕРИСТИКИ: \n-военный рацион \n-здоровое питане \n\nНасыщение 100 \nЖажда 100" --Его описание
ITEM.price = 27555
ITEM.hunger = 100
ITEM.thirst = 100
ITEM.quantity = 7 
ITEM.empty = false
ITEM.weight = 1.39
ITEM.exRender = false

ITEM.model = "models/kek1ch/ration_ru.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, -2.2929935455322),
	fov = 4.0127388535032
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
		client:EmitSound("ration_using/rus_ration.wav", 80, 110)	
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

function ITEM:onInstanced()
	if not self:getData("quantity") then
		self:setData("quantity", self.quantity)
	end
end
