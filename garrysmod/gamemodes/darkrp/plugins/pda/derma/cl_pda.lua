local PANEL = {}

function PANEL:Init(uniqueID)
	self:SetSize(ScrW() * 0.41, ScrH() * 0.57)
	self:MakePopup()
	self:Center()
	self:SetTitle("")
	self:ShowCloseButton(false)
	self:SetDraggable(false)
end

vgui.Register("pda_kek1ch", PANEL, "DFrame")
netstream.Hook("pda_kek1ch", function()
	pda_kek1ch = vgui.Create("pda_kek1ch")
end)