ITEM.name = "«Выверт»"
ITEM.desc = "Артефакт причудливой формы, возникающий в местах повышенной гравитационной активности. Представляет собой своего рода губку, поглощающую радиоактивные элементы. В равной степени успешно защищает своего носителя от воздействия как наведённой радиации, так и уже попавших в организм радиоактивных частиц. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +4 / сек"
ITEM.price = 16825
ITEM.isAnomaly = true

ITEM.model = "models/kek1ch/vyvert.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(271.78997802734, 228.13900756836, 172.78308105469),
	ang = Angle(25, 220, 0),
	fov = 4
}

ITEM.functions.Use = {
	name = "положить в СИМК",
	onRun = function(item)
		local client = item.player
		if (IsValid(client) and client:Alive()) then
			if not client:getChar():getInv():hasItem("simkemp") then
				client:notify("Вам нужны СИМК (пустой).")
				return false
			end

			client:EmitSound( Sound( "interface/inv_iam_close.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			client:getChar():getInv():add("simk_vyvert")
			client:getChar():getInv():remove(client:getChar():getInv():hasItem("simkemp"):getID()) 
			client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
			timer.Simple(1,function()
				client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
			end)
		end
	end,

	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}