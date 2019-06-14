ITEM.name = "«Батарейка»"
ITEM.desc = "Редкий, довольно дорогой артефакт, образующийся в аномалиях электрического типа, немного повышает мышечный тонуc. Известно, что в состав этого артефакта входят электростатические элементы, однако в каких именно условиях он формируется, науке пока не известно. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +2 / сек"
ITEM.price = 19752
ITEM.isAnomaly = true
ITEM.weight = 0.82

ITEM.model = "models/kek1ch/dummy_battery.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(125, 104.16584777832, 81.444068908691),
	ang = Angle(25, 220, 0),
	fov = 4.4758594506754
}

ITEM.functions.Use = {
	name = "положить в СИМК",
	icon = "icon16/cup.png",
	onRun = function(item)
		local client = item.player
		if (IsValid(item.player) && item.player:Alive()) then
			if !item.player:getChar():getInv():hasItem("simkemp") then
				item.player:notify("Вам нужны СИМК (пустой).")
				return false
			end
			item.player:EmitSound( Sound( "interface/inv_iam_close.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			item.player:getChar():getInv():add("simk_batary")
			client:getChar():getInv():remove(client:getChar():getInv():hasItem("simkemp"):getID()) 
		end
	end,

	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}