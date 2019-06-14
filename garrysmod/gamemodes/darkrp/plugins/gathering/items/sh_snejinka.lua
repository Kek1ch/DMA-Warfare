ITEM.name = "«Снежинка»"
ITEM.desc = "Внешне артефакт похож на «Колобок». Существует мнение что это и есть «Колобок», свойства которого усилились после воздействия мощного электрического поля. Благодаря своим качествам способен резко увеличивать мышечный тонус носителя. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +4 / сек"
ITEM.price = 38904
ITEM.isAnomaly = true
ITEM.weight = 0.82

ITEM.model = "models/kek1ch/ice.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(250.99797058105, 210.95155334473, 161.34284973145),
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
			client:getChar():getInv():add("simk_snejinka")
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