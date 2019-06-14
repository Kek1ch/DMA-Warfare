﻿ITEM.name = "Заряд РС-15"
ITEM.desc = "Самодельное взрывное устройство, полученное из различных химических веществ, забитых в контейнер с металлическими шариками и со сломанным электрическим воспламенителем. Активируется автоматически. \n\nХАРАКТЕРИСТИКИ: \n-взрывоопасно \n-военное изделие \n\nДля активации необходимо выложить"
ITEM.category = "Комфорт"
ITEM.price = 6940
ITEM.exRender = false
ITEM.weight = 1.25

ITEM.model = "models/kek1ch/bomb_c4.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 4.7
}

ITEM.functions.Use = { 
	name = "установить",
	icon = "icon16/cup.png", 
	onRun = function(item) 
		local client = item.player
		local mine = ents.Create("mine")
		local data = {
			start = client:GetShootPos(),
			endpos = client:GetShootPos() + client:GetAimVector() * 95,
			filter = client
		}
		local trace = util.TraceLine(data)
		if (!trace.Hit or trace.HitSky) then return false end
		mine:SetPos(trace.HitPos)
		mine:Spawn()
		mine:Activate()
		mine:EmitSound("physics/flesh/flesh_impact_hard6.wav")
		client:ScreenFade(SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3)
		timer.Simple(1,function()
			client:ScreenFade(SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3)
		end)
	end 
}