local PANEL = {}

function PANEL:Init()
	self:SetSize(300, 500)	
	self:MakePopup()
	self:Center()
	self:SetTitle("")
	
	self.controls = self:Add("DPanel")
	self.controls:Dock(BOTTOM)
	self.controls:SetTall(30)
	self.controls:DockMargin(0, 5, 0, 0)
	
	self.contents = self:Add("DTextEntry")
	--[[function self.contents:Paint( w, h )
			local material = Material("ui/but_1.png") 
			--surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
	end]]
	--self.contents:SetSize( ScrW()*0.487, ScrH()*0.06 )	-- Size it to 150x150
	--self.contents:SetPaintBackground( true )
	--self.contents:Dock(LEFT)
	self.contents:SetMultiline(true)
	self.contents:SetEditable(false)
	self.contents:SetSize(210, 420)		
	self.contents:SetPos(45, 30)		
	self.contents:SetPaintBackgroundEnabled(true)
	self:ShowCloseButton( true )
	

	self.confirm = self.controls:Add("DButton")
	--self.confirm:Dock(BOTTOM)
	function self.confirm:Paint( w, h )
			local material = Material("ui/but_1.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
	end
	self.confirm:SetDisabled(false)
	self.confirm:SetText(L("finish"))
	self.confirm:SetFont("StalkerMediumFont")
	self.confirm:SetTextColor(Color(210, 180, 140))
	self.confirm:SetSize(127, 37)	
	self.confirm:SetPos(85, -11)	

	self.confirm.DoClick = function()
	self.confirm:Close()
	end
	

	self.controls.Paint = function(this, w, h)
		local text = self.contents:GetValue()
		--draw.SimpleText(Format("Лимит символов: %s/1020", string.len(text)), "DermaDefault", 10, h/2, color_white, TEXT_ALIGN_LEFT, 1)
	end
	function self:Paint( w, h )
			local material = Material("ui/note.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
	end
	self.confirm.DoClick = function(this)
		local text = self.contents:GetValue()
		netstream.Start("noteSendText", self.id, text)
		self:Close()
	end
	
	
end

function PANEL:allowEdit(bool)
	if (bool == true) then
		self.contents:SetEditable(true)
		self.confirm:SetDisabled(false)
	else
		self.contents:SetEditable(false)
		self.confirm:SetDisabled(true)
	end
end

function PANEL:setText(text)
	self.contents:SetText(text)

end

vgui.Register("noteRead", PANEL, "DFrame")
