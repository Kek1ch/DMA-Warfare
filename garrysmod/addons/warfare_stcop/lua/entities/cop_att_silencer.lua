AddCSLuaFile()

ENT.PrintName = "Silencer"
ENT.Category  = "Call of Pripyat - Upgrades"

ENT.Type      = "anim"
ENT.Spawnable = true

ENT.Model = "models/Items/BoxMRounds.mdl"
ENT.Addon = "silencer"

ENT.IsCOPEntity = true

function ENT:Use(activator, caller)
	if SERVER then
		if activator:COP_GiveAddon(self.Addon) then
			self:Remove()
		end
	end
end

function ENT:Initialize()
	if SERVER then
		self:SetModel(self.Model)

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_NONE)

		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:Wake()
		end

		self:SetUseType(SIMPLE_USE)
	end
end