local PANEL = {}
	function PANEL:Init()
		--imhere = 0

		self:SetSize(ScrW() * 0.33, ScrH() * 0.61)
		self:SetTitle("")
		self:MakePopup()
		self:SetPos(ScrW() * 0.33, ScrH() * 0.2)
		self:ShowCloseButton(false)
		self:SetDraggable(false)

		local left = vgui.Create( "DFrame" )
		left:SetPos(ScrW() * 0.111, ScrH() * 0.2)
		left:SetSize(ScrW() * 0.212, ScrH() * 0.24)
		left:SetTitle("")
		left:ShowCloseButton(false)
		left:SetDraggable(false)
		left:MakePopup()

		local left_bottom = vgui.Create( "DFrame" )
		left_bottom:SetPos(ScrW() * 0.111, ScrH() * 0.455)
		left_bottom:SetSize(ScrW() * 0.212, ScrH() * 0.356)
		left_bottom:SetTitle("")
		left_bottom:ShowCloseButton(false)
		left_bottom:SetDraggable(false)
		left_bottom:MakePopup()

		function left_bottom:Paint( w, h )  --Расположение X Y, Размер W H.
			nut.util.drawBlur(self, 10)
			surface.SetDrawColor(Color( 30, 30, 30, 190))
			surface.DrawRect( 0, 0, w, h)
			surface.DrawOutlinedRect(0, 0, w, h)

			surface.SetDrawColor(255, 255, 255, 230) 
			surface.SetMaterial(Material("daui/scrbr.png")) 
			surface.DrawTexturedRect(0, 0, w, h) 

			surface.SetDrawColor(0, 0, 14, 150)
			surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033)

			surface.SetDrawColor(Color( 30, 30, 30, 50))
			surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033) --шапка

			draw.DrawText("Обмен", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --надпись шапки

			surface.SetDrawColor(0, 0, 0, 210)
			surface.DrawRect(ScrW() * 0.055, ScrH() * 0.12, ScrW() * 0.094, ScrH() * 0.0325) --верхняя альфа панелька

			surface.SetDrawColor(0, 0, 0, 210)
			surface.DrawRect(ScrW() * 0.045, ScrH() * 0.1525, ScrW() * 0.114, ScrH() * 0.0325) --нижняя альфа панелька

			draw.DrawText("Не доступно", "Roh20", ScrW() * 0.102, ScrH() * 0.123, Color(255, 255, 255, 210), TEXT_ALIGN_CENTER ) --верхняя альфа надпись

			draw.DrawText("В альфа версии", "Roh20", ScrW() * 0.101, ScrH() * 0.1535, Color(255, 255, 255, 210), TEXT_ALIGN_CENTER ) --нижняя альфа надпись
		end



		left.buy = left:Add("DButton")
		left.buy:SetSize( ScrW() * 0.085, ScrH() * 0.0325)
		left.buy:SetPos(ScrW() * 0.0115, ScrH() * 0.187)
		left.buy:SetText("Купить")
		left.buy:SetFont("Roh20")
		left.buy:SetTextColor(Color(255, 255, 255, 210))
		left.buy.DoClick = function(client)
			if (IsValid(self.activeSell)) then
				netstream.Start("vendorTrade", self.activeSell.item)
			end
		end

		--[[function left.buy:Think()
			if ((self.nextUpdaterightleftbuy or 0) < CurTime()) then
				if imhere == 0 then
					left.buy:SetText("Купить")
				elseif imhere == 1 then
					left.buy:SetText("Обменять")
				end
			self.nextUpdaterightleftbuy = CurTime() + 0.4
			end
		end]]

		function left.buy:Paint( w, h )
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
			surface.DrawRect( 0, 0, w, h)
			surface.DrawOutlinedRect(0, 0, w, h)

			surface.SetDrawColor(0, 0, 14, 150)
			surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033)

			surface.SetDrawColor(Color( 30, 30, 30, 50))
			surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033) --шапка

			draw.DrawText("Торговец", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --надпись шапки

			surface.SetDrawColor(0, 0, 14, 150)
			surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.0575, ScrW() * 0.085, ScrH() * 0.125) --фон модели игрока

			surface.SetDrawColor(Color( 0, 0, 0, 255))
			surface.DrawOutlinedRect(ScrW() * 0.0115, ScrH() * 0.0575, ScrW() * 0.085, ScrH() * 0.125) --обводка модели игрока

			surface.SetDrawColor(0, 0, 14, 150)
			surface.DrawRect(ScrW() * 0.1, ScrH() * 0.187, ScrW() * 0.1, ScrH() * 0.0325) --информация о предмете

			if (namevendor) then
				draw.DrawText(namevendor, "Roh20", ScrW() * 0.1, ScrH() * 0.06, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)
			end

			if (buyprice and buyweight) then
				draw.DrawText(buyprice..buyweight, "Roh10", ScrW() * 0.105, ScrH() * 0.193, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)
			else
				draw.DrawText("0₽ (0кг)", "Roh10", ScrW() * 0.105, ScrH() * 0.193, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)
			end
			
			draw.DrawText("Фракция:", "Roh10", ScrW() * 0.1, ScrH() * 0.09, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --team.GetColor(character:getFaction())
			if (descvendor) then
				draw.DrawText(descvendor, "Roh10", ScrW() * 0.2, ScrH() * 0.09, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			end

			draw.DrawText("Деньги:", "Roh10", ScrW() * 0.1, ScrH() * 0.111, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)
			if (moneyvendor) then
				draw.DrawText(moneyvendor.."₽", "Roh10", ScrW() * 0.2, ScrH() * 0.111, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			end

			draw.DrawText("Скидка:", "Roh10", ScrW() * 0.1, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)

			--draw.DrawText((LocalPlayer():getChar():getData("rep") * 0.001).."%", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 204, 0, 210), TEXT_ALIGN_RIGHT)
			draw.DrawText("0 %", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 204, 0, 210), TEXT_ALIGN_RIGHT)

			draw.DrawText("Отношение:", "Roh10", ScrW() * 0.1, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)
			--if (relation) then
			draw.DrawText((LocalPlayer():getChar():getData("rep") + LocalPlayer():getChar():getData("rank")) * 0.001, "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			--end

			--[[surface.SetDrawColor(Color(0, 0, 14, 150))
			surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.543, ScrW() * 0.189, ScrH() * 0.0325) --панель веса


			if (vweight) then
				draw.DrawText("Общий вес: "..vweight.." кг", "Roh10", ScrW() * 0.016, ScrH() * 0.547, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)
			end


			surface.SetDrawColor( 0, 33, 55, 160)
			surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.235, ScrW() * 0.189, ScrH() * 0.024) --верхняя часть описания

			surface.SetDrawColor(Color( 0, 0, 0, 150))
			surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.258, ScrW() * 0.189, ScrH() * 0.27) --основная часть описания

			surface.SetDrawColor(Color( 0, 0, 0, 235))
			surface.DrawOutlinedRect(ScrW() * 0.0115, ScrH() * 0.235, ScrW() * 0.189, ScrH() * 0.294) --основная обводка описания

			surface.SetDrawColor(255, 255, 255, 190)
			surface.SetMaterial(Material("daui/scrbr_3.png")) 
			surface.DrawTexturedRect(ScrW() * 0.0115, ScrH() * 0.258, ScrW() * 0.189, ScrH() * 0.27)
			

			surface.SetDrawColor(Color( 0, 0, 0, 50))
			surface.DrawOutlinedRect(ScrW() * 0.0115, ScrH() * 0.235, ScrW() * 0.189, ScrH() * 0.294) --вторичная обводка описания

			draw.DrawText("Обмен", "Roh20", ScrW() * 0.0135, ScrH() * 0.233, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --название шапки описания]]
		end

		--Начало обмена

		--local counttrade = LocalPlayer():getChar():getInv():getItemCount(v)

		--nut.item.list[uniqueID]

	
		--[[left.tradescroll = left:Add("DScrollPanel")
		left.tradescroll:SetPos(ScrW() * 0.0115, ScrH() * 0.258)
		left.tradescroll:SetSize(ScrW() * 0.189, ScrH() * 0.27)
		left.tradescroll:SetDrawBackground(false)

		left.tradingitems = left.tradescroll:Add("DListLayout")
		left.tradingitems:SetSize(left.tradescroll:GetSize())
		left.tradingitems:DockPadding(0, 0, 0, 4)
		left.tradingitems:SetTall(ScrH()) --кек

		left.dlabeltrade = left.tradingitems:Add("DPanel")
		left.dlabeltrade:SetTall(36)
		left.dlabeltrade:SetText("")
		left.dlabeltrade:DockMargin(4, 4, 4, 0)


		left.icon = left.dlabeltrade:Add("SpawnIcon")
		left.icon:SetPos(2, 2)
		left.icon:SetSize(32, 32)
		left.icon:SetModel("models/error.mdl")

		left.name = left.dlabeltrade:Add("DLabel")
		left.name:Dock(FILL)
		left.name:DockMargin(42, 0, 0, 0)
		left.name:SetFont("Roh14")

		local trades = {}
		trades['pm'] = 'cheizer'

		local item = 'pm'

		left.name:SetTextColor(color_white)
		left.name:SetExpensiveShadow(1, Color(0, 0, 0, 200))

		left.click = left.dlabeltrade:Add("DButton")
		left.click:Dock(FILL)
		left.click:SetText("")
		left.click.Paint = function() end
		left.click.DoClick = function(this)
			left.click:SetToggle(true)
			for v, k in pairs(nut.item.list) do
				LocalPlayer():ConCommand('say trade '..v)
			end
		end

		function left.dlabeltrade:Paint(w, h)
			if left.click:GetToggle() then

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

		local sbar = left.tradescroll:GetVBar()
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
		end ]]

		--Конец обмена

		left.icon = left:Add("nutModelPanel")
		timer.Simple(1, function()
			if (modelvendor) then
				left.icon:SetModel(modelvendor)
				function left.icon:LayoutEntity( Entity ) return end
				local headpos = left.icon.Entity:GetBonePosition( left.icon.Entity:LookupBone("bip01_head"))

				left.icon:SetLookAt(headpos)
				left.icon:SetCamPos(headpos-Vector( -18, 2.5, 4 ))
				left.icon:SetFOV(70)
			end
		end)
		left.icon:SetSize(ScrW() * 0.085, ScrH() * 0.121)
		left.icon:SetPos(ScrW() * 0.0115, ScrH() * 0.06)

		local right = vgui.Create( "DFrame" )
		right:SetPos(ScrW() * 0.668, ScrH() * 0.2)
		right:SetSize(ScrW() * 0.212, ScrH() * 0.61)
		right:SetTitle("")
		right:ShowCloseButton(false)
		right:SetDraggable(false)
		right:MakePopup()

		right.sell = right:Add("DButton")
		right.sell:SetSize( ScrW() * 0.085, ScrH() * 0.0325)
		right.sell:SetPos(ScrW() * 0.0115, ScrH() * 0.187)
		right.sell:SetText("Продать")
		right.sell:SetFont("Roh20")
		right.sell:SetTextColor(Color(255, 255, 255, 210)) 
		right.sell.DoClick = function(client)
			if (IsValid(self.activeBuy)) then
				netstream.Start("vendorTrade", self.activeBuy.item, true)
			end
		end

		function right.sell:Paint( w, h )
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

		right.icon = right:Add("nutModelPanel")
		right.icon:SetSize(ScrW() * 0.085, ScrH() * 0.121)
		right.icon:SetPos(ScrW() * 0.0115, ScrH() * 0.06)
		timer.Simple(1, function()
			if (playermodel) then
				right.icon:SetModel(playermodel)

				function right.icon:LayoutEntity( Entity ) return end
				local headpos = right.icon.Entity:GetBonePosition( right.icon.Entity:LookupBone("bip01_head"))

				right.icon:SetLookAt(headpos)
				right.icon:SetCamPos(headpos-Vector( -18, 2.5, 4 ))
				right.icon:SetFOV(70)
			end
		end)

		right.dscrolldesc = right:Add("DScrollPanel")
		right.dscrolldesc:SetSize(ScrW() * 0.189, ScrH() * 0.27)
		right.dscrolldesc:SetPos(ScrW() * 0.0115, ScrH() * 0.258)
		right.dscrolldesc:SetDrawBackground(false)

		local sbar = right.dscrolldesc:GetVBar()
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

		right.dpaneldesc = right.dscrolldesc:Add("DLabel")
		right.dpaneldesc:SetSize(ScrW() * 0.189, ScrH() * 1)
		right.dpaneldesc:SetText("")
		function right.dpaneldesc:Paint( w, h )

			if (itemname) then
				if (itemheight == 1) then
					draw.DrawText(itemname, "Roh10", ScrW() * 0.09, ScrH() * 0.07, Color(255, 255, 255, 210), TEXT_ALIGN_CENTER)
				elseif (itemheight == 2) then
					draw.DrawText(itemname, "Roh10", ScrW() * 0.09, ScrH() * 0.12, Color(255, 255, 255, 210), TEXT_ALIGN_CENTER)
				elseif (itemheight == 3) then
					draw.DrawText(itemname, "Roh10", ScrW() * 0.09, ScrH() * 0.17, Color(255, 255, 255, 210), TEXT_ALIGN_CENTER)
				end
			end

			local x, y = ScrW() * 0, ScrH() * 0.15 
			if (itemdesc) then
				if (itemheight == 1) then
					local lines = nut.util.wrapText(itemdesc, ScrW() * 0.142, "Roh10")
					for i = 1, #lines do
						y = ScrH() * 0.07 + (i * 18) 
						nut.util.drawText(lines[i], x, y, color_white, ScrW() * 0.001, ScrH() * 0.13, "Roh10", TEXT_ALIGN_LEFT) 
					end
				elseif (itemheight == 2) then
					local lines = nut.util.wrapText(itemdesc, ScrW() * 0.142, "Roh10")
					for i = 1, #lines do
						y = ScrH() * 0.115 + (i * 18) 
						nut.util.drawText(lines[i], x, y, color_white, ScrW() * 0.001, ScrH() * 0.1, "Roh10", TEXT_ALIGN_LEFT) 
					end
				elseif (itemheight == 3) then
					local lines = nut.util.wrapText(itemdesc, ScrW() * 0.142, "Roh10")
					for i = 1, #lines do
						y = ScrH() * 0.17 + (i * 18) 
						nut.util.drawText(lines[i], x, y, color_white, ScrW() * 0.001, ScrH() * 0.1, "Roh10", TEXT_ALIGN_LEFT) 
					end
				else
					local lines = nut.util.wrapText(itemdesc, ScrW() * 0.142, "Roh10")
					for i = 1, #lines do
						y = ScrH() * 0.07 + (i * 18) 
						nut.util.drawText(lines[i], x, y, color_white, ScrW() * 0.001, ScrH() * 0.1, "Roh10", TEXT_ALIGN_LEFT) 
					end
				end
			end
		end 

		right.icon_desc = right.dpaneldesc:Add("nutItemIcon") --иконка описания
		right.icon_desc:SetSize(0, 0)
		right.icon_desc.Icon:SetVisible(false)

		self.exit = self:Add("DButton")
		self.exit:SetPos(ScrW() * 0.105, ScrH() * 0.576)
		self.exit:SetSize( ScrW() * 0.11, ScrH() * 0.0325)
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

			sellprice = nil
			buyprice = nil
			namevendor = nil
			modelvendor = nil
			descvendor = nil
			discount = nil
			price = nil
			relation = nil
			playermodel = nil

			sellweight = nil
			buyweight = nil

			--vweight = nil
			--imhere = nil

			itemuniqueID = nil
			itemwidth = nil
			itemheight = nil
			itemiconCam = nil
			itemdesc = nil
			itemmodel = nil
			itemname = nil
			collectgarbage()
		end

		local reptext = LocalPlayer():getChar():getData("rep")
		local ranktext = LocalPlayer():getChar():getData("rank")

		function right:Think()
			if ((self.nextUpdateright or 0) < CurTime()) then
				if (itemname and itemmodel and itemdesc and itemdesc and itemiconCam and itemheight and itemwidth and itemuniqueID) then
					right.icon_desc:SetModel(itemmodel, 0)
					right.icon_desc:SetSize(ScrW() * itemwidth * 0.03, ScrH() * itemheight * 0.0505)

					if (itemwidth == 1) then
						right.icon_desc:SetPos(ScrW() * 0.075, ScrH() * 0.02)
					elseif (itemwidth == 2) then
						right.icon_desc:SetPos(ScrW() * 0.06, ScrH() * 0.02)
					elseif (itemwidth == 3) then
						right.icon_desc:SetPos(ScrW() * 0.044, ScrH() * 0.02)
					elseif (itemwidth == 4) then
						right.icon_desc:SetPos(ScrW() * 0.031, ScrH() * 0.02)
					elseif (itemwidth == 5) then
						right.icon_desc:SetPos(ScrW() * 0.0185, ScrH() * 0.02)
					elseif (itemwidth == 6) then
						right.icon_desc:SetPos(ScrW() * 0.003, ScrH() * 0.02)
					end
					right.icon_desc.ExtraPaint = function(self, x, y)
					local exIcon = ikon:getIcon(itemuniqueID)
						if (exIcon) then
							surface.SetMaterial(exIcon)
							surface.SetDrawColor(color_white)
							surface.DrawTexturedRect(0, 0, x, y)

							surface.SetDrawColor(Color( 0, 0, 0, 235))
							surface.DrawOutlinedRect(0, 0, x, y)
						else
								ikon:renderIcon(
								itemuniqueID,
								itemwidth,
								itemheight,
								itemmodel,
								itemiconCam
							)
						end
					end
				end
				self.nextUpdateright = CurTime() + 0.4
			end
		end

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
			surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.235, ScrW() * 0.189, ScrH() * 0.024) --верхняя часть описания

			surface.SetDrawColor(Color( 0, 0, 0, 150))
			surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.258, ScrW() * 0.189, ScrH() * 0.27) --основная часть описания

			surface.SetDrawColor(Color( 0, 0, 0, 235))
			surface.DrawOutlinedRect(ScrW() * 0.0115, ScrH() * 0.235, ScrW() * 0.189, ScrH() * 0.294) --основная обводка описания

			surface.SetDrawColor(Color( 0, 0, 0, 50))
			surface.DrawOutlinedRect(ScrW() * 0.0115, ScrH() * 0.235, ScrW() * 0.189, ScrH() * 0.294) --вторичная обводка описания

			draw.DrawText("Описание предмета", "Roh20", ScrW() * 0.0135, ScrH() * 0.233, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --название шапки описания

			draw.DrawText("Персонаж", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --надпись шапки

			draw.DrawText(LocalPlayer():getChar():getName(), "Roh20", ScrW() * 0.1, ScrH() * 0.06, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)

			draw.DrawText("Фракция:", "Roh10", ScrW() * 0.1, ScrH() * 0.09, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --team.GetColor(character:getFaction()) Фракция
			draw.DrawText(team.GetName(LocalPlayer():Team()), "Roh10", ScrW() * 0.2, ScrH() * 0.09, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)

			draw.DrawText("Деньги:", "Roh10", ScrW() * 0.1, ScrH() * 0.111, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --Деньги
			draw.DrawText(LocalPlayer():getChar():getMoney().." ₽", "Roh10", ScrW() * 0.2, ScrH() * 0.111, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)

			draw.DrawText("Ранг:", "Roh10", ScrW() * 0.1, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --Ранг

			if (ranktext > 12000) then
				draw.DrawText("Легенда", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (ranktext > 5200 and ranktext < 11999) then
				draw.DrawText("Мастер", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (ranktext > 3200 and ranktext < 5199) then
				draw.DrawText("Эксперт", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (ranktext > 2000 and ranktext < 3199) then
				draw.DrawText("Ветеран", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (ranktext > 1000 and ranktext < 1999) then
				draw.DrawText("Профессионал", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (ranktext > 600 and ranktext < 999) then
				draw.DrawText("Опытный", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (ranktext > 200 and ranktext < 599) then
				draw.DrawText("Стажер", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (ranktext < 199) then
				draw.DrawText("Новичок", "Roh10", ScrW() * 0.2, ScrH() * 0.132, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			end

			draw.DrawText("Репутация:", "Roh10", ScrW() * 0.1, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --Репутация

			if (reptext > 2000) then
				draw.DrawText("Великолепно", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext > 1000 and reptext < 1999) then
				draw.DrawText("Отлично", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext > 500 and reptext < 999) then
				draw.DrawText("Оч.Хорошо", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext > 100 and reptext < 499) then
				draw.DrawText("Хорошо", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext > -29 and reptext < 99) then
				draw.DrawText("Безразлично", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext > -79 and reptext < -30) then
				draw.DrawText("Плохо", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext > -299 and reptext < -80) then
				draw.DrawText("Оч.Плохо", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext > -599 and reptext < -300) then
				draw.DrawText("Ужасно", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext < -600) then
				draw.DrawText("Хуже всех", "Roh10", ScrW() * 0.2, ScrH() * 0.152, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			end

			surface.SetDrawColor(0, 0, 14, 150)
			surface.DrawRect(ScrW() * 0.1, ScrH() * 0.187, ScrW() * 0.1, ScrH() * 0.0325) --информация о предмете

			if (sellprice and sellweight) then
				draw.DrawText(sellprice..sellweight, "Roh10", ScrW() * 0.105, ScrH() * 0.193, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --цена предмета
			else
				draw.DrawText("0₽ (0кг)", "Roh10", ScrW() * 0.105, ScrH() * 0.193, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)
			end

			surface.SetDrawColor(Color(0, 0, 14, 150))
			surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.543, ScrW() * 0.189, ScrH() * 0.0325) --панель веса

			draw.DrawText("Общий вес: "..LocalPlayer():GetWeight().." кг (max"..nut.config.get("maxWeight") + LocalPlayer():GetWeightAddition().." кг)", "Roh10", ScrW() * 0.016, ScrH() * 0.547, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)
		end

		self.selling = self:Add("DScrollPanel")
		self.selling:SetPos(ScrW() * 0.013,ScrH() * 0.0811)
		self.selling:SetSize(ScrW()*0.1525, ScrH()*0.494)
		self.selling:SetDrawBackground(true)

		local sbar = self.selling:GetVBar()
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
		
		self.sellingItems = self.selling:Add("DListLayout")
		self.sellingItems:SetSize(self.selling:GetSize())
		self.sellingItems:DockPadding(0, 0, 0, 4)
		self.sellingItems:SetTall(ScrH())

		self.buying = self:Add("DScrollPanel")
		self.buying:SetPos(ScrW() * 0.165,ScrH() * 0.0811)
		self.buying:SetSize(ScrW()*0.1525, ScrH()*0.494)
		self.buying:SetDrawBackground(true)

		local sbar_second = self.selling:GetVBar()
		function sbar_second:Paint( w, h ) --рисуем скролл
			surface.SetDrawColor(Color( 30, 30, 30, 200))
			surface.DrawRect(0, 0, w, h)
		end
		function sbar_second.btnUp:Paint( w, h )
			surface.SetDrawColor(Color( 0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)
		end
		function sbar_second.btnDown:Paint( w, h )
			surface.SetDrawColor(Color( 0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)
		end
		function sbar_second.btnGrip:Paint( w, h )
			surface.SetDrawColor(Color( 60, 60, 60, 200))
			surface.DrawRect(0, 0, w, h)
		end 

		self.buyingItems = self.buying:Add("DListLayout")
		self.buyingItems:SetSize(self.buying:GetSize())
		self.buyingItems:DockPadding(0, 0, 0, 4)

		self.sellingList = {}
		self.buyingList = {}
	end

	function PANEL:addItem(uniqueID, listID)
		local entity = self.entity
		local items = entity.items
		local data = items[uniqueID]

		if ((!listID or listID == "selling") and !IsValid(self.sellingList[uniqueID])) then
		--	if (data and data[VENDOR_MODE] and data[VENDOR_MODE] != VENDOR_BUYONLY) then
				local item = self.sellingItems:Add("nutVendorItem")
				item:setup(uniqueID)

				self.sellingList[uniqueID] = item
				self.sellingItems:InvalidateLayout()
		--	end
		end

		if ((!listID or listID == "buying") and !IsValid(self.buyingList[uniqueID]) and LocalPlayer():getChar():getInv():hasItem(uniqueID)) then
			if (data and data[VENDOR_MODE] and data[VENDOR_MODE] != VENDOR_SELLONLY) then
				local item = self.buyingItems:Add("nutVendorItem")
				item:setup(uniqueID)
				item.isLocal = true

				self.buyingList[uniqueID] = item
				self.buyingItems:InvalidateLayout()
			end
		end
	end
	
	local activePanels = {}
	
	function PANEL:Paint(w, h) --раскрашиваем основую панель
		nut.util.drawBlur(self, 10)
		surface.SetDrawColor(Color( 30, 30, 30, 190))
		surface.DrawRect( 0, 0, w, h )
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 14, 150)
		surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.33, ScrH() * 0.033) --шапка

		surface.SetDrawColor(Color( 30, 30, 30, 50))
		surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.33, ScrH() * 0.033) --обводка шапки

		draw.DrawText("Торговля", "Roh20", ScrW() * 0.01, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

		surface.SetDrawColor( 0, 33, 55, 160)
		surface.DrawRect(ScrW() * 0.013, ScrH() * 0.0575, ScrW() * 0.305, ScrH() * 0.024) --верхняя часть торговли

		draw.DrawText("Список предметов", "Roh20", ScrW() * 0.015, ScrH() * 0.0575, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

		surface.SetDrawColor( Color(125, 105, 0, 40) )
		surface.SetMaterial( Material("lgh/circle_gradient.png") )
		surface.DrawTexturedRectUV( -ScrW() * 0.045, ScrH() * 0.587, ScrW() * 0.42, ScrH() * 0.032, 1, 0.9, 0, 0.3 )

		surface.SetDrawColor(Color( 0, 0, 0, 235))						
		surface.DrawOutlinedRect(ScrW() * 0.013, ScrH() * 0.0575, ScrW() * 0.305, ScrH() * 0.518) --основная обводка описания

		surface.SetDrawColor(Color( 0, 0, 0, 50))
		surface.DrawOutlinedRect(ScrW() * 0.013, ScrH() * 0.0575, ScrW() * 0.305, ScrH() * 0.518) --вторичная обводка описания
    end

	function PANEL:removeItem(uniqueID, listID)
		if (!listID or listID == "selling") then
			if (IsValid(self.sellingList[uniqueID])) then
				self.sellingList[uniqueID]:Remove()
				self.sellingItems:InvalidateLayout()
			end
		end

		if (!listID or listID == "buying") then
			if (IsValid(self.buyingList[uniqueID])) then
				self.buyingList[uniqueID]:Remove()
				self.buyingItems:InvalidateLayout()
			end
		end
	end

	function PANEL:setup(entity)
		self.entity = entity

		namevendor = entity:getNetVar("name", "")
		modelvendor = entity:GetModel()
		descvendor = entity:getNetVar("desc", "")
		playermodel = LocalPlayer():getChar():getModel()
		--relation = (LocalPlayer():getChar():getData("rep") + LocalPlayer():getChar():getData("rank")) * 0.001
		--discount = LocalPlayer():getChar():getData("rep") * 0.001
		--vweight = math.random( 166.1, 255.9 )

		for k, v in SortedPairs(entity.items) do
			self:addItem(k, "selling")
		end

		if LocalPlayer():getChar():getData("rank") >= 500 then
			self:addItem(nut.item.list["aksu"].uniqueID, "selling")
		elseif LocalPlayer():getChar():getData("rank") == 0 then
			self:addItem(nut.item.list["pm"].uniqueID, "selling")
		end

		for k, v in SortedPairs(LocalPlayer():getChar():getInv():getItems()) do
			self:addItem(v.uniqueID, "buying")
		end
	end

	function PANEL:OnRemove()
		netstream.Start("vendorExit")

		if (IsValid(nut.gui.vendorEditor)) then
			nut.gui.vendorEditor:Remove()
		end
	end

	function PANEL:Think()
		local entity = self.entity


		if (!IsValid(entity)) then
			self:Remove()

			return
		end

		if ((self.nextUpdate or 0) < CurTime()) then
			moneyvendor = entity.money or "---"
			self.nextUpdate = CurTime() + 0.25
		end
	end


	function PANEL:onItemSelected(panel)
		local price = self.entity:getPrice(panel.item, panel.isLocal)
		local desc = self.entity:getDesc(panel.item, panel.isLocal)
		local name = self.entity:getName(panel.item, panel.isLocal)
		local model = self.entity:getModel(panel.item, panel.isLocal)
		local uniqueID = self.entity:getUniqueID(panel.item, panel.isLocal)
		local width = self.entity:getWidth(panel.item, panel.isLocal)
		local height = self.entity:getHeight(panel.item, panel.isLocal)
		local iconCam = self.entity:getIconCam(panel.item, panel.isLocal)
		local weight = self.entity:getWeight(panel.item, panel.isLocal)

		itemuniqueID = uniqueID
		itemwidth = width
		itemheight = height
		itemiconCam = iconCam or {pos = Vector(0, 0, 200), ang = Angle(90, 0, -50.445858001709), fov = 2.2}
		itemdesc = ""..desc..""
		itemmodel = ""..model..""
		itemname = ""..name..""
		--imhere = 0

		if serverguard.player:GetRank(LocalPlayer()) == 'vip' then
			price = price * 0.7
		else
			if LocalPlayer():getChar():getData("rep") <= 100 then
				price = price * (-LocalPlayer():getChar():getData("rep")) * 0.0105
			else
				price = price
			end
		end

		if (panel.isLocal) then
			sellprice = price.."₽"
			sellweight = "("..weight.."кг)"
		else
			buyprice = price.."₽"
			buyweight = "("..weight.."кг)"
		end
	end

vgui.Register("nutVendor", PANEL, "DFrame")

PANEL = {}
	function PANEL:Init()
		self:SetTall(36)
		self:DockMargin(4, 4, 4, 0)

		self.icon = self:Add("SpawnIcon")
		self.icon:SetPos(2, 2)
		self.icon:SetSize(32, 32)
		self.icon:SetModel("models/error.mdl")

		self.name = self:Add("DLabel")
		self.name:Dock(FILL)
		self.name:DockMargin(42, 0, 0, 0)
		self.name:SetFont("Roh14")
		self.name:SetTextColor(color_white)
		self.name:SetExpensiveShadow(1, Color(0, 0, 0, 200))

		self.click = self:Add("DButton")
		self.click:Dock(FILL)
		self.click:SetText("")
		self.click.Paint = function() end
		self.click.DoClick = function(this)
			SELECTED_ITEM = self
			
			if (self.isLocal) then
				nut.gui.vendor.activeBuy = self
			else
				nut.gui.vendor.activeSell = self
			end

			nut.gui.vendor:onItemSelected(self)
		end
	end

	function PANEL:setCallback(callback)
		self.click.DoClick = function(this)
			callback()
			self.selected = true
		end
	end

	function PANEL:setup(uniqueID)
		local item = nut.item.list[uniqueID]

		if (item) then
			self.item = uniqueID --кук
			self.icon:SetModel(item.model, item.skin or 0)
			self.name:SetText(L(item.name))
			self.itemName = L(item.name)
		end


		--for v, k in pairs(nut.item.list[uniqueID].name) do
			--if item.name == "ПМ" then
				--LocalPlayer():ConCommand('say trade '..v)
			--end
		--end

	end

	function PANEL:Think()
		if ((self.nextUpdate or 0) < CurTime()) then
			local name = self.itemName
			local entity = nut.gui.vendor.entity

			if (entity) then
				if (self.isLocal) then
					local count = LocalPlayer():getChar():getInv():getItemCount(self.item)

					if (count == 0) then
						self:Remove()
					end
					
					name = name.." ("..count..")"
				elseif (entity.items[self.item] and entity.items[self.item][VENDOR_MAXSTOCK]) then
					name = name.." ("..entity.items[self.item][VENDOR_STOCK].."/"..entity.items[self.item][VENDOR_MAXSTOCK]..")"
				end
			end

			self.name:SetText(name)
			self.nextUpdate = CurTime() + 0.1
		end
	end

	function PANEL:Paint(w, h)
		if (nut.gui.vendor.activeBuy == self or nut.gui.vendor.activeSell == self) then

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
vgui.Register("nutVendorItem", PANEL, "DPanel")