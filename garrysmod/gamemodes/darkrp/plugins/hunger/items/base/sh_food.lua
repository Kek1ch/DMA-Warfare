ITEM.name = "Food base"
ITEM.desc = "A food."
ITEM.category = "food"
ITEM.model = "models/props_lab/bindergraylabel01b.mdl"
ITEM.hunger = 5
ITEM.category = "Consumeable"
ITEM.thirst = 5
ITEM.isFood = true
ITEM.quantity = 1
ITEM.empty = false
ITEM.weight = 0
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

ITEM.functions.use = { -- sorry, for name order.
	name = "Употребить",
	tip = "useTip",
	icon = "icon16/cup.png",
	onRun = function(item)
	local client = item.player
			item.player:EmitSound("ration_using/us_ration.wav", 80, 110)	
			if item.hunger > 0 then client:restoreHunger(item.hunger) end
			if item.thirst > 0 then client:restoreThirst(item.thirst) end
			--if (IsValid(target) and target:IsPlayer() and target:Alive()) then
			item:setData("quantity", item:getData("quantity", item.quantity or 0) - 1)
			
			if item:getData("quantity") < 1 then
				item.player:notify("Вы израсходовали все аптечки")
				return true
			end
		--end
		return false;
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

function ITEM:onInstanced()
	if !self:getData("quantity") then
		self:setData("quantity", self.quantity)
	end
end
