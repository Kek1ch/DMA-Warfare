ITEM.name = "Мультитопливная печь"
ITEM.desc = "Печь прошла тщательное тестирование в полевых условиях и была использована в бесчисленном множестве экспедиций в течении многих лет. Она невероятно прочная, надежная и мощная. Работает в самых сложных и суровых условиях: как на огромных высотах, так и при экстремальных температурах. \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-высококачественное изделие \n-используется для: приготовления мясо мутантов \n-для использования требуется: зажигалка, керосин, либо канистра бензина"
ITEM.price = 9385
ITEM.exRender = false
ITEM.weight = 0.36

ITEM.model = "models/kek1ch/multi_fuel_stove.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(166.95794677734, 136.87271118164, 102.66918182373),
	ang = Angle(25, 220, 6.8789811134338),
	fov = 4.6389929926663
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
		
		local pechka = ents.Create("multipechka")
		pechka:SetPos(trace.HitPos + trace.HitNormal * 10)
		pechka:Spawn()
		ply:EmitSound(Sound( "interface/inv_put_up_tent.ogg" ))
		ply:Freeze(true)
		timer.Create(5, function()
			ply:Freeze(false)
		end)
		ply:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1, function()
			ply:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
