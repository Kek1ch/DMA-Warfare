AddCSLuaFile()

SWEP.PrintName = "M60"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 3
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/weapons/wick/stcopwep/m60_model.mdl"
SWEP.WorldModel    = "models/weapons/wick/stcopwep/m60_model_world.mdl"
SWEP.ViewModelFOV  = 60
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 50
SWEP.RPM      = 525
SWEP.Accuracy = 68
SWEP.Handling = 87

SWEP.Primary.ClipSize    = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Automatic   = true
--SWEP.Primary.Ammo        = "762x63"
SWEP.Primary.Ammo        = "556x45"


SWEP.OriginPos = Vector(-2, -1, -9)
SWEP.OriginAng = Vector(3, 0, 0)

SWEP.AimPos = Vector(-7.53, 1, -8.25)
SWEP.AimAng = Vector(0.4, 0.1, 0)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.SprintAnim = "idle_sprint"

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.6

SWEP.ReloadTime     = 7.6
SWEP.ReloadFillTime = 5

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.HiddenBones = { "wpn_launcher" }

SWEP.FireSound     = "m60_shoot"
SWEP.EmptySound    = "COP_Generic.Empty"
SWEP.ReloadSound   = "m60_reload"
SWEP.DeploySound   = "COP_Generic.Draw"
SWEP.HolsterSound  = "COP_Generic.Holster"