local PLUGIN = PLUGIN

ENT.Type = "anim"
ENT.PrintName = "Тайник"
ENT.Category = "Warfare ENT"
ENT.Spawnable = false

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props_junk/watermelon01.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:setNetVar("name", "Тайник")
		self.receivers = {}

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end
	end

	function ENT:setInventory(inventory)
		if (inventory) then
			self:setNetVar("id", inventory:getID())
			
			inventory.onAuthorizeTransfer = function(inventory, client, oldInventory, item)
				if (IsValid(client) and IsValid(self) and self.receivers[client]) then
					return true
				end
			end
			inventory.getReceiver = function(inventory)
				local receivers = {}

				for k, v in pairs(self.receivers) do
					if (IsValid(k)) then
						receivers[#receivers + 1] = k
					end
				end

				return #receivers > 0 and receivers or nil
			end
			inventory.onCanTransfer = function(inventory, client, oldX, oldY, x, y, newInvID)
				return hook.Run("StorageCanTransfer", inventory, client, oldX, oldY, x, y, newInvID)
			end
		end
	end

	function ENT:OnRemove()
		local index = self:getNetVar("id")

		if (!nut.shuttingDown and !self.nutIsSafe and index) then
			local item = nut.item.inventories[index]

			if (item) then
				nut.item.inventories[index] = nil

				nut.db.query("DELETE FROM nut_items WHERE _invID = "..index)
				nut.db.query("DELETE FROM nut_inventories WHERE _invID = "..index)

				hook.Run("StorageItemRemoved", self, item)
			end
		end
	end

	local OPEN_TIME = .7
	function ENT:OpenInv(activator)
		local inventory = self:getInv()
		local def = self.invData

		if (def.onOpen) then
			def.onOpen(self, activator)
		end

		activator:setAction("Открываем...", OPEN_TIME, function()
			if (activator:GetPos():Distance(self:GetPos()) <= 100) then
				self.receivers[activator] = true
				activator.nutBagEntity = self
				
				inventory:sync(activator)
				netstream.Start(activator, "invOpen2", self, inventory:getID(), self.money)
				self:EmitSound(def.opensound or "items/ammocrate_open.wav")
			end
		end)
	end

	function ENT:Use(activator)
		if not self.placed and (activator:getChar():getID() == self.owner or activator:IsAdmin()) and self:IsValid() then
			if activator:KeyDown(IN_WALK) then
				activator:setAction("Передвигаем...", 7)
				activator:doStaredAction(self, function()
					if (!activator:getChar():getInv():add(self.item.uniqueID)) then
						activator:notify("Вам не хватает места в инвентаре!")
						return
					else
						self:Remove()
					end	
				end, 7, function()
					if (IsValid(activator)) then
						activator:setAction()
					end				
				end)
				return
			end
			local physObj = self:GetPhysicsObject()
			
			if (IsValid(physObj)) then
				physObj:EnableMotion(false)
				physObj:Sleep()
			end
			self:EmitSound("physics/wood/wood_box_impact_hard".. math.random(1, 6) ..".wav")
			self:SetMaterial(self.selfMat)
			self.placed = true
			return
		end
		if self.placed and activator:KeyDown(IN_WALK) and activator:getChar():getID() == self.owner and self:IsValid() then
			local items = 0
			
			for k, v in pairs(self:getInv():getItems()) do
				items = items + 1
			end
			if items == 0 and self.money == 0 and self.lockedid == nil then
				self:EmitSound("physics/wood/wood_box_impact_hard".. math.random(1, 6) ..".wav")
				self:SetMaterial("models/wireframe")
				activator:EmitSound("physics/wood/wood_box_impact_soft".. math.random(1, 6) ..".wav")
				self.placed = false
			
				local physObj = self:GetPhysicsObject()
				if (IsValid(physObj)) then
					physObj:EnableMotion(true)
					physObj:Wake()
				end		
				return
			elseif self.money ~= 0 then
				activator:notify("Нельзя передвинуть контейнер, когда в нем находятся деньги!")
				return
			elseif self.lockedid ~= nil then
				activator:notify("Нельзя передвинуть контейнер, на котором висит замок!")
				return
			else
				activator:notify("Нельзя передвинуть контейнер, когда в нем находятся предметы!")
				return
			end
		end
		local inventory = self:getInv()

		if (inventory and (activator.nutNextOpen or 0) < CurTime()) then
			if (activator:getChar()) then
				local def = self.invData
				
				if (self:getNetVar("locked") and !activator:getChar():hasKey(self.lockedid)) then
					self:EmitSound(def.locksound or "doors/default_locked.wav")
				else
					self:OpenInv(activator)
				end
			end

			activator.nutNextOpen = CurTime() + OPEN_TIME * 1.5
		end
	end
else
	ENT.DrawEntityInfo = true

	local COLOR_LOCKED = Color(242, 38, 19)
	local COLOR_UNLOCKED = Color(135, 211, 124)
	local toScreen = FindMetaTable("Vector").ToScreen
	local colorAlpha = ColorAlpha
	local drawText = nut.util.drawText
	local configGet = nut.config.get

	function ENT:onDrawEntityInfo(alpha)
		local locked = self.getNetVar(self, "locked", false)
		local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
		local x, y = position.x, position.y

		y = y - 20
		local tx, ty = nut.util.drawText(locked and "P" or "Q", x, y, colorAlpha(locked and COLOR_LOCKED or COLOR_UNLOCKED, alpha), 1, 1, "nutIconsMedium", alpha * 0.65)
		y = y + ty*.9

		local tx, ty = drawText(nut.item.list[self:getNetVar("uid")]:getName(), x, y, colorAlpha(configGet("color"), alpha), 1, 1, nil, alpha * 0.65)
		y = y + ty + 1
		drawText(nut.item.list[self:getNetVar("uid")]:getDesc(), x, y, colorAlpha(color_white, alpha), 1, 1, nil, alpha * 0.65)
	end
end

function ENT:getItem()
	return self.item
end

function ENT:getMoney()
	return self.money
end

function ENT:getInv()
	return nut.item.inventories[self:getNetVar("id", 0)]
end

function ENT:giveMoney(amount)
	self:setMoney(self:getMoney() + amount)

	return true
end

function ENT:setMoney(amount)
	self.money = amount
	netstream.Start(self.receivers, "ContainerMoney", self.money, self:getInv():getID())
end

function ENT:takeMoney(amount)
	amount = math.abs(amount)
	self:giveMoney(-amount)
	return true
end

function ENT:hasMoney(amount)
	if self:getMoney() >= amount then
		return true
	end
end