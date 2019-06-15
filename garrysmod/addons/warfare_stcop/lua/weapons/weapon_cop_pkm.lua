AddCSLuaFile()

SWEP.PrintName = "ПКМ"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 3
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/pkm_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_pkm_model.mdl"
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
SWEP.Primary.Ammo        = "762x54"

SWEP.OriginPos = Vector(-2, -1, -8)
SWEP.OriginAng = Vector(3, 0, 0)

SWEP.AimPos = Vector(-7.759, 1, -6.59)
SWEP.AimAng = Vector(-0.1, 0, 0)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.SprintAnim = "idle_sprint"

SWEP.ScopeTexture = "wpn_crosshair"

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

SWEP.FireSound     = "COPPKM.pkm_shoot"
SWEP.EmptySound    = "COPPKM.pkm_empty"
SWEP.ReloadSound   = "COPPKM.pkm_reload"
SWEP.DeploySound   = "COPPKM.pkm_draw"
SWEP.HolsterSound  = "COPPKM.pkm_holster"
