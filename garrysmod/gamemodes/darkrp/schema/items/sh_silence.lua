ITEM.name = "Глушитель"
ITEM.price = 35140
ITEM.weight = 0.01
ITEM.exRender = false
ITEM.model = "models/weapons/wick/stcopwep/ak_silender.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-0.5, 0, 200),
	ang = Angle(90, 0, -89.426750183105),
	fov = 3.5
}

ITEM.functions.Equip = {
	name = "установить",
	onCanRun = function(item)				
		return (!IsValid(item.entity))
	end,

	onRun = function(item)
		item.player:notify("Улучшение одето на оружие!")
		item.player:EmitSound(Sound("weapons/stalker_cop/addon_attach.wav"))
		item:setData("equip", true)
		return false
	end
}
ITEM.functions.EquipUn = {
	name = "снять",
	onCanRun = function(item)				
		return (!IsValid(item.entity))
	end,

	onRun = function(item)
		item.player:notify("Улучшение снято с оружия!")
		item.player:EmitSound(Sound("weapons/stalker_cop/addon_detach.wav"))
		item:setData("equip", false)
		return false
	end
}

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if (item:getData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end