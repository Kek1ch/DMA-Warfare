ITEM.name = "Кошелек"
ITEM.desc = "Используется для хранения значительного количества денег. \n\nХАРАКТЕРИСТИКИ: \n-повсеместное применение \n-используется для: хранения денег \n-не выпадает"
ITEM.category = "Прочее"
ITEM.price = 3221
ITEM.exRender = false
ITEM.weight = 0.07

ITEM.model = "models/kek1ch/kowelek_v2.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0.15000000596046, 0, 200),
	ang = Angle(90, 0, 2.2929935455322),
	fov = 1.7
}

local MoneyTable = {}
MoneyTable[5000] = {moneyitem = "5000r"}
MoneyTable[1000] = {moneyitem = "1000r"}
MoneyTable[500] = {moneyitem = "500r"}
MoneyTable[100] = {moneyitem = "100r"}
MoneyTable[50] = {moneyitem = "50r"}
MoneyTable[10] = {moneyitem = "10r"}

--[[ITEM.functions.Use = { 
onRun = function(item) 
	local client = item.player
	if client:getChar():hasMoney(5000) then
		client:getChar():getInv():add("5000r", 1)
		client:getChar():takeMoney(5000)
	elseif client:getChar():hasMoney(1000) then
		client:getChar():getInv():add("1000r", 1)
		client:getChar():takeMoney(1000)
	elseif client:getChar():hasMoney(500) then
		client:getChar():getInv():add("500r", 1)
		client:getChar():takeMoney(500)
	elseif client:getChar():hasMoney(100) then
		client:getChar():getInv():add("100r", 1)
		client:getChar():takeMoney(100)
	elseif client:getChar():hasMoney(50) then
		client:getChar():getInv():add("1000r", 1)
		client:getChar():takeMoney(50)
	elseif client:getChar():hasMoney(1000) then
		client:getChar():getInv():add("10r", 1)
		client:getChar():takeMoney(10)
	end
	return false
end 
}]]

--sound = "interface/money_"..math.random(1, 2)..".ogg",
