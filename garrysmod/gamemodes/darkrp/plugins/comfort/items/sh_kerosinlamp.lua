﻿ITEM.name = "Керосиновая лампа"
ITEM.desc = "Керосиновая малпа из-за своих больших размеров не пользуется особой популярностью среди сталкеров, но достаточно удобна и практична в качестве статичного источника освещения в лагере. \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-не требует заправки"
ITEM.price = 678
ITEM.exRender = false
ITEM.weight = 1.33

ITEM.model = "models/kek1ch/dev_kerosinka.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(241.85496520996, 203, 158),
	ang = Angle(25, 220, 0),
	fov = 2.8
}

ITEM.functions.use = { 
	name = "поставить",
	onRun = function(item)
		local client = item.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local trace = util.TraceLine(data)
		
		local lamp = ents.Create("nut_kerosinka")
		lamp:SetPos(trace.HitPos + trace.HitNormal * 10)
		lamp:Spawn()
		client:EmitSound( Sound("interface/inv_put_up_tent.ogg"), Entity(1):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100)
		client:ScreenFade(SCREENFADE.OUT, Color(0, 0, 0), 1, 3)
		timer.Simple(1,function()
			client:ScreenFade(SCREENFADE.IN, Color(0, 0, 0), 1, 3)
		end)
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

