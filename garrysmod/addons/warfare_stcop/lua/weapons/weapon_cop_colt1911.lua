AddCSLuaFile()

SWEP.PrintName = "Colt M1911"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 1
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/colt_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_colt_model_stcop.mdl"
SWEP.ViewModelFOV  = 42
SWEP.ViewModelFlip = false
SWEP.HoldType      = "pistol"

SWEP.Damage   = 43
SWEP.RPM      = 190
SWEP.Accuracy = 74
SWEP.Handling = 85

SWEP.Primary.ClipSize    = 7
SWEP.Primary.DefaultClip = 7
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "45acp"

SWEP.OriginPos = Vector(-1.5, -5, -6.5)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(-5.9, 4, -5.79)
SWEP.AimAng = Vector(0.5, 0, 0)

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

SWEP.FireSound     = "COPCOLT.colt_shoot"
SWEP.SilencedSound = "COPCOLT.colt_shot_sil"
SWEP.EmptySound    = "COPCOLT.colt_empty"
SWEP.DeploySound   = "COPCOLT.colt_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPCOLT.de_reload"
