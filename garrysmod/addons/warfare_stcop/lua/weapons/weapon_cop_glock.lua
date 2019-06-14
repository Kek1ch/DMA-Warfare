AddCSLuaFile()

SWEP.PrintName = "Glock 19"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 1
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/glock_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_glock_model_stcop.mdl"
SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.HoldType      = "pistol"

SWEP.Damage   = 30
SWEP.RPM      = 520
SWEP.Accuracy = 81
SWEP.Handling = 88

SWEP.Primary.ClipSize    = 17
SWEP.Primary.DefaultClip = 17
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "9x19"

SWEP.OriginPos = Vector(-2.5, -9, -8)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-6.15, -5, -5.53)
SWEP.AimAng = Vector(0.7, 0, 0)

--SWEP.ShellModel = "models/shells/shell_9mm.mdl"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.6

SWEP.ReloadTime     = 4
SWEP.ReloadFillTime = 2

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0
SWEP.LastFire = true

SWEP.SilencerBone = "wpn_silencer"

SWEP.ZoomFOV  = 70
SWEP.ScopeFOV = 50

SWEP.HiddenBones    = { "wpn_launcher" }

SWEP.FireSound     = "COPGLOCKSTCOP.glock_shoot"
SWEP.SilencedSound = "COPGLOCKSTCOP.glock_shot_sil"
SWEP.EmptySound    = "COPPM.pm_empty"
SWEP.DeploySound   = "COPPM.pm_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPGLOCKSTCOP.glock_reload"