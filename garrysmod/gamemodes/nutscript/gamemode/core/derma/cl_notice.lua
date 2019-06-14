local PANEL = {}
function PANEL:Init()
	self:SetSize(256, 36)
	self:SetContentAlignment(5)
	self:SetFont("dobi4ikxyecockft1234444")
	self:SetTextColor(Color(211, 211, 211))
	self:SetDrawOnTop(true)
	--[[function self:Paint( w, h )
		local material = Material("daui/notice.png") 
		surface.SetDrawColor(color_white) 
		surface.SetMaterial(material) 
		surface.DrawTexturedRect(0, 0, w, h) 
	end]]
end
vgui.Register("nutNotice", PANEL, "DLabel")