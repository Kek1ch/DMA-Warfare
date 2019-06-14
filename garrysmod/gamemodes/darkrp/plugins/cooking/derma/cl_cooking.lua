local PANEL = {}

function PANEL:Init(uniqueID)

	local data = {}
	data.toggle_1 = toggle_1
	data.toggle_2 = toggle_2
	data.itog = itog

	toggle_1 = "fooddrop1"
	toggle_2 = "gascan"
	itog = 0

	self:SetSize(ScrW() * 0.41, ScrH() * 0.57)
	self:MakePopup()
	self:Center()
	self:SetTitle("")
	self:ShowCloseButton(false)
	self:SetDraggable(false)

	self.craftit = self:Add("DButton")
	self.craftit:SetSize( ScrW() * 0.095, ScrH() * 0.0375)
	self.craftit:SetPos(ScrW() * 0.01, ScrH() * 0.508)
	self.craftit:SetText("Применить")
	self.craftit:SetFont("Roh20")
	self.craftit:SetTextColor(Color(255, 255, 255, 210)) 
	self.craftit.DoClick = function(client)
		if not(itog == 0) then
			if not (toggle_1 == 0) and not (toggle_2 == 0) and not (itog == 0) and LocalPlayer():getChar():getInv():hasItem(toggle_1) and LocalPlayer():getChar():getInv():hasItem(toggle_2) then 
				netstream.Start("goto_cooking", data)
				self:Close()
			end
		end
	end

	function self.craftit:Paint( w, h )
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
		else
			surface.SetDrawColor(Color( 30, 30, 30, 160))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 0, 0, 0, 235))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
	end

	self.exit = self:Add("DButton")
	self.exit:SetPos(ScrW() * 0.11, ScrH() * 0.508)
	self.exit:SetSize( ScrW() * 0.089, ScrH() * 0.0375)
	self.exit:SetText("Выход")
	self.exit:SetFont("Roh20")
	self.exit:SetTextColor(Color(211, 211, 211)) 
	function self.exit:Paint( w, h )
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
		else
			surface.SetDrawColor(Color( 30, 30, 30, 160))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 0, 0, 0, 235))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
	end
	self.exit.DoClick = function(client)
		self:Close()

		pechka_model = nil
		toggle_1 = nil
		toggle_2 = nil
		itog = nil
		collectgarbage()
	end

	self.takeit = self:Add("DButton")
	self.takeit:SetPos(ScrW() * 0.31, ScrH() * 0.508)
	self.takeit:SetSize(ScrW() * 0.089, ScrH() * 0.0375)
	self.takeit:SetText("Забрать")
	self.takeit:SetFont("Roh20")
	self.takeit:SetTextColor(Color(211, 211, 211)) 
	function self.takeit:Paint( w, h )
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
		else
			surface.SetDrawColor(Color( 30, 30, 30, 160))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 0, 0, 0, 235))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
	end
	self.takeit.DoClick = function(client)
		netstream.Start("vernite_pechky")

		self:Close()

		data.toggle_1 = nil
		data.toggle_2 = nil
		data.itog = nil

		pechka_model = nil
		toggle_1 = nil
		toggle_2 = nil
		itog = nil
		collectgarbage()
	end


	self.dscrolldesc = self:Add("DScrollPanel")
	self.dscrolldesc:SetSize(ScrW() * 0.189, ScrH() * 0.145)
	self.dscrolldesc:SetPos(ScrW() * 0.21, ScrH() * 0.08)
	self.dscrolldesc:SetDrawBackground(false)

	local sbar = self.dscrolldesc:GetVBar()
	function sbar:Paint( w, h ) 
		surface.SetDrawColor(Color( 30, 30, 30, 200))
		surface.DrawRect(0, 0, w, h)
	end
	function sbar.btnUp:Paint( w, h )
		surface.SetDrawColor(Color( 0, 0, 0, 0))
		surface.DrawRect(0, 0, w, h)
	end
	function sbar.btnDown:Paint( w, h )
		surface.SetDrawColor(Color( 0, 0, 0, 0))
		surface.DrawRect(0, 0, w, h)
	end
	function sbar.btnGrip:Paint( w, h )
		surface.SetDrawColor(Color( 60, 60, 60, 200))
		surface.DrawRect(0, 0, w, h)
	end 

	self.list = self.dscrolldesc:Add("DListLayout")
	self.list:SetSize(self.dscrolldesc:GetSize())
	self.list:DockPadding(0, 0, 0, 4)
	self.list:SetTall(ScrH())

	self.meat_kaban = self.list:Add("DButton")
	self.meat_kaban:Dock(TOP)
	self.meat_kaban:DockMargin(3, 3, 3, 0)
	self.meat_kaban:SetTall(ScrH() * 0.025)
	self.meat_kaban:SetText("Мясо кабана")
	self.meat_kaban:SetFont("Roh15")
	self.meat_kaban:SetTextColor(Color(169, 169, 169))
	self.meat_kaban.DoClick = function(this)
		self.meat_kaban:SetToggle(true)
		self.meat_slep_kaban:SetToggle(false)
		self.meat_plot:SetToggle(false)
		self.meat_psevdosobaki:SetToggle(false)
		self.ruka_snorka:SetToggle(false)
		self.meat_tywkan:SetToggle(false)

		toggle_1 = "fooddrop1"
		itog = "fooddropcook2"

		data.toggle_1 = "fooddrop1"
		data.itog = "fooddropcook2"
	end
	function self.meat_kaban:Paint( w, h )
		if self:GetToggle() then
			surface.SetDrawColor(Color( 255, 186, 0, 6))
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 186, 0, 12))
			surface.DrawOutlinedRect(0, 0, w, h) 
		else
			surface.SetDrawColor(0, 0, 0, 100)
		end

		surface.DrawRect(0, 0, w, h)
	end

	self.meat_slep_kaban = self.list:Add("DButton")
	self.meat_slep_kaban:Dock(TOP)
	self.meat_slep_kaban:DockMargin(3, 3, 3, 0)
	self.meat_slep_kaban:SetTall(ScrH() * 0.025)
	self.meat_slep_kaban:SetText("Мясо слепого пса")
	self.meat_slep_kaban:SetFont("Roh15")
	self.meat_slep_kaban:SetTextColor(Color(169, 169, 169))
	self.meat_slep_kaban.DoClick = function(this)
		self.meat_kaban:SetToggle(false)
		self.meat_slep_kaban:SetToggle(true)
		self.meat_plot:SetToggle(false)
		self.meat_psevdosobaki:SetToggle(false)
		self.ruka_snorka:SetToggle(false)
		self.meat_tywkan:SetToggle(false)

		toggle_1 = "fooddrop5"
		itog = "fooddropcook5"

		data.toggle_1 = "fooddrop5"
		data.itog = "fooddropcook5"
	end
	function self.meat_slep_kaban:Paint( w, h )
		if self:GetToggle() then
			surface.SetDrawColor(Color( 255, 186, 0, 6))
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 186, 0, 12))
			surface.DrawOutlinedRect(0, 0, w, h) 
		else
			surface.SetDrawColor(0, 0, 0, 100)
		end

		surface.DrawRect(0, 0, w, h)
	end

	self.meat_plot = self.list:Add("DButton")
	self.meat_plot:Dock(TOP)
	self.meat_plot:DockMargin(3, 3, 3, 0)
	self.meat_plot:SetTall(ScrH() * 0.025)
	self.meat_plot:SetText("Мясо плоти")
	self.meat_plot:SetFont("Roh15")
	self.meat_plot:SetTextColor(Color(169, 169, 169))
	self.meat_plot.DoClick = function(this)
		self.meat_kaban:SetToggle(false)
		self.meat_slep_kaban:SetToggle(false)
		self.meat_plot:SetToggle(true)
		self.meat_psevdosobaki:SetToggle(false)
		self.ruka_snorka:SetToggle(false)
		self.meat_tywkan:SetToggle(false)

		toggle_1 = "fooddrop6"
		itog = "fooddropcook6"

		data.toggle_1 = "fooddrop6"
		data.itog = "fooddropcook6"
	end
	function self.meat_plot:Paint( w, h )
		if self:GetToggle() then
			surface.SetDrawColor(Color( 255, 186, 0, 6))
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 186, 0, 12))
			surface.DrawOutlinedRect(0, 0, w, h) 
		else
			surface.SetDrawColor(0, 0, 0, 100)
		end

		surface.DrawRect(0, 0, w, h)
	end

	self.meat_psevdosobaki = self.list:Add("DButton")
	self.meat_psevdosobaki:Dock(TOP)
	self.meat_psevdosobaki:DockMargin(3, 3, 3, 0)
	self.meat_psevdosobaki:SetTall(ScrH() * 0.025)
	self.meat_psevdosobaki:SetText("Мясо псевдособаки")
	self.meat_psevdosobaki:SetFont("Roh15")
	self.meat_psevdosobaki:SetTextColor(Color(169, 169, 169))
	self.meat_psevdosobaki.DoClick = function(this)
		self.meat_kaban:SetToggle(false)
		self.meat_slep_kaban:SetToggle(false)
		self.meat_plot:SetToggle(false)
		self.meat_psevdosobaki:SetToggle(true)
		self.ruka_snorka:SetToggle(false)
		self.meat_tywkan:SetToggle(false)

		toggle_1 = "fooddrop2"
		itog = "fooddropcook1"

		data.toggle_1 = "fooddrop2"
		data.itog = "fooddropcook1"
	end
	function self.meat_psevdosobaki:Paint( w, h )
		if self:GetToggle() then
			surface.SetDrawColor(Color( 255, 186, 0, 6))
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 186, 0, 12))
			surface.DrawOutlinedRect(0, 0, w, h) 
		else
			surface.SetDrawColor(0, 0, 0, 100)
		end

		surface.DrawRect(0, 0, w, h)
	end

	self.ruka_snorka = self.list:Add("DButton")
	self.ruka_snorka:Dock(TOP)
	self.ruka_snorka:DockMargin(3, 3, 3, 0)
	self.ruka_snorka:SetTall(ScrH() * 0.025)
	self.ruka_snorka:SetText("Рука снорка")
	self.ruka_snorka:SetFont("Roh15")
	self.ruka_snorka:SetTextColor(Color(169, 169, 169))
	self.ruka_snorka.DoClick = function(this)
		self.meat_kaban:SetToggle(false)
		self.meat_slep_kaban:SetToggle(false)
		self.meat_plot:SetToggle(false)
		self.meat_psevdosobaki:SetToggle(false)
		self.ruka_snorka:SetToggle(true)
		self.meat_tywkan:SetToggle(false)

		toggle_1 = "fooddrop7"
		itog = "fooddropcook7"

		data.toggle_1 = "fooddrop7"
		data.itog = "fooddropcook7"
	end
	function self.ruka_snorka:Paint( w, h )
		if self:GetToggle() then
			surface.SetDrawColor(Color( 255, 186, 0, 6))
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 186, 0, 12))
			surface.DrawOutlinedRect(0, 0, w, h) 
		else
			surface.SetDrawColor(0, 0, 0, 100)
		end

		surface.DrawRect(0, 0, w, h)
	end

	self.meat_tywkan = self.list:Add("DButton")
	self.meat_tywkan:Dock(TOP)
	self.meat_tywkan:DockMargin(3, 3, 3, 0)
	self.meat_tywkan:SetTall(ScrH() * 0.025)
	self.meat_tywkan:SetText("Мясо тушкана")
	self.meat_tywkan:SetFont("Roh15")
	self.meat_tywkan:SetTextColor(Color(169, 169, 169))
	self.meat_tywkan.DoClick = function(this)
		self.meat_kaban:SetToggle(false)
		self.meat_slep_kaban:SetToggle(false)
		self.meat_plot:SetToggle(false)
		self.meat_psevdosobaki:SetToggle(false)
		self.ruka_snorka:SetToggle(false)
		self.meat_tywkan:SetToggle(true)

		toggle_1 = "fooddrop4"
		itog = "fooddropcook4"

		data.toggle_1 = "fooddrop4"
		data.itog = "fooddropcook4"
	end
	function self.meat_tywkan:Paint( w, h )
		if self:GetToggle() then
			surface.SetDrawColor(Color( 255, 186, 0, 6))
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 186, 0, 12))
			surface.DrawOutlinedRect(0, 0, w, h) 
		else
			surface.SetDrawColor(0, 0, 0, 100)
		end

		surface.DrawRect(0, 0, w, h)
	end
	-------------------------------------
	--Список топлива
	-------------------------------------

	self.dscrolldesc_second = self:Add("DScrollPanel")
	self.dscrolldesc_second:SetSize(ScrW() * 0.189, ScrH() * 0.145)
	self.dscrolldesc_second:SetPos(ScrW() * 0.21, ScrH() * 0.27)
	self.dscrolldesc_second:SetDrawBackground(false)

	local sbar = self.dscrolldesc_second:GetVBar()
	function sbar:Paint( w, h ) 
		surface.SetDrawColor(Color( 30, 30, 30, 200))
		surface.DrawRect(0, 0, w, h)
	end
	function sbar.btnUp:Paint( w, h )
		surface.SetDrawColor(Color( 0, 0, 0, 0))
		surface.DrawRect(0, 0, w, h)
	end
	function sbar.btnDown:Paint( w, h )
		surface.SetDrawColor(Color( 0, 0, 0, 0))
		surface.DrawRect(0, 0, w, h)
	end
	function sbar.btnGrip:Paint( w, h )
		surface.SetDrawColor(Color( 60, 60, 60, 200))
		surface.DrawRect(0, 0, w, h)
	end 

	self.list_second = self.dscrolldesc_second:Add("DListLayout")
	self.list_second:SetSize(self.dscrolldesc_second:GetSize())
	self.list_second:DockPadding(0, 0, 0, 4)
	self.list_second:SetTall(ScrH())

	self.drevesny_ygol = self.list_second:Add("DButton")
	self.drevesny_ygol:Dock(TOP)
	self.drevesny_ygol:DockMargin(3, 3, 3, 0)
	self.drevesny_ygol:SetTall(ScrH() * 0.025)
	self.drevesny_ygol:SetText("Древесный уголь")
	self.drevesny_ygol:SetFont("Roh15")
	self.drevesny_ygol:SetTextColor(Color(169, 169, 169))
	self.drevesny_ygol.DoClick = function(this)
		self.drevesny_ygol:SetToggle(true)
		self.kanistra:SetToggle(false)
		self.kerosin:SetToggle(false)
		self.ballon_s_gasom:SetToggle(false)

		toggle_2 = "ugol"

		data.toggle_2 = "ugol"
	end
	function self.drevesny_ygol:Paint( w, h )
		if self:GetToggle() then
			surface.SetDrawColor(Color( 255, 186, 0, 6))
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 186, 0, 12))
			surface.DrawOutlinedRect(0, 0, w, h) 
		else
			surface.SetDrawColor(0, 0, 0, 100)
		end

		surface.DrawRect(0, 0, w, h)
	end

	self.kanistra = self.list_second:Add("DButton")
	self.kanistra:Dock(TOP)
	self.kanistra:DockMargin(3, 3, 3, 0)
	self.kanistra:SetTall(ScrH() * 0.025)
	self.kanistra:SetText("Канстра с бензином")
	self.kanistra:SetFont("Roh15")
	self.kanistra:SetTextColor(Color(169, 169, 169))
	self.kanistra.DoClick = function(this)
		self.drevesny_ygol:SetToggle(false)
		self.kanistra:SetToggle(true)
		self.kerosin:SetToggle(false)
		self.ballon_s_gasom:SetToggle(false)

		toggle_2 = "gascan"

		data.toggle_2 = "gascan"
	end
	function self.kanistra:Paint( w, h )
		if self:GetToggle() then
			surface.SetDrawColor(Color( 255, 186, 0, 6))
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 186, 0, 12))
			surface.DrawOutlinedRect(0, 0, w, h) 
		else
			surface.SetDrawColor(0, 0, 0, 100)
		end

		surface.DrawRect(0, 0, w, h)
	end

	self.kerosin = self.list_second:Add("DButton")
	self.kerosin:Dock(TOP)
	self.kerosin:DockMargin(3, 3, 3, 0)
	self.kerosin:SetTall(ScrH() * 0.025)
	self.kerosin:SetText("Керосин")
	self.kerosin:SetFont("Roh15")
	self.kerosin:SetTextColor(Color(169, 169, 169))
	self.kerosin.DoClick = function(this)
		self.drevesny_ygol:SetToggle(false)
		self.kanistra:SetToggle(false)
		self.kerosin:SetToggle(true)
		self.ballon_s_gasom:SetToggle(false)

		toggle_2 = "kerosin"

		data.toggle_2 = "kerosin"
	end
	function self.kerosin:Paint( w, h )
		if self:GetToggle() then
			surface.SetDrawColor(Color( 255, 186, 0, 6))
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 186, 0, 12))
			surface.DrawOutlinedRect(0, 0, w, h) 
		else
			surface.SetDrawColor(0, 0, 0, 100)
		end

		surface.DrawRect(0, 0, w, h)
	end

	self.ballon_s_gasom = self.list_second:Add("DButton")
	self.ballon_s_gasom:Dock(TOP)
	self.ballon_s_gasom:DockMargin(3, 3, 3, 0)
	self.ballon_s_gasom:SetTall(ScrH() * 0.025)
	self.ballon_s_gasom:SetText("Баллон с газом")
	self.ballon_s_gasom:SetFont("Roh15")
	self.ballon_s_gasom:SetTextColor(Color(169, 169, 169))
	self.ballon_s_gasom.DoClick = function(this)
		self.drevesny_ygol:SetToggle(false)
		self.kanistra:SetToggle(false)
		self.kerosin:SetToggle(false)
		self.ballon_s_gasom:SetToggle(true)

		toggle_2 = "kbgas"

		data.toggle_2 = "kbgas"
	end
	function self.ballon_s_gasom:Paint( w, h )
		if self:GetToggle() then
			surface.SetDrawColor(Color( 255, 186, 0, 6))
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 186, 0, 12))
			surface.DrawOutlinedRect(0, 0, w, h) 
		else
			surface.SetDrawColor(0, 0, 0, 100)
		end

		surface.DrawRect(0, 0, w, h)
	end

	self.main_weapon_model = self:Add("nutItemIcon")

	self.second_model = self:Add("nutItemIcon")

	self.pechka_model = self:Add("nutItemIcon")
	local Hit = LocalPlayer():GetEyeTraceNoCursor() 
	local entity = Hit.Entity
	if entity:GetModel() == "models/se_ex/wood_stove.mdl" then
		pechka_model = "pechka1"
	elseif entity:GetModel() == "models/se_ex/spenser_lublu_tebya.mdl" then
		pechka_model = "gasplate"
	end

	if (pechka_model) then
		local item = nut.item.list[pechka_model]
		self.pechka_model:SetModel(item.model, 0)
		if item.width == 2 and item.height == 1 then
			self.pechka_model:SetPos(ScrW() * 0.228, ScrH() * 0.471)
		elseif item.width == 2 and item.height == 2 then
			self.pechka_model:SetPos(ScrW() * 0.228, ScrH() * 0.451)
		end
		self.pechka_model:SetSize(ScrW() * item.width * 0.025, ScrH() * item.height * 0.044)
		self.pechka_model.Icon:SetVisible(false)
		self.pechka_model.ExtraPaint = function(self, x, y)
			local exIcon = ikon:getIcon(item.uniqueID)
			if (exIcon) then
				surface.SetMaterial(exIcon)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(0, 0, x, y)

				surface.SetDrawColor(Color( 0, 0, 0, 235))
				surface.DrawOutlinedRect(0, 0, x, y)
			else
				ikon:renderIcon(
					item.uniqueID,
					item.width,
					item.height,
					item.model,
					item.iconCam
				)
			end
		end
	end


	function self:Think()
		if ((self.updatekek or 0) < CurTime()) then
			if !(toggle_1 == 0) then
				local item = nut.item.list[toggle_1]

				self.main_weapon_model:SetModel(item.model, 0)
				if item.width == 1 and item.height == 1 then
					self.main_weapon_model:SetPos(ScrW() * 0.0865, ScrH() * 0.121)
				elseif item.width == 2 and item.height == 1 then
					self.main_weapon_model:SetPos(ScrW() * 0.08, ScrH() * 0.121)
				elseif item.width == 1 and item.height == 2 then
					self.main_weapon_model:SetPos(ScrW() * 0.0915, ScrH() * 0.103) -- W+0.005 H+0.05
				elseif item.width == 2 and item.height == 2 then
					self.main_weapon_model:SetPos(ScrW() * 0.08, ScrH() * 0.103)
				elseif item.width == 3 and item.height == 2 then
					self.main_weapon_model:SetPos(ScrW() * 0.065, ScrH() * 0.103)
				end
				self.main_weapon_model:SetSize(ScrW() * item.width * 0.025, ScrH() * item.height * 0.044)
				self.main_weapon_model.Icon:SetVisible(false)
				self.main_weapon_model.ExtraPaint = function(self, x, y)
					local exIcon = ikon:getIcon(item.uniqueID)
					if (exIcon) then
						surface.SetMaterial(exIcon)
						surface.SetDrawColor(color_white)
						surface.DrawTexturedRect(0, 0, x, y)

						surface.SetDrawColor(Color( 0, 0, 0, 235))
						surface.DrawOutlinedRect(0, 0, x, y)
					else
						ikon:renderIcon(
							item.uniqueID,
							item.width,
							item.height,
							item.model,
							item.iconCam
						)
					end
				end
			else
				self.main_weapon_model:SetSize(0, 0)
			end

			if !(toggle_2 == 0) then
				local item = nut.item.list[toggle_2]

				self.second_model:SetModel(item.model, 0)
				if item.width == 1 and item.height == 1 then
					self.second_model:SetPos(ScrW() * 0.0915, ScrH() * 0.310) -- W+0.005 H+0.14
				elseif item.width == 2 and item.height == 1 then
					self.second_model:SetPos(ScrW() * 0.08, ScrH() * 0.310)
				elseif item.width == 1 and item.height == 2 then
					self.second_model:SetPos(ScrW() * 0.0915, ScrH() * 0.292)
				elseif item.width == 2 and item.height == 2 then
					self.second_model:SetPos(ScrW() * 0.08, ScrH() * 0.292)
				elseif item.width == 3 and item.height == 2 then
					self.second_model:SetPos(ScrW() * 0.065, ScrH() * 0.292)
				end
				self.second_model:SetSize(ScrW() * item.width * 0.025, ScrH() * item.height * 0.044)
				self.second_model.Icon:SetVisible(false)
				self.second_model.ExtraPaint = function(self, x, y)
					local exIcon = ikon:getIcon(item.uniqueID)
					if (exIcon) then
						surface.SetMaterial(exIcon)
						surface.SetDrawColor(color_white)
						surface.DrawTexturedRect(0, 0, x, y)

						surface.SetDrawColor(Color( 0, 0, 0, 235))
						surface.DrawOutlinedRect(0, 0, x, y)
					else
						ikon:renderIcon(
							item.uniqueID,
							item.width,
							item.height,
							item.model,
							item.iconCam
						)
					end
				end
			else
				self.second_model:SetSize(0, 0)
			end

		end
	end

	function self:Paint( w, h )
		nut.util.drawBlur(self, 10)
		surface.SetDrawColor(Color( 30, 30, 30, 190))
		surface.DrawRect( 0, 0, w, h )
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 14, 150)
		surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033)

		surface.SetDrawColor(Color( 30, 30, 30, 50))
		surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033) --шапка

		draw.DrawText("Приготовление пищи", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT ) --надпись шапки

		surface.SetDrawColor(Color( 138, 149, 151, 60))
		surface.DrawLine(ScrW() * 0.05, ScrH() * 0.0325, ScrW() * 0.36, ScrH() * 0.0325)

		surface.SetDrawColor(Color( 0, 33, 55, 160))
		surface.DrawRect(ScrW() * 0.21, ScrH() * 0.057, ScrW() * 0.189, ScrH() * 0.024) --верхняя панель крафта

		surface.SetDrawColor(Color( 0, 0, 0, 200))
		surface.DrawRect(ScrW() * 0.21, ScrH() * 0.08, ScrW() * 0.189, ScrH() * 0.145) --основная панель крафта

		surface.SetDrawColor(Color( 0, 0, 0, 235))
		surface.DrawOutlinedRect(ScrW() * 0.21, ScrH() * 0.057, ScrW() * 0.189, ScrH() * 0.169) --основная обводка крафта

		surface.SetDrawColor(Color( 0, 0, 0, 50))
		surface.DrawOutlinedRect(ScrW() * 0.21, ScrH() * 0.057, ScrW() * 0.189, ScrH() * 0.169) --вторичная обводка крафта

		surface.SetDrawColor(Color( 255, 255, 255, 240))
		surface.SetMaterial(Material("daui/scrbr_2.png"))
		surface.DrawTexturedRect(ScrW() * 0.01, ScrH() * 0.08, ScrW() * 0.189, ScrH() * 0.145) --бекграуд первого предмета

		surface.SetDrawColor(Color( 0, 0, 0, 235))
		surface.DrawOutlinedRect(ScrW() * 0.01, ScrH() * 0.08, ScrW() * 0.189, ScrH() * 0.145) --обводка первого предмета

		draw.DrawText("Выбранный ингридиент", "Roh20", ScrW() * 0.01, ScrH() * 0.0555, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

		draw.DrawText("Ингридиенты", "Roh20", ScrW() * 0.215, ScrH() * 0.0555, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

		surface.SetDrawColor(Color( 0, 33, 55, 160))
		surface.DrawRect(ScrW() * 0.21, ScrH() * 0.247, ScrW() * 0.189, ScrH() * 0.024) --верхняя панель крафта

		surface.SetDrawColor(Color( 0, 0, 0, 200))
		surface.DrawRect(ScrW() * 0.21, ScrH() * 0.27, ScrW() * 0.189, ScrH() * 0.145) --основная панель крафта

		surface.SetDrawColor(Color( 0, 0, 0, 235))
		surface.DrawOutlinedRect(ScrW() * 0.21, ScrH() * 0.247, ScrW() * 0.189, ScrH() * 0.169) --основная обводка крафта

		surface.SetDrawColor(Color( 0, 0, 0, 50))
		surface.DrawOutlinedRect(ScrW() * 0.21, ScrH() * 0.247, ScrW() * 0.189, ScrH() * 0.169) --вторичная обводка крафта

		surface.SetDrawColor(Color( 255, 255, 255, 240))
		surface.SetMaterial(Material("daui/scrbr_2.png"))
		surface.DrawTexturedRect(ScrW() * 0.01, ScrH() * 0.27, ScrW() * 0.189, ScrH() * 0.145) --бекграуд первого предмета

		surface.SetDrawColor(Color( 0, 0, 0, 235))
		surface.DrawOutlinedRect(ScrW() * 0.01, ScrH() * 0.27, ScrW() * 0.189, ScrH() * 0.145) --обводка первого предмета

		draw.DrawText("Выбранное топливо", "Roh20", ScrW() * 0.01, ScrH() * 0.2455, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

		draw.DrawText("Топливо", "Roh20", ScrW() * 0.215, ScrH() * 0.2455, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

		surface.SetDrawColor(Color( 255, 255, 255, 240))
		surface.SetMaterial(Material("daui/scrbr_2.png"))
		surface.DrawTexturedRect(ScrW() * 0.21, ScrH() * 0.44, ScrW() * 0.087, ScrH() * 0.105) --бекграуд первого предмета

		surface.SetDrawColor(Color( 0, 0, 0, 235))
		surface.DrawOutlinedRect(ScrW() * 0.21, ScrH() * 0.44, ScrW() * 0.087, ScrH() * 0.105) --обводка первого предмета

		if !(toggle_1 == 0) then
			local item = nut.item.list[toggle_1]
			if LocalPlayer():getChar():getInv():hasItem(toggle_1) then
				draw.DrawText(LocalPlayer():getChar():getInv():hasItem(toggle_1).name, "Roh10", ScrW() * 0.103, ScrH() * 0.19, Color(19, 136, 8, 210), TEXT_ALIGN_CENTER )
			else
				draw.DrawText(item.name, "Roh10", ScrW() * 0.103, ScrH() * 0.19, Color(146, 0, 10, 210), TEXT_ALIGN_CENTER )
			end
		end

		if !(toggle_2 == 0) then
			local item = nut.item.list[toggle_2]
			if LocalPlayer():getChar():getInv():hasItem(toggle_2) then
				draw.DrawText(LocalPlayer():getChar():getInv():hasItem(toggle_2).name, "Roh10", ScrW() * 0.103, ScrH() * 0.38, Color(19, 136, 8, 210), TEXT_ALIGN_CENTER )
			else
				draw.DrawText(item.name, "Roh10", ScrW() * 0.103, ScrH() * 0.38, Color(146, 0, 10, 210), TEXT_ALIGN_CENTER )
			end
		end

		surface.SetDrawColor( Color(125, 105, 0, 100) )
		surface.SetMaterial( Material("lgh/circle_gradient.png") )
		surface.DrawTexturedRectUV( ScrW() * 0.01, ScrH() * 0.545, ScrW() * 0.4, ScrH() * 0.032, 1, 0.9, 0, 0.3 )
	end
end

vgui.Register("cooking_kek1ch", PANEL, "DFrame")
netstream.Hook("cooking_kek1ch", function()
	cooking_kek1ch = vgui.Create("cooking_kek1ch")
end)