AddCSLuaFile()

ENT.PrintName = "Bolt"
ENT.Category  = "Call of Pripyat - Miscellaneous"

ENT.Type      = "anim"
ENT.Spawnable = false

ENT.Model = "models/wick/weapons/stalker/stcopwep/w_bold_model_stcop.mdl"

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
	end
end