AddCSLuaFile()

SWEP.PrintName = "АКМС"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/weapons/wick/stcopwep/v_akmc.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_ak_74_model_stcop.mdl"
SWEP.ViewModelFOV  = 48
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

SWEP.OriginPos = Vector(-3, 0, -6.5)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-7.65, 3, -5)
SWEP.AimAng = Vector(0.15, 0.05, 0)

SWEP.ScopeAimPos = Vector(-7.65, 0, -6)
SWEP.ScopeAimAng = Vector(1, 0.1, 0)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair_red"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 2

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

SWEP.FireSound     = "COPAKMSCOP.akm_shoot"
SWEP.SilencedSound = "COPAK_74SCOP.ak74_shot_sil_stcop"
SWEP.EmptySound    = "COP_Generic.Empty"
SWEP.DeploySound   = "COP_AK74.Draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPAK_74SCOP.ak74_reload"
