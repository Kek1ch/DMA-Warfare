local mat = Material("sprites/stalker_cop/ani_explo")

function EFFECT:Init(data)
	local origin = data:GetOrigin()
	local angles = data:GetAngles()

	self.Time = 0
	self.Data = data

	ParticleEffect("cop_rgd_explosion", origin, angles)
end

function EFFECT:Think()
	self.Time = self.Time + FrameTime()
	if self.Time >= 1 then
		return false
	end

	return true
end

function EFFECT:Render()
	local t = math.floor(self.Time * 55)

	render.SetMaterial(mat)
	mat:SetInt("$frame", t)

	render.DrawSprite(self:GetPos(), 144, 144)
end