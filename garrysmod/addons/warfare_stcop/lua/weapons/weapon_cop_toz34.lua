AddCSLuaFile()

SWEP.PrintName = "ТОЗ-34"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/weapons/wick/stcopwep/v_toz34.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_toz34_stcop.mdl"
SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.HoldType      = "shotgun"

SWEP.Damage   = 52
SWEP.RPM      = 1000
SWEP.Accuracy = 95
SWEP.Handling = 50

SWEP.Primary.BulletNum = 15
SWEP.Primary.Spread    = 0.04

SWEP.Primary.ClipSize    = 2
SWEP.Primary.DefaultClip = 2
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "12x70"

SWEP.OriginPos = Vector(-7, -2, -7)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-11.4, 0, -3.9)
SWEP.AimAng = Vector(0, 0.025, 0)

SWEP.ScopeTexture = "wpn_crosshair"

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.6

SWEP.ReloadTime     = 4
SWEP.ReloadFillTime = 3

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.FireSound     = "COPTOZ34COP.toz34_shoot"
SWEP.SilencedSound = "COP_AK74.Sil"
SWEP.EmptySound    = "COPTOZ34COP.toz34_empty"
SWEP.DeploySound   = "COPTOZ34COP.toz34_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = ""

local ReloadSound_L  = "COPTOZ34COP.toz34_reload_l"
local ReloadSound_LR = "COPTOZ34COP.toz34_reload_lr"

function SWEP:PreReload()
	if self:Clip1() <= 0 then
		self.ReloadSound = ReloadSound_LR

		self.ReloadTime = 4
		self.ReloadFillTime = 3
		return
	end

	self.ReloadSound = ReloadSound_L

	self.ReloadTime = 2.8
	self.ReloadFillTime = 2
end

function SWEP:GetReloadAnimation()
	if self:Clip1() <= 0 then
		return "reload_lr"
	end

	return "reload_l"
end