local PANEL = {}

function PANEL:Init()

	local items = LocalPlayer():getChar():getInv():getItems()
	local data = {}

	local Hit = LocalPlayer():GetEyeTraceNoCursor()
	local entity = Hit.Entity

	if (entity) then
		tehnikname = entity:getNetVar("name") 
		tehnikdesc = entity:getNetVar("desc")
		tehnikmodel =  entity:GetModel()
	end

	data.cost_main = cost_main
	data.cost_main_button = cost_main_button
	data.cost_armor_button = cost_armor_button
	data.cost_helmet_button = cost_helmet_button
	data.cost_pistol_button = cost_pistol_button
	data.cost_siderman_button = cost_siderman_button

	cost_main = 0
	cost_main_button = 0
	cost_armor_button = 0
	cost_helmet_button = 0
	cost_pistol_button = 0
	cost_siderman_button = 0

	self:SetSize(ScrW() * 0.212, ScrH() * 0.61)
	self:MakePopup()
	self:SetPos(ScrW() * 0.4, ScrH() * 0.2)
	self:SetTitle("")
	self:ShowCloseButton(false)
	self:SetDraggable(false)

	local right = vgui.Create( "DFrame" )
	right:SetPos(ScrW() * 0.62, ScrH() * 0.2)
	right:SetSize(ScrW() * 0.212, ScrH() * 0.61)
	right:SetTitle("")
	right:ShowCloseButton(false)
	right:SetDraggable(false)
	right:MakePopup()

	right.icon = right:Add("nutModelPanel")
	right.icon:SetModel(LocalPlayer():getChar():getModel())
	right.icon:SetSize(ScrW() * 0.085, ScrH() * 0.121)
	right.icon:SetPos(ScrW() * 0.0115, ScrH() * 0.06)

	function right.icon:LayoutEntity( Entity ) return end
	local headpos = right.icon.Entity:GetBonePosition( right.icon.Entity:LookupBone("bip01_head"))

	right.icon:SetLookAt(headpos)
	right.icon:SetCamPos(headpos-Vector( -18, 2.5, 4 ))
	right.icon:SetFOV(70)

	right.dscrolldesc = right:Add("DScrollPanel")
	right.dscrolldesc:SetSize(ScrW() * 0.189, ScrH() * 0.31)
	right.dscrolldesc:SetPos(ScrW() * 0.0115, ScrH() * 0.224)
	right.dscrolldesc:SetDrawBackground(false)

	local sbar = right.dscrolldesc:GetVBar()
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

	right.dpaneldesc = right.dscrolldesc:Add("DLabel")
	right.dpaneldesc:SetSize(ScrW() * 0.189, ScrH() * 1)

	right.dpaneldesc:SetText("")
	function right.dpaneldesc:Paint( w, h )


		local x, y = ScrW() * 0, ScrH() * 0.15

		for _, v in pairs(items) do
			if armor_button_toggled == 1 then
				if v.category == "armor" and v:getData("equip") then
					local lines = nut.util.wrapText(v.name.." - "..v.desc, ScrW() * 0.124, "Roh10")
					for i = 1, #lines do
						y = ScrH() * 0 + (i * 18) 
						nut.util.drawText(lines[i], x, y, color_white, ScrW() * 0.001, ScrH() * 0.1, "Roh10", TEXT_ALIGN_LEFT) 
					end
				end
			elseif main_button_toggled == 1 then
				if v.weaponCategory == "1" and v:getData("equip") then
					local lines = nut.util.wrapText(v.name.." - "..v.desc, ScrW() * 0.124, "Roh10")
					for i = 1, #lines do
						y = ScrH() * 0 + (i * 18) 
						nut.util.drawText(lines[i], x, y, color_white, ScrW() * 0.001, ScrH() * 0.1, "Roh10", TEXT_ALIGN_LEFT) 
					end
				end
			elseif second_button_toggled == 1 then
				if v.weaponcategory == "1.5" and v:getData("equip") then
					local lines = nut.util.wrapText(v.name.." - "..v.desc, ScrW() * 0.124, "Roh10")
					for i = 1, #lines do
						y = ScrH() * 0 + (i * 18) 
						nut.util.drawText(lines[i], x, y, color_white, ScrW() * 0.001, ScrH() * 0.1, "Roh10", TEXT_ALIGN_LEFT) 
					end
				end
			elseif pistol_button_toggled == 1 then
				if v.weaponcategory == "2" and v:getData("equip") then
					local lines = nut.util.wrapText(v.name.." - "..v.desc, ScrW() * 0.124, "Roh10")
					for i = 1, #lines do
						y = ScrH() * 0 + (i * 18) 
						nut.util.drawText(lines[i], x, y, color_white, ScrW() * 0.001, ScrH() * 0.1, "Roh10", TEXT_ALIGN_LEFT) 
					end
				end
			elseif helmet_button_toggled == 1 then
				if v.category == "Шлем" and v:getData("equip") then
					local lines = nut.util.wrapText(v.name.." - "..v.desc, ScrW() * 0.124, "Roh10")
					for i = 1, #lines do
						y = ScrH() * 0 + (i * 18) 
						nut.util.drawText(lines[i], x, y, color_white, ScrW() * 0.001, ScrH() * 0.1, "Roh10", TEXT_ALIGN_LEFT) 
					end
				end
			else
				local lines = nut.util.wrapText("Для ремонта снаряжения выберите иконки на панели «Экипировка», после чего нажмите на кнопку «Ремонт».", ScrW() * 0.124, "Roh10")
				for i = 1, #lines do
					y = ScrH() * 0 + (i * 18) 
					nut.util.drawText(lines[i], x, y, color_white, ScrW() * 0.001, ScrH() * 0.13, "Roh10", TEXT_ALIGN_LEFT) 
				end
			end
		end
	end 

	right.icon_desc = right.dpaneldesc:Add("nutItemIcon") --иконка описания
	right.icon_desc:SetSize(0, 0)
	right.icon_desc.Icon:SetVisible(false)

	local left = vgui.Create( "DFrame" )
	left:SetPos(ScrW() * 0.18, ScrH() * 0.2)
	left:SetSize(ScrW() * 0.212, ScrH() * 0.24)
	left:SetTitle("")
	left:ShowCloseButton(false)
	left:SetDraggable(false)
	left:MakePopup()

	left.icon = left:Add("nutModelPanel")
	left.icon:SetSize(ScrW() * 0.085, ScrH() * 0.121)
	left.icon:SetPos(ScrW() * 0.0115, ScrH() * 0.06)

	function left:Think()
		if ((left.updateurmodel4kek or 0) < CurTime()) then
			if !(tehnikmodel == nil) then
				left.icon:SetModel(tehnikmodel)
			else
				left.icon:SetModel("models/spenser/kek1ch/stalker_neutral0a.mdl")
			end
			function left.icon:LayoutEntity( Entity ) return end
			if left.icon.Entity:LookupBone("bip01_head") then
				local headpos = left.icon.Entity:GetBonePosition( left.icon.Entity:LookupBone("bip01_head"))

				left.icon:SetLookAt(headpos)
				left.icon:SetCamPos(headpos-Vector( -18, 2.5, 4 ))
				left.icon:SetFOV(70)
			end
			left.updateurmodel4kek = CurTime() + 0.4
		end
	end	

	left.fixit = left:Add("DButton")
	left.fixit:SetSize( ScrW() * 0.085, ScrH() * 0.0325)
	left.fixit:SetPos(ScrW() * 0.0115, ScrH() * 0.187)
	left.fixit:SetText("Ремонт")
	left.fixit:SetFont("Roh20")
	left.fixit:SetTextColor(Color(255, 255, 255, 210)) 
	left.fixit.DoClick = function(client)
		if cost_main == 0 then
			return false
		else
			netstream.Start("fix_my_gear", data)
		end

		cost_main = 0
		cost_main_button = 0
		cost_armor_button = 0
		cost_helmet_button = 0
		cost_pistol_button = 0
		cost_siderman_button = 0

		armor_button_toggled = 0
		main_button_toggled = 0
		second_button_toggled = 0
		pistol_button_toggled = 0
		helmet_button_toggled = 0

		self.main_button:SetToggle(false)
		self.siderman_button:SetToggle(false)
		self.helmet_button:SetToggle(false)
		self.pistol_button:SetToggle(false)
		self.armor_button:SetToggle(false)

	end

	function left.fixit:Paint( w, h )
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

	function left:Paint( w, h )  --Расположение X Y, Размер W H.
		nut.util.drawBlur(self, 10)
		surface.SetDrawColor(Color( 30, 30, 30, 190))
		surface.DrawRect( 0, 0, w, h )
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 14, 150)
		surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033) --шапка

		surface.SetDrawColor(Color( 30, 30, 30, 50))
		surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033) --обводка шапки

		draw.DrawText("Ремонт", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT ) --надпись шапки

		surface.SetDrawColor(0, 0, 14, 150)
		surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.0575, ScrW() * 0.085, ScrH() * 0.125) --фон модели игрока

		surface.SetDrawColor(Color( 0, 0, 0, 255))
		surface.DrawOutlinedRect(ScrW() * 0.0115, ScrH() * 0.0575, ScrW() * 0.085, ScrH() * 0.125) --обводка модели игрока

		surface.SetDrawColor(0, 0, 14, 150)
		surface.DrawRect(ScrW() * 0.1, ScrH() * 0.187, ScrW() * 0.1, ScrH() * 0.0325) --информация о предмете

		draw.DrawText(tehnikname or "Пожилой Баг", "Roh20", ScrW() * 0.1, ScrH() * 0.06, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)

		if (cost_main == 0) then
			draw.DrawText("--- ₽", "Roh10", ScrW() * 0.105, ScrH() * 0.193, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)
		else
			draw.DrawText(cost_main.." ₽", "Roh10", ScrW() * 0.105, ScrH() * 0.193, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)
		end
			
		draw.DrawText("Фракция:", "Roh10", ScrW() * 0.1, ScrH() * 0.09, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --team.GetColor(character:getFaction())
		draw.DrawText(tehnikdesc or "Одиночки", "Roh10", ScrW() * 0.2, ScrH() * 0.09, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)

		draw.DrawText("Деньги:", "Roh10", ScrW() * 0.1, ScrH() * 0.111, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)
		draw.DrawText("--- ₽", "Roh10", ScrW() * 0.2, ScrH() * 0.111, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)

		draw.DrawText("Скидка:", "Roh10", ScrW() * 0.1, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)

		--draw.DrawText((LocalPlayer():getChar():getData("rep") * 0.001).."%", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 204, 0, 210), TEXT_ALIGN_RIGHT)

		draw.DrawText("0 %", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 204, 0, 210), TEXT_ALIGN_RIGHT)

		draw.DrawText("Отношение:", "Roh10", ScrW() * 0.1, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)
		draw.DrawText((LocalPlayer():getChar():getData("rep") + LocalPlayer():getChar():getData("rank")) * 0.001, "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	end

	local left_bottom = vgui.Create( "DFrame" )
	left_bottom:SetPos(ScrW() * 0.18, ScrH() * 0.455)
	left_bottom:SetSize(ScrW() * 0.212, ScrH() * 0.356)
	left_bottom:SetTitle("")
	left_bottom:ShowCloseButton(false)
	left_bottom:SetDraggable(false)
	left_bottom:MakePopup()

	function left_bottom:Paint( w, h )  --Расположение X Y, Размер W H.
		nut.util.drawBlur(self, 10)

		surface.SetDrawColor(Color( 30, 30, 30, 190))
		surface.DrawRect( 0, 0, w, h )

		surface.SetDrawColor(255, 255, 255, 230) 
		surface.SetMaterial(Material("daui/scrbr.png")) 
		surface.DrawTexturedRect(0, 0, w, h) 

		surface.SetDrawColor(0, 0, 14, 150)
		surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033) 

		surface.SetDrawColor(Color( 30, 30, 30, 190))

		surface.DrawOutlinedRect(0, 0, w, h) --обводка основной панеи

		surface.SetDrawColor(Color( 30, 30, 30, 50))
		surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033) --шапка

		draw.DrawText("Модификации", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT ) --надпись шапки

		surface.SetDrawColor(0, 0, 0, 210)
		surface.DrawRect(ScrW() * 0.055, ScrH() * 0.12, ScrW() * 0.094, ScrH() * 0.0325) --верхняя альфа панелька

		surface.SetDrawColor(0, 0, 0, 210)
		surface.DrawRect(ScrW() * 0.045, ScrH() * 0.1525, ScrW() * 0.114, ScrH() * 0.0325) --нижняя альфа панелька

		draw.DrawText("Не доступно", "Roh20", ScrW() * 0.102, ScrH() * 0.123, Color(255, 255, 255, 210), TEXT_ALIGN_CENTER ) --верхняя альфа надпись

		draw.DrawText("В альфа версии", "Roh20", ScrW() * 0.101, ScrH() * 0.1535, Color(255, 255, 255, 210), TEXT_ALIGN_CENTER ) --нижняя альфа надпись
	end

	self.exit = self:Add("DButton")
	self.exit:SetPos(ScrW() * 0.0525, ScrH() * 0.575)
	self.exit:SetSize( ScrW() * 0.11, ScrH() * 0.0335)
	self.exit:SetText("Выход")
	self.exit:SetFont("Roh20")
	self.exit:SetTextColor(Color(211, 211, 211)) 
	function self.exit:Paint( w, h )
		if self:IsDown() then 
			surface.SetDrawColor(Color( 30, 30, 30, 100))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 0, 0, 0, 235))
			surface.DrawOutlinedRect(0, 0, w, h)
		elseif self:IsHovered() then 
			surface.SetDrawColor(Color( 30, 30, 30, 160))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 0, 0, 0, 235))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
	end
	self.exit.DoClick = function(client)
		self:Close()
		left:Close()
		right:Close()
		left_bottom:Close()

		cost_main_button = nil
		cost_armor_button = nil
		cost_helmet_button = nil
		cost_pistol_button = nil
		cost_siderman_button = nil

		tehnikmodel = nil
		tehnikdesc = nil
		tehnikname = nil

		armor_button_toggled = nil
		main_button_toggled = nil
		second_button_toggled = nil
		pistol_button_toggled = nil
		helmet_button_toggled = nil
		collectgarbage()
	end

	self.main_weapon_model = self:Add("nutItemIcon") --основное оружия
	self.main_weapon_model:SetPos(-ScrW(), ScrH() * 0.08)
	for _, v in pairs(items) do
		if v.category == "Оружие" and v:getData("equip") then
			if v.weaponCategory == "1" then
				self.main_weapon_model:SetModel(v.model, 0)
 				if v.width == 6 and v.height == 1 then
					self.main_weapon_model:SetPos(ScrW() * 0.0115, ScrH() * 0.105)
				elseif v.width == 6 then
					self.main_weapon_model:SetPos(ScrW() * 0.0115, ScrH() * 0.08)
				elseif v.width == 5 and v.height == 1 then
					self.main_weapon_model:SetPos(ScrW() * 0.025, ScrH() * 0.105)
				elseif v.width == 5 then
					self.main_weapon_model:SetPos(ScrW() * 0.025, ScrH() * 0.08)
				elseif v.width == 4 then
					self.main_weapon_model:SetPos(ScrW() * 0.041, ScrH() * 0.08)
				elseif v.width == 3 then
					self.main_weapon_model:SetPos(ScrW() * 0.055, ScrH() * 0.08)
				else
					self.main_weapon_model:SetPos(ScrW() * 0.0115, ScrH() * 0.08)
				end

				self.main_weapon_model:SetSize(ScrW() * v.width * 0.0313, ScrH() * v.height * 0.0505)

				self.main_weapon_model.Icon:SetVisible(false)
				self.main_weapon_model.ExtraPaint = function(self, x, y)
				local exIcon = ikon:getIcon(v.uniqueID)
					if (exIcon) then
						surface.SetMaterial(exIcon)
						surface.SetDrawColor(color_white)
						surface.DrawTexturedRect(0, 0, x, y)

						surface.SetDrawColor(Color( 0, 0, 0, 235))
						surface.DrawOutlinedRect(0, 0, x, y)
					else
						ikon:renderIcon(
							v.uniqueID,
							v.width,
							v.height,
							v.model,
							v.iconCam
						)
					end
				end	
			end
		end
	end

	self.main_plus_model = self:Add("nutItemIcon") --основное оружия
	self.main_plus_model:SetPos(-ScrW(), ScrH() * 0.08)
	for _, v in pairs(items) do
		if v.weaponCategory == "1.5" and v:getData("equip") then
			self.main_plus_model:SetModel(v.model, 0)
			if v.width == 6 and v.height == 1 then
				self.main_plus_model:SetPos(ScrW() * 0.0115, ScrH() * 0.67)
			elseif v.width == 6 then
				self.main_plus_model:SetPos(ScrW() * 0.0115, ScrH() * 0.47)
			elseif v.width == 5 and v.height == 1 then
				self.main_plus_model:SetPos(ScrW() * 0.025, ScrH() * 0.67)
			elseif v.width == 5 then
				self.main_plus_model:SetPos(ScrW() * 0.025, ScrH() * 0.47)
			elseif v.width == 4 then
				self.main_plus_model:SetPos(ScrW() * 0.041, ScrH() * 0.47)
			elseif v.width == 3 then
				self.main_plus_model:SetPos(ScrW() * 0.055, ScrH() * 0.47)
			else
				self.main_plus_model:SetPos(ScrW() * 0.0115, ScrH() * 0.47)
			end
			self.main_plus_model:SetSize(ScrW() * v.width * 0.0318, ScrH() * v.height * 0.0505)
			self.main_plus_model.Icon:SetVisible(false)
			self.main_plus_model.ExtraPaint = function(self, x, y)
			local exIcon = ikon:getIcon(v.uniqueID)
				if (exIcon) then
					surface.SetMaterial(exIcon)
					surface.SetDrawColor(color_white)
					surface.DrawTexturedRect(0, 0, x, y)

					surface.SetDrawColor(Color( 0, 0, 0, 235))
					surface.DrawOutlinedRect(0, 0, x, y)
				else
					ikon:renderIcon(
						v.uniqueID,
						v.width,
						v.height,
						v.model,
						v.iconCam
					)
				end
			end	
		end
	end

	self.second_weapon_model = self:Add("nutItemIcon") --пистолет
	self.second_weapon_model:SetPos(-ScrW(), ScrH() * 0.08)
	for _, v in pairs(items) do
		if v.weaponCategory == "2" and v:getData("equip") then
			self.second_weapon_model:SetModel(v.model, 0)
			self.second_weapon_model:SetPos(ScrW() * 0.1245, ScrH() * 0.358)
			self.second_weapon_model:SetSize(ScrW() * v.width * 0.036, ScrH() * v.height * 0.05)
			self.second_weapon_model.Icon:SetVisible(false)
			self.second_weapon_model.ExtraPaint = function(self, x, y)
			local exIcon = ikon:getIcon(v.uniqueID)
				if (exIcon) then
					surface.SetMaterial(exIcon)
					surface.SetDrawColor(color_white)
					surface.DrawTexturedRect(0, 0, x, y)

					surface.SetDrawColor(Color( 0, 0, 0, 235))
					surface.DrawOutlinedRect(0, 0, x, y)
				else
					ikon:renderIcon(
						v.uniqueID,
						v.width,
						v.height,
						v.model,
						v.iconCam
					)
				end
			end
		end
	end

	self.armor_model = self:Add("nutItemIcon") --броня
	self.armor_model:SetPos(-ScrW(), ScrH() * 0.08)
	for _, v in pairs(items) do
		if v.category == "armor" and v:getData("equip") then
			self.armor_model:SetModel(v.model, 0)
			self.armor_model:SetPos(ScrW() * 0.0247, ScrH() * 0.255 - v.height * 5)
			self.armor_model:SetSize(ScrW() * v.width * 0.036, ScrH() * v.height * 0.06)

			self.armor_model.Icon:SetVisible(false)
			self.armor_model.ExtraPaint = function(self, x, y)
			local exIcon = ikon:getIcon(v.uniqueID)
				if (exIcon) then
					surface.SetMaterial(exIcon)
					surface.SetDrawColor(color_white)
					surface.DrawTexturedRect(0, 0, x, y)

					surface.SetDrawColor(Color( 0, 0, 0, 235))
					surface.DrawOutlinedRect(0, 0, x, y)
				else
					ikon:renderIcon(
						v.uniqueID,
						v.width,
						v.height,
						v.model,
						v.iconCam
					)
				end
			end
		end
	end

	self.helmet_model = self:Add("nutItemIcon") --шлем
	self.helmet_model:SetPos(-ScrW(), ScrH() * 0.08)
	for _, v in pairs(items) do
		if v.category == "Шлем" and v:getData("equip") then
			self.helmet_model:SetModel(v.model, 0)
			self.helmet_model:SetPos(ScrW() * 0.132, ScrH() * 0.224)
			self.helmet_model:SetSize(ScrW() * v.width * 0.028, ScrH() * v.height * 0.041)

			self.helmet_model.Icon:SetVisible(false)
			self.helmet_model.ExtraPaint = function(self, x, y)
			local exIcon = ikon:getIcon(v.uniqueID)
				if (exIcon) then
					surface.SetMaterial(exIcon)
					surface.SetDrawColor(color_white)
					surface.DrawTexturedRect(0, 0, x, y)

					surface.SetDrawColor(Color( 0, 0, 0, 235))
					surface.DrawOutlinedRect(0, 0, x, y)
				else
					ikon:renderIcon(
						v.uniqueID,
						v.width,
						v.height,
						v.model,
						v.iconCam
					)
				end
			end
		end
	end

	self.main_button = self:Add("DButton") --кнопка выбора основного оружия
	self.main_button:SetPos(ScrW() * 0.0115, ScrH() * 0.08)
	self.main_button:SetSize(ScrW() * 0.189, ScrH() * 0.1)
	self.main_button:SetText("")
	self.main_button:SetFont("Roh20")
	self.main_button:SetTextColor(Color(211, 211, 211)) 
	function self.main_button:Paint( w, h )
		if self:GetToggle() then 
			surface.SetDrawColor(Color( 255, 186, 0, 6))
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 186, 0, 12))
			surface.DrawOutlinedRect(0, 0, w, h) 
		end
	end
	self.main_button.DoClick = function(client)
		for _, v in pairs(items) do
			if v.weaponCategory == "1" and v:getData("equip") then
				if self.main_button:GetToggle() then
					self.main_button:SetToggle(false)
					cost_main = cost_main - cost_main_button
					cost_main_button = 0
					--collectgarbage()

					armor_button_toggled = 0
					main_button_toggled = 0
					second_button_toggled = 0
					pistol_button_toggled = 0
					helmet_button_toggled = 0
				else
					self.main_button:SetToggle(true)
					if v:getData("durability") == 100 then
						cost_main_button = 0
					else
						cost_main_button = math.Round(v.price / v:getData("durability") * 10)
					end
					cost_main = cost_main + cost_main_button

					armor_button_toggled = 0
					main_button_toggled = 1
					second_button_toggled = 0
					pistol_button_toggled = 0
					helmet_button_toggled = 0
				end	
			end
		end
	end

	self.armor_button = self:Add("DButton") --кнопка выбора брони
	self.armor_button:SetPos(ScrW() * 0.0115, ScrH() * 0.224)
	self.armor_button:SetSize(ScrW() * 0.1, ScrH() * 0.206)
	self.armor_button:SetText("")
	self.armor_button:SetFont("Roh20")
	self.armor_button:SetTextColor(Color(211, 211, 211)) 
	function self.armor_button:Paint( w, h )
		if self:GetToggle() then 
			surface.SetDrawColor(Color( 255, 186, 0, 6))
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 186, 0, 12))
			surface.DrawOutlinedRect(0, 0, w, h) 
		end
	end
	self.armor_button.DoClick = function(client)
		for _, v in pairs(items) do
			if v.category == "armor" and v:getData("equip") then
				if self.armor_button:GetToggle() then
					self.armor_button:SetToggle(false)
					cost_main = cost_main - cost_armor_button
					cost_armor_button = 0
					armor_button_toggled = 0
					--collectgarbage()

					armor_button_toggled = 0
					main_button_toggled = 0
					second_button_toggled = 0
					pistol_button_toggled = 0
					helmet_button_toggled = 0
				else
					self.armor_button:SetToggle(true)
					if v:getData("durabilityarmor") == 100 then
						cost_armor_button = 0
					else
						cost_armor_button = math.Round(v.price / v:getData("durabilityarmor") * 10)
					end
					cost_main = cost_main + cost_armor_button
					armor_button_toggled = 1

					armor_button_toggled = 1
					main_button_toggled = 0
					second_button_toggled = 0
					pistol_button_toggled = 0
					helmet_button_toggled = 0
				end	
			end
		end
	end

	self.helmet_button = self:Add("DButton") --кнопка выбора шлема
	self.helmet_button:SetPos(ScrW() * 0.12, ScrH() * 0.224)
	self.helmet_button:SetSize(ScrW() * 0.08, ScrH() * 0.082)
	self.helmet_button:SetText("")
	self.helmet_button:SetFont("Roh20")
	self.helmet_button:SetTextColor(Color(211, 211, 211)) 
	function self.helmet_button:Paint( w, h )
		if self:GetToggle() then 
			surface.SetDrawColor(Color( 255, 186, 0, 6))
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 186, 0, 12))
			surface.DrawOutlinedRect(0, 0, w, h) 
		end
	end
	self.helmet_button.DoClick = function(client)
		for _, v in pairs(items) do
			if v.category == "Шлем" and v:getData("equip") then
				if self.helmet_button:GetToggle() then
					self.helmet_button:SetToggle(false)
					cost_main = cost_main - cost_helmet_button
					cost_helmet_button = 0
					--collectgarbage()

					armor_button_toggled = 0
					main_button_toggled = 0
					second_button_toggled = 0
					pistol_button_toggled = 0
					helmet_button_toggled = 0
				else
					self.helmet_button:SetToggle(true)
					if v:getData("durabilityarmor") == 100 then
						cost_helmet_button = 0
					else
						cost_helmet_button = math.Round(v.price / v:getData("durabilityarmor") * 10)
					end
					cost_main = cost_main + cost_helmet_button

					armor_button_toggled = 0
					main_button_toggled = 0
					second_button_toggled = 0
					pistol_button_toggled = 0
					helmet_button_toggled = 1
				end	
			end
		end
	end

	self.pistol_button = self:Add("DButton") --кнопка выбора пистолета
	self.pistol_button:SetPos(ScrW() * 0.12, ScrH() * 0.348)
	self.pistol_button:SetSize(ScrW() * 0.08, ScrH() * 0.082)
	self.pistol_button:SetText("")
	self.pistol_button:SetFont("Roh20")
	self.pistol_button:SetTextColor(Color(211, 211, 211)) 
	function self.pistol_button:Paint( w, h )
		if self:GetToggle() then 
			surface.SetDrawColor(Color( 255, 186, 0, 6))
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 186, 0, 12))
			surface.DrawOutlinedRect(0, 0, w, h) 
		end
	end
	self.pistol_button.DoClick = function(client)
		for _, v in pairs(items) do
			if v.weaponCategory == "2" and v:getData("equip") then
				if self.pistol_button:GetToggle() then
					self.pistol_button:SetToggle(false)
					cost_main = cost_main - cost_pistol_button
					cost_pistol_button = 0
					--collectgarbage()

					armor_button_toggled = 0
					main_button_toggled = 0
					second_button_toggled = 0
					pistol_button_toggled = 0
					helmet_button_toggled = 0
				else
					self.pistol_button:SetToggle(true)
					if v:getData("durability") == 100 then
						cost_pistol_button = 0
					else
						cost_pistol_button = math.Round(v.price / v:getData("durability") * 10)
					end
					cost_main = cost_main + cost_pistol_button

					armor_button_toggled = 0
					main_button_toggled = 0
					second_button_toggled = 0
					pistol_button_toggled = 1
					helmet_button_toggled = 0
				end	
			end
		end
	end

	self.siderman_button = self:Add("DButton") --кнопка выбора вторичного оружия
	self.siderman_button:SetPos(ScrW() * 0.0115, ScrH() * 0.47)
	self.siderman_button:SetSize(ScrW() * 0.189, ScrH() * 0.1)
	self.siderman_button:SetText("")
	self.siderman_button:SetFont("Roh20")
	self.siderman_button:SetTextColor(Color(211, 211, 211)) 
	function self.siderman_button:Paint( w, h )
		if self:GetToggle() then 
			surface.SetDrawColor(Color( 255, 186, 0, 6))
			surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 186, 0, 12))
			surface.DrawOutlinedRect(0, 0, w, h) 
		end
	end
	self.siderman_button.DoClick = function(client)
		for _, v in pairs(items) do
			if v.weaponCategory == "1.5" and v:getData("equip") then
				if self.siderman_button:GetToggle() then
					self.siderman_button:SetToggle(false)
					cost_main = cost_main - cost_siderman_button 
					cost_siderman_button = 0
					--collectgarbage()
				else
					self.siderman_button:SetToggle(true)
					if v:getData("durability") == 100 then
						cost_siderman_button = 0
					else
						cost_siderman_button = math.Round(v.price / v:getData("durability") * 10)
					end
					cost_main = cost_main + cost_siderman_button
				end	
			end
		end
	end

	local reptext = LocalPlayer():getChar():getData("rep")
	local ranktext = LocalPlayer():getChar():getData("rank")

	function right:Paint( w, h )  --Расположение X Y, Размер W H.
		nut.util.drawBlur(self, 10)
		surface.SetDrawColor(Color( 30, 30, 30, 190))
		surface.DrawRect( 0, 0, w, h)
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 14, 150)
		surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033)

		surface.SetDrawColor(Color( 30, 30, 30, 50))
		surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033) --шапка

		surface.SetDrawColor(0, 0, 14, 150)
		surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.0575, ScrW() * 0.085, ScrH() * 0.125) --фон модели игрока

		surface.SetDrawColor(Color( 0, 0, 0, 255))
		surface.DrawOutlinedRect(ScrW() * 0.0115, ScrH() * 0.0575, ScrW() * 0.085, ScrH() * 0.125) --обводка модели игрока

		surface.SetDrawColor( 0, 33, 55, 160)
		surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.2, ScrW() * 0.189, ScrH() * 0.024) --верхняя часть описания пау пау пау

		surface.SetDrawColor(Color( 0, 0, 0, 150))
		surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.224, ScrW() * 0.189, ScrH() * 0.31) --основная часть описания

		surface.SetDrawColor(Color( 0, 0, 0, 235))
		surface.DrawOutlinedRect(ScrW() * 0.0115, ScrH() * 0.2, ScrW() * 0.189, ScrH() * 0.334) --основная обводка описания

		surface.SetDrawColor(Color( 0, 0, 0, 50))
		surface.DrawOutlinedRect(ScrW() * 0.0115, ScrH() * 0.2, ScrW() * 0.189, ScrH() * 0.334) --вторичная обводка описания

		draw.DrawText("Описание предмета", "Roh20", ScrW() * 0.0135, ScrH() * 0.198, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --название шапки описания

		draw.DrawText("Персонаж", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --надпись шапки

		draw.DrawText(LocalPlayer():getChar():getName(), "Roh20", ScrW() * 0.1, ScrH() * 0.06, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)

		draw.DrawText("Фракция:", "Roh10", ScrW() * 0.1, ScrH() * 0.09, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --team.GetColor(character:getFaction()) Фракция
		draw.DrawText(team.GetName(LocalPlayer():Team()), "Roh10", ScrW() * 0.2, ScrH() * 0.09, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)

		draw.DrawText("Деньги:", "Roh10", ScrW() * 0.1, ScrH() * 0.111, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --Деньги
		draw.DrawText(LocalPlayer():getChar():getMoney().." ₽", "Roh10", ScrW() * 0.2, ScrH() * 0.111, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)

		draw.DrawText("Ранг:", "Roh10", ScrW() * 0.1, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --Ранг

		if (ranktext >= 12000) then
			draw.DrawText("Легенда", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		elseif (ranktext >= 5200 and ranktext <= 11999) then
			draw.DrawText("Мастер", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		elseif (ranktext >= 3200 and ranktext <= 5199) then
			draw.DrawText("Эксперт", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		elseif (ranktext >= 2000 and ranktext <= 3199) then
			draw.DrawText("Ветеран", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		elseif (ranktext >= 1000 and ranktext <= 1999) then
			draw.DrawText("Профессионал", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		elseif (ranktext >= 600 and ranktext <= 999) then
			draw.DrawText("Опытный", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		elseif (ranktext >= 200 and ranktext <= 599) then
			draw.DrawText("Стажер", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		elseif (ranktext <= 199) then
			draw.DrawText("Новичок", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		end

		draw.DrawText("Репутация:", "Roh10", ScrW() * 0.1, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --Репутация

		if (reptext >= 2000) then
			draw.DrawText("Великолепно", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		elseif (reptext >= 1000 and reptext <= 1999) then
			draw.DrawText("Отлично", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		elseif (reptext >= 500 and reptext <= 999) then
			draw.DrawText("Оч.Хорошо", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext > 100 and reptext <= 499) then
			draw.DrawText("Хорошо", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		elseif (reptext >= -29 and reptext <= 99) then
			draw.DrawText("Безразлично", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		elseif (reptext >= -79 and reptext <= -30) then
			draw.DrawText("Плохо", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		elseif (reptext >= -299 and reptext <= -80) then
			draw.DrawText("Оч.Плохо", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		elseif (reptext >= -599 and reptext <= -300) then
			draw.DrawText("Ужасно", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		elseif (reptext <= -600) then
			draw.DrawText("Хуже всех", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		end

		surface.SetDrawColor(Color(0, 0, 14, 150))
		surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.543, ScrW() * 0.189, ScrH() * 0.0325) --панель веса

		draw.DrawText("Общий вес: "..LocalPlayer():GetWeight().." кг (max"..nut.config.get("maxWeight") + LocalPlayer():GetWeightAddition().." кг)", "Roh10", ScrW() * 0.016, ScrH() * 0.547, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)
	end

	function self:Paint( w, h )  --Расположение X Y, Размер W H.
		nut.util.drawBlur(self, 10)
		surface.SetDrawColor(Color( 30, 30, 30, 190))
		surface.DrawRect( 0, 0, w, h )
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 14, 150)
		surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033)

		surface.SetDrawColor(Color( 30, 30, 30, 50))
		surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033) --шапка

		draw.DrawText("Экпипировка", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT ) --надпись шапки

		surface.SetDrawColor(Color( 0, 33, 55, 160))
		surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.057, ScrW() * 0.189, ScrH() * 0.024) --верхняя панель основного оружия

		for _, v in pairs(items) do
			if v.weaponCategory == "1" and v:getData("equip") then
				surface.SetDrawColor( Color(80, 80, 80, 160) )
				surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.057, ScrW() * (v:getData("durability")) / 1000 * 1.885, ScrH() * 0.024) --индикатор состояния шлема
			end
		end

		surface.SetDrawColor(Color( 0, 0, 0, 200))
		surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.08, ScrW() * 0.189, ScrH() * 0.1) --основная панель основного оружия

		surface.SetDrawColor(Color( 0, 0, 0, 235))
		surface.DrawOutlinedRect(ScrW() * 0.0115, ScrH() * 0.0575, ScrW() * 0.189, ScrH() * 0.125) --основная обводка

		surface.SetDrawColor(Color( 0, 0, 0, 50))
		surface.DrawOutlinedRect(ScrW() * 0.011, ScrH() * 0.0575, ScrW() * 0.18915, ScrH() * 0.1265) --вторичная обводка

		draw.DrawText("Основное", "Roh20", ScrW() * 0.102, ScrH() * 0.0555, Color(255, 255, 255, 210), TEXT_ALIGN_CENTER ) --надпись основного оружия

		surface.SetDrawColor(Color( 0, 33, 55, 160))
		surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.2, ScrW() * 0.1, ScrH() * 0.024) --верхняя панель брони

		for _, v in pairs(items) do
			if v.category == "armor" and v:getData("equip") then
				surface.SetDrawColor( Color(80, 80, 80, 160) )
				surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.2, math.Clamp((ScrW() * (v:getData("durabilityarmor")) / 1000 * 1.25), 0, ScrW() * 0.1), ScrH() * 0.024) --индикатор состояния шлема
			end
		end

		draw.DrawText("Комбинезон", "Roh20", ScrW() * 0.062, ScrH() * 0.198, Color(255, 255, 255, 210), TEXT_ALIGN_CENTER ) --надпись на верхней панели брони

		surface.SetDrawColor(Color( 0, 0, 0, 150))
		surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.224, ScrW() * 0.1, ScrH() * 0.206) --основная панель брони

		surface.SetDrawColor(Color( 0, 0, 0, 235))
		surface.DrawOutlinedRect(ScrW() * 0.0115, ScrH() * 0.2, ScrW() * 0.1, ScrH() * 0.23) --основная обводка брони ?

		surface.SetDrawColor(Color( 0, 0, 0, 50))
		surface.DrawOutlinedRect(ScrW() * 0.0115, ScrH() * 0.2, ScrW() * 0.1, ScrH() * 0.23) --вторичная обводка брони ?

		surface.SetDrawColor(Color( 0, 33, 55, 160))
		surface.DrawRect(ScrW() * 0.12, ScrH() * 0.2, ScrW() * 0.08, ScrH() * 0.024) --верхняя панель шлема


		for _, v in pairs(items) do
			if v.category == "Шлем" and v:getData("equip") then
				surface.SetDrawColor( Color(80, 80, 80, 160) )
				surface.DrawRect(ScrW() * 0.12, ScrH() * 0.2, ScrW() * (v:getData("durabilityarmor")) / 1000 * 0.8, ScrH() * 0.024) --индикатор состояния шлема
			end
		end

		draw.DrawText("Шлем", "Roh20", ScrW() * 0.16, ScrH() * 0.198, Color(255, 255, 255, 210), TEXT_ALIGN_CENTER ) --надпись на верхней панели шлема

		surface.SetDrawColor(Color( 0, 0, 0, 150))
		surface.DrawRect(ScrW() * 0.12, ScrH() * 0.224, ScrW() * 0.08, ScrH() * 0.082) --основная панель шлема

		surface.SetDrawColor(Color( 0, 0, 0, 235))
		surface.DrawOutlinedRect(ScrW() * 0.12, ScrH() * 0.2, ScrW() * 0.08, ScrH() * 0.105) --основная обводка пистолета

		surface.SetDrawColor(Color( 0, 0, 0, 50))
		surface.DrawOutlinedRect(ScrW() * 0.12, ScrH() * 0.2, ScrW() * 0.0815, ScrH() * 0.1075) --вторичная обводка пистолета

		surface.SetDrawColor(Color( 0, 33, 55, 160))
		surface.DrawRect(ScrW() * 0.12, ScrH() * 0.325, ScrW() * 0.08, ScrH() * 0.024) --верхняя панель пистолета

		for _, v in pairs(items) do
			if v.weaponCategory == "2" and v:getData("equip") then
				surface.SetDrawColor( Color(80, 80, 80, 160) )
				surface.DrawRect(ScrW() * 0.12, ScrH() * 0.325, ScrW() * (v:getData("durability")) / 1000 * 0.8, ScrH() * 0.024) --индикатор состояния шлема
			end
		end

		draw.DrawText("Пистолет", "Roh20", ScrW() * 0.16, ScrH() * 0.322, Color(255, 255, 255, 210), TEXT_ALIGN_CENTER ) --надпись на верхней панели пистолета

		surface.SetDrawColor(Color( 0, 0, 0, 150))
		surface.DrawRect(ScrW() * 0.12, ScrH() * 0.348, ScrW() * 0.08, ScrH() * 0.082) --основная панель пистолета

		surface.SetDrawColor(Color( 0, 0, 0, 235))
		surface.DrawOutlinedRect(ScrW() * 0.12, ScrH() * 0.324, ScrW() * 0.08, ScrH() * 0.105) --основная обводка пистолета

		surface.SetDrawColor(Color( 0, 0, 0, 50))
		surface.DrawOutlinedRect(ScrW() * 0.12, ScrH() * 0.324, ScrW() * 0.0815, ScrH() * 0.1075) --вторичная обводка пистолета

		surface.SetDrawColor(Color( 0, 33, 55, 160))
		surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.447, ScrW() * 0.189, ScrH() * 0.024) --верхняя панель дополнительного оружия

		for _, v in pairs(items) do
			if v.weaponCategory == "1.5" and v:getData("equip") then
				surface.SetDrawColor( Color(80, 80, 80, 160) )
				surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.447, ScrW() * (v:getData("durability")) / 1000 * 1.885, ScrH() * 0.024) --индикатор состояния шлема
			end
		end

		surface.SetDrawColor(Color( 0, 0, 0, 200))
		surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.47, ScrW() * 0.189, ScrH() * 0.1) --основная панель дополнительного оружия

		surface.SetDrawColor(Color( 0, 0, 0, 235))
		surface.DrawOutlinedRect(ScrW() * 0.0115, ScrH() * 0.446, ScrW() * 0.189, ScrH() * 0.125) --основная обводка дополнительного оружия

		surface.SetDrawColor(Color( 0, 0, 0, 50))
		surface.DrawOutlinedRect(ScrW() * 0.011, ScrH() * 0.446, ScrW() * 0.18915, ScrH() * 0.1265) --вторичная обводка дополнительного оружия

		draw.DrawText("Дополнительное", "Roh20", ScrW() * 0.102, ScrH() * 0.444, Color(255, 255, 255, 210), TEXT_ALIGN_CENTER ) --надпись основного оружия

		surface.SetDrawColor( Color(125, 105, 0, 40) )
		surface.SetMaterial( Material("lgh/circle_gradient.png") )
		surface.DrawTexturedRectUV( -ScrW() * 0.03, ScrH() * 0.587, ScrW() * 0.3, ScrH() * 0.032, 1, 0.9, 0, 0.3 )
	end
end

function PANEL:SetEntity( ent )
	self.name = ent:getNetVar( "name", "Техник" )
	self.desc = ent:getNetVar( "desc", "Одиночки" )
end

vgui.Register("fixmygearplz_tehnik", PANEL, "DFrame")
netstream.Hook("fixmygearplz_tehnik", function()
	fixmygearplz_tehnik = vgui.Create("fixmygearplz_tehnik")
end)

--[[function PLUGIN:ShouldDrawTargetEntity(entity)
	if (string.lower(entity:GetClass()) == "nut_talker") then
		return true
	end
end

function PLUGIN:DrawTargetID(entity, x, y, alpha)
	if (string.lower(entity:GetClass()) == "nut_talker") then
		talkername = entity:getNetVar("name", "John Doe")
		talkerdesc = entity:getNetVar("desc", nut.lang.Get("no_desc"))
		talkermodel = entity:GetModel()
	end
end]]