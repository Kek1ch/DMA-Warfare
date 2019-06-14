AddCSLuaFile()

SWEP.PrintName = "LR300"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/lr300_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_lr300_model_stcop.mdl"
SWEP.ViewModelFOV  = 45
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 30
SWEP.RPM      = 685
SWEP.Accuracy = 75
SWEP.Handling = 85

SWEP.Primary.ClipSize    = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "556x45"

SWEP.OriginPos = Vector(-2, 7, -8)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(-7.63, 2, -7.4)
SWEP.AimAng = Vector(0.1, 0, 0)

SWEP.ScopeAimPos = Vector(-7.61, -6, -7)
SWEP.ScopeAimAng = Vector(0.7, 0, 0)

SWEP.ScopeBone    = "wpn_scope"
SWEP.SilencerBone = "wpn_silencer"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 2

SWEP.ScopeAddon = "scope_susat"
SWEP.ScopeTexture = "wpn_crosshair_acog"

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 3
SWEP.ReloadFillTime = 1.6

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 40

SWEP.HiddenBones = { "wpn_launcher" }

SWEP.FireSound     = "COPLR300.lr300_shoot"
SWEP.SilencedSound = "COPLR300.lr300_shot_sil"
SWEP.EmptySound    = "COPLR300.lr300_empty"
SWEP.DeploySound   = "COPLR300.lr300_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPLR300.lr300_reload"