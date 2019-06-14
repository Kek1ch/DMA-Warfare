local PANEL = {}

function PANEL:Init(uniqueID)

	self:SetSize(ScrW() * 0.3, ScrH() * 0.682)
	self:MakePopup()
	self:SetTitle("")
	self:ShowCloseButton(false)
	self:SetDraggable(false)

end

function PANEL:Paint(w, h)
	nut.util.drawBlur(self, 10)
	surface.SetDrawColor(Color( 20, 20, 20, 220))
	surface.DrawRect( 0, 0, w, h )
	surface.DrawOutlinedRect(0, 0, w, h)

	surface.SetDrawColor(0, 0, 14, 150)
	surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033)

	surface.SetDrawColor(Color( 30, 30, 30, 90))
	surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033) --шапка

	surface.SetDrawColor(255, 255, 255, 200) 
	surface.SetMaterial(Material("daui/scrbr.png")) 
	surface.DrawTexturedRect(0, ScrH()*0.033, w, h) 

	surface.SetDrawColor(Color( 138, 149, 151, 60))
	surface.DrawLine(ScrW() * 0.018, ScrH() * 0.0325, ScrW() * 0.29, ScrH() * 0.0325)

	surface.SetDrawColor(Color( 30, 30, 30, 190))
	surface.DrawOutlinedRect(0, 0, w, h) --обводка основной панеи

	draw.DrawText("Экипировка", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT ) --надпись шапки

	surface.SetDrawColor(0, 0, 0, 210)
	surface.DrawRect(ScrW() * 0.104, ScrH() * 0.22, ScrW() * 0.097, ScrH() * 0.036) --верхняя альфа панелька

	surface.SetDrawColor(0, 0, 0, 210)
	surface.DrawRect(ScrW() * 0.094, ScrH() * 0.2525, ScrW() * 0.12, ScrH() * 0.036) --нижняя альфа панелька

	draw.DrawText("Не доступно", "Roh25", ScrW() * 0.151, ScrH() * 0.223, Color(255, 255, 255, 210), TEXT_ALIGN_CENTER ) --верхняя альфа надпись

	draw.DrawText("В альфа версии", "Roh25", ScrW() * 0.15, ScrH() * 0.2535, Color(255, 255, 255, 210), TEXT_ALIGN_CENTER ) --нижняя альфа надпись
end

vgui.Register("equipment_panel", PANEL, "DFrame")
netstream.Hook("equipment_panel", function()
	equipment_panel = vgui.Create("equipment_panel")
end)