AddCSLuaFile()

ENT.PrintName = "SUSAT Scope"
ENT.Category  = "Call of Pripyat - Upgrades"

ENT.Type      = "anim"
ENT.Spawnable = true

ENT.Model = "models/Items/BoxMRounds.mdl"
ENT.Addon = "scope_susat"

ENT.IsCOPEntity = true

function ENT:Use(activator, caller)
	if SERVER then
		if activator:COP_GiveAddon(self.Addon) then
			self:Remove()
		end
	end
end

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:DrawShadow(true)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end

	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end
end