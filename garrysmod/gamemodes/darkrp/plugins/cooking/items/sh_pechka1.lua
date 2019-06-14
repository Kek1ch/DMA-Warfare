ITEM.name = "Самодельная походная печка"
ITEM.desc = "Печь кустарного производства, использующая сухую древесину или угол в качестве топлива и предназначена для приготовления пищи. Популярная среди сталкеров, так как легка в изготовлении: копус состоит из простого газового баллона ёмкостью 5 литров, а внутренние детали грубо вырезаютсяы из повсеместно распространённых канистр. \n\nХАРАКТЕРИСТИКИ:\n-технологическое приспособление\n-используется пдля приготовления мяса"
ITEM.price = 2370
ITEM.weight = 3.10

ITEM.model = "models/kek1ch/wood_stove.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(248.53330993652, 208, 163),
	ang = Angle(25, 220, 0),
	fov = 4.9434642813403
}

ITEM.functions.use = { 
	name = "использовать",
	tip = "useTip",
	icon = "icon16/drive.png",
	onRun = function(item)
		local ply = item.player
		local data = {}
			data.start = ply:GetShootPos()
			data.endpos = data.start + ply:GetAimVector()*200
			data.filter = ply
		local trace = util.TraceLine(data)
		
		local pechka = ents.Create("pechka")
		pechka:SetPos(trace.HitPos + trace.HitNormal * 10)
		pechka:Spawn()
		ply:EmitSound(Sound( "interface/inv_put_up_tent.ogg" ))
		ply:Freeze(true)
		timer.Simple(5, function()
			ply:Freeze(false)
		end)
		ply:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
			ply:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
