ITEM.name = "Пси-шлем"
ITEM.desc = "Прототип, разработнный учеными для защиты от пси-излучения. Представляет из себя наушники с начинкой, продолжающиеся конструкцией из сетки, покрывающей голову. Размеры позволяют носить его под капюшоном, каской, шлемом и другой экипировкой. \n\nХАРАКТЕРИСТИКИ: \n-важный предмет \n-элемент экипировки \n-не выпадает \n-обеспечивает надежную защиту от источников пси-излучения"
ITEM.price = 38900
ITEM.exRender = false

ITEM.model = "models/kek1ch/item_psi_helmet.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-203.82165527344, 106, 111),
	ang = Angle(25, -27.515924453735, 0),
	fov = 3.4
}

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if (item:getData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	return !self:getData("equip")
end
