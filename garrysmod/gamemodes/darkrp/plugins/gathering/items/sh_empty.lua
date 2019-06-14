ITEM.name = "«Пустышка»"
ITEM.desc = "«Пустышка» состоит из двух дисков голубоватого цвета, связанных между собой полупрозрачным материалом неизвестной природы. Этот странный артефакт считался лишенным каких-либо полезных свойств в течение длительного времени. Лишь недавно было обнаружено, что он обеспечивает весь высокий уровень защиты от пси-воздействий, частично поглощая их. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +2 / сек"
ITEM.price = 13752
ITEM.isAnomaly = true
ITEM.weight = 0.89

ITEM.model = "models/kek1ch/dummy_dummy.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 5.1592356687898
}

ITEM.functions.Use = {
	name = "положить в СИМК",
	onRun = function(item)
		local client = item.player
		if (IsValid(client) && client:Alive()) then
			if not client:getChar():getInv():hasItem("simkemp") then
				client:notify("Вам нужны СИМК (пустой).")
				return false
			end
			
			client:EmitSound( Sound( "interface/inv_iam_close.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			client:getChar():getInv():add("simk_empty")
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