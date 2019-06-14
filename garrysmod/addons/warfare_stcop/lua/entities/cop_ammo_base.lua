AddCSLuaFile()

ENT.PrintName = "Call of Pripyat Ammo Base"
ENT.Category  = "Call of Pripyat - Ammo"

ENT.Type      = "anim"
ENT.Spawnable = false

ENT.Model = "models/Items/BoxMRounds.mdl"

ENT.AmmoType   = "none"
ENT.GiveAmount = 20

ENT.IsCOPEntity = true

function ENT:Use(activator, caller)
	if SERVER then
		activator:GiveAmmo(self.GiveAmount, self.AmmoType)
		self:Remove()
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