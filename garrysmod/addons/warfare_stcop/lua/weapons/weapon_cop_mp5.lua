AddCSLuaFile()

SWEP.PrintName = "MP5"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/mp5_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_mp5_model_stcop.mdl"
SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.HoldType      = "smg"

SWEP.Damage   = 35
SWEP.RPM      = 620
SWEP.Accuracy = 68
SWEP.Handling = 85

SWEP.Primary.ClipSize    = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "9x19"

SWEP.OriginPos = Vector(0, 5, 0)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(-3.4, 4, 0.8)
SWEP.AimAng = Vector(0.3, 0, 0)

SWEP.SilencerBone = "wpn_silencer"

--SWEP.ShellModel = "models/shells/shell_9mm.mdl"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 2.85
SWEP.ReloadFillTime = 1.4

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.HiddenBones = { "wpn_launcher" }

SWEP.FireSound     = "COPMP5.SHOOTSTCOP"
SWEP.SilencedSound = "COPMP5.SHOOTSILSTCOP"
SWEP.EmptySound    = "COPMP5.EMPTSTCOP"
SWEP.DeploySound   = "COPMP5.DELPOY"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPMP5.RELOADSTCOP"