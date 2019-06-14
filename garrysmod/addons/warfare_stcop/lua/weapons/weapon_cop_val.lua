AddCSLuaFile()

SWEP.PrintName = "АС «Вал»"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/val_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_val_model_stcop.mdl"
SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 42
SWEP.RPM      = 580
SWEP.Accuracy = 80
SWEP.Handling = 90

SWEP.Primary.ClipSize    = 20
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "9x39"

SWEP.OriginPos = Vector(-3, 1, -6)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-7.6, 0, -3.75)
SWEP.AimAng = Vector(0.3, 0.02, 0)

SWEP.ScopeAimPos = Vector(-7.6, -4, -5.5)
SWEP.ScopeAimAng = Vector(0, 0, 0)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair_red"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 1
SWEP.ScopeMode    = 2

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 4.7
SWEP.ReloadFillTime = 1.4

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.FireSound     = "COPVALSTCOP.val_shoot"
SWEP.SilencedSound = "COPVALSTCOP.val_shoot"
SWEP.EmptySound    = "COPVALSTCOP.val_empty"
SWEP.DeploySound   = "COPVALSTCOP.val_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPVALSTCOP.val_reload"