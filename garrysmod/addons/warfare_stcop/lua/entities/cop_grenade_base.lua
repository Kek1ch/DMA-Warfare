AddCSLuaFile()

ENT.Type      = "anim"
ENT.Spawnable = false

ENT.Model = "models/weapons/w_cw_fraggrenade_thrown.mdl"

ENT.Radius = 320
ENT.Damage = 250

ENT.Sound = "weapons/stalker_cop/rgd5_explode.wav"

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

function ENT:Fuse(t)
	timer.Simple(t, function()
		if IsValid(self) then
			self:Explode()
		end
	end)
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	self.collisionData = nil
	return false
end

function ENT:Explode()
	local pos = self:GetPos()
	local eff = EffectData()

	if eff then
		local data = self.collisionData

		if data then
			util.Decal("Scorch", pos + data.HitNormal, pos - data.HitNormal)
			pos = pos - data.HitNormal * 24
		end

		eff:SetOrigin(pos)
		util.Effect("cop_explosion", eff)
	end

	util.BlastDamage(self, self.Owner, pos, self.Radius, self.Damage)
	util.ScreenShake(pos, 10, 2, 0.4, self.Radius + 200)

	self:EmitSound(self.Sound, 120)
	SafeRemoveEntity(self)
end

function ENT:PhysicsCollide(data, physObj)
	local vel = physObj:GetVelocity()
	self.collisionData = data

	if vel:Length() >= 100 then
		self:EmitSound("weapons/hegrenade/he_bounce-1.wav")
	end
end