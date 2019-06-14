ITEM.name = "«Золотая рыбка»"
ITEM.desc = "Все его свойства были обнаружены учёным Сахаровым на Янтаре после массивного выброса. После его тщательных исследований было установлено, что этот артефакт образуется после слияния трёх «Грави» на уровне взаимодействия сингулярных полей. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +2 / сек"
ITEM.price = 19752
ITEM.isAnomaly = true
ITEM.weight = 0.82

ITEM.model = "models/kek1ch/gold_fish.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 89.426750183105),
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
			client:getChar():getInv():add("simk_goldfish")
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