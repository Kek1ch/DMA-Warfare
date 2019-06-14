local PANEL = {}

function PANEL:Init(uniqueID)

	local data = {}
	data.toggle_1 = toggle_1
	data.toggle_2 = toggle_2
	data.toggle_3 = toggle_3
	data.toggle_4 = toggle_4
	data.itog = itog

	toggle_1 = "vodka_def"
	toggle_2 = "tkan"
	toggle_3 = 0
	toggle_4 = 0
	itog = 0

	self:SetSize(ScrW() * 0.41, ScrH() * 0.55)
	self:MakePopup()
	self:Center()
	self:SetTitle("")
	self:ShowCloseButton(false)
	self:SetDraggable(false)

	self.craftit = self:Add("DButton")
	self.craftit:SetSize( ScrW() * 0.089, ScrH() * 0.0325)
	self.craftit:SetPos(ScrW() * 0.21, ScrH() * 0.455)
	self.craftit:SetText("Создать")
	self.craftit:SetFont("Roh20")
	self.craftit:SetTextColor(Color(255, 255, 255, 210)) 
	self.craftit.DoClick = function(client)
		if !(itog == 0) then
			if !(toggle_4 == 0) and LocalPlayer():getChar():getInv():hasItem(toggle_1) and LocalPlayer():getChar():getInv():hasItem(toggle_2) and LocalPlayer():getChar():getInv():hasItem(toggle_3) and LocalPlayer():getChar():getInv():hasItem(toggle_4) then 
				netstream.Start("goto_craft", data)
				self:Close()
			elseif !(toggle_3 == 0) and (toggle_4 == 0) and LocalPlayer():getChar():getInv():hasItem(toggle_1) and LocalPlayer():getChar():getInv():hasItem(toggle_2) and LocalPlayer():getChar():getInv():hasItem(toggle_3) then 
				netstream.Start("goto_craft", data)
				self:Close()
			elseif !(toggle_2 == 0) and (toggle_3 == 0) and LocalPlayer():getChar():getInv():hasItem(toggle_1) and LocalPlayer():getChar():getInv():hasItem(toggle_2) then 
				netstream.Start("goto_craft", data)
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
	self.exit:SetPos(ScrW() * 0.31, ScrH() * 0.455)
	self.exit:SetSize( ScrW() * 0.089, ScrH() * 0.0325)
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

		toggle_1 = nil
		toggle_2 = nil
		toggle_3 = nil
		toggle_4 = nil
		itog = nil
		collectgarbage()
	end

	self.dscrolldesc = self:Add("DScrollPanel")
	self.dscrolldesc:SetSize(ScrW() * 0.189, ScrH() * 0.365)
	self.dscrolldesc:SetPos(ScrW() * 0.21, ScrH() * 0.08)
	self.dscrolldesc:SetDrawBackground(false)

	local sbar = self.dscrolldesc:GetVBar()
	function sbar:Paint( w, h ) --рисуем скролл
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


	self.bint = self.list:Add("DButton") --бинт из водки казаки и листа легкой ткани
	self.bint:Dock(TOP)
	self.bint:DockMargin(3, 3, 3, 0)
	self.bint:SetTall(ScrH() * 0.032)
	self.bint:SetText("Бинт")
	self.bint:SetFont("Roh15")
	self.bint:SetTextColor(Color(169, 169, 169))
	self.bint.DoClick = function(this)
		self.bint:SetToggle(true)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "vodka_def"
		toggle_2 = "tkan"
		toggle_3 = 0
		toggle_4 = 0

		itog = "bint"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.bint:Paint( w, h )
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

	self.bint_second = self.list:Add("DButton") --бинт из водки столичной и листа легкой ткани
	self.bint_second:Dock(TOP)
	self.bint_second:DockMargin(3, 3, 3, 0)
	self.bint_second:SetTall(ScrH() * 0.032)
	self.bint_second:SetText("Бинт")
	self.bint_second:SetFont("Roh15")
	self.bint_second:SetTextColor(Color(169, 169, 169))
	self.bint_second.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(true)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "vodka"
		toggle_2 = "tkan"
		toggle_3 = 0
		toggle_4 = 0

		itog = "bint"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.bint_second:Paint( w, h )
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

	self.hand_flashlight = self.list:Add("DButton") --ручной фонарь из банки с хламом, медной проволоки, разбитого фонара + армейский фонарь
	self.hand_flashlight:Dock(TOP)
	self.hand_flashlight:DockMargin(3, 3, 3, 0)
	self.hand_flashlight:SetTall(ScrH() * 0.032)
	self.hand_flashlight:SetText("Ручной фонарь")
	self.hand_flashlight:SetFont("Roh15")
	self.hand_flashlight:SetTextColor(Color(169, 169, 169))
	self.hand_flashlight.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(true)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "banka_s_xlamom"
		toggle_2 = "mednya_provoloka"
		toggle_3 = "batar"
		toggle_4 = 0

		itog = "flashlight"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.hand_flashlight:Paint( w, h )
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

	self.dozimetr = self.list:Add("DButton") --дозиметр из конденсаторов, переносного радио, медной проволоки, канифоли
	self.dozimetr:Dock(TOP)
	self.dozimetr:DockMargin(3, 3, 3, 0)
	self.dozimetr:SetTall(ScrH() * 0.032)
	self.dozimetr:SetText("Дозиметр")
	self.dozimetr:SetFont("Roh15")
	self.dozimetr:SetTextColor(Color(169, 169, 169))
	self.dozimetr.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(true)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "condensators"
		toggle_2 = "perenosnoe_radio"
		toggle_3 = "mednya_provoloka"
		toggle_4 = "kanifol"

		itog = "dozimetr"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.dozimetr:Paint( w, h )
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

	self.samodel = self.list:Add("DButton") --самодельный детектор из конденсаторов, переносного радио, коробки транзисторов, текстолита
	self.samodel:Dock(TOP)
	self.samodel:DockMargin(3, 3, 3, 0)
	self.samodel:SetTall(ScrH() * 0.032)
	self.samodel:SetText("Самодельный детектор")
	self.samodel:SetFont("Roh15")
	self.samodel:SetTextColor(Color(169, 169, 169))
	self.samodel.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(true)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "condensators"
		toggle_2 = "perenosnoe_radio"
		toggle_3 = "tranzistors"
		toggle_4 = "tekstolit_osnova"

		itog = "samodel"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.samodel:Paint( w, h )
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

	self.fire_kit = self.list:Add("DButton") --набор для розжига из гитары и старой книги
	self.fire_kit:Dock(TOP)
	self.fire_kit:DockMargin(3, 3, 3, 0)
	self.fire_kit:SetTall(ScrH() * 0.032)
	self.fire_kit:SetText("Набор для розжига")
	self.fire_kit:SetFont("Roh15")
	self.fire_kit:SetTextColor(Color(169, 169, 169))
	self.fire_kit.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(true)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "guitare"
		toggle_2 = "old_book"
		toggle_3 = 0
		toggle_4 = 0

		itog = "nabor_dlya_rozhiga"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.fire_kit:Paint( w, h )
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

	self.fire_kit_second = self.list:Add("DButton") --набор для розжига из гитары и плейбоя
	self.fire_kit_second:Dock(TOP)
	self.fire_kit_second:DockMargin(3, 3, 3, 0)
	self.fire_kit_second:SetTall(ScrH() * 0.032)
	self.fire_kit_second:SetText("Набор для розжига")
	self.fire_kit_second:SetFont("Roh15")
	self.fire_kit_second:SetTextColor(Color(169, 169, 169))
	self.fire_kit_second.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(true)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "guitare"
		toggle_2 = "sex"
		toggle_3 = 0
		toggle_4 = 0

		itog = "rozshig_kit"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog

	end
	function self.fire_kit_second:Paint( w, h )
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

	self.kit_food = self.list:Add("DButton") --комплект изготовления еды из канистры и 2 полевых столовых приборов
	self.kit_food:Dock(TOP)
	self.kit_food:DockMargin(3, 3, 3, 0)
	self.kit_food:SetTall(ScrH() * 0.032)
	self.kit_food:SetText("Комплект изготовления еды")
	self.kit_food:SetFont("Roh15")
	self.kit_food:SetTextColor(Color(169, 169, 169))
	self.kit_food.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(true)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "condensators"
		toggle_2 = "ckit"
		toggle_3 = "ckit"
		toggle_4 = 0

		itog = "komplekt_izg_edi"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.kit_food:Paint( w, h )
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

	self.pecka = self.list:Add("DButton") --Самодельная походная печь из канистры, баллона с газом, 2 банки с хламом
	self.pecka:Dock(TOP)
	self.pecka:DockMargin(3, 3, 3, 0)
	self.pecka:SetTall(ScrH() * 0.032)
	self.pecka:SetText("Самодельная походная печь")
	self.pecka:SetFont("Roh15")
	self.pecka:SetTextColor(Color(169, 169, 169))
	self.pecka.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(true)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "gascan"
		toggle_2 = "kbgas"
		toggle_3 = "banka_s_xlamom"
		toggle_4 = "banka_s_xlamom"

		itog = "pechka1"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.pecka:Paint( w, h )
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

	self.maska = self.list:Add("DButton") --тряпичная маска из 2 листов легкой ткани
	self.maska:Dock(TOP)
	self.maska:DockMargin(3, 3, 3, 0)
	self.maska:SetTall(ScrH() * 0.032)
	self.maska:SetText("Тряпичная маска")
	self.maska:SetFont("Roh15")
	self.maska:SetTextColor(Color(169, 169, 169))
	self.maska.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(true)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "tkan"
		toggle_2 = "tkan"
		toggle_3 = 0
		toggle_4 = 0

		itog = "maska"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.maska:Paint( w, h )
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

	self.sleeping_bag = self.list:Add("DButton") --спальный мешок из камуфляжного брезента, нити, 2 листа легкой ткани
	self.sleeping_bag:Dock(TOP)
	self.sleeping_bag:DockMargin(3, 3, 3, 0)
	self.sleeping_bag:SetTall(ScrH() * 0.032)
	self.sleeping_bag:SetText("Спальный мешок")
	self.sleeping_bag:SetFont("Roh15")
	self.sleeping_bag:SetTextColor(Color(169, 169, 169))
	self.sleeping_bag.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(true)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "tkan"
		toggle_2 = "tkan"
		toggle_3 = 0
		toggle_4 = 0

		itog = "sleeping_bag"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.sleeping_bag:Paint( w, h )
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

	self.polev_bag = self.list:Add("DButton") --полевой рюкзак из 2 листа брезента, нити и легкой ткани
	self.polev_bag:Dock(TOP)
	self.polev_bag:DockMargin(3, 3, 3, 0)
	self.polev_bag:SetTall(ScrH() * 0.032)
	self.polev_bag:SetText("Полевой рюкзак")
	self.polev_bag:SetFont("Roh15")
	self.polev_bag:SetTextColor(Color(169, 169, 169))
	self.polev_bag.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(true)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "trapk"
		toggle_2 = "trapk"
		toggle_3 = "nitka_sintetichesk"
		toggle_4 = "tkan"

		itog = "polevoi_backpack"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.polev_bag:Paint( w, h )
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

	self.pohod_bag = self.list:Add("DButton") --походный рюкзак из листа брезента, нити, веревки и плотного покрывала
	self.pohod_bag:Dock(TOP)
	self.pohod_bag:DockMargin(3, 3, 3, 0)
	self.pohod_bag:SetTall(ScrH() * 0.032)
	self.pohod_bag:SetText("Походный рюкзак")
	self.pohod_bag:SetFont("Roh15")
	self.pohod_bag:SetTextColor(Color(169, 169, 169))
	self.pohod_bag.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(true)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "trapk"
		toggle_2 = "nitka_sintetichesk"
		toggle_3 = "tie"
		toggle_4 = "twomatras"

		itog = "backpack_3"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.pohod_bag:Paint( w, h )
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

	self.hunter_kit = self.list:Add("DButton") --охотничий набор из полевого рюкзака, набора для стрижки, туристического ножа, набор для заточки 31
	self.hunter_kit:Dock(TOP)
	self.hunter_kit:DockMargin(3, 3, 3, 0)
	self.hunter_kit:SetTall(ScrH() * 0.032)
	self.hunter_kit:SetText("Охотничий набор")
	self.hunter_kit:SetFont("Roh15")
	self.hunter_kit:SetTextColor(Color(169, 169, 169))
	self.hunter_kit.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(true)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "nabor_dlya_strijki"
		toggle_2 = "knife"
		toggle_3 = "tie"
		toggle_4 = "instument"

		itog = "kithunt"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.hunter_kit:Paint( w, h )
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

	self.qr = self.list:Add("DButton") --система быстрого сброса из веревки, банки с хламом, швейцарского ножа
	self.qr:Dock(TOP)
	self.qr:DockMargin(3, 3, 3, 0)
	self.qr:SetTall(ScrH() * 0.032)
	self.qr:SetText("Система быстрого сброса (QR)")
	self.qr:SetFont("Roh15")
	self.qr:SetTextColor(Color(169, 169, 169))
	self.qr.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(true)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "tie"
		toggle_2 = "banka_s_xlamom"
		toggle_3 = "swiss"
		toggle_4 = 0

		itog = "qc"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.qr:Paint( w, h )
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

	self.metal_plate = self.list:Add("DButton") --железная пластина из канистры, веревки, листа брезента, банки с хламом
	self.metal_plate:Dock(TOP)
	self.metal_plate:DockMargin(3, 3, 3, 0)
	self.metal_plate:SetTall(ScrH() * 0.032)
	self.metal_plate:SetText("Железная пластина")
	self.metal_plate:SetFont("Roh15")
	self.metal_plate:SetTextColor(Color(169, 169, 169))
	self.metal_plate.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(true)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "gascan"
		toggle_2 = "tie"
		toggle_3 = "brezent"
		toggle_4 = "banka_s_xlamom"

		itog = "plate"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.metal_plate:Paint( w, h )
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

	self.metal_plate_second = self.list:Add("DButton") --железная пластина из баллона с газом, веревки, листа брезента, банки с хламом
	self.metal_plate_second:Dock(TOP)
	self.metal_plate_second:DockMargin(3, 3, 3, 0)
	self.metal_plate_second:SetTall(ScrH() * 0.032)
	self.metal_plate_second:SetText("Железная пластина")
	self.metal_plate_second:SetFont("Roh15")
	self.metal_plate_second:SetTextColor(Color(169, 169, 169))
	self.metal_plate_second.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(true)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "kbgas"
		toggle_2 = "tie"
		toggle_3 = "brezent"
		toggle_4 = "banka_s_xlamom"

		itog = "plate"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.metal_plate_second:Paint( w, h )
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

	self.verb_gorb = self.list:Add("DButton") --верблюжий горб из 2 листов брезента, очищенной воды и веревки
	self.verb_gorb:Dock(TOP)
	self.verb_gorb:DockMargin(3, 3, 3, 0)
	self.verb_gorb:SetTall(ScrH() * 0.032)
	self.verb_gorb:SetText("Верблюжий горб")
	self.verb_gorb:SetFont("Roh15")
	self.verb_gorb:SetTextColor(Color(169, 169, 169))
	self.verb_gorb.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(true)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "brezent"
		toggle_2 = "brezent"
		toggle_3 = "water"
		toggle_4 = "tie"

		itog = "backpack_1"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.verb_gorb:Paint( w, h )
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

	self.samodel_knife = self.list:Add("DButton") --самодельный нож из канистры, ножа для заточки
	self.samodel_knife:Dock(TOP)
	self.samodel_knife:DockMargin(3, 3, 3, 0)
	self.samodel_knife:SetTall(ScrH() * 0.032)
	self.samodel_knife:SetText("Самодельный нож")
	self.samodel_knife:SetFont("Roh15")
	self.samodel_knife:SetTextColor(Color(169, 169, 169))
	self.samodel_knife.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(true)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "gascan"
		toggle_2 = "instument"
		toggle_3 = 0
		toggle_4 = 0

		itog = "knife"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.samodel_knife:Paint( w, h )
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

	self.samodel_knife_second = self.list:Add("DButton") --самодельный нож из баллона, ножа для заточки
	self.samodel_knife_second:Dock(TOP)
	self.samodel_knife_second:DockMargin(3, 3, 3, 0)
	self.samodel_knife_second:SetTall(ScrH() * 0.032)
	self.samodel_knife_second:SetText("Самодельный нож")
	self.samodel_knife_second:SetFont("Roh15")
	self.samodel_knife_second:SetTextColor(Color(169, 169, 169))
	self.samodel_knife_second.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(true)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(false)

		toggle_1 = "kbgas"
		toggle_2 = "instument"
		toggle_3 = 0
		toggle_4 = 0

		itog = "knife"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.samodel_knife_second:Paint( w, h )
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

	self.exp_rgd = self.list:Add("DButton") --взрывчатка из ргд, проволоки и нитки
	self.exp_rgd:Dock(TOP)
	self.exp_rgd:DockMargin(3, 3, 3, 0)
	self.exp_rgd:SetTall(ScrH() * 0.032)
	self.exp_rgd:SetText("Взрывчатка")
	self.exp_rgd:SetFont("Roh15")
	self.exp_rgd:SetTextColor(Color(169, 169, 169))
	self.exp_rgd.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(true)
		self.exp_f1:SetToggle(false)

		toggle_1 = "wep_rgd"
		toggle_2 = "mednya_provoloka"
		toggle_3 = "nitka_sintetichesk"
		toggle_4 = 0

		itog = "mine"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end
	function self.exp_rgd:Paint( w, h )
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

	self.exp_f1 = self.list:Add("DButton") --взрывчатка из ф1, проволоки и нитки
	self.exp_f1:Dock(TOP)
	self.exp_f1:DockMargin(3, 3, 3, 0)
	self.exp_f1:SetTall(ScrH() * 0.032)
	self.exp_f1:SetText("Взрывчатка")
	self.exp_f1:SetFont("Roh15")
	self.exp_f1:SetTextColor(Color(169, 169, 169))
	self.exp_f1.DoClick = function(this)
		self.bint:SetToggle(false)
		self.bint_second:SetToggle(false)
		self.hand_flashlight:SetToggle(false)
		self.dozimetr:SetToggle(false)
		self.samodel:SetToggle(false)
		self.fire_kit:SetToggle(false)
		self.fire_kit_second:SetToggle(false)
		self.kit_food:SetToggle(false)
		self.pecka:SetToggle(false)
		self.maska:SetToggle(false)
		self.sleeping_bag:SetToggle(false)
		self.polev_bag:SetToggle(false)
		self.pohod_bag:SetToggle(false)
		self.hunter_kit:SetToggle(false)
		self.qr:SetToggle(false)
		self.metal_plate:SetToggle(false)
		self.metal_plate_second:SetToggle(false)
		self.verb_gorb:SetToggle(false)
		self.samodel_knife:SetToggle(false)
		self.samodel_knife_second:SetToggle(false)
		self.exp_rgd:SetToggle(false)
		self.exp_f1:SetToggle(true)

		toggle_1 = "wep_sskf1"
		toggle_2 = "mednya_provoloka"
		toggle_3 = "nitka_sintetichesk"
		toggle_4 = 0

		itog = "mine"

		data.toggle_1 = toggle_1
		data.toggle_2 = toggle_2
		data.toggle_3 = toggle_3
		data.toggle_4 = toggle_4
		data.itog = itog
	end

	function self.exp_f1:Paint( w, h )
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

	self.third_model = self:Add("nutItemIcon")
	
	self.four_model = self:Add("nutItemIcon")

	function self:Think()

		if ((self.updatekek or 0) < CurTime()) then
			if !(toggle_1 == 0) then
				local item = nut.item.list[toggle_1]

				self.main_weapon_model:SetModel(item.model, 0)
				if item.width == 1 and item.height == 1 then
					self.main_weapon_model:SetPos(ScrW() * 0.0865, ScrH() * 0.071)
				elseif item.width == 2 and item.height == 1 then
					self.main_weapon_model:SetPos(ScrW() * 0.075, ScrH() * 0.071)
				elseif item.width == 1 and item.height == 2 then
					self.main_weapon_model:SetPos(ScrW() * 0.0865, ScrH() * 0.053)
				elseif item.width == 2 and item.height == 2 then
					self.main_weapon_model:SetPos(ScrW() * 0.075, ScrH() * 0.053)
				elseif item.width == 3 and item.height == 2 then
					self.main_weapon_model:SetPos(ScrW() * 0.06, ScrH() * 0.053)
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
					self.second_model:SetPos(ScrW() * 0.0865, ScrH() * 0.180)
				elseif item.width == 2 and item.height == 1 then
					self.second_model:SetPos(ScrW() * 0.075, ScrH() * 0.180)
				elseif item.width == 1 and item.height == 2 then
					self.second_model:SetPos(ScrW() * 0.0865, ScrH() * 0.162)
				elseif item.width == 2 and item.height == 2 then
					self.second_model:SetPos(ScrW() * 0.075, ScrH() * 0.162)
				elseif item.width == 3 and item.height == 2 then
					self.second_model:SetPos(ScrW() * 0.06, ScrH() * 0.162)
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

			if !(toggle_3 == 0) then
				local item = nut.item.list[toggle_3]

				self.third_model:SetModel(item.model, 0)
				if item.width == 1 and item.height == 1 then
					self.third_model:SetPos(ScrW() * 0.0865, ScrH() * 0.289)
				elseif item.width == 2 and item.height == 1 then
					self.third_model:SetPos(ScrW() * 0.075, ScrH() * 0.289)
				elseif item.width == 1 and item.height == 2 then
					self.third_model:SetPos(ScrW() * 0.0865, ScrH() * 0.271)
				elseif item.width == 2 and item.height == 2 then
					self.third_model:SetPos(ScrW() * 0.075, ScrH() * 0.271)
				elseif item.width == 3 and item.height == 2 then
					self.third_model:SetPos(ScrW() * 0.06, ScrH() * 0.271)
				end
				self.third_model:SetSize(ScrW() * item.width * 0.025, ScrH() * item.height * 0.044)
				self.third_model.Icon:SetVisible(false)
				self.third_model.ExtraPaint = function(self, x, y)
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
				self.third_model:SetSize(0, 0)
			end

			if !(toggle_4 == 0) then
				local item = nut.item.list[toggle_4]

				self.four_model:SetModel(item.model, 0)
				if item.width == 1 and item.height == 1 then
					self.four_model:SetPos(ScrW() * 0.0865, ScrH() * 0.401)
				elseif item.width == 2 and item.height == 1 then
					self.four_model:SetPos(ScrW() * 0.075, ScrH() * 0.401)
				elseif item.width == 1 and item.height == 2 then
					self.four_model:SetPos(ScrW() * 0.0865, ScrH() * 0.390)
				elseif item.width == 2 and item.height == 2 then
					self.four_model:SetPos(ScrW() * 0.075, ScrH() * 0.390)
				elseif item.width == 3 and item.height == 2 then
					self.four_model:SetPos(ScrW() * 0.06, ScrH() * 0.390)
				end
				self.four_model:SetSize(ScrW() * item.width * 0.025, ScrH() * item.height * 0.044)
				self.four_model.Icon:SetVisible(false)
				self.four_model.ExtraPaint = function(self, x, y)
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
				self.four_model:SetSize(0, 0)
			end

			self.updatekek = CurTime() + 0.0
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

		draw.DrawText("Создание вещей", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT ) --надпись шапки

		surface.SetDrawColor(Color( 0, 33, 55, 160))
		surface.DrawRect(ScrW() * 0.21, ScrH() * 0.057, ScrW() * 0.189, ScrH() * 0.024) --верхняя панель крафта

		surface.SetDrawColor(Color( 0, 0, 0, 200))
		surface.DrawRect(ScrW() * 0.21, ScrH() * 0.08, ScrW() * 0.189, ScrH() * 0.365) --основная панель крафта

		surface.SetDrawColor(Color( 0, 0, 0, 235))
		surface.DrawOutlinedRect(ScrW() * 0.21, ScrH() * 0.057, ScrW() * 0.189, ScrH() * 0.389) --основная обводка крафта

		surface.SetDrawColor(Color( 0, 0, 0, 50))
		surface.DrawOutlinedRect(ScrW() * 0.21, ScrH() * 0.057, ScrW() * 0.189, ScrH() * 0.389) --вторичная обводка крафта

		draw.DrawText("Список рецептов", "Roh20", ScrW() * 0.215, ScrH() * 0.0555, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

		if !(toggle_1 == 0) then
			local item = nut.item.list[toggle_1]
			if LocalPlayer():getChar():getInv():hasItem(toggle_1) then
				draw.DrawText(LocalPlayer():getChar():getInv():hasItem(toggle_1).name, "Roh10", ScrW() * 0.1, ScrH() * 0.14, Color(19, 136, 8, 210), TEXT_ALIGN_CENTER )
			else
				draw.DrawText(item.name, "Roh10", ScrW() * 0.1, ScrH() * 0.14, Color(146, 0, 10, 210), TEXT_ALIGN_CENTER )
			end
		end

		if !(toggle_2 == 0) then
			local item = nut.item.list[toggle_2]
			if LocalPlayer():getChar():getInv():hasItem(toggle_2) then
				draw.DrawText(LocalPlayer():getChar():getInv():hasItem(toggle_2).name, "Roh10", ScrW() * 0.1, ScrH() * 0.25, Color(19, 136, 8, 210), TEXT_ALIGN_CENTER )
			else
				draw.DrawText(item.name, "Roh10", ScrW() * 0.1, ScrH() * 0.25, Color(146, 0, 10, 210), TEXT_ALIGN_CENTER )
			end
		end

		if !(toggle_3 == 0) then
			local item = nut.item.list[toggle_3]
			if LocalPlayer():getChar():getInv():hasItem(toggle_3) then
				draw.DrawText(LocalPlayer():getChar():getInv():hasItem(toggle_3).name, "Roh10", ScrW() * 0.1, ScrH() * 0.36, Color(19, 136, 8, 210), TEXT_ALIGN_CENTER )
			else
				draw.DrawText(item.name, "Roh10", ScrW() * 0.1, ScrH() * 0.36, Color(146, 0, 10, 210), TEXT_ALIGN_CENTER )
			end
		end

		if !(toggle_4 == 0) then
			local item = nut.item.list[toggle_4]
			if LocalPlayer():getChar():getInv():hasItem(toggle_4) then
				draw.DrawText(LocalPlayer():getChar():getInv():hasItem(toggle_4).name, "Roh10", ScrW() * 0.1, ScrH() * 0.47, Color(19, 136, 8, 210), TEXT_ALIGN_CENTER )
			else
				draw.DrawText(item.name, "Roh10", ScrW() * 0.1, ScrH() * 0.47, Color(146, 0, 10, 210), TEXT_ALIGN_CENTER )
			end
		end

		surface.SetDrawColor( Color(125, 105, 0, 40) )
		surface.SetMaterial( Material("lgh/circle_gradient.png") )
		surface.DrawTexturedRectUV( ScrW() * 0.01, ScrH() * 0.525, ScrW() * 0.4, ScrH() * 0.032, 1, 0.9, 0, 0.3 )
	end
end

vgui.Register("crafting_kek1ch", PANEL, "DFrame")
netstream.Hook("crafting_kek1ch", function()
	crafting_kek1ch = vgui.Create("crafting_kek1ch")
end)