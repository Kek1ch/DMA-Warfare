AddCSLuaFile()

SWEP.PrintName = "АК-74"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/ak_74_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_ak_74_model_stcop.mdl"
SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 36
SWEP.RPM      = 570
SWEP.Accuracy = 67
SWEP.Handling = 86

SWEP.Primary.ClipSize    = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "545x39"

SWEP.OriginPos = Vector(0.4, 3, 0.1)
SWEP.OriginAng = Vector(1, 0, 0)

SWEP.AimPos = Vector(-2.78, 3, 1.62)
SWEP.AimAng = Vector(0.26, 0, 0)

SWEP.ScopeAimPos = Vector(-2.78, 0, 1.62)
SWEP.ScopeAimAng = Vector(0, 0, 0)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair_red"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 2

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 4.5
SWEP.ReloadFillTime = 3

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.HiddenBones = { "wpn_launcher" }

SWEP.FireSound     = "COPAK_74SCOP.ak74_shoot"
SWEP.SilencedSound = "COPAK_74SCOP.ak74_shot_sil_stcop"
SWEP.EmptySound    = "COP_Generic.Empty"
SWEP.DeploySound   = "COPAK_74SCOP.ak74_draw_stcop"
SWEP.HolsterSound  = "COPAK_74SCOP.ak74_holster"
SWEP.ReloadSound   = "COPAK_74SCOP.ak74_reload"
