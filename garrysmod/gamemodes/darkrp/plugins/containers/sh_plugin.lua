PLUGIN.name = "Containers"
PLUGIN.author = "AleXXX_007"
PLUGIN.desc = "Adds placeable containers."

nut.util.include("sv_plugin.lua")

nut.command.add("getlock", {
	onRun = function(client, arguments)
		local trace = client:GetEyeTraceNoCursor()
		local target = trace.Entity
		if target and IsValid(target) and (target:isDoor() or target:GetClass() == "nut_container") then
			if target:isDoor() then
				local data = target:getNetVar("doorData")
				if not data["locked"] then
					if data["lockedid"] then
						local data1 = {}
						data1["id"] = data["lockedid"]
						client:getChar():getInv():add("lock", 1, data)
						data["lockedid"] = nil
						target:setNetVar("doorData", data)
						client:notify("Замок снят!")		
					else
						client:notify("На двери нет замка!")
					end
				else
					client:notify("Дверь должна быть открытой, чтобы снять с нее замок!")
				end
			else
				if not target:getNetVar("locked", false) then
					if (target:getNetVar("lockedid")) then
						client:getChar():getInv():add("lock", 1, data)
						target:setNetVar("lockedid", nil)
						client:notify("Замок снят!")
					else
						client:notify("На контейнере нет замка!")
					end
				else
					client:notify("Контейнер должен быть открытым, чтобы снять с него замок!")
				end
			end
		else
			client:notify("Вы должны смотреть на дверь или контейнер!")
		end
	end
})

function PLUGIN:OnContainerSpawned(container, item, load)	
	container:SetModel(item.model)
	container:PhysicsInit(SOLID_VPHYSICS)
	container:SetMoveType(MOVETYPE_VPHYSICS)
	container:SetUseType(SIMPLE_USE)
	local physicsObject = container:GetPhysicsObject()
	if (IsValid(physicsObject)) then
		physicsObject:EnableMotion(true)
		physicsObject:Wake()
	end

	container.owner = item.player:getChar():getID()
	container.selfMat = container:GetMaterial()
	if (!load == true) then
		container:SetMaterial("models/wireframe")
	end
	container.item = item
	local invData = {
		name = item.name,
		desc = item.desc,
		width = item.invW,
		height = item.invH,
		locksound = item.locksound,
		opensound = item.opensound
	}
	container.invData = invData
	container.money = 0
	container:setNetVar("uid", item.uniqueID)
end

function PLUGIN:LoadData()
	local savedTable = self:getData() or {}
	for k, v in ipairs(savedTable) do
		local container = ents.Create("nut_container")
		
		container:SetPos(v.pos)
		container:SetAngles(v.ang)
		container:Spawn()
		container:SetModel(v.model)
		container:PhysicsInit(SOLID_VPHYSICS)
		container:SetMoveType(MOVETYPE_VPHYSICS)
		container:SetUseType(SIMPLE_USE)
		local physicsObject = container:GetPhysicsObject()
		if (IsValid(physicsObject)) then
			physicsObject:EnableMotion(false)
			physicsObject:Sleep()
		end
		container.owner = v.owner
		container.selfMat = v.selfMat
		container.item = v.item
		container.invData = v.invData
		container.money = v.money
		container.placed = true
		container.lockedid = v.lockedid
		container:setNetVar("uid", v.uid)
		container:setNetVar("locked", v.locked)
		
		nut.item.restoreInv(v.id, v.invData.width, v.invData.height, function(inventory)
			if (IsValid(container)) then
				container:setInventory(inventory)
			end
		end)
	end
end

function PLUGIN:SaveData()
	self:saveContainer()
end

function PLUGIN:saveContainer()
	local saveTable = {}
	for k, v in ipairs(ents.FindByClass("nut_container")) do
		if v.placed == true then
			table.insert(saveTable, {
			model = v:GetModel(), 
			pos = v:GetPos(), 
			ang = v:GetAngles(), 
			item = v.item, 
			owner = v.owner, 
			invData = v.invData,
			selfMat = v.selfMat,	
			id = v:getNetVar("id"),
			money = v:getMoney(),
			lockedid = v.lockedid,
			locked = v:getNetVar("locked", false),
			uid = v:getNetVar("uid")
			})
		end
	end
	
	self:setData(saveTable)
end

if (CLIENT) then
	local PLUGIN = PLUGIN
	
	netstream.Hook("ContainerMoney", function(value, index)
		if (!IsValid(nut.gui["inv"..index])) then
			return
		end
		nut.gui["inv"..index].money = value
	end)
	
	netstream.Hook("invOpen2", function(entity, index, lave)
		netstream.Start("EntGiveMoney", entity, 0)
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
			if LocalPlayer():getChar():hasMoney(value) and value > 0 then
				surface.PlaySound("hgn/crussaria/items/itm_gold_down.wav")
				netstream.Start("TakeMoney", value)
				netstream.Start("EntGiveMoney", entity, value)
				entry:SetValue(0)
			elseif value <= 0 then
				nut.util.notify("Вы ввели недействительное значение!")
				entry:SetValue(0)
			else
				nut.util.notify("У вас нет таких денег!")
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
			if LocalPlayer():getChar():hasMoney(value) and value > 0 then
				surface.PlaySound("hgn/crussaria/items/itm_gold_down.wav")
				netstream.Start("TakeMoney", value)
				netstream.Start("EntGiveMoney", entity, value)
				entry:SetValue(0)
			elseif value <= 0 then
				nut.util.notify("Вы ввели недействительное значение!")
				entry:SetValue(0)
			else
				nut.util.notify("У вас нет таких денег!")
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
			if nut.gui["inv"..index].money >= value and value > 0 then
				surface.PlaySound("hgn/crussaria/items/itm_gold_up.wav")
				netstream.Start("EntTakeMoney", entity, value)
				netstream.Start("GiveMoney", value)
				entry1:SetValue(0)
			elseif value <= 0 then
				nut.util.notify("Вы ввели недействительное значение!")
				entry1:SetValue(0)
			else
				nut.util.notify("Здесь нет таких денег!")
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
			if nut.gui["inv"..index].money >= value and value > 0 then
				surface.PlaySound("hgn/crussaria/items/itm_gold_up.wav")
				netstream.Start("EntTakeMoney", entity, value)
				netstream.Start("GiveMoney", value)
				entry1:SetValue(0)
			elseif value <= 0 then
				nut.util.notify("Вы ввели недействительное значение!")
				entry1:SetValue(0)
			else
				nut.util.notify("Здесь нет таких денег!")
				entry1:SetValue(0)
			end						
			print("Я блядь ахуеваю")
		end
	end)
end

