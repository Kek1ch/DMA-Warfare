AddCSLuaFile()

function EFFECT:Init(data)
	local ent = data:GetEntity()
	local att = data:GetAttachment()

	local origin  = self:GetTracerShootPos2(data:GetOrigin(), ent, att) - data:GetNormal() * 20
	local emitter = ParticleEmitter(origin)

	local particle = emitter:Add("weapons/stalker_cop/muzzleflash_x", origin)
	particle:SetDieTime(0.05)
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(0)
	particle:SetStartSize(6)
	particle:SetEndSize(8)
	particle:SetRoll( math.random(-180, 180) )
	particle:SetColor(255, 255, 255)

	local particle = emitter:Add("particle/particle_smokegrenade", origin)
	particle:SetVelocity(25 * VectorRand())
	particle:SetAirResistance(200)
	particle:SetGravity(Vector(0, 0, math.Rand(25, 100)))
	particle:SetDieTime(math.Rand(1, 3))
	particle:SetStartAlpha(100)
	particle:SetEndAlpha(0)
	particle:SetStartSize(math.Rand(2, 7))
	particle:SetEndSize(math.Rand(15, 25))
	particle:SetRoll(math.Rand(-25, 25))
	particle:SetRollDelta(math.Rand(-0.05, 0.05))
	particle:SetColor(255, 255, 255)
	particle:SetLighting(true)

	emitter:Finish()

	local dlight = DynamicLight(self:EntIndex())

	dlight.r = 255
	dlight.g = 120
	dlight.b = 60
	dlight.Brightness = 2
	dlight.Pos = origin
	dlight.Size = 100
	dlight.Decay = 1000
	dlight.DieTime = CurTime() + 0.01
end

function EFFECT:GetTracerShootPos2(pos, ent, att)
	if !IsValid( ent ) then return pos end
	if !ent:IsWeapon() then return pos end

	if (ent:IsCarriedByLocalPlayer() && !LocalPlayer():ShouldDrawLocalPlayer()) then
		local VModel = ent.VModel or ent.Owner:GetViewModel()

		if IsValid(VModel) then
			local att = VModel:GetAttachment(att)

			if att then
				pos = att.Pos
			end
		end
	else
		local att = ent:GetAttachment(att)

		if att then
			pos = att.Pos
		end
	end

	return pos
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
