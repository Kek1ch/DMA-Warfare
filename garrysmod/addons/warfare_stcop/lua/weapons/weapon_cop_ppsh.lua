AddCSLuaFile()

SWEP.PrintName = "ППШ"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 0
SWEP.SlotPos = 0

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/weapons/wick/stcopwep/ppsh_model.mdl"
SWEP.WorldModel    = "models/weapons/wick/stcopwep/w_ppsh_model.mdl"
SWEP.ViewModelFOV  = 42
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 30
SWEP.RPM      = 575
SWEP.Accuracy = 75
SWEP.Handling = 88

SWEP.Primary.ClipSize    = 71
SWEP.Primary.DefaultClip = 71
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "9x18"

SWEP.OriginPos = Vector(-6, 5, -6.6)
SWEP.OriginAng = Vector(1, 0, 0)

SWEP.AimPos = Vector(-11.17, 16 , -4.9)
SWEP.AimAng = Vector(0.1, 0, 0)

SWEP.ScopeAimPos = Vector(-8.4, 7, -6)
SWEP.ScopeAimAng = Vector(0.8, -1.05, -1.5)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair_red"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 3.9
SWEP.ReloadFillTime = 1.4

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.ReloadType = 0

SWEP.FireSound     = "COPBIZON.SHOOTSTCOP"
SWEP.SilencedSound = "COPBIZON.SHOOTSILSTCOP"
SWEP.EmptySound    = "COP_Generic.Empty"
SWEP.DeploySound   = "COP_AK74.Draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPBIZON.RELOADSTCOP"