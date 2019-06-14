ITEM.name = "Записка"
ITEM.price = 129
ITEM.permit = "Мусор"
ITEM.weight = 0.01

ITEM.model = "models/kek1ch/notes_letter_1.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 4.5859870910645),
	fov = 7
}

ITEM.functions.Write = {
	name = "прочитать",
	icon = "icon16/font.png",
	onRun = function(item)	
	local canwrite = true
	if item:getData("owner") == nil then
		item:setData("owner", item.player:getChar():getID())
	end
	if (item:getData("owner")) and (item:getData("owner") == item.player:getChar():getID()) then
		canwrite = true
	elseif (item:getData("owner")) and (item:getData("owner") ~= item.player:getChar():getID()) then
		canwrite = false
	end
	local client = item.player
		netstream.Start(client, "receiveNote", item:getID(), item:getData("text", ""), canwrite)
		return false
	end,
	onCanRun = function(item)
		if item:getData("block") then
			return false
		end
	end,
}

