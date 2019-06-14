 ENT.Type = "anim"
ENT.PrintName = "Vendor"
ENT.Category = "NutScript"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.isVendor = true
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.AutomaticFrameAdvance = true 

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/spenser/kek1ch/stalker_neutral0c.mdl")
		self:SetMoveType( MOVETYPE_NONE )
		self:SetSolid( SOLID_BBOX )
		self:SetUseType( SIMPLE_USE )
		self:DrawShadow( false )
		self:PhysicsInit(SOLID_VPHYSICS)
		self:DropToFloor()
		self:SetColor(Color(255, 255, 255, 0))
		self:SetRenderMode( RENDERMODE_TRANSALPHA )

		self.items = {}
		self.messages = {}
		self.factions = {}
		self.classes = {}

		self:setNetVar("name", "Торговец")
		self:setNetVar("desc", "Одиночки")
		self:setNetVar("anim", "idle_0_idle_1")
		self:setNetVar("sound", "")

		self.receivers = {}
	end
end

function ENT:Think(client)
	if (SERVER) then
		if (!self.anim_vendor or self.anim_vendor < CurTime()) then
			self:PhysicsInitBox(  Vector( -13, -5, -1 ),  Vector( 13, 5, 70 ) )

			if (IsValid(self:GetPhysicsObject())) then
				self:GetPhysicsObject():EnableMotion(false)
			end

			self:ResetSequence(self:getNetVar("anim"))
			self:SetPlaybackRate(1)
			--self:SetColor(Color(255, 255, 255, 0))
			--self:SetRenderMode( RENDERMODE_TRANSALPHA )


			self.anim_vendor = CurTime() + 8
		end
	end
end

function ENT:canAccess(client)
	if (client:IsAdmin()) then
		return true
	end

	local allowed = false
	local uniqueID = nut.faction.indices[client:Team()].uniqueID

	if (self.factions and table.Count(self.factions) > 0) then
		if (self.factions[uniqueID]) then
			allowed = true
		else
			return false
		end
	end

	if (allowed and self.classes and table.Count(self.classes) > 0) then
		local class = nut.class.list[client:getChar():getClass()]
		local uniqueID = class and class.uniqueID

		if (!self.classes[uniqueID]) then
			return false
		end
	end

	return true
end

function ENT:getStock(uniqueID)
	if (self.items[uniqueID] and self.items[uniqueID][VENDOR_MAXSTOCK]) then
		return self.items[uniqueID][VENDOR_STOCK] or 0, self.items[uniqueID][VENDOR_MAXSTOCK]
	end
end

function ENT:getPrice(uniqueID, selling)
	local price = nut.item.list[uniqueID] and self.items[uniqueID] and self.items[uniqueID][VENDOR_PRICE] or nut.item.list[uniqueID].price or 0
	
	if (selling) then
		price = math.floor(price * (self.scale or 0.5))
	end

	return math.Round(price)
end

function ENT:getName(uniqueID, selling)
	local name = nut.item.list[uniqueID].name or "kek"
	
	name = name

	return name
end

function ENT:getDesc(uniqueID, selling)
	local desc = nut.item.list[uniqueID].desc or "kek"
	
	desc = desc

	return desc
end

function ENT:getModel(uniqueID, selling)
	local model = nut.item.list[uniqueID].model or "kek"
	
	model = model

	return model
end

function ENT:getIconCam(uniqueID, selling)
	local iconCam = nut.item.list[uniqueID].iconCam or "kek"
	
	iconCam = iconCam

	return iconCam
end


function ENT:getUniqueID(uniqueID, selling)
	local uniqueID = nut.item.list[uniqueID].uniqueID or "kek"
	
	uniqueID = uniqueID

	return uniqueID
end

function ENT:getWidth(uniqueID, selling)
	local width = nut.item.list[uniqueID].width or "kek"
	
	width = width

	return width
end

function ENT:getHeight(uniqueID, selling)
	local height = nut.item.list[uniqueID].height or "kek"
	
	height = height

	return height
end

function ENT:getWeight(uniqueID, selling)
	local weight = nut.item.list[uniqueID].weight or "kek"
	
	weight = weight

	return weight
end

function ENT:getAllWeight(uniqueID, selling)
	local weight = nut.item.list.weight or "5"
	
	weight = weight

	return weight
end

--[[function ENT:getPrice(uniqueID, selling, client)
	if !(serverguard.player:GetRank(client) == 'founder') then
	local price = nut.item.list[uniqueID] and self.items[uniqueID] and self.items[uniqueID][VENDOR_PRICE] or nut.item.list[uniqueID].price or 0
	local price = price * 0.4
	
	if (selling) then
		price = math.floor(price * (self.scale or 0.5))
	end

	return price
	else
	local price = nut.item.list[uniqueID] and self.items[uniqueID] and self.items[uniqueID][VENDOR_PRICE] or nut.item.list[uniqueID].price or 0
	
	if (selling) then
		price = math.floor(price * (self.scale or 0.5))
	end
	return price
end
end]]

function ENT:canSellToPlayer(client, uniqueID)
	local data = self.items[uniqueID]

	if (!data or !client:getChar() or !nut.item.list[uniqueID]) then
		return false
	end

	if (data[VENDOR_MODE] == VENDOR_BUYONLY) then
		return false
	end

	if (!client:getChar():hasMoney(self:getPrice(uniqueID))) then
		return false
	end

	if (data[VENDOR_STOCK] and data[VENDOR_STOCK] < 1) then
		return false
	end

	return true
end

function ENT:canBuyFromPlayer(client, uniqueID)
	local data = self.items[uniqueID]

	if (!data or !client:getChar() or !nut.item.list[uniqueID]) then
		return false
	end

	if (data[VENDOR_MODE] != VENDOR_SELLONLY) then
		return false
	end

	if (!self:hasMoney(data[VENDOR_PRICE] or nut.item.list[uniqueID].price or 0)) then
		return false
	end

	return true
end

function ENT:hasMoney(amount)
	-- Vendor not using money system so they can always afford it.
	if (!self.money) then
		return true
	end
	
	return self.money >= amount
end

if (SERVER) then
	local PLUGIN = PLUGIN

	function ENT:SpawnFunction(client, trace)
		local angles = (trace.HitPos - client:GetPos()):Angle()
		angles.r = 0
		angles.p = 0
		angles.y = angles.y + 180

		local entity = ents.Create("nut_vendor")
		entity:SetPos(trace.HitPos)
		entity:SetAngles(angles)
		entity:Spawn()

		PLUGIN:SaveData()

		return entity
	end

	function ENT:Use(activator)
		if (!self:canAccess(activator) or hook.Run("CanPlayerUseVendor", activator) == false) then
			if (self.messages[VENDOR_NOTRADE]) then
				activator:ChatPrint(self:getNetVar("name")..": "..self.messages[VENDOR_NOTRADE])
			end

			return
		end

		self.receivers[#self.receivers + 1] = activator

		if (self.messages[VENDOR_WELCOME]) then
			activator:ChatPrint(self:getNetVar("name")..": "..self.messages[VENDOR_WELCOME])
		end
			
		local items = {}

		for k, v in pairs(self.items) do
			if (table.Count(v) > 0 and (activator:IsAdmin() or v[VENDOR_MODE])) then
				items[k] = v
			end
		end

		self.scale = self.scale or 0.5
		--self.scale = self.scale * (activator:getChar():getData("rep", 0)/100)

		local data = {}
		data[1] = items
		data[2] = self.money
		data[3] = self.scale

		if (activator:IsAdmin()) then
			data[4] = self.messages
			data[5] = self.factions
			data[6] = self.classes
		end

		activator.nutVendor = self
	
		netstream.Start(activator, "vendorOpen", self:EntIndex(), unpack(data))
		timer.Simple(1, function()
			if (self:getNetVar("sound") != "") then
				self:EmitSound(self:getNetVar("sound"))
			end
		end)
	end

	function ENT:setMoney(value)
		self.money = value

		netstream.Start(self.receivers, "vendorMoney", value)
	end

	function ENT:giveMoney(value)
		if (self.money) then
			self:setMoney(self:getMoney() + value)
		end
	end

	function ENT:takeMoney(value)
		if (self.money) then
			self:giveMoney(-value)
		end
	end

	function ENT:setStock(uniqueID, value)
		if (!self.items[uniqueID][VENDOR_MAXSTOCK]) then
			return
		end

		self.items[uniqueID] = self.items[uniqueID] or {}
		self.items[uniqueID][VENDOR_STOCK] = math.min(value, self.items[uniqueID][VENDOR_MAXSTOCK])

		netstream.Start(self.receivers, "vendorStock", uniqueID, value)
	end

	function ENT:addStock(uniqueID, value)
		if (!self.items[uniqueID][VENDOR_MAXSTOCK]) then
			return
		end

		self:setStock(uniqueID, self:getStock(uniqueID) + (value or 1))
	end

	function ENT:takeStock(uniqueID, value)
		if (!self.items[uniqueID][VENDOR_MAXSTOCK]) then
			return
		end

		self:addStock(uniqueID, -(value or 1))
	end
else
	function ENT:createBubble()
		self.bubble = ClientsideModel("models/extras/info_speech.mdl", RENDERGROUP_OPAQUE)
		self.bubble:SetPos(self:GetPos() + Vector(0, 0, 84))
		self.bubble:SetModelScale(0.6, 0)
	end

	function ENT:Draw()
		local bubble = self.bubble
		
		if (IsValid(bubble)) then
			local realTime = RealTime()

			bubble:SetRenderOrigin(self:GetPos() + Vector(0, 0, 84 + math.sin(realTime * 3) * 0.05))
			bubble:SetRenderAngles(Angle(0, realTime * 100, 0))
		end

		self:DrawModel()
	end

	function ENT:OnRemove()
		if (IsValid(self.bubble)) then
			self.bubble:Remove()
		end
	end

	local TEXT_OFFSET = Vector(0, 0, 20)
	local toScreen = FindMetaTable("Vector").ToScreen
	local colorAlpha = ColorAlpha
	local drawText = nut.util.drawText
	local configGet = nut.config.get

	ENT.DrawEntityInfo = true

	function ENT:onDrawEntityInfo(alpha)
		local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)) + TEXT_OFFSET)
		local x, y = position.x, position.y
		local desc = self.getNetVar(self, "desc")

		drawText(self.getNetVar(self, "name", "John Doe"), x, y, colorAlpha(Color(211, 211, 211)), 1, 1, "gost10", alpha * 0.65)

		if (desc) then
			drawText(desc, x, y + 23, colorAlpha(Color(62, 95, 138)), 1, 1, "gost10", alpha * 0.65)
		end
	end
end

function ENT:getMoney()
	return self.money
end
