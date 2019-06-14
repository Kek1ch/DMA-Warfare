AddCSLuaFile()

SWEP.PrintName = "FN FNP-45"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 1
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/fnp_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_fnp_model_stcop.mdl"
SWEP.ViewModelFOV  = 42
SWEP.ViewModelFlip = false
SWEP.HoldType      = "pistol"

SWEP.Damage   = 34
SWEP.RPM      = 450
SWEP.Accuracy = 75
SWEP.Handling = 85

SWEP.Primary.ClipSize    = 16
SWEP.Primary.DefaultClip = 16
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "9x18"

SWEP.OriginPos = Vector(-1, -2, -7)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(-5.8, 2, -5.89)
SWEP.AimAng = Vector(0.1, 0.05, 0)

--SWEP.ShellModel = "models/shells/shell_9mm.mdl"

SWEP.SilencerBone = "wpn_silencer"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.6

SWEP.ReloadTime     = 2.8
SWEP.ReloadFillTime = 5

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.LastFire = true

SWEP.SlideBone = { name = "breachblock", pos = Vector(0, -1.2, 0) }

SWEP.ZoomFOV  = 70
SWEP.ScopeFOV = 50

SWEP.HiddenBones    = { "wpn_launcher" }

SWEP.FireSound     = "COPFNPSTCOP.fnp45_shoot"
SWEP.SilencedSound = "COPFNPSTCOP.fnp45_shot_sil"
SWEP.EmptySound    = "COP_Pistol.Empty"
SWEP.DeploySound   = "COPFNPSTCOP.fnp45_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPFNPSTCOP.fnp45_reload"