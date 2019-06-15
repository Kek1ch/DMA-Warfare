AddCSLuaFile()

SWEP.PrintName = "Гаусс-пушка («Изделие №62»)"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 3
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.ViewModel     = "models/weapons/wick/stcopwep/gaus_model.mdl"
SWEP.WorldModel    = "models/weapons/wick/stcopwep/w_gaus_model_stcop.mdl"
SWEP.ViewModelFOV  = 42
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 200
SWEP.RPM      = 30
SWEP.Accuracy = 100
SWEP.Handling = 90

SWEP.Primary.PenMul   = 0
SWEP.Primary.Ricochet = false

SWEP.Primary.ClipSize    = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "gaus"

SWEP.OriginPos = Vector(-3.1, 4, -8.5)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-8, 0, -7.2)
SWEP.AimAng = Vector(0.7, 0, 0)

SWEP.ScopeBone    = "wpn_scope"
SWEP.SilencerBone = "wpn_silencer"

SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.ScopeTexture = "wpn_crosshair_pks07"

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 1

SWEP.AimTime    = 0.25
SWEP.DeployTime = 0.8

SWEP.FireIdleTime = 0.2

SWEP.ReloadTime     = 3
SWEP.ReloadFillTime = 2.6

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

--[[SWEP.WorldMatrix = {
	Pos = Vector(0, 1, 1),
	Ang = Vector(-10, 180, 0)
}]]

SWEP.FireSound     = "gauss_shot"
SWEP.SilencedSound = "gauss_shot"
SWEP.EmptySound    = "gauss_empty"
SWEP.DeploySound   = "gauss_draw"
SWEP.HolsterSound  = "gauss_holster"
SWEP.ReloadSound   = "gauss_reload"

function SWEP:CreateMuzzleEffect()
	local effectdata = EffectData()
	effectdata:SetEntity(self)
	effectdata:SetAttachment(1)
	effectdata:SetNormal(self.Owner:GetAimVector())

	util.Effect("cop_muzzleflash_plasma", effectdata)
end

function SWEP:BulletCallback(tr, dmginfo)
	local pos, ang = self:GetTracerOrigin()
	pos = pos + ang:Up() * -8

	if not self:GetAiming() then
		pos = pos + ang:Forward() * 6
	end

	if (game.SinglePlayer() and SERVER) or (not game.SinglePlayer() and CLIENT and IsFirstTimePredicted()) then
		if tr.HitPos then
			util.ParticleTracerEx("cop_gauss_rail", pos, tr.HitPos, false, -1, 1)
		end
	end
end
