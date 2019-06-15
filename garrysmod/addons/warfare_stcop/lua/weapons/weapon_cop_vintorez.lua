AddCSLuaFile()

SWEP.PrintName = "ВСС «Винторез»"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/vss_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_vss_model_stcop.mdl"
SWEP.ViewModelFOV  = 48
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 42
SWEP.RPM      = 580
SWEP.Accuracy = 83
SWEP.Handling = 90

SWEP.Primary.ClipSize    = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "9x39"

SWEP.OriginPos = Vector(-2, 4, -6.5)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-7.6, 5, -3.8)
SWEP.AimAng = Vector(0.15, 0, 0)

SWEP.ScopeAimPos = Vector(-7.6, 0, -5.5)
SWEP.ScopeAimAng = Vector(0.15, 0, 0)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair_red"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 1
SWEP.ScopeMode    = 2

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 4
SWEP.ReloadFillTime = 3

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25 

SWEP.FireSound     = "COPVSSSTCOP.vintorez_shoot"
SWEP.SilencedSound = "COPVSSSTCOP.vintorez_shoot"
SWEP.EmptySound    = "COPVSSSTCOP.vintorez_empty"
SWEP.DeploySound   = "COPVSSSTCOP.vintorez_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPVSSSTCOP.vintorez_reload"
