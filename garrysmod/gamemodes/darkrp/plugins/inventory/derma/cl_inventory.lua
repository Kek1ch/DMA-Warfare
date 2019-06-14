-- The queue for the rendered icons.
renderdIcons = renderdIcons or {}

-- To make making inventory variant, This must be followed up.
function renderNewIcon(panel, itemTable)
	-- re-render icons
	if ((itemTable.iconCam and !renderdIcons[string.lower(itemTable.model)]) or itemTable.forceRender) then
		local iconCam = itemTable.iconCam
		iconCam = {
			cam_pos = iconCam.pos,
			cam_ang = iconCam.ang,
			cam_fov = iconCam.fov,
		}
		renderdIcons[string.lower(itemTable.model)] = true
		
		panel.Icon:RebuildSpawnIconEx(
			iconCam
		)
	end
end

local PANEL = {}

function PANEL:Init()
	self:Droppable("inv")
end

function PANEL:PaintOver(w, h)
	local itemTable = nut.item.instances[self.itemID]

	if (self.waiting and self.waiting > CurTime()) then
		local wait = (self.waiting - CurTime()) / self.waitingTime
		surface.SetDrawColor(255, 255, 255, 100*wait)
		surface.DrawRect(0, 0, w, h)
	end

	if (itemTable and itemTable.paintOver) then
		local w, h = self:GetSize()

		itemTable.paintOver(self, itemTable, w, h)
	end
end

function PANEL:ExtraPaint(w, h)
end

function PANEL:Paint(w, h) --рисуем ячейки
	local parent = self:GetParent()

	self:ExtraPaint(w, h)
end

function PANEL:wait(time)
	time = math.abs(time) or .2
	self.waiting = CurTime() + time
	self.waitingTime = time
end

function PANEL:isWaiting()
	if (self.waiting and self.waitingTime) then
		return (self.waiting and self.waiting > CurTime())
	end
end

vgui.Register("nutItemIcon", PANEL, "SpawnIcon")

local CPANEL = {}

function CPANEL:Init()
	self:Droppable("inv")
end

function CPANEL:PaintOver(w, h)
	local itemTable = nut.item.instances[self.itemID]

	if (self.waiting and self.waiting > CurTime()) then
		local wait = (self.waiting - CurTime()) / self.waitingTime
		surface.SetDrawColor(255, 255, 255, 100*wait)
		surface.DrawRect(0, 0, w, h)
	end

	if (itemTable and itemTable.paintOver) then
		local w, h = self:GetSize()

		itemTable.paintOver(self, itemTable, w, h)
	end
end

function CPANEL:ExtraPaint(w, h)
end

function CPANEL:Paint(w, h) --рисуем ячейки
	local parent = self:GetParent()

	surface.SetDrawColor( 205, 160, 10, 8 )
	surface.DrawRect( 0, 0, w, h )
				
	surface.SetDrawColor( 205, 100, 10, 10 )
	surface.SetMaterial( Material("vgui/gradient-d") )
	surface.DrawTexturedRect( 0, 0, w, h )
				
	if self:IsHovered() then
		surface.SetDrawColor( 255, 255, 255, 10 )
		surface.DrawRect( 0, 0, w, h )
	end

	self:ExtraPaint(w, h)
end

function CPANEL:wait(time)
	time = math.abs(time) or .2
	self.waiting = CurTime() + time
	self.waitingTime = time
end

function CPANEL:isWaiting()
	if (self.waiting and self.waitingTime) then
		return (self.waiting and self.waiting > CurTime())
	end
end

vgui.Register("nutItemIcon_inv", CPANEL, "SpawnIcon")

PANEL = {}
	function PANEL:Init()
		self:MakePopup()
		self:Center()
		self:ShowCloseButton(false)
		self:SetDraggable(true)
		self:SetTitle("")

		self.panels = {}
	end
		
	function PANEL:OnRemove()
		if (self.childPanels) then
			for k, v in ipairs(self.childPanels) do
				if (v != self) then
					v:Remove()
				end
			end
		end
	end

	function PANEL:viewOnly()
		self.viewOnly = true

		for id, icon in pairs(self.panels) do
			icon.OnMousePressed = nil
			icon.OnMouseReleased = nil
			icon.doRightClick = nil
		end
	end

	function PANEL:setInventory(inventory)
		if (inventory.slots) then
			if (IsValid(nut.gui.inv1) and nut.gui.inv1.childPanels and inventory != LocalPlayer():getChar():getInv()) then
				table.insert(nut.gui.inv1.childPanels, self)
			end

			self.invID = inventory:getID()  
			self:SetSize(ScrW()*0.05, ScrH()*0.05)
			self:setGridSize(inventory:getSize())

			for x, items in pairs(inventory.slots) do
				for y, data in pairs(items) do
					if (!data.id) then continue end

					local item = nut.item.instances[data.id]

					if (item and !IsValid(self.panels[item.id])) then
						local icon = self:addIcon(item.model or "models/props_junk/popcan01a.mdl", x, y, item.width, item.height)

						if (IsValid(icon)) then
							local newTooltip = hook.Run("OverrideItemTooltip", self, data, item)

							if (newTooltip) then
								icon:SetToolTip(newTooltip)
							else
								icon:SetToolTip(
									Format(nut.config.itemFormat,
									L(item.name), item:getDesc() or "")
								)
							end
							icon.itemID = item.id

							self.panels[item.id] = icon
						end
					end
				end
			end
		end

		self:Center()
	end

	function PANEL:setGridSize(w, h)
		self.gridW = w
		self.gridH = h
		
		--self:SetSize(w * ScrW() * 0.032 + ScrW() * 0.05, h * ScrH() * 0.053 + ScrH() * 0.28) --self:SetSize(w * 64 + 8, h * 64 + 31)
		self:SetSize(w * ScrW() * 0.032 + ScrW() * 0.05, h * ScrH() * 0.053 + ScrH() * 0.205)

		self:buildSlots()
	end
	
	function PANEL:buildSlots()
		self.slots = self.slots or {}
		
		local function PaintSlot(slot, w, h)
			surface.SetDrawColor(0, 0, 0, 250)
			surface.DrawOutlinedRect(0, 0, w, h)
			
			surface.SetDrawColor(40, 40, 45, 240)
			surface.DrawRect(0, 0, w, h)
			
			surface.SetDrawColor( 0, 0, 0, 255 )
			surface.SetMaterial( Material("vgui/gradient-d") )
			surface.DrawTexturedRect( 0, -ScrH()*0.05, w, ScrH()*0.18 )
			
			surface.SetDrawColor( 55, 55, 65, 90 )
			surface.DrawOutlinedRect( 0, 0, w, h )
			
			surface.SetDrawColor( 55, 55, 65, 90 )
			surface.DrawOutlinedRect( 0, 0, w, 0 )
		end
		
		for k, v in ipairs(self.slots) do
			for k2, v2 in ipairs(v) do
				v2:Remove()
			end
		end
		
		self.slots = {}
		
		for x = 1, self.gridW do
			self.slots[x] = {}
			
			for y = 1, self.gridH do
				local slot = self:Add("DPanel")
				slot:SetZPos(-999) --slot:SetZPos(-999) похуй
				slot.gridX = x
				slot.gridY = y
				slot:SetPos((x - 1) * ScrW() * 0.03392 + ScrW() * 0.017, (y - 1) * ScrH() * 0.056 + ScrH() * 0.085) --slot:SetPos((x - 1) * 64 + 4, (y - 1) * 64 + 27)
				slot:SetSize(ScrW() * 0.03392, ScrH() * 0.056) --slot:SetSize(64, 64)
				slot.Paint = PaintSlot
				
				self.slots[x][y] = slot	
			end
		end
	end

	--[[slot:SetPos((x - 1) * 64 + 4, (y - 1) * 64 + 27)
	x - 1 - смещение инвентаря влево
	y - 1 - смещение инвентаря вверх
	+ 4 - отступ по горизонтали от гамки
	+ 27 - отступ сверху
	64 и 64 - размеры ячеек в пикселях, должлы быть равны размерам из SetSize
	]]
	
	local activePanels = {}

    function PANEL:Paint(w, h) --рисуем панель инвентаря
    	nut.util.drawBlur(self, 10)
        surface.SetDrawColor(Color( 20, 20, 20, 220))
		surface.DrawRect( 0, 0, w, h )
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 14, 150)
		surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033)

		surface.SetDrawColor(Color( 30, 30, 30, 90))
		surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033) --шапка

		draw.DrawText("Инвентарь", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

		surface.SetDrawColor(Color( 138, 149, 151, 60))
		surface.DrawLine(ScrW() * 0.018, ScrH() * 0.0325, ScrW() * 0.29, ScrH() * 0.0325)

		surface.SetDrawColor(Color(  0, 33, 55, 210))
		surface.DrawRect(ScrW() * 0.017, ScrH() * 0.059, ScrW() * 0.2715, ScrH() * 0.027) --верхняя панель крафта

		surface.SetDrawColor( Color(80, 80, 80, 255) )
		surface.DrawRect( ScrW() * 0.017, ScrH() * 0.059, math.Clamp(((ScrW()*0.27)*(LocalPlayer():GetWeight()/(nut.config.get("maxWeight") + LocalPlayer():GetWeightAddition()))), 0, ScrW() * 0.2715), ScrH() * 0.027 )

		surface.SetDrawColor( Color(125, 105, 0, 255) )
		surface.SetMaterial( Material("lgh/circle_gradient.png") )
		surface.DrawTexturedRectUV( ScrW() * 0.13, ScrH() * 0.061, ScrW() * 0.05, ScrH() * 0.04, 1, 0.9, 0, 0.3 )

		draw.DrawText(LocalPlayer():GetWeight() .."/".. (nut.config.get("maxWeight") + LocalPlayer():GetWeightAddition()), "Roh10", ScrW() * 0.15, ScrH() * 0.064, Color(255, 255, 255, 210), TEXT_ALIGN_CENTER )

		draw.DrawText("Рюкзак", "Roh20", ScrW() * 0.02, ScrH() * 0.06, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

		surface.SetDrawColor(Color( 0, 0, 0, 255))
		surface.DrawOutlinedRect(ScrW() * 0.0165, ScrH() * 0.059, ScrW() * 0.273, ScrH() * 0.53) --обводка модели игрока

		surface.SetDrawColor( Color(125, 105, 0, 40) )
		surface.SetMaterial( Material("lgh/circle_gradient.png") )
		surface.DrawTexturedRectUV( -ScrW() * 0.01, ScrH() * 0.657, ScrW() * 0.35, ScrH() * 0.032, 1, 0.9, 0, 0.3 )
    end

	function PANEL:PaintOver(w, h) --рисуем поверх
		local item = nut.item.held
		
		if (IsValid(item)) then
			local mouseX, mouseY = self:LocalCursorPos()
			local dropX, dropY = math.ceil((mouseX - ScrW() * 0.017 - (item.gridW - 1) * 32) / 51), math.ceil((mouseY - ScrH() * 0.085 - (item.gridH - 1) * 32) / 51)



			if ((mouseX < -w*0.05 or mouseX > w*1.05) or (mouseY < h*0.05 or mouseY > h*1.05)) then
				activePanels[self] = nil
			else
				activePanels[self] = true
			end

			item.dropPos = item.dropPos or {}
			if (item.dropPos[self]) then
				item.dropPos[self].item = nil
			end

			for x = 0, item.gridW - 1 do
				for y = 0, item.gridH - 1 do
					local x2, y2 = dropX + x, dropY + y
					
					-- Is Drag and Drop icon is in the Frame?
					if (self.slots[x2] and IsValid(self.slots[x2][y2])) then
						local bool = self:isEmpty(x2, y2, item)
						
						surface.SetDrawColor(0, 0, 255, 10)

						if (x == 0 and y == 0) then
							item.dropPos[self] = {x = (x2 - 1)*ScrW() * 0.03392 + ScrW() * 0.017, y = (y2 - 1)*ScrH() * 0.056 + ScrH() * 0.085, x2 = x2, y2 = y2}

							--[[{x = (x2 - 1)*64 + 4, y = (y2 - 1)*64 + 27, x2 = x2, y2 = y2}
							Сетка перетаскивания, должна быть равна обычной сетке
							x2 - 1 - смещение инвентаря влево
							y2 - 1 - смещение инвентаря вверх
							+ 4 - отступ по горизонтали от гамки
							+ 27 - отступ сверху
							64 и 64 - размеры ячеек в пикселях, должлы быть равны размерам из SetSize
							]]

						end
							
						if (bool) then
							surface.SetDrawColor(0, 255, 0, 10)
						else
							surface.SetDrawColor(255, 255, 0, 10)
							
							if (self.slots[x2] and self.slots[x2][y2] and item.dropPos[self]) then
								item.dropPos[self].item = self.slots[x2][y2].item
							end
						end
					
						surface.DrawRect((x2 - 1)*ScrW() * 0.03392 + ScrW() * 0.017, (y2 - 1)*ScrH() * 0.056 + ScrH() * 0.085, ScrW() * 0.03392, ScrH() * 0.056)



						--[[{x = (x2 - 1)*64 + 4, y = (y2 - 1)*64 + 27, x2 = x2, y2 = y2}
						Рисуем сетку перетаскивания, должна быть равна обычной сетке
						x2 - 1 - смещение инвентаря влево
						y2 - 1 - смещение инвентаря вверх
						+ 4 - отступ по горизонтали от гамки
						+ 27 - отступ сверху
						64 и 64 - размеры ячеек в пикселях, должлы быть равны размерам из SetSize
						]]
					else
						if (item.dropPos) then
							item.dropPos[self] = nil
						end
					end
				end
			end
		end
	end


	
	function PANEL:isEmpty(x, y, this)
		return (!IsValid(self.slots[x][y].item) or self.slots[x][y].item == this)
	end
	
	function PANEL:onTransfer(oldX, oldY, x, y, oldInventory, noSend)
		local inventory = nut.item.inventories[oldInventory.invID]
		local inventory2 = nut.item.inventories[self.invID]
		local item
		
		if (inventory) then
			item = inventory:getItemAt(oldX, oldY)
			
			if (!item) then
				return false
			end

			if (hook.Run("CanItemBeTransfered", item, nut.item.inventories[oldInventory.invID], nut.item.inventories[self.invID]) == false) then
				return false, "notAllowed"
			end
		
			if (item.onCanBeTransfered and item:onCanBeTransfered(inventory, inventory != inventory2 and inventory2 or nil) == false) then
				return false
			end
		end

		if (!noSend) then
			if (self != oldInventory) then
				netstream.Start("invMv", oldX, oldY, x, y, oldInventory.invID, self.invID)
			else
				netstream.Start("invMv", oldX, oldY, x, y, oldInventory.invID)
			end
		end

		if (inventory) then			
			inventory.slots[oldX][oldY] = nil
		end

		if (item and inventory2) then
			inventory2.slots[x] = inventory2.slots[x] or {}
			inventory2.slots[x][y] = item
		end
	end

	function PANEL:addIcon(model, x, y, w, h, skin)
		w = w or 1
		h = h or 1
		
		if (self.slots[x] and self.slots[x][y]) then
			local panel = self:Add("nutItemIcon_inv")
			panel:SetSize(w * ScrW() * 0.03392, h * ScrH() * 0.056)
			panel:SetZPos(999)
			panel:InvalidateLayout(true)
			panel:SetModel(model, skin)
			panel:SetPos(self.slots[x][y]:GetPos())
			panel.gridX = x
			panel.gridY = y
			panel.gridW = w
			panel.gridH = h
			--[[panel.Paint = function(self, w, h)
				surface.SetDrawColor( 205, 160, 10, 8 )
				surface.DrawRect( 0, 0, w, h )
				
				if self:IsHovered() then
					surface.SetDrawColor( 255, 255, 255, 30 )
					surface.DrawRect( 0, 0, w, h )
				end
			end]]

			--[[panel:SetSize(w * 64, h * 64)
			Размеры иконок, должны быть равна обычной сетке
			64 и 64 - размеры иконок в пикселях, должлы быть равны размерам из SetSize
			]]

			local inventory = nut.item.inventories[self.invID]

			if (!inventory) then
				return
			end

			panel.inv = inventory

			local itemTable = inventory:getItemAt(panel.gridX, panel.gridY)
			panel.itemTable = itemTable

			if (self.panels[itemTable:getID()]) then
				self.panels[itemTable:getID()]:Remove()
			end
			
			--if (itemTable.exRender) then
				panel.Icon:SetVisible(false)
				panel.ExtraPaint = function(self, x, y)
					local exIcon = ikon:getIcon(itemTable.uniqueID)
					if (exIcon) then
						surface.SetMaterial(exIcon)
						surface.SetDrawColor(color_white)
						surface.DrawTexturedRect(0, 0, x, y)
					else
						ikon:renderIcon(
							itemTable.uniqueID,
							itemTable.width,
							itemTable.height,
							itemTable.model,
							itemTable.iconCam
						)
					end
				end
			--else
				--renderNewIcon(panel, itemTable)
			--end

			panel.move = function(this, data, inventory, noSend)
				local oldX, oldY = this.gridX, this.gridY
				local oldParent = this:GetParent()

				if (inventory:onTransfer(oldX, oldY, data.x2, data.y2, oldParent, noSend) == false) then
					return
				end

				data.x = data.x or (data.x2 - 1)*ScrW() * 0.03392 + ScrW() * 0.017
				data.y = data.y or (data.y2 - 1)*ScrH() * 0.056 + ScrH() * 0.085

				--[[
				data.x = data.x or (data.x2 - 1)*64 + 4
				data.y = data.y or (data.y2 - 1)*64 + 27
				64 и 64 - размеры в пикселях
				4 и 27 - отступы
				]]

				this.gridX = data.x2
				this.gridY = data.y2
				this.invID = inventory.invID
				this:SetParent(inventory)
				this:SetPos(data.x, data.y)

				if (this.slots) then
					for k, v in ipairs(this.slots) do
						if (IsValid(v) and v.item == this) then
							v.item = nil
						end
					end
				end
				
				this.slots = {}

				for x = 1, this.gridW do
					for y = 1, this.gridH do
						local slot = inventory.slots[this.gridX + x-1][this.gridY + y-1]

						slot.item = this
						this.slots[#this.slots + 1] = slot
					end
				end
			end

			panel.OnMousePressed = function(this, code)
				if (code == MOUSE_LEFT) then
					if (input.IsKeyDown(KEY_LCONTROL) or input.IsKeyDown(KEY_RCONTROL)) then
						local func = itemTable.functions

						if (func) then
							local use
							local comm
							for k, v in pairs(USABLE_FUNCS or {}) do
								comm = v
								use = func[comm]

								if (use and use.onCanRun) then
									if (use.onCanRun(itemTable) == false) then
										continue
									end
								end

								if (use) then
									break
								end
							end

							if (!use) then return end

							if (use.onCanRun) then
								if (use.onCanRun(itemTable) == false) then
									itemTable.player = nil

									return
								end
							end

							itemTable.player = LocalPlayer()
								local send = true

								if (use.onClick) then
									send = use.onClick(itemTable)
								end

								if (use.sound) then
									surface.PlaySound(use.sound)
								end

								if (send != false) then
									netstream.Start("invAct", comm, itemTable.id, self.invID)
								end
							itemTable.player = nil
						end
					else
						this:DragMousePress(code)
						this:MouseCapture(true)

						nut.item.held = this
					end
				elseif (code == MOUSE_RIGHT and this.doRightClick) then
					this:doRightClick()
				end
			end
			panel.OnMouseReleased = function(this, code)
				if (code == MOUSE_LEFT and nut.item.held == this) then
					local data = this.dropPos

					this:DragMouseRelease(code)
					this:MouseCapture(false)
					this:SetZPos(99)

					nut.item.held = nil
					
					if (table.Count(activePanels) == 0) then
						local item = this.itemTable
						local inv = this.inv

						if (item and inv) then
							netstream.Start("invAct", "drop", item.id, inv:getID(), item.id)
						end
						
						return false
					end
					activePanels = {}

					if (data) then
						local inventory = table.GetFirstKey(data)
						
						if (IsValid(inventory)) then
							data = data[inventory]

							if (IsValid(data.item)) then
								inventory = panel.inv

								if (inventory) then
									local targetItem = data.item.itemTable
									
									if (targetItem) then
										-- to make sure...
										if (targetItem.id == itemTable.id) then return end

										if (itemTable.functions) then
											local combine = itemTable.functions.combine

											-- does the item has the combine feature?
											if (combine) then
												itemTable.player = LocalPlayer()

												-- canRun == can item combine into?
												if (combine.onCanRun and (combine.onCanRun(itemTable, targetItem.id) != false)) then
													netstream.Start("invAct", "combine", itemTable.id, inventory:getID(), targetItem.id)
												end

												itemTable.player = nil
											end
										end
									end
								end
							else
								local oldX, oldY = this.gridX, this.gridY

								if (oldX != data.x2 or oldY != data.y2 or inventory != self) then									
									this:move(data, inventory)
								end
							end
						end
					end
				end
			end
			panel.doRightClick = function(this)
				if (itemTable) then
					itemTable.player = LocalPlayer()
						local menu = DermaMenu()
						local override = hook.Run("OnCreateItemInteractionMenu", panel, menu, itemTable)
						
						if (override == true) then if (menu.Remove) then menu:Remove() end return end
							for k, v in SortedPairs(itemTable.functions) do
								if (k == "combine") then continue end -- we don't need combine on the menu mate. 

								if (v.onCanRun) then
									if (v.onCanRun(itemTable) == false) then
										itemTable.player = nil

										continue
									end
								end

								-- is Multi-Option Function
								if (v.isMulti) then
									local subMenu, subMenuOption = menu:AddSubMenu(L(v.name or k), function()
										itemTable.player = LocalPlayer()
											local send = true

											if (v.onClick) then
												send = v.onClick(itemTable)
											end

											if (v.sound) then
												surface.PlaySound(v.sound)
											end

											if (send != false) then
												netstream.Start("invAct", k, itemTable.id, self.invID)
											end
										itemTable.player = nil
									end)
									subMenuOption:SetImage(v.icon or "icon16/brick.png")

									if (v.multiOptions) then
										local options = isfunction(v.multiOptions) and v.multiOptions(itemTable, LocalPlayer()) or v.multiOptions

										for _, sub in pairs(options) do
											subMenu:AddOption(L(sub.name or "subOption"), function()
												itemTable.player = LocalPlayer()
													local send = true

													if (v.onClick) then
														send = v.onClick(itemTable)
													end

													if (v.sound) then
														surface.PlaySound(v.sound)
													end

													if (send != false) then
														netstream.Start("invAct", k, itemTable.id, self.invID, sub.data)
													end
												itemTable.player = nil
											end)
										end
									end
								else
									menu:AddOption(L(v.name or k), function()
										itemTable.player = LocalPlayer()
											local send = true

											if (v.onClick) then
												send = v.onClick(itemTable)
											end

											if (v.sound) then
												surface.PlaySound(v.sound)
											end

											if (send != false) then
												netstream.Start("invAct", k, itemTable.id, self.invID)
											end
										itemTable.player = nil
									end):SetImage(v.icon or "icon16/brick.png")
								end
							end
						menu:Open()
					itemTable.player = nil
				end
			end
			
			panel.slots = {}
			
			for i = 0, w - 1 do
				for i2 = 0, h - 1 do
					local slot = self.slots[x + i] and self.slots[x + i][y + i2]

					if (IsValid(slot)) then
						slot.item = panel
						panel.slots[#panel.slots + 1] = slot
					else
						for k, v in ipairs(panel.slots) do
							v.item = nil
						end

						panel:Remove()

						return
					end
				end
			end
			
			return panel
		end
	end
vgui.Register("nutInventory", PANEL, "DFrame")

hook.Add("PostRenderVGUI", "nutInvHelper", function()
	local pnl = nut.gui.inv1

	hook.Run("PostDrawInventory", pnl)
end)