AddCSLuaFile()

SWEP.PrintName = "ПП-19 «Бизон»"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/bizon_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_bizon_model.mdl"
SWEP.ViewModelFOV  = 42
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 30
SWEP.RPM      = 575
SWEP.Accuracy = 75
SWEP.Handling = 88

SWEP.Primary.ClipSize    = 64
SWEP.Primary.DefaultClip = 64
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "9x18"

SWEP.OriginPos = Vector(-4, 5, -6)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(-8.4, 10, -5.55)
SWEP.AimAng = Vector(0.8, -1.05, -1.5)

SWEP.ScopeAimPos = Vector(-8.4, 7, -6)
SWEP.ScopeAimAng = Vector(0.8, -1.05, -1.5)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair_red"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 2

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 4
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