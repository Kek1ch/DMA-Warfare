local PANEL = {}
local alpha = 80

	function PANEL:Init()
		local char = LocalPlayer():getChar()
		if (IsValid(nut.gui.menu)) then
			nut.gui.menu:Remove()
		end

		nut.gui.menu = self

		self:SetSize(ScrW(), ScrH())

		local right_panelWyes, right_panelHyes = ScrW() * 0.564, ScrH() * 0.26
		local right_panelXyes, right_panelYyes = (ScrW() * 0.665) - (right_panelWyes * 0.5), ScrH() * 0.05

		local trueplusW, trueplusH = ScrW() * 0.542, ScrH() * 0.155
		local trueplusX, trueplusY = (ScrW() * 0.664) - (trueplusW * 0.5), ScrH() * 0.137

		local typo_logoWyes, typo_logoHyes = ScrW() * 0.32, ScrH() * 0.78
		local typo_logoXyes, typo_logoYyes = (ScrW() * 0.2) - (typo_logoWyes * 0.5), ScrH() * 0.05

		local right_panelplusW, right_panelplusH = ScrW() * 0.295, ScrH() * 0.08
		local right_panelplusX, right_panelplusY = (ScrW() * 0.16) - (right_panelplusW * 0.5), ScrH() * 0.02

		self:SetAlpha(0)
		self:AlphaTo(255, 0.25, 0)
		self:SetPopupStayAtBack(true)
		function self:Paint( w, h )
			local x, y = gui.MousePos()
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(Material("daui/mrkek_blur.png") ) 
			surface.DrawTexturedRect(-0.02 * x, -0.02 * y, w * 1.02, h * 1.02)

			surface.SetDrawColor(Color( 0, 0, 0, 220))
			surface.DrawRect(right_panelXyes, right_panelYyes, right_panelWyes, right_panelHyes) 

			surface.SetDrawColor(43, 43, 43, 255)
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawTexturedRect(trueplusX, trueplusY, trueplusW, trueplusH) 

			draw.DrawText( LocalPlayer():getChar():getData("rad", 0).."%", "dobi4ikxyecoc44", ScrW() * 0.463, ScrH() * 0.222, Color(211, 211, 211), TEXT_ALIGN_CENTER ) --радиация
			draw.DrawText( math.Round(LocalPlayer():getChar():getData("sleep_need", 0)).."%", "dobi4ikxyecoc44", ScrW() * 0.561, ScrH() * 0.222, Color(211, 211, 211), TEXT_ALIGN_CENTER ) --сон
			draw.DrawText( LocalPlayer():getLocalVar("hunger").."%", "dobi4ikxyecoc44", ScrW() * 0.661, ScrH() * 0.222, Color(211, 211, 211), TEXT_ALIGN_CENTER ) --еда
			draw.DrawText( LocalPlayer():getLocalVar("thirst").."%", "dobi4ikxyecoc44", ScrW() * 0.762, ScrH() * 0.222, Color(211, 211, 211), TEXT_ALIGN_CENTER ) --вода
			draw.DrawText( LocalPlayer():getChar():getData("psy", 0).."%", "dobi4ikxyecoc44", ScrW() * 0.862, ScrH() * 0.222, Color(211, 211, 211), TEXT_ALIGN_CENTER ) --что-то

			surface.SetDrawColor(0, 0, 0, 220) 
			surface.DrawRect(typo_logoXyes, typo_logoYyes, typo_logoWyes, typo_logoHyes) 
			surface.DrawTexturedRect(typo_logoXyes, typo_logoYyes, typo_logoWyes, typo_logoHyes) 

			draw.DrawText(LocalPlayer():getChar():getName(), "dobi4ikxyecoc",  ScrW() * 0.185, ScrH() * 0.733, Color(211, 211, 211), TEXT_ALIGN_CENTER )
			draw.DrawText("EXP: "..LocalPlayer():getChar():getData("rank", 0), "dobi4ikxyecoc44",  ScrW() * 0.185, ScrH() * 0.764, Color(169, 169, 169), TEXT_ALIGN_CENTER )

			surface.SetDrawColor(210, 210, 210, 200) 
			surface.SetMaterial(Material("daui/rad_icon_v6.png") ) 
			surface.DrawTexturedRect(ScrW() * 0.445, ScrH() * 0.15, ScrW() * 0.033, ScrH() * 0.058)

			surface.SetDrawColor(210, 210, 210, 200) 
			surface.SetMaterial(Material("daui/sleep_icon_v5.png") ) 
			surface.DrawTexturedRect(ScrW() * 0.544, ScrH() * 0.15, ScrW() * 0.033, ScrH() * 0.058)

			surface.SetDrawColor(210, 210, 210, 200) 
			surface.SetMaterial(Material("daui/eat_icon_v2.png") ) 
			surface.DrawTexturedRect(ScrW() * 0.644, ScrH() * 0.15, ScrW() * 0.033, ScrH() * 0.058)

			surface.SetDrawColor(210, 210, 210, 200) 
			surface.SetMaterial(Material("daui/drop_2.png") ) 
			surface.DrawTexturedRect(ScrW() * 0.744, ScrH() * 0.15, ScrW() * 0.033, ScrH() * 0.058)

			surface.SetDrawColor(210, 210, 210, 200) 
			surface.SetMaterial(Material("daui/psy5_v3.png") ) 
			surface.DrawTexturedRect(ScrW() * 0.844, ScrH() * 0.15, ScrW() * 0.033, ScrH() * 0.058)
		end
		local suppress = hook.Run("CanCreateCharInfo", self)

		local function paintDtextEntry(s, w, h)
		surface.SetDrawColor(0, 0, 0, 220)
		surface.DrawRect(0, 0, w, h)

		s:DrawTextEntryText(color_white, color_white, color_white)
		end

		self.build_info = self:Add("DLabel")
		self.build_info:SetSize(ScrW() * 0.15, ScrH() * 0.021)
		self.build_info:SetPos(ScrW() * 0, ScrH() * 0.97)
		self.build_info:SetText("Version: 0.32 Build 1110")
		self.build_info:SetFont("dobi4ikxyecockft123")
		self.build_info:SetContentAlignment(2)
		self.build_info:SetAlpha(0)
		self.build_info:AlphaTo(255, 1, 0, function()
			self.build_info.Paint = function(this)
				this:SetAlpha(math.abs(math.cos(RealTime() * 0) * 255))
			end
		end)
		self.build_info:SetExpensiveShadow(1, color_black)


		local typo_logoWyes, typo_logoHyes = ScrW() * 0.32, ScrH() * 0.78
		local typo_logoXyes, typo_logoYyes = (ScrW() * 0.2) - (typo_logoWyes * 0.5), ScrH() * 0.05

		self.left_panel = self:Add("DLabel")
		self.left_panel:SetPos( typo_logoXyes, typo_logoYyes )
		self.left_panel:SetSize( typo_logoWyes, typo_logoHyes )
		self.left_panel:SetText("")
		self.left_panel:SetFont("DescCharFont1")

		local but_1Wyes, but_1Hyes = ScrW() * 0.15, ScrH() * 0.05
		local but_1Xyes, but_1Yyes = (ScrW() * 0.485) - (but_1Wyes * 0.5), ScrH() * 0.07

		self.but_1 = self:Add("DButton")
		self.but_1:SetPos( but_1Xyes, but_1Yyes )
		self.but_1:SetSize( but_1Wyes, but_1Hyes )
		self.but_1:SetText("Персонажи")
		self.but_1:SetFont("dobi4ikxyecockft123123123")
		self.but_1:SetTextColor(color_white) 
		function self.but_1:Paint( w, h )
			if self:IsDown() then 
				surface.SetDrawColor(Color( 40, 40, 40, 240))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 0, 0, 0, 235))
				surface.DrawOutlinedRect(0, 0, w, h)
			elseif self:IsHovered() then 
				surface.SetDrawColor(Color( 30, 30, 30, 150))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 0, 0, 0, 235))
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		end
		self.but_1.DoClick = function(client)
			self:Remove()
			local chars_window = vgui.Create("nutIntro")
		end


		local but_2Wyes, but_2Hyes = ScrW() * 0.15, ScrH() * 0.05
		local but_2Xyes, but_2Yyes = (ScrW() * 0.663) - (but_2Wyes * 0.5), ScrH() * 0.07

		self.but_2 = self:Add("DButton")
		self.but_2:SetPos( but_2Xyes, but_2Yyes )
		self.but_2:SetSize( but_2Wyes, but_2Hyes )
		self.but_2:SetText("Навыки")
		self.but_2:SetFont("dobi4ikxyecockft123123123")
		self.but_2:SetTextColor(color_white) 
		function self.but_2:Paint( w, h )
			if self:IsDown() then 
				surface.SetDrawColor(Color( 40, 40, 40, 240))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 0, 0, 0, 235))
				surface.DrawOutlinedRect(0, 0, w, h)
			elseif self:IsHovered() then 
				surface.SetDrawColor(Color( 30, 30, 30, 150))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 0, 0, 0, 235))
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		end
		self.but_2.DoClick = function(client)
			local chars_window = vgui.Create("perk_menu")
			self:Remove()
		end

		local but_3Wyes, but_3Hyes = ScrW() * 0.15, ScrH() * 0.05
		local but_3Xyes, but_3Yyes = (ScrW() * 0.84) - (but_3Wyes * 0.5), ScrH() * 0.07

		self.but_3 = self:Add("DButton")
		self.but_3:SetPos( but_3Xyes, but_3Yyes )
		self.but_3:SetSize( but_3Wyes, but_3Hyes )
		self.but_3:SetText("Помощь")
		self.but_3:SetFont("dobi4ikxyecockft123123123")
		self.but_3:SetTextColor(color_white) 
		function self.but_3:Paint( w, h )
			if self:IsDown() then 
				surface.SetDrawColor(Color( 40, 40, 40, 240))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 0, 0, 0, 235))
				surface.DrawOutlinedRect(0, 0, w, h)
			elseif self:IsHovered() then 
				surface.SetDrawColor(Color( 30, 30, 30, 150))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 0, 0, 0, 235))
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		end
		self.but_3.DoClick = function(client)
			local chars_window = vgui.Create("helpul")
			self:Remove()
		end


		local right_panelplusW, right_panelplusH = ScrW() * 0.295, ScrH() * 0.08
		local right_panelplusX, right_panelplusY = (ScrW() * 0.16) - (right_panelplusW * 0.5), ScrH() * 0.02

		self.right_panelplus = self.left_panel:Add("DLabel")
		self.right_panelplus:SetPos( right_panelplusX, right_panelplusY )
		self.right_panelplus:SetSize( right_panelplusW, right_panelplusH )
		self.right_panelplus:SetText("")
		self.right_panelplus:SetFont("DescCharFont1")
		function self.right_panelplus:Paint( w, h )
			surface.SetDrawColor(50, 60, 75, 255)
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawTexturedRect(0, 0, w, h)
		end
		
		local timeW, timeH = ScrW() * 0.225, ScrH() * 0.05
		local timeX, timeY = (ScrW() * 0.145) - (timeW * 0.5), ScrH() * 0.008

		self.time = self.right_panelplus:Add("DLabel")
		self.time:SetPos( timeX, timeY )
		self.time:SetSize( timeW, timeH )
		self.time:SetText("")
		self.time:SetFont("DescCharFont1")


		self.model = self.left_panel:Add("nutModelPanel")
		self.model:SetPos(ScrW() * 0.04, ScrH() * 0.00)
		self.model:SetSize(ScrW() * 0.5, ScrH() * 0.7)
		self.model:SetWide(ScrW() * 0.25)
		--self.model.enableHook = false
		--self.model.copyLocalSequence = true
		self.model:SetFOV(44)

		local main_valuesW, main_valuesH = ScrW() * 0.564, ScrH() * 0.03
		local main_valuesX, main_valuesY = (ScrW() * 0.665) - (main_valuesW * 0.5), ScrH() * 0.32

		self.main_values = self:Add("DLabel")
		self.main_values:SetPos( main_valuesX, main_valuesY )
		self.main_values:SetSize( main_valuesW, main_valuesH )
		self.main_values:SetText("Статистика")
		self.main_values:SetFont("dobi4ikxyecockft")
		self.main_values:SetTextColor(Color(169, 169, 169))
		self.main_values:SetExpensiveShadow(2, color_black)

		self.first_list = self:Add("DListLayout")
		self.first_list:SetPos( ScrW() * 0.382, ScrH() * 0.36 )
		self.first_list:SetSize( ScrW() * 0.564, ScrH() * 0.33 )

		self.main_values2 = self.first_list:Add("DLabel")
		self.main_values2:Dock(TOP)
		self.main_values2:DockMargin(3, 3, 3, 0)
		self.main_values2:SetTall(ScrH() * 0.032)
		self.main_values2:SetText("Общие данные")
		self.main_values2:SetFont("dobi4ikxyecockft")
		self.main_values2:SetTextColor(Color(169, 169, 169))
		function self.main_values2:Paint( w, h )
			surface.SetDrawColor(50, 60, 75, 255)
			surface.SetMaterial(nut.util.getMaterial("vgui/gradient-l"))
			surface.DrawTexturedRect(0, 0, w, h) 
		end

		self.disc_values = self.first_list:Add("DLabel")
		self.disc_values:Dock(TOP)
		self.disc_values:DockMargin(3, 3, 3, 0)
		self.disc_values:SetTall(ScrH() * 0.032)
		self.disc_values:SetText(L("charFaction", L(team.GetName(LocalPlayer():Team()))))
		self.disc_values:SetFont("dobi4ikxyecockft")
		self.disc_values:SetTextColor(Color(169, 169, 169))
		function self.disc_values:Paint( w, h )
			surface.SetDrawColor(0, 0, 0, 220)
			surface.DrawRect(0, 0, w, h)
		end

		if (!suppress or (suppress and !suppress.all)) then
			if (!suppress or !suppress.desc) then
				self.desc = self.first_list:Add("DTextEntry")
				self.desc:Dock(TOP)
				self.desc:DockMargin(3, 3, 3, 0)
				self.desc:SetTall(ScrH() * 0.032)
				self.desc:SetFont("dobi4ikxyecockft")
				self.desc:SetTextColor(Color(169, 169, 169))
				self.desc.Paint = paintDtextEntry
			end
		end

		self.money_2ez = self.first_list:Add("DLabel")
		self.money_2ez:Dock(TOP)
		self.money_2ez:DockMargin(3, 3, 3, 0)
		self.money_2ez:SetTall(ScrH() * 0.032)
		self.money_2ez:SetText(L("charMoney", nut.currency.get(char:getMoney())))
		self.money_2ez:SetFont("dobi4ikxyecockft")
		self.money_2ez:SetTextColor(Color(169, 169, 169))
		function self.money_2ez:Paint( w, h )
			surface.SetDrawColor(0, 0, 0, 220)
			surface.DrawRect(0, 0, w, h)
		end


		self.urrank = self.first_list:Add("DLabel")
		self.urrank:Dock(TOP)
		self.urrank:DockMargin(3, 3, 3, 0)
		self.urrank:SetTall(ScrH() * 0.032)
		local rank = char:getData("rank", 0)
		self.urrank.Think = function()
			if (rank > 2000 and rank < 3199) then
				self.urrank:SetText("Ранг: Ветеран")
			elseif (rank > 12000) then
				self.urrank:SetText("Ранг: Легенда")
			elseif (rank > 5200 and rank < 11999) then
				self.urrank:SetText("Ранг: Мастер")
			elseif (rank > 3200 and rank < 5199) then
				self.urrank:SetText("Ранг: Эксперт")
			elseif (rank > 1000 and rank < 1999) then
				self.urrank:SetText("Ранг: Профессионал")
			elseif (rank > 600 and rank < 999) then
				self.urrank:SetText("Ранг: Опытный")
			elseif (rank > 200 and rank < 599) then
				self.urrank:SetText("Ранг: Стажер")
			elseif (rank < 199) then
				self.urrank:SetText("Ранг: Новичок")
			end
		end
		self.urrank:SetFont("dobi4ikxyecockft")
		self.urrank:SetTextColor(Color(169, 169, 169))
		function self.urrank:Paint( w, h )
			surface.SetDrawColor(0, 0, 0, 220)
			surface.DrawRect(0, 0, w, h) 
		end

		self.rank_o4ko = self.first_list:Add("DLabel")
		self.rank_o4ko:Dock(TOP)
		self.rank_o4ko:DockMargin(3, 3, 3, 0)
		self.rank_o4ko:SetTall(ScrH() * 0.032)
		self.rank_o4ko:SetText("Очки ранга: "..char:getData("rank", 0))
		self.rank_o4ko:SetFont("dobi4ikxyecockft")
		self.rank_o4ko:SetTextColor(Color(169, 169, 169))
		function self.rank_o4ko:Paint( w, h )
			surface.SetDrawColor(0, 0, 0, 220)
			surface.DrawRect(0, 0, w, h)
		end

		self.rep_chek = self.first_list:Add("DLabel")
		self.rep_chek:Dock(TOP)
		self.rep_chek:DockMargin(3, 3, 3, 0)
		self.rep_chek:SetTall(ScrH() * 0.032)
		local rep = char:getData("rep", 0)
		self.rep_chek.Think = function()
			if (rep > -29 and rep < 99) then
				self.rep_chek:SetText("Репутация: Безразлично")
			elseif (rep > 2000) then
				self.rep_chek:SetText("Репутация: Великолепно")
			elseif (rep > 1000 and rep < 1999) then
				self.rep_chek:SetText("Репутация: Отлично")
			elseif (rep > 500 and rep < 999) then
				self.rep_chek:SetText("Репутация: Оч. Хорошо")
			elseif (rep > 100 and rep < 499) then
				self.rep_chek:SetText("Репутация: Хорошо")
			elseif (rep > -79 and rep < -30) then
				self.rep_chek:SetText("Репутация: Плохо")
			elseif (rep > -299 and rep < -80) then
				self.rep_chek:SetText("Репутация: Оч. Плохо")
			elseif (rep > -599 and rep < -300) then
				self.rep_chek:SetText("Репутация: Ужасно")
			elseif (rep < -600) then
				self.rep_chek:SetText("Репутация: Хуже всех")
			end
		end
		self.rep_chek:SetFont("dobi4ikxyecockft")
		self.rep_chek:SetTextColor(Color(169, 169, 169))
		function self.rep_chek:Paint( w, h )
			surface.SetDrawColor(0, 0, 0, 220)
			surface.DrawRect(0, 0, w, h)
		end

		self.rep_o4ko = self.first_list:Add("DLabel")
		self.rep_o4ko:Dock(TOP)
		self.rep_o4ko:DockMargin(3, 3, 3, 0)
		self.rep_o4ko:SetTall(ScrH() * 0.032)
		self.rep_o4ko:SetText("Очки репуцтации: "..char:getData("rep", 0))
		self.rep_o4ko:SetFont("dobi4ikxyecockft")
		self.rep_o4ko:SetTextColor(Color(169, 169, 169))
		function self.rep_o4ko:Paint( w, h )
			surface.SetDrawColor(0, 0, 0, 220)
			surface.DrawRect(0, 0, w, h)
		end

		self.two4ko = self.first_list:Add("DLabel")
		self.two4ko:Dock(TOP)
		self.two4ko:DockMargin(3, 3, 3, 0)
		self.two4ko:SetTall(ScrH() * 0.032)
		self.two4ko:SetText("Побед в 21 очко: "..char:getData("two4ko", 0))
		self.two4ko:SetFont("dobi4ikxyecockft")
		self.two4ko:SetTextColor(Color(169, 169, 169))
		function self.two4ko:Paint( w, h )
			surface.SetDrawColor(0, 0, 0, 220)
			surface.DrawRect(0, 0, w, h)
		end

		local secord_strokaW, secord_strokaH = ScrW() * 0.564, ScrH() * 0.0355
		local secord_strokaX, secord_strokaY = (ScrW() * 0.665) - (secord_strokaW * 0.5), ScrH() * 0.688

		self.second_list = self:Add("DLabel")
		self.second_list:SetPos( ScrW() * 0.382, ScrH() * 0.69 )
		self.second_list:SetSize( ScrW() * 0.564, ScrH() * 0.14 )

		self.second_list:SetText("")
		self.second_list:SetFont("dobi4ikxyecockft")
		self.second_list:SetTextColor(Color(169, 169, 169))
		function self.second_list:Paint( w, h )
			--surface.SetDrawColor(50, 60, 25, 255)
			--surface.DrawRect(0, 0, w, h) 
		end

		self.secord_stroka = self.second_list:Add("DLabel")
		self.secord_stroka:Dock(TOP)
		self.secord_stroka:DockMargin(3, 3, 3, 0)
		self.secord_stroka:SetTall(ScrH() * 0.032)
		self.secord_stroka:SetText("Физические данные")
		self.secord_stroka:SetFont("dobi4ikxyecockft")
		self.secord_stroka:SetTextColor(Color(169, 169, 169))
		function self.secord_stroka:Paint( w, h )
			surface.SetDrawColor(50, 60, 75, 255)
			surface.SetMaterial(nut.util.getMaterial("vgui/gradient-l"))
			surface.DrawTexturedRect(0, 0, w, h)
		end

		self.hpmax = self.second_list:Add("DLabel")
		self.hpmax:Dock(TOP)
		self.hpmax:DockMargin(3, 3, 3, 0)
		self.hpmax:SetTall(ScrH() * 0.032)
		self.hpmax:SetText("Очки здоровья: "..LocalPlayer():Health())
		self.hpmax:SetFont("dobi4ikxyecockft")
		self.hpmax:SetTextColor(Color(169, 169, 169))
		function self.hpmax:Paint( w, h )
			surface.SetDrawColor(0, 0, 0, 220)
			surface.DrawRect(0, 0, w, h)
		end

		self.stamina = self.second_list:Add("DLabel")
		self.stamina:Dock(TOP)
		self.stamina:DockMargin(3, 3, 3, 0)
		self.stamina:SetTall(ScrH() * 0.032)
		self.stamina:SetText("Очки выносливости: "..LocalPlayer():getLocalVar("stm", 0))
		self.stamina:SetFont("dobi4ikxyecockft")
		self.stamina:SetTextColor(Color(169, 169, 169))
		function self.stamina:Paint( w, h )
			surface.SetDrawColor(0, 0, 0, 220)
			surface.DrawRect(0, 0, w, h)
		end
	
		self.speed_run = self.second_list:Add("DLabel")
		self.speed_run:Dock(TOP)
		self.speed_run:DockMargin(3, 3, 3, 0)
		self.speed_run:SetTall(ScrH() * 0.032)
		self.speed_run:SetText("Скорость бега: "..LocalPlayer():GetRunSpeed())
		self.speed_run:SetFont("dobi4ikxyecockft")
		self.speed_run:SetTextColor(Color(169, 169, 169))
		function self.speed_run:Paint( w, h )
			surface.SetDrawColor(0, 0, 0, 220)
			surface.DrawRect(0, 0, w, h)
		end

		--------------
		--[[local icon_1W, icon_1H = ScrW() * 0.033, ScrH() * 0.058
		local icon_1X, icon_1Y = ScrW() * 0.445, ScrH() * 0.15

		self.icon_1 = self:Add("DImage")
		self.icon_1:SetPos( icon_1X, icon_1Y )
		self.icon_1:SetSize( icon_1W, icon_1H )
		self.icon_1:SetImage("daui/rad_icon_v3.png")]]



		--------------





		--[[local frac_icoW, frac_icoH = ScrW() * 0.05, ScrH() * 0.09
		local frac_icoX, frac_icoY = (ScrW() * 0.060) - (frac_icoW * 0.5), ScrH() * 0.12

		self.frac_ico = self.left_panel:Add("DImage")
		self.frac_ico:SetPos( frac_icoX, frac_icoY )
		self.frac_ico:SetSize( frac_icoW, frac_icoH )
		self.frac_ico:SetImage("daui/loner_info1.png")]]


		
		self.noAnchor = CurTime() + .4
		self.anchorMode = true
		self:MakePopup()

		self:setup()
		hook.Run("CreateCharInfo", self)
	end

	function PANEL:setup()
		local char = LocalPlayer():getChar()

		if (self.time) then
			local format = "%A, %d %B %Y %X"
			
			self.time:SetText(L("curTime", os.date(format, nut.date.get())))
			self.time.Think = function(this)
				if ((this.nextTime or 0) < CurTime()) then
					this:SetText(L("curTime", os.date(format, nut.date.get())))
					this.nextTime = CurTime() + 0.5
				end
			end
		end

		if (self.desc) then
			self.desc:SetText(char:getDesc())
			self.desc.OnEnter = function(this, w, h)
				nut.command.send("chardesc", this:GetText())
			end
		end

		if (self.model) then
			self.model:SetModel(LocalPlayer():GetModel())
			self.model.Entity:SetSkin(LocalPlayer():GetSkin())

			for k, v in ipairs(LocalPlayer():GetBodyGroups()) do
				self.model.Entity:SetBodygroup(v.id, LocalPlayer():GetBodygroup(v.id))
			end

			local ent = self.model.Entity
			if (ent and IsValid(ent)) then
				local mats = LocalPlayer():GetMaterials()
				for k, v in pairs(mats) do
					ent:SetSubMaterial(k - 1, LocalPlayer():GetSubMaterial(k - 1))
				end
			end
		end
		hook.Run("CreateCharInfoText", self)
		hook.Run("OnCharInfoSetup", self)

	end

	function PANEL:OnKeyCodePressed(key)
		self.noAnchor = CurTime() + .5

		if (key == KEY_F1) then
			self:remove()
		end
	end

	function PANEL:Think()
		local key = input.IsKeyDown(KEY_F1)
		if (LocalPlayer():Alive()) then
		if (key and (self.noAnchor or CurTime()+.4) < CurTime() and self.anchorMode == true) then
			self.anchorMode = false
			surface.PlaySound("buttons/lightswitch2.wav")
		end
		end
	end

	local color_bright = Color(240, 240, 240, 180)

	function PANEL:Paint(w, h)
		--[[nut.util.drawBlur(self, 12)

		surface.SetDrawColor(0, 0, 0)
		surface.SetMaterial(gradient)
		surface.DrawTexturedRect(0, 0, w, h)

		surface.SetDrawColor(30, 30, 30, alpha)
		surface.DrawRect(0, 0, w, 78)

		surface.SetDrawColor(color_bright)
		surface.DrawRect(0, 78, w, 8)]]
	end


	function PANEL:OnRemove()
	end

	function PANEL:remove()
		CloseDermaMenus()
		
		if (!self.closing) then
			self:AlphaTo(0, 0.25, 0, function()
				self:Remove()
			end)
			self.closing = true
		end
	end

vgui.Register("nutMenu", PANEL, "EditablePanel")

if (IsValid(nut.gui.menu)) then
	vgui.Create("nutMenu")
end