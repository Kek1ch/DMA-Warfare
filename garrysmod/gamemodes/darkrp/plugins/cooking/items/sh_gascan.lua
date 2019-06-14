ITEM.name = "Канистра (8 литров)"
ITEM.desc = "Большая, наполовину пустая металлическая канистра с 95-м бензином. Канистры поставлялись в зону в больших количествах следом за украиноской военной техникой. \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-топливо для приготовления пищи \n-используется для: заправки машин"
ITEM.category = "Топливо"
ITEM.price = 1609
ITEM.exRender = false
ITEM.weight = 7.52
ITEM.kerosinAmount = 8

ITEM.model = "models/kek1ch/kanistra.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(0, 200, 12),
	ang = Angle(0, 270, 0),
	fov = 8.6
}

ITEM:hook("use", function(item)
	item.player:EmitSound("items/battery_pickup.wav")
end)

ITEM.functions._use = { 
	name = "заправить",
	onRun = function(item)
		local client = item.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local trace = util.TraceLine(data)
		local ent = trace.Entity

		if (ent and IsValid(ent) and ent.spawnedVehicle) then
			local percent
			ent:fillGas(1000)
			percent = (ent:getNetVar("gas") / ent.maxGas)*100
			client:notify("Машина заправлена", client, percent)
			return true
		else
			client:notify(L("vehicleGasLook", client))
		end

		return false
	end,
	onCanRun = function(item)
		return (!item:getData("spawned"))
	end
}

function ITEM:getDesc()
	local str
	str = self.desc.." Осталось %s литр(а)"
	return Format(str, self:getData("kerosinAmount"))
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		local kerosinAmount = item:getData("kerosinAmount", item.kerosinAmount or 1)
		draw.SimpleText(kerosinAmount, "nutIconFont", 4, y, Color(255, 255, 255, 255))
	end
end

function ITEM:onInstanced()
	if not self:getData("kerosinAmount") then
		self:setData("kerosinAmount", self.kerosinAmount)
	end
end