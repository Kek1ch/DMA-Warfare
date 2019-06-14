AddCSLuaFile()

ENT.PrintName = "PG-7VL Warhead"
ENT.Category  = "Call of Pripyat - Miscellaneous"

ENT.Base  = "cop_grenade_base"
ENT.Type  = "anim"
ENT.Model = "models/kek1ch/ammo_og_7b.mdl"

ENT.Radius = 300
ENT.Damage = 350

ENT.Sound = "weapons/stalker_cop/rpg7_explode.wav"

function ENT:PhysicsCollide(data, physObj)
	self:Explode()
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
			phys:SetMass(1)
			phys:EnableDrag(false)
			phys:EnableGravity(false)
			phys:SetBuoyancyRatio(0)
		end
	end

	ParticleEffectAttach("rocket_smoke_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end