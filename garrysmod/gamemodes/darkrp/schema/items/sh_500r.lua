ITEM.name = "500 Рублей"
ITEM.desc = "Российские рубли, обычно хранят в кошельке, неотъемлемая часть торговлю. \n\nХАРАКТЕРИСТИКИ: \n-высокая ценность \n-для использования нужен кошелек"
ITEM.price = 500
ITEM.exRender = false
ITEM.weight = 0.01

ITEM.model = "models/kek1ch/money_500.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 3.7
}

ITEM.functions.Use = {
	onRun = function(item)
		if (IsValid(item.player) && item.player:Alive()) then
			if not item.player:getChar():getInv():hasItem("kowelek") then
				item.player:notify("У вас нет кошелька!")
				return false
			end
			
			local cough = {
				"interface/money_1.ogg",
				"interface/money_2.ogg"
			}
			item.player:EmitSound(table.Random(cough), 50, 100)
			item.player:getChar():giveMoney(500)
		end
	end,

	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}