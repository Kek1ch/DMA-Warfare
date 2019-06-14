AddCSLuaFile()

SWEP.PrintName = "Форт-12"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 1
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/fort_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_fort_model_stcop.mdl"
SWEP.ViewModelFOV  = 45
SWEP.ViewModelFlip = false
SWEP.HoldType      = "pistol"

SWEP.Damage   = 33
SWEP.RPM      = 430
SWEP.Accuracy = 78
SWEP.Handling = 95

SWEP.Primary.ClipSize    = 12
SWEP.Primary.DefaultClip = 12
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "9x18"

SWEP.OriginPos = Vector(-1, -4, -8)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-6, -2, -5.6)
SWEP.AimAng = Vector(0.42, -0.05, 0)

--SWEP.ShellModel = "models/shells/shell_9mm.mdl"

SWEP.SilencerBone = "wpn_silencer"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.6

SWEP.ReloadTime     = 2.2
SWEP.ReloadFillTime = 1.8

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.LastFire = true

SWEP.ZoomFOV  = 70
SWEP.ScopeFOV = 50

SWEP.FireSound     = "COPFORTSCOP.fort_shoot"
SWEP.SilencedSound = "COPFORTSCOP.fort_shot_sil"
SWEP.EmptySound    = "COPFORTSCOP.fort_empty"
SWEP.DeploySound   = "COPFORTSCOP.fort_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPFORTSCOP.fort_reload"
