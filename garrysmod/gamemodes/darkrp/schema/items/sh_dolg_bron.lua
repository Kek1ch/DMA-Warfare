ITEM.name = "ПСЗ-9д «Броня Долга» (Заказной)"
ITEM.desc = "Ранняя модель комбинезона «Долга» — бронежилет спецназа серии ПС3-9, приспособленный для использования в условиях Зоны. Способен защитить от автоматной пули, но очень громоздок и почти не обеспечивает защиту от аномальных воздействий. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-усиленная бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.price = 114254
ITEM.ric = 22
ITEM.dmgsteal = 45
ITEM.exRender = false
ITEM.addition = 8
ITEM.weight = 14

ITEM.model = "models/kek1ch/dolg_heavy_outfit.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(1.6000000238419, -0.40000000596046, 200),
	ang = Angle(90, 0, 180),
	fov = 8.5987261146497
}


ITEM.functions.Use = {
	onRun = function(item)
		local client = item.player
		client:ScreenFade(SCREENFADE.OUT, Color(0, 0, 0), 1, 3)
		timer.Simple(1, function()
			client:ScreenFade(SCREENFADE.IN, Color(0, 0, 0), 1, 3)
		end)
		client:getChar():setModel("models/hdmodels/kek1ch/stalker_dolg2a_mas3.mdl")
		client:EmitSound("interface/inv_bandage_3p7.ogg", 50, 100)
		return false
	end
}

