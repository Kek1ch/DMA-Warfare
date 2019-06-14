AddCSLuaFile()

SWEP.PrintName = "Browning HP"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 1
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/hpsa_model_nohands.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_wpn_hpsa_stcop.mdl"
SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.HoldType      = "pistol"

SWEP.Damage   = 37
SWEP.RPM      = 290
SWEP.Accuracy = 74
SWEP.Handling = 95

SWEP.Primary.ClipSize    = 13
SWEP.Primary.DefaultClip = 13
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "9x19"

SWEP.OriginPos = Vector(-1, -8, -8)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-5.85, -6, -5.95)
SWEP.AimAng = Vector(0.8, -0.02, 0)

--SWEP.ShellModel = "models/shells/shell_9mm.mdl"

SWEP.SilencerBone = "wpn_silencer"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.6

SWEP.ReloadTime     = 3.25
SWEP.ReloadFillTime = 3

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.LastFire = true

SWEP.ZoomFOV  = 70
SWEP.ScopeFOV = 50

SWEP.FireSound     = "COPBROWINGSCOP.hpsa_shoot"
SWEP.SilencedSound = "COPBROWINGSCOP.hpsa_shot_sil"
SWEP.EmptySound    = "COPBROWINGSCOP.hpsa_empty"
SWEP.DeploySound   = "COPBROWINGSCOP.hpsa_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPBROWINGSCOP.hpsa_reload"