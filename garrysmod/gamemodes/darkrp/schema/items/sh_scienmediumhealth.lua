ITEM.name = "Научная аптечка"
ITEM.category = "Медицина"
ITEM.desc = "Медицинский набор, разработанный специально для научных сотрудников, которые работают в условиях Зоны. Содержит средства как для заживления механических травм, так и для предоствращения развития лучевой болезник \n\nХАРАКТЕРИСТИКИ: \n-высокая ценность \n-высококачественный препарат \n-медленное использование (полевой набор) \n\nВосст. здоровья 91"
ITEM.price = 3164
ITEM.exRender = false
ITEM.weight = 0.1

ITEM.model = "models/kek1ch/dev_aptechka_mid.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 2.3
}

ITEM.functions.Use = {
	onRun = function(item)
		local client = item.player
		client:Freeze(true)
		timer.Simple(5, function()
			client:Freeze(false)
		end)
		client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
			client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
		client:setNetVar("bleeding",false)
		client:SetHealth(math.min(client:Health() + 100, 100))
	end
}
