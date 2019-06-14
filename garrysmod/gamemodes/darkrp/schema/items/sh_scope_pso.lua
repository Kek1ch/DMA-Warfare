ITEM.name = "Прицел ПСО-1"
ITEM.price = 50170
ITEM.desc = "Широко распространённый оптический прицел советского производства фиксированной кратности (5). Оснащён шкалой для определения дальности до цели. Для установки на оружие используется стандартное в странах Варшавского договора крепление типа «ласточкин хвост»"
ITEM.weight = 0.01
ITEM.exRender = false

ITEM.model = "models/weapons/wick/stcopwep/ak_pso.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(1, 200, 0),
	ang = Angle(0, 270, 0),
	fov = 4.6
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

