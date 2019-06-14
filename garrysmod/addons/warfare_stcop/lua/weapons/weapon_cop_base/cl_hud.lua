if SERVER then return end

local rect, setColor, lerp, clamp = surface.DrawRect, surface.SetDrawColor, csLerp, math.Clamp

local custom_color = Color(0, 0, 0)

local function DrawLines(x, y, gap, length, thickness)
	local gap = math.ceil(gap)

	rect(x + gap, y - thickness * 0.5, length, thickness)
	rect(x - thickness * 0.5, y + gap, thickness, length)
	rect(x - gap - length - 1, y - thickness * 0.5, length, thickness)
	rect(x - thickness * 0.5, y - gap - length - 1, thickness, length)
end

local function DrawDot(x, y, dot_scale)
	rect(x - dot_scale/2, y - dot_scale/2, dot_scale, dot_scale)
end

--[[local CrosshairColor = {
	neutral = Color(255, 255, 100),
	hostile = Color(255, 0, 0),
	friendly = Color(0, 255, 0),
	none  = Color(255, 255, 255),
}]]

function SWEP:PreDrawScope()

end

function SWEP:PostDrawScope()

end

function SWEP:DrawScope()
	local texID = surface.GetTextureID( "weapons/stalker_cop/" .. self.ScopeTexture .. ".vmt" )
	local scrW, scrH = ScrW(), ScrH()

	self:PreDrawScope()

	render.UpdateScreenEffectTexture()
	surface.SetTexture(texID)

	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(0, 0, scrW, scrH)

	self:PostDrawScope()
end

function SWEP:DrawHUD()
	if self:GetAiming() then
		if self:GetScoped() and self.AimMul >= 0.99 then
			self:DrawScope()
			return
		end

		if not self.ZoomCrosshair then
			return
		end
	end

	if self:GetHolstering() then
		return
	end

	if not stalker_cop.CrosshairEnabled:GetBool() or not self.COP_DrawCrosshair then
		return
	end

	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	local FT, CT = FrameTime(), CurTime()
	local EP, EA = EyePos(), EyeAngles()

	local gap = (100 - self.Accuracy) * 0.01 + self.Primary.Spread * 10

	if stalker_cop.DynamicCrosshair:GetBool() then
		local inacc = self:GetAccuracy()
		gap = math.max(inacc, gap)
	end

	gap = gap * 64 + 2

	local alpha = 100

	local tr = util.TraceLine( util.GetPlayerTrace(self.Owner) )

	local x = ScrW() * 0.5
	local y = ScrH() * 0.5

	if self.Owner:GetViewEntity() ~= self.Owner then
		local toscreen = tr.HitPos:ToScreen()

		x = toscreen.x
		y = toscreen.y
	end

	--[[if IsValid(tr.Entity) then
		if tr.Entity:IsNPC() then
			setColor(255, 255, 160, alpha)
		elseif tr.Entity:IsPlayer() then
			if tr.Entity:Team() == self.Owner:Team() then
				setColor(0, 255, 0, alpha)
			else
				setColor(255, 0, 0, alpha)
			end
		else
			setColor(255, 255, 255, alpha)
		end
	else
		setColor(255, 255, 255, alpha)
	end]]

	--DrawLines(x, y, gap, 32, 1)
	--DrawLines(x, y, gap, 16, 1)
	--DrawDot(x, y, 1)
end

