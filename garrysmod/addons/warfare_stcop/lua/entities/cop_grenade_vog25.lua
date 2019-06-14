AddCSLuaFile()

ENT.PrintName = "VOG-25 Grenade"
ENT.Category  = "Call of Pripyat - Miscellaneous"

ENT.Base  = "cop_grenade_base"
ENT.Type  = "anim"
ENT.Model = "models/kek1ch/ammo_vog_25.mdl"

ENT.Radius = 320
ENT.Damage = 200

ENT.Sound = "weapons/stalker_cop/grenade1.wav"

function ENT:PhysicsCollide(data, physObj)
	local vel = physObj:GetVelocity()
	self.collisionData = data

	if vel:Length() >= 100 then
		self:Explode()
	end
end