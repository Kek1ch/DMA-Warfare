AddCSLuaFile()

SWEP.PrintName = "Walter P99"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 1
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/p99_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_p99_model.mdl"
SWEP.ViewModelFOV  = 50
SWEP.ViewModelFlip = false
SWEP.HoldType      = "pistol"

SWEP.Damage   = 36
SWEP.RPM      = 265
SWEP.Accuracy = 83
SWEP.Handling = 94

SWEP.Primary.ClipSize    = 16
SWEP.Primary.DefaultClip = 16
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "9x19"

SWEP.OriginPos = Vector(-1, -7, -7)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(-5.8, -2, -6.05)
SWEP.AimAng = Vector(1, 0.21, 0)

--SWEP.ShellModel = "models/shells/shell_9mm.mdl"

SWEP.SilencerBone = "wpn_silencer"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.6

SWEP.ReloadTime     = 3
SWEP.ReloadFillTime = 1.8

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.LastFire = true

SWEP.SlideBone = { name = "breachblock", pos = Vector(0, -1.2, 0) }

SWEP.ZoomFOV  = 70
SWEP.ScopeFOV = 50

SWEP.HiddenBones    = { "wpn_launcher" }

SWEP.FireSound     = "COPP99.walther_shoot"
SWEP.SilencedSound = "COPP99.walther_shot_sil"
SWEP.EmptySound    = "COPP99.walther_empty"
SWEP.DeploySound   = "COPP99.walther_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPP99.walther_reload"
