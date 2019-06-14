ITEM.name = "«Грави»"
ITEM.desc = "Артефакт образуется при длительном гравитационном воздействии на металлосодержащие вещества. Способен поддерживать антигравитационное поле. Многие сталкеры используют его так же, как и артефакт «Ночная звезда» – чтобы заметно уменьшить вес рюкзака. \n-артефакт \n\nРадиация +3 / сек"
ITEM.price = 40620
ITEM.isAnomaly = true
ITEM.weight = 0.82

ITEM.model = "models/kek1ch/gravi.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(122, 101.49317169189, 78.509117126465),
	ang = Angle(25, 220, 0),
	fov = 4.4618770353483
}

ITEM.functions.Use = {
	name = "положить в СИМК",
	onRun = function(item)
		local client = item.player
		if (IsValid(client) && iclient:Alive()) then
			if not client:getChar():getInv():hasItem("simkemp") then
				client:notify("Вам нужны СИМК (пустой).")
				return false
			end

			client:EmitSound( Sound( "interface/inv_iam_close.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			client:getChar():getInv():add("simk_gravy")
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