local PANEL = {}

function PANEL:Init()

	self.scrW, self.scrH = ScrW(), ScrH()

	self:SetSize(self.scrW * 0.4, self.scrH * 0.29)
	self:MakePopup()
	self:Center()
	self:SetTitle("")
	self:ShowCloseButton( false )
	self:SetDraggable( false )

	local typo_logoWyes, typo_logoHyes = self.scrW * 0.3, self.scrH * 0.0265
	local typo_logoXyes, typo_logoYyes = (self.scrW * 0.21) - (typo_logoWyes * 0.5), self.scrH * 0.01

	self.typo_logo = self:Add("DLabel")
	self.typo_logo:SetPos( typo_logoXyes, typo_logoYyes )
	self.typo_logo:SetSize( typo_logoWyes, typo_logoHyes )
	self.typo_logo:SetText("Исполнитель желаний")
	self.typo_logo:SetFont("dobi4ikxyecockft")
 
	local buttonWyes, buttonHyes = self.scrW * 0.262, self.scrH * 0.0265
	local buttonXyes, buttonYyes = (self.scrW * 0.257) - (buttonWyes * 0.5), self.scrH * 0.06

	self.kekone = self:Add("DButton")
	self.kekone:SetText(L("Я хочу, чтобы Зона исчезла."))
	self.kekone:SetFont("NameFactionPingFont")
	self.kekone:SetTextColor(color_white)
	self.kekone:SetSize(buttonWyes, buttonHyes)	
	self.kekone:SetPos(buttonXyes, buttonYyes)	
	function self.kekone:Paint( w, h )
		local material = Material("daui/noimg.png")
		surface.SetDrawColor(color_white) 
		surface.SetMaterial(material) 
		surface.DrawTexturedRect(0, 0, w, h) 
	end
	self.kekone.DoClick = function(client)
		LocalPlayer():ConCommand("say /zispjel Твое желание - закон для меня. Но помни, Сталкер, что каждое действие имеет последствия.")
		netstream.Start("isp_jel")
		self:Close()
	end

	local kektwoWyes, kektwoHyes = self.scrW * 0.262, self.scrH * 0.0265
	local kektwoXyes, kektwoYyes = (self.scrW * 0.257) - (kektwoWyes * 0.5), self.scrH * 0.085

	self.kektwo = self:Add("DButton")
	self.kektwo:SetText(L("Я хочу стать богачем."))
	self.kektwo:SetFont("NameFactionPingFont")
	self.kektwo:SetTextColor(color_white)
	self.kektwo:SetSize(kektwoWyes, kektwoHyes)	
	self.kektwo:SetPos(kektwoXyes, kektwoYyes)	
	function self.kektwo:Paint( w, h )
		local material = Material("daui/noimg.png")
		surface.SetDrawColor(color_white) 
		surface.SetMaterial(material) 
		surface.DrawTexturedRect(0, 0, w, h) 
	end
	self.kektwo.DoClick = function(client)
		LocalPlayer():ConCommand("say /ztakemoney 6000000")
		netstream.Start("isp_jel")
		self:Close()
	end

	local kektreeWyes, kektreeHyes = self.scrW * 0.262, self.scrH * 0.0265
	local kektreeXyes, kektreeYyes = (self.scrW * 0.257) - (kektreeWyes * 0.5), self.scrH * 0.107

	self.kektree = self:Add("DButton")
	self.kektree:SetText(L("Я хочу править миром."))
	self.kektree:SetFont("NameFactionPingFont")
	self.kektree:SetTextColor(color_white)
	self.kektree:SetSize(kektreeWyes, kektreeHyes)	
	self.kektree:SetPos(kektreeXyes, kektreeYyes)	
	function self.kektree:Paint( w, h )
		local material = Material("daui/noimg.png")
		surface.SetDrawColor(color_white) 
		surface.SetMaterial(material) 
		surface.DrawTexturedRect(0, 0, w, h) 
	end
	self.kektree.DoClick = function(client)
		LocalPlayer():ConCommand("say /zispjel Нас много и мы будем управлять тобой.")

		timer.Simple(1, function()
		LocalPlayer():ConCommand("say /zdwonnewrep Великолепная")
		end)
		netstream.Start("isp_jel")
		self:Close()
	end

	local kekforWyes, kekforHyes = self.scrW * 0.262, self.scrH * 0.0265
	local kekforXyes, kekforYyes = (self.scrW * 0.257) - (kekforWyes * 0.5), self.scrH * 0.13

	self.kekfor = self:Add("DButton")
	self.kekfor:SetText(L("Человечеством нужно управлять."))
	self.kekfor:SetFont("NameFactionPingFont")
	self.kekfor:SetTextColor(color_white)
	self.kekfor:SetSize(kekforWyes, kekforHyes)	
	self.kekfor:SetPos(kekforXyes, kekforYyes)	
	function self.kekfor:Paint( w, h )
		local material = Material("daui/noimg.png")
		surface.SetDrawColor(color_white) 
		surface.SetMaterial(material) 
		surface.DrawTexturedRect(0, 0, w, h) 
	end
	self.kekfor.DoClick = function(client)
		LocalPlayer():ConCommand("say /zispjel Человечество уже под контролем, как и ты.")
		netstream.Start("isp_jel")
		self:Close()
	end

	local kekfiveWyes, kekfiveHyes = self.scrW * 0.262, self.scrH * 0.0265
	local kekfiveXyes, kekfiveYyes = (self.scrW * 0.257) - (kekfiveWyes * 0.5), self.scrH * 0.153

	self.kekfive = self:Add("DButton")
	self.kekfive:SetText(L("Хочу стать бессмертным."))
	self.kekfive:SetFont("NameFactionPingFont")
	self.kekfive:SetTextColor(color_white)
	self.kekfive:SetSize(kekfiveWyes, kekfiveHyes)	
	self.kekfive:SetPos(kekfiveXyes, kekfiveYyes)	
	function self.kekfive:Paint( w, h )
		local material = Material("daui/noimg.png")
		surface.SetDrawColor(color_white) 
		surface.SetMaterial(material) 
		surface.DrawTexturedRect(0, 0, w, h) 
	end
	self.kekfive.DoClick = function(client)
		LocalPlayer():ConCommand("say /zispjel Я дам тебе бессмертную армию.")
		netstream.Start("isp_jel")
		self:Close()
	end

	local keksixWyes, keksixHyes = self.scrW * 0.262, self.scrH * 0.0265
	local keksixXyes, keksixYyes = (self.scrW * 0.257) - (keksixWyes * 0.5), self.scrH * 0.176

	self.keksix = self:Add("DButton")
	self.keksix:SetText(L("Хочу Идеальное снаряжение."))
	self.keksix:SetFont("NameFactionPingFont")
	self.keksix:SetTextColor(color_white)
	self.keksix:SetSize(keksixWyes, keksixHyes)	
	self.keksix:SetPos(keksixXyes, keksixYyes)	
	function self.keksix:Paint( w, h )
		local material = Material("daui/noimg.png")
		surface.SetDrawColor(color_white) 
		surface.SetMaterial(material) 
		surface.DrawTexturedRect(0, 0, w, h) 
	end
	self.keksix.DoClick = function(client)
		LocalPlayer():ConCommand("say /zispjel Твое желание - закон для меня. Но помни, Сталкер, что каждое действие имеет последствия.")
		netstream.Start("isp_jel")
		self:Close()
	end

	local keksevenWyes, keksevenHyes = self.scrW * 0.262, self.scrH * 0.0265
	local keksevenXyes, keksevenYyes = (self.scrW * 0.257) - (keksevenWyes * 0.5), self.scrH * 0.2

	self.kekseven = self:Add("DButton")
	self.kekseven:SetText(L("Хочу Идеальный артефакт."))
	self.kekseven:SetFont("NameFactionPingFont")
	self.kekseven:SetTextColor(color_white)
	self.kekseven:SetSize(keksevenWyes, keksevenHyes)	
	self.kekseven:SetPos(keksevenXyes, keksevenYyes)	
	function self.kekseven:Paint( w, h )
		local material = Material("daui/noimg.png")
		surface.SetDrawColor(color_white) 
		surface.SetMaterial(material) 
		surface.DrawTexturedRect(0, 0, w, h) 
	end
	self.kekseven.DoClick = function(client)
		LocalPlayer():ConCommand("say /zispjel Твое желание - закон для меня. Но помни, Сталкер, что каждое действие имеет последствия.")
		netstream.Start("isp_jel")
		self:Close()
	end

	local ny_ego_naxyiWno, ny_ego_naxyiHno = self.scrW * 0.12, self.scrH * 0.032
	local ny_ego_naxyiXno, ny_ego_naxyiYno = (self.scrW * 0.335) - (ny_ego_naxyiWno * 0.5), self.scrH * 0.24

	self.ny_ego_naxyi = self:Add("DButton")
	function self.ny_ego_naxyi:Paint(w,h)
		if self:IsDown() then 
			local material = Material("daui/but_pressf.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		elseif self:IsHovered() then
			local material = Material("daui/but_cur.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		else
		local material = Material("daui/dev_but.png") 
		surface.SetDrawColor(color_white) 
		surface.SetMaterial(material) 
		surface.DrawTexturedRect(0, 0, w, h)
		end
	end
	self.ny_ego_naxyi:SetDisabled(false)
	self.ny_ego_naxyi:SetText(L("Уйти"))
	self.ny_ego_naxyi:SetFont("DescTipFont")
	self.ny_ego_naxyi:SetTextColor(color_white)
	self.ny_ego_naxyi:SetSize(ny_ego_naxyiWno, ny_ego_naxyiHno)	
	self.ny_ego_naxyi:SetPos(ny_ego_naxyiXno, ny_ego_naxyiYno)	

	self.ny_ego_naxyi.DoClick = function()
	self:Close()
	end
	
	function self:Paint( w, h )
		local material = Material("daui/ips_jelun.png")
		surface.SetDrawColor(color_white) 
		surface.SetMaterial(material) 
		surface.DrawTexturedRect(0, 0, w, h) 
	end
end

vgui.Register("monolet", PANEL, "DFrame")
netstream.Hook("monolet", function()
	noteRead1 = vgui.Create("monolet")
end)
