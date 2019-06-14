ITEM.name = "Баллон с газом (7 литров)"
ITEM.desc = "Тяжелый металлический газовый баллон, пропитанный изнутри особыми полимерами для хранения внутри СО2/О2 раза, а с внешней стороны покрыт гипалоном для защиты от погодных условий и ультрафиолета. Этот газовый баллон пригоден для хранения внутри любого промышленного газа под давлением. \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-топливо для приготовления пищи"
ITEM.category = "misc"
ITEM.price = 1736
ITEM.exRender = false
ITEM.weight = 8
ITEM.kerosinAmount = 8

ITEM.model = "models/kek1ch/decor_janov_32.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(224.84808349609, 187.87902832031, 147.58396911621),
	ang = Angle(25, 220, 0),
	fov = 4.8615716244981
}

function ITEM:getDesc()
	local str
	str = self.desc.." Осталось %s литр(а)"
	return Format(str, self:getData("kerosinAmount"))
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		local kerosinAmount = item:getData("kerosinAmount", item.kerosinAmount or 1)
		draw.SimpleText(kerosinAmount, "nutIconFont", 4, y, Color(255, 255, 255, 255))
	end
end

function ITEM:onInstanced()
	if not self:getData("kerosinAmount") then
		self:setData("kerosinAmount", self.kerosinAmount)
	end
end