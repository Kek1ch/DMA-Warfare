AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Сейф"
ENT.Category = "Warfare ENT"
ENT.Spawnable = true
ENT.AdminOnly = true

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/kek1ch/dev_instrument_1.mdl") --models/z-o-m-b-i-e/st/shkaf/st_seif_02.mdl
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS) 
		self:SetUseType(SIMPLE_USE)
		self:setNetVar("name", "Сейф")

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end
	end
	
	function ENT:CreateInv(activator)
		local character = activator:getChar()
		nut.item.newInv(character:getID(), "safe."..character:getID(), function(inventory)
			character:setData("safebox", inventory:getID())
		end)
	end
	
	function ENT:getInv(activator)
		local index = activator:getChar():getData("safebox")

		if (index) then
			return nut.item.inventories[index]
		end
	end

	function ENT:RestoreInv(activator)
		local character = activator:getChar()
		local index = character:getData("safebox")
		local inventory = nut.item.inventories[index]
		
		if (index) then
			if (inventory) then
				inventory:sync(activator)
			else
				nut.item.restoreInv(index, PLUGIN.config.width, PLUGIN.config.height, function(inventory)
					inventory:setOwner(character, true)
				end)
			end
		else
			nut.item.newInv(character:getID(), "safe."..character:getID(), function(inventory)
				character:setData("safebox", inventory:getID())
			end)
		end
	end
	
	local OPEN_TIME = .3
	function ENT:OpenInv(activator)
		local index = activator:getChar():getData("safebox")
		local character = activator:getChar()
		
		if index then
			activator:setAction("@opening", OPEN_TIME)
			activator:doStaredAction(self, function()
				if (activator:GetPos():Distance(self:GetPos()) < 101) then
					nut.item.restoreInv(index, nut.config.get("BankInvW"), nut.config.get("BankInvH"), function(inventory) -- width = 10; height = 10
						inventory:setOwner(character, true)
						self:setNetVar("bank", inventory:getID())
					end)
					nut.item.inventories[index]:sync(activator)
					netstream.Start(activator, "safeOpen", self, index)
					self:EmitSound("items/ammocrate_open.wav")
				end
			end, OPEN_TIME, function()
				if (IsValid(activator)) then
					activator:setAction()
				end
			end)
			return
		else
			local index = character:getData("safebox")
			local inventory = nut.item.inventories[index]
			nut.item.newInv(character:getID(), "safe."..character:getID(), function(inventory)
				character:setData("safebox", inventory:getID())
				print("new")
			end)
		end
	end
	
	function ENT:Use(activator)
		self:OpenInv(activator)		
	end
	
	netstream.Hook("TakeMoney", function(client, value)
		client:getChar():takeMoney(value)
	end)
	
	netstream.Hook("GiveMoney", function(client, value)
		client:getChar():giveMoney(value)
	end)
	
	netstream.Hook("BankTakeMoney", function(client, value)
		client:getChar():takeReserve(value)
	end)
	
	netstream.Hook("BankGiveMoney", function(client, value)
		client:getChar():addReserve(value)
	end)
else
	netstream.Hook("safeOpen", function(entity, index)
		local char = LocalPlayer():getChar()

		if (IsValid(nut.gui.inv1)) or (IsValid(invent_info_kek)) or (IsValid(equipment_panel)) or (IsValid(equipment)) then return false end

		if (char) then
			nut.gui.inv1 = vgui.Create("nutInventory")
			nut.gui.inv1:ShowCloseButton(false)
			local inventory2 = char:getInv()
			if (inventory2) then nut.gui.inv1:setInventory(inventory2) end
			nut.gui.inv1:SetSize(nut.gui.inv1:GetWide(), nut.gui.inv1:GetTall())
			nut.gui.inv1:SetPos(ScrW()*0.6592, ScrH()*0.29)

			invent_info_kek = vgui.Create("invent_info_kek")
			invent_info_kek:SetPos(ScrW()*0.6592, ScrH()*0.067)
			invent_info_kek:SetSize(invent_info_kek:GetSize())

			safebox_menuINV = vgui.Create("nutInventory")
			safebox_menuINV:ShowCloseButton(false)
			safebox_menuINV:SetTitle("")
			safebox_menuINV:setInventory(nut.item.inventories[index])
			safebox_menuINV:SetPos(ScrW()*0.035, ScrH()*0.29)

			function safebox_menuINV:Paint(w, h)
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

				draw.DrawText("Тайник", "Roh20", ScrW() * 0.02, ScrH() * 0.06, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

				surface.SetDrawColor(Color( 0, 0, 0, 255))
				surface.DrawOutlinedRect(ScrW() * 0.0165, ScrH() * 0.059, ScrW() * 0.273, ScrH() * 0.53) --обводка модели игрока

				surface.SetDrawColor( Color(125, 105, 0, 40) )
				surface.SetMaterial( Material("lgh/circle_gradient.png") )
				surface.DrawTexturedRectUV( -ScrW() * 0.01, ScrH() * 0.657, ScrW() * 0.35, ScrH() * 0.032, 1, 0.9, 0, 0.3 )
			end

			case_info_kek = vgui.Create("safe_info_kek")
			case_info_kek:SetPos(ScrW()*0.035, ScrH()*0.067)
			case_info_kek:SetSize(case_info_kek:GetSize())

			equipment_panel = vgui.Create("equipment_panel")
			equipment_panel:SetPos(ScrW()*0.35, ScrH()*0.29)
			equipment_panel:SetSize(equipment_panel:GetSize())

			safebox_menuINV.OnClose = function(this)
				if (IsValid(nut.gui.inv1) and !IsValid(nut.gui.menu)) then
					nut.gui.inv1:Remove()
					invent_info_kek:Remove()
					equipment_panel:Remove()
					case_info_kek:Remove()
				end
			end
		
			local oldClose = nut.gui.inv1.OnClose
			nut.gui.inv1.OnClose = function()
				if (IsValid(safebox_menuINV) and !IsValid(nut.gui.menu)) then
					safebox_menuINV:Remove()
					invent_info_kek:Remove()
					equipment_panel:Remove()
					case_info_kek:Remove()
				end
				nut.gui.inv1.OnClose = oldClose
			end
		end

		nut.gui["inv"..index] = safebox_menuINV

		local function paintDtextEntry(s, w, h)
		surface.SetDrawColor(0, 0, 14, 100)
		surface.DrawRect(0, 0, w, h)

		s:DrawTextEntryText(color_white, color_white, color_white)
		end

		local entry = nut.gui.inv1:Add("DTextEntry")
		entry:SetSize(ScrW() * 0.173, ScrH() * 0.0325)
		entry:SetPos(ScrW() * 0.017, ScrH() * 0.608)
		entry:SetValue(0)
		entry:SetNumeric(true)
		entry.Paint = paintDtextEntry
		entry:SetFont("Roh20")
		entry:SetTextColor(Color(255, 255, 255, 210))
		entry.OnEnter = function()
			local value = tonumber(entry:GetValue()) or 0
			if value and value > 0 then
				if LocalPlayer():getChar():hasMoney(value) then
					surface.PlaySound("hgn/crussaria/items/itm_gold_down.wav")
					netstream.Start("TakeMoney", value)
					netstream.Start("BankGiveMoney", value)
					--nut.command.send("actstand", 4)
					entry:SetValue(0)
				else
					nut.util.notify(L("provideValidNumber"))
					entry:SetValue(0)
				end
			else
				nut.util.notify(L("cantAfford"))
				entry:SetValue(0)
			end		
		end
		
		local transfer = nut.gui.inv1:Add("DButton")
		transfer:SetSize( ScrW() * 0.095, ScrH() * 0.0325)
		transfer:SetPos(ScrW() * 0.1937, ScrH() * 0.608)
		transfer:SetText("Положить")
		transfer:SetFont("Roh20")
		transfer:SetTextColor(Color(211, 211, 211)) 
		function transfer:Paint( w, h )
			if self:IsDown() then 
				surface.SetDrawColor(Color( 255, 186, 0, 12))
				surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 255, 186, 0, 24))
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

		transfer.DoClick = function()
			local value = tonumber(entry:GetValue()) or 0
			if value and value > 0 then
				if LocalPlayer():getChar():hasMoney(value) then
					surface.PlaySound("hgn/crussaria/items/itm_gold_down.wav")
					netstream.Start("TakeMoney", value)
					netstream.Start("BankGiveMoney", value)
					--nut.command.send("actstand", 4)
					entry:SetValue(0)
				else
					nut.util.notify(L("provideValidNumber"))
					entry:SetValue(0)
				end
			else
				nut.util.notify(L("cantAfford"))
				entry:SetValue(0)
			end					
		end
		
		safebox_menuINV:SetSize(safebox_menuINV:GetWide(), safebox_menuINV:GetTall())
		
		local entry1 = safebox_menuINV:Add("DTextEntry")
		entry1:SetSize(ScrW() * 0.173, ScrH() * 0.0325)
		entry1:SetPos(ScrW() * 0.017, ScrH() * 0.608)
		entry1:SetValue(0)
		entry1.Paint = paintDtextEntry
		entry1:SetFont("Roh20")
		entry1:SetTextColor(Color(255, 255, 255, 210))
		entry1:SetNumeric(true)
		entry1.OnEnter = function()
			local value = tonumber(entry1:GetValue()) or 0
			if LocalPlayer():getChar():getReserve() >= value and value > 0 then
				surface.PlaySound("hgn/crussaria/items/itm_gold_up.wav")
				netstream.Start("BankTakeMoney", value)
				netstream.Start("GiveMoney", value)
				entry1:SetValue(0)
			elseif value < 1 then
				nut.util.notify(L("provideValidNumber"))
				entry1:SetValue(0)
			else
				nut.util.notify(L("cantAfford"))
				entry1:SetValue(0)
			end			
		end
		
		local transfer1 = safebox_menuINV:Add("DButton")
		transfer1:SetSize( ScrW() * 0.095, ScrH() * 0.0325)
		transfer1:SetPos(ScrW() * 0.1937, ScrH() * 0.608)
		transfer1:SetFont("Roh20")
		transfer1:SetTextColor(Color(211, 211, 211)) 
		function transfer1:Paint( w, h )
			if self:IsDown() then 
				surface.SetDrawColor(Color( 255, 186, 0, 12))
				surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 255, 186, 0, 24))
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
		transfer1:SetText("Снять")
		transfer1.DoClick = function()
			local value = tonumber(entry1:GetValue()) or 0
			if LocalPlayer():getChar():getReserve() >= value and value > 0 then
				surface.PlaySound("hgn/crussaria/items/itm_gold_up.wav")
				netstream.Start("BankTakeMoney", value)
				netstream.Start("GiveMoney", value)
				entry1:SetValue(0)
			elseif value < 1 then
				nut.util.notify(L("provideValidNumber"))
				entry1:SetValue(0)
			else
				nut.util.notify(L("cantAfford"))
				entry1:SetValue(0)
			end								
		end

	end)

	ENT.DrawEntityInfo = true
	local toScreen = FindMetaTable("Vector").ToScreen
	local colorAlpha = ColorAlpha
	local drawText = nut.util.drawText
	local configGet = nut.config.get

	function ENT:onDrawEntityInfo(alpha)
		local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
		local x, y = position.x, position.y
		local tx, ty = drawText("Сейф", x, y, colorAlpha(Color(211, 211, 211)), 1, 1, "gost10", alpha * 0.65)
	end
end

