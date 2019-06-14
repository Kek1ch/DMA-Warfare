AddCSLuaFile()

function EFFECT:Init(data)
	local ent = data:GetEntity()
	local att = data:GetAttachment()

	local origin  = self:GetTracerShootPos2(data:GetOrigin(), ent, att) - data:GetNormal() * 20
	local emitter = ParticleEmitter(origin)

	local rollDelta = (math.random() - math.random()) * 2

	local particle = emitter:Add("weapons/stalker_cop/pfx_light", origin)
	particle:SetDieTime(0.1)
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(0)
	particle:SetStartSize(12)
	particle:SetEndSize(4)
	particle:SetRoll(math.random(0, 360))
	particle:SetRollDelta(rollDelta)
	particle:SetColor(255, 255, 255)

	emitter:Finish()
	local dlight = DynamicLight(self:EntIndex())

	dlight.r = 140
	dlight.g = 160
	dlight.b = 255
	dlight.Brightness = 2
	dlight.Pos = origin
	dlight.Size = 200
	dlight.Decay = 1000
	dlight.DieTime = CurTime() + 0.1
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
