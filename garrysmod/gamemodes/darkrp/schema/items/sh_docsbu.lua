ITEM.name = "Персональное удостоверение ВСУ"
ITEM.desc = "Документ военно служащего Украины, в нем содержатся данные, которые занесены в Систему, автоматически даёт право на проход в зону экологического бедствия. \n\nХАРАКТЕРИСТИКИ: \n-личная вещь"
ITEM.category = "misc"
ITEM.price = 9535
ITEM.exRender = false
ITEM.weight = 0.02

ITEM.model = "models/kek1ch/identity_card.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(165.60510253906, 191.08280944824, 19.108280181885),
	ang = Angle(4.3000001907349, -130.89999389648, 2.2929935455322),
	fov = 2.8
}

ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end

ITEM.functions.Use = {
	onRun = function(item)
		local client = item.player
		if not item:getData("name") == "Пусто" then
			client:getChar():getInv():add("docsbu", 1, {name = client:getChar():getName()})
			return true
		end

		return false
	end
}

function ITEM:getDesc()
	local description = self.desc.."\n\nИмя: "..self:getData("name", "Пусто").."."
	return description
end

