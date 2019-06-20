local gradient = nut.util.getMaterial("vgui/gradient-r.vtf")
local glow = surface.GetTextureID("particle/Particle_Glow_04_Additive")

local PANEL = {}
	function PANEL:Init()

		if (IsValid(nut.gui.intro)) then
			nut.gui.intro:Remove()
		end

		nut.gui.intro = self

		self:SetSize(ScrW(), ScrH())
		self:SetAlpha(0)
		self:AlphaTo(255, 0.25, 0)
		self:SetPopupStayAtBack(true)


		function self:Paint( w, h )
			local x, y = gui.MousePos()
			surface.SetDrawColor(color_white)
			surface.SetMaterial(Material("daui/poster-18-09-27 21-53-21.png"))
			surface.DrawTexturedRect(-0.05 * x, -0.05 * y, w * 1.05, h * 1.05)
		end 

		self.scrW, self.scrH = ScrW(), ScrH()

		self.black = self:Add("DLabel")
		self.black:SetSize(ScrW(), ScrH())
		self.black:SetText("")
		self.black:SetFont("dobi4ikxyecoc")
		function self.black:Paint( w, h )
			surface.SetDrawColor(0, 0, 0, 255)  
			surface.DrawRect(0, 0, w, h) 
		end 

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
		self.line1:SizeTo( line1W, line1H, 3, 0, -3 )
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

		timer.Simple(2.5, function()
			if (IsValid(self)) then
				self:AlphaTo(255, 2, 0, function()
					self.line1:Remove()
					self.black:Remove()
					self.third:Remove()
					self:addContinue()
				end)
			end
		end)
	end

	function PANEL:addContinue()

		self.scrW, self.scrH = ScrW(), ScrH()

		local buttonW, buttonH = self.scrW * 0.4, self.scrH * 0.055 
		local buttonX, buttonY = (self.scrW * 0.225) - (buttonW * 0.5), self.scrH * 0.36 

		self.third = self:Add("DLabel")
		self.third:SetSize(buttonW, buttonH)
		self.third:SetPos(buttonX, buttonY)
		self.third:DockMargin(0, 0, 0, 32)
		self.third:SetText("S.T.A.L.K.E.R.")
		self.third:SetFont("dobi4ikxyecoc1")
		self.third:SetContentAlignment(2)
		self.third:SetAlpha(0)
		self.third:AlphaTo(255, 1, 0, function()
			self.third.Paint = function(this)
				this:SetAlpha(math.abs(math.cos(RealTime() * 0) * 255))
			end
		end)
		self.third:SetExpensiveShadow(1, color_black)


		local button1Y =  self.scrH * 0.3977
		self.second = self:Add("DLabel")
		self.second:SetSize(buttonW, buttonH)
		self.second:SetPos(self.scrW * -0.0245, button1Y)
		self.second:DockMargin(0, 0, 0, 32)
		self.second:SetText("Warfare")
		self.second:SetFont("dobi4ikxyecoc")
		self.second:SetContentAlignment(2)
		self.second:SetAlpha(0)
		self.second:AlphaTo(255, 1, 0, function()
			self.second.Paint = function(this)
				this:SetAlpha(math.abs(math.cos(RealTime() * 0) * 255))
			end
		end)
		self.second:SetExpensiveShadow(1, color_black)

		self.secondw = self:Add("DLabel")
		self.secondw:SetSize(buttonW, buttonH)
		self.secondw:SetPos(self.scrW * 0.054, button1Y)
		self.secondw:DockMargin(0, 0, 0, 32)
		self.secondw:SetText("ROLE-PLAY")
		self.secondw:SetFont("dobi4ikxyecoc")
		self.secondw:SetTextColor(Color(255, 140, 0))
		self.secondw:SetContentAlignment(2)
		self.secondw:SetAlpha(0)
		self.secondw:AlphaTo(255, 1, 0, function()
			self.secondw.Paint = function(this)
				this:SetAlpha(math.abs(math.cos(RealTime() * 0) * 255))
			end
		end)
		self.secondw:SetExpensiveShadow(1, color_black)

		local button2Y =  self.scrH * 0.45
		self.info = self:Add("DLabel")
		self.info:SetSize(buttonW, buttonH)
		self.info:SetPos(buttonX, button2Y )
		self.info:SetTall(36)
		self.info:DockMargin(0, 0, 0, 32)
		self.info:SetText("-Нажмите [ПРОБЕЛ] для перехода в меню-")
		self.info:SetFont("dobi4ikxyecoc")

		self.info:SetContentAlignment(2)
		self.info:SetAlpha(0)
		self.info:AlphaTo(255, 1, 0, function()
			self.info.Paint = function(this)
				this:SetAlpha(math.abs(math.cos(RealTime() * 0.8) * 255))
			end
		end)
		self.info:SetExpensiveShadow(1, color_black)

		local buttonW1, buttonH1 = self.scrW * 0.05, self.scrH * 0.04
		local buttonX1, buttonY1 = (self.scrW * 0.003), (self.scrH * 0)


		self.build = self:Add("DLabel")
		self.build:SetSize(buttonW1, buttonH1)
		self.build:SetPos(buttonX1, buttonY1)
		self.build:SetText("Version: 0.3 \nBuild 2709")
		self.build:SetFont("dobi4ikxyecoc1_ver")
		self.build:SetContentAlignment(2)
		self.build:SetAlpha(0)
		self.build:AlphaTo(255, 1, 0, function()
			self.build.Paint = function(this)
				this:SetAlpha(math.abs(math.cos(RealTime() * 0) * 255))
			end
		end)
		self.build:SetExpensiveShadow(1, color_black)



		local buttonW2, buttonH2 = self.scrW * 0.585, self.scrH * 0.105
		local buttonX2, buttonY2 = (self.scrW * 0.21), (self.scrH * 0.85)

		self.tkv = self:Add("DLabel")
		self.tkv:SetSize(0, buttonH2)
		self.tkv:SetPos(buttonX2, buttonY2)
		self.tkv:SetText(" Внимание! Это бета версия сборки Warfare RP, прездазначенная для тестирования\n                    Она не отображает финального качества продукта\n                         Спасибо за понимание и поддержу. Удачи!")
		self.tkv:SetTextColor(Color(0, 0, 0))
		self.tkv:SetFont("dobi4ikxyecockft")
		self.tkv:SizeTo( buttonW2, buttonH2, 0.3, 0, 1 )
		function self.tkv:Paint( w, h )
			surface.SetDrawColor(255, 140, 0, 90)  
			surface.DrawRect(0, 0, w, h) 
		end 

	end

	function PANEL:Think()
		if (IsValid(self.info) and input.IsKeyDown(KEY_SPACE) and !self.closing) then
			self.closing = true
			--self:AlphaTo(0, 1, 0, function()
				vgui.Create("nutCharMenu", self)
				self:Remove()
			--end)
		end
	end

	function PANEL:OnRemove()
		if (self.sound) then
			self.sound:Stop()
			self.sound = nil
		end
	end

	function PANEL:Paint(w, h)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawRect(0, 0, w, h)

		--[[if (self.glow) then
			self.delta = math.Approach(self.delta, 100, FrameTime() * 10)

			local x, y = ScrW()*0.5 - 700, ScrH()*0.5 - 340

			surface.SetDrawColor(self.delta, self.delta, self.delta, self.delta + math.sin(RealTime() * 0.7)*10)
			surface.SetTexture(glow)
			surface.DrawTexturedRect(x, y, 1400, 680)
		end]]
	end
vgui.Register("nutIntro", PANEL, "EditablePanel")
