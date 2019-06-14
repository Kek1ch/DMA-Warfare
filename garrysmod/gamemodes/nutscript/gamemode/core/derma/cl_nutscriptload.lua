local gradient = nut.util.getMaterial("vgui/gradient-r.vtf")
local glow = surface.GetTextureID("particle/Particle_Glow_04_Additive")

local PANEL = {}
	function PANEL:Init()

		if (IsValid(nut.gui.intro)) then
			nut.gui.intro:Remove()
		end

		nut.gui.intro = self
		self.scrW, self.scrH = ScrW(), ScrH()
		self:SetSize(ScrW(), ScrH())
		self:SetZPos(9999)
		self:MakePopup()
		function self:Paint(w, h)
			surface.SetDrawColor(0, 0, 0)
			surface.DrawRect(0, 0, w, h)

			if (self.glow) then
				self.delta = math.Approach(self.delta, 100, FrameTime() * 10)

				local x, y = ScrW()*0.5 - 700, ScrH()*0.5 - 340

				surface.SetDrawColor(self.delta, self.delta, self.delta, self.delta + math.sin(RealTime() * 0.7)*10)
				surface.SetTexture(glow)
				surface.DrawTexturedRect(x, y, 1400, 680)
			end
		end

		timer.Simple(3, function()
			if (IsValid(self)) then
				self:addContnutscript()
			end
		end)

	end

	function PANEL:addContnutscript()

		self.scrW, self.scrH = ScrW(), ScrH()

		local buttonW, buttonH = self.scrW * 0.4, self.scrH * 0.055
		local buttonX, buttonY = (self.scrW * 0.225) - (buttonW * 0.5), self.scrH * 0.36 

		self.third = self:Add("DLabel")
		self.third:SetSize(buttonW, buttonH)
		self.third:DockMargin(0, 0, 0, 32)
		self.third:Center()
		self.third:SetText("Nutscript is loading...")
		self.third:SetFont("dobi4ikxyecoc")
		self.third:SetContentAlignment(2)
		self.third:SetAlpha(0)
		self.third:AlphaTo(255, 1, 0, function()
		end)
		self.third:SetExpensiveShadow(1, color_black)

		local line1W, line1H = self.scrW * 0.2, self.scrH * 0.025
		local line1X, line1Y = (self.scrW * 0.4955) - (line1W * 0.5), self.scrH * 0.54

		self.line1 = self:Add("DLabel")
		self.line1:SetSize(0, line1H)
		self.line1:SetPos(line1X, line1Y)
		self.line1:DockMargin(0, 0, 0, 32)
		self.line1:SetText("")
		self.line1:SetFont("dobi4ikxyecoc")
		self.line1:SetContentAlignment(2)
		self.line1:SetAlpha(0)
		self.line1:SizeTo( line1W, line1H, 5, 0, -5 )
		self.line1:AlphaTo(255, 1, 0, function()
		end)
		self.line1:SetExpensiveShadow(1, color_black)
		function self.line1:Paint( w, h )
			surface.SetDrawColor(169, 169, 169)
			surface.DrawRect(0, 0, w, h)

			if (self.glow) then
				local x, y = ScrW()*0.5 - 700, ScrH()*0.5 - 340
				surface.SetTexture(glow)
				surface.DrawTexturedRect(x, y, 1400, 680)
				surface.SetDrawColor(169, 169, 169)
			end
		end

		timer.Simple(5, function()
			intro = vgui.Create("nutCharMenu")
			self:Remove()
		end)

	end

vgui.Register("nutscriptload", PANEL, "EditablePanel")
netstream.Hook("nutscriptload", function()
	nutscriptload = vgui.Create("nutscriptload")
end)