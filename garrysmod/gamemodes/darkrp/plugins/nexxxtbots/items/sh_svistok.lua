ITEM.name = "Медальон Призыва"
ITEM.desc = "Позволяет призывать компаньона \n\nХАРАКТЕРИСТИКИ: \n-высокая ценность \n-не выпадает"
ITEM.price = 92642 
ITEM.exRender = false
ITEM.weight = 0.09

ITEM.model = "models/kek1ch/dev_money3.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, -90),
	fov = 0.8,
	outline = true,
	outlineColor = Color(129, 194, 0)
}

function ITEM:onInstanced()
	self:setData("DOG_ID", math.random(0,9999999999))
end

ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end

ITEM.functions.Use = {
	name = "позвать компаньона",
	onRun = function(item)
		local client = item.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local trace = util.TraceLine(data)

		local object = nil
		for k,v in pairs(ents.GetAll()) do
			if (v.uniqueid == item:getData("DOG_ID")) then
				object = v
				break
			end
		end

		if (object) then
			object:Remove()
		else
			local companion = ents.Create("nextbot_wolf")
			companion:SetPos(trace.HitPos + trace.HitNormal * 10)
			companion:Spawn()
			companion.uniqueid = item:getData("DOG_ID")
		end

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
