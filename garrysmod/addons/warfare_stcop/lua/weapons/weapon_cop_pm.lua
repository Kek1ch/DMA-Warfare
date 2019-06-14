AddCSLuaFile()

SWEP.PrintName = "ПМ"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 1
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/pm_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_pm_model_stcop.mdl"
SWEP.ViewModelFOV  = 50
SWEP.ViewModelFlip = false
SWEP.HoldType      = "pistol"

SWEP.Damage   = 32
SWEP.RPM      = 260
SWEP.Accuracy = 75
SWEP.Handling = 95

SWEP.Primary.ClipSize    = 8
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "9x18"

SWEP.OriginPos = Vector(0, -5, -7.1)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(-6, -2, -5.75)
SWEP.AimAng = Vector(0.25, 0, 0)

--SWEP.ShellModel = "models/shells/shell_9mm.mdl"

SWEP.SilencerBone = "wpn_silencer"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.6

SWEP.ReloadTime     = 3.2
SWEP.ReloadFillTime = 1.8

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.LastFire = true

SWEP.SlideBone = { name = "breachblock", pos = Vector(0, -1.2, 0) }

SWEP.ZoomFOV  = 70
SWEP.ScopeFOV = 50

SWEP.HiddenBones    = { "wpn_launcher" }

SWEP.FireSound     = "COPPM.pm_shoot"
SWEP.SilencedSound = "COPPM.pm_shot_sil"
SWEP.EmptySound    = "COPPM.pm_empty"
SWEP.DeploySound   = "COPPM.pm_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPPM.pm_reload"