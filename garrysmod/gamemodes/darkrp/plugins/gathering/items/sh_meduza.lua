ITEM.name = "«Медуза»"
ITEM.desc = "Артефакт гравитационной природы, обладающий способностью активно притягивать и поглощать радиоактивные частицы, тем самым уменьшая облучённость организма. Широко распространён в Зоне; за её пределами широко, хотя и негласно, используется при лечении острой лучевой болезни. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +2 / сек"
ITEM.price = 12354
ITEM.isAnomaly = true
ITEM.weight = 0.82

ITEM.model = "models/kek1ch/medusa.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(129.83967590332, 109.03283691406, 85.107475280762),
	ang = Angle(25, 220, 0),
	fov = 4.4979937329715
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
			client:getChar():getInv():add("simk_meduza")
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