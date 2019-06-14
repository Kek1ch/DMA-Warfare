ITEM.name = "«Ночная звезда»"
ITEM.desc = "Ночная звезда — артефакт, изредка образующийся в аномалии «Трамплин». Красивое образование с зеркальной поверхностью и цветными фосфоресцирующими вкраплениями. Ночью освещает зеленоватым светом всё вокруг себя в радиусе одного-двух метров, за что и получил у сталкеров такое название. Представляет собой спрессованные и причудливо изогнутые сильной гравитацией остатки растений, почвы и вообще всего, что попадает в непосредственную близость от аномалии. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +2 / сек"
ITEM.price = 12356
ITEM.isAnomaly = true
ITEM.weight = 0.82

ITEM.model = "models/kek1ch/nightstar.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(276.04568481445, 231.64785766602, 176.0782623291),
	ang = Angle(25, 220, 0),
	fov = 4
}

ITEM.functions.Use = {
	name = "положить в СИМК",
	onRun = function(item)
		local client = item.player
		if (IsValid(item.player) and item.player:Alive()) then
			if not client:getChar():getInv():hasItem("simkemp") then
				client:notify("Вам нужны СИМК (пустой).")
				return false
			end

			client:EmitSound( Sound( "interface/inv_iam_close.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			client:getChar():getInv():add("simk_nightstar")
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