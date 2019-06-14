AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Money"
ENT.Category = "NutScript"
ENT.Spawnable = false

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/kek1ch/money_russia.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR )
		self:DropToFloor()

		if (IsValid(self:GetPhysicsObject())) then
			self:GetPhysicsObject():EnableMotion(false)
		else
			local min, max = Vector(-8, -8, -8), Vector(8, 8, 8)

			self:PhysicsInitBox(min, max)
			self:SetCollisionBounds(min, max)
		end
	end

	function ENT:Use(activator)
		if (self.client and self.charID) then
			local char = activator:getChar()
			
			if (char) then
				if (self.charID != char:getID() and self.client == activator) then
					activator:notifyLocalized("logged")
					
					return false
				end
			end
		end
		
		if (hook.Run("OnPickupMoney", activator, self) != false) then
			activator:ConCommand("say /ztakemoney " ..self:getAmount().. " руб")
			self:Remove()
		end
	end
end

if (CLIENT) then
	ENT.DrawEntityInfo = true

	local toScreen = FindMetaTable("Vector").ToScreen
	local colorAlpha = ColorAlpha
	local drawText = nut.util.drawText
	local configGet = nut.config.get

	function ENT:onDrawEntityInfo(alpha)
		local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
		local x, y = position.x, position.y

		drawText(nut.currency.get(self.getAmount(self)), x, y, colorAlpha(configGet("color"), alpha), 1, 1, nil, alpha * 0.65)
	end
end

function ENT:setAmount(amount)
	self:setNetVar("amount", amount)
end

function ENT:getAmount(amount)
	return self:getNetVar("amount", 0)
end