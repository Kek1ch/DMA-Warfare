AddCSLuaFile()

SWEP.PrintName = "L85A2"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/l85_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_l85_model_stcop.mdl"
SWEP.ViewModelFOV  = 60
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 31
SWEP.RPM      = 650
SWEP.Accuracy = 70
SWEP.Handling = 85

SWEP.Primary.ClipSize    = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "556x45"

SWEP.OriginPos = Vector(-3, 2, -7.5)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-7.61, -1, -7)
SWEP.AimAng = Vector(0.7, 0, 0)

SWEP.ScopeBone    = "wpn_scope"
SWEP.SilencerBone = "wpn_silencer"

SWEP.ScopeTexture = "wpn_crosshair_l85_stcop"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 1

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 3.5
SWEP.ReloadFillTime = 1.6

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = true

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 40

SWEP.HiddenBones = { "wpn_launcher" }

SWEP.FireSound     = "COPLR85.l85_shoot"
SWEP.SilencedSound = "COPLR85.l85_shot_sil"
SWEP.EmptySound    = "COPLR85.l85_empty"
SWEP.DeploySound   = "COPLR85.l85_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPLR85.l85_reload"