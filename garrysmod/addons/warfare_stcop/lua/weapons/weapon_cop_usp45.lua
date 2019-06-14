AddCSLuaFile()

SWEP.PrintName = "USP"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 1
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/usp_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_usp_model_stcop.mdl"
SWEP.ViewModelFOV  = 45
SWEP.ViewModelFlip = false
SWEP.HoldType      = "pistol"

SWEP.Damage   = 42
SWEP.RPM      = 240
SWEP.Accuracy = 81
SWEP.Handling = 85

SWEP.Primary.ClipSize    = 8
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "45acp"

SWEP.OriginPos = Vector(-1, -1, -7)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(-5.9, 2, -5.4)
SWEP.AimAng = Vector(-0.2, -0.05, 0)

--SWEP.ShellModel = "models/shells/shell_9mm.mdl"

SWEP.SilencerBone = "wpn_silencer"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.6

SWEP.ReloadTime     = 2.5
SWEP.ReloadFillTime = 1.8

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.LastFire = true

SWEP.SlideBone = { name = "breachblock", pos = Vector(0, -1.2, 0) }

SWEP.ZoomFOV  = 70
SWEP.ScopeFOV = 50

SWEP.HiddenBones    = { "wpn_launcher" }

SWEP.FireSound     = "COPUSP.usp_shoot"
SWEP.SilencedSound = "COPUSP.usp_shot_sil"
SWEP.EmptySound    = "COPUSP.usp_empty"
SWEP.DeploySound   = "COPUSP.usp_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPUSP.usp_reload"