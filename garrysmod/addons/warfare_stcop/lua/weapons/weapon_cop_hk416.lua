AddCSLuaFile()

SWEP.PrintName = "HK416"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/hk416_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_hk416_model_stcop.mdl"
SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 36
SWEP.RPM      = 650
SWEP.Accuracy = 72
SWEP.Handling = 88

SWEP.Primary.ClipSize    = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "556x45"

SWEP.OriginPos = Vector(1, 3, 2.4)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-3.85, 3, 4.3)
SWEP.AimAng = Vector(0, 0, 0)

SWEP.ScopeAimPos = Vector(-3.85, -8, 3.4)
SWEP.ScopeAimAng = Vector(0, 0, 0)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair_acog"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 2

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 3.9
SWEP.ReloadFillTime = 2

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.HiddenBones = { "wpn_launcher", "gl_trigger", "grenade", "przesuw", "muzzle_gl" }

SWEP.FireSound     = "COPLR300.lr300_shoot"
SWEP.SilencedSound = "COPLR300.lr300_shot_sil"
SWEP.EmptySound    = "COPLR300.lr300_empty"
SWEP.DeploySound   = "COPLR300.lr300_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPHK416STCOP.hk416_reload"