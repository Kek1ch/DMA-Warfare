AddCSLuaFile()

SWEP.PrintName = "СКС"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/weapons/wick/stcopwep/sks_model.mdl"
SWEP.WorldModel    = "models/weapons/wick/stcopwep/w_sks_model.mdl"
SWEP.ViewModelFOV  = 48
SWEP.ViewModelFlip = false
SWEP.HoldType      = "shotgun"

SWEP.Damage   = 60
SWEP.RPM      = 240
SWEP.Accuracy = 85
SWEP.Handling = 75

SWEP.Primary.ClipSize    = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "762x39"

SWEP.OriginPos = Vector(0, 2, -6.5)
SWEP.OriginAng = Vector(2, 0, 0)


SWEP.AimPos = Vector(-3.87, -6, -3.03)
SWEP.AimAng = Vector(-0.1, 0.14, 0)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.25
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 4.25
SWEP.ReloadFillTime = 2

-- SWEP.SprintAnim = "idle_moving"

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.FireSound     = "COPSKSSCOP.sks_shoot"
SWEP.SilencedSound = ""
SWEP.EmptySound    = "COP_Generic.Empty"
SWEP.DeploySound   = "COPSKSSCOP.sks_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPSKSSCOP.sks_reload"