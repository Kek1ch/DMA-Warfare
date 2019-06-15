AddCSLuaFile()

SWEP.PrintName = "АЕК-971"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/aek_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_aek_model_stcop.mdl"
SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 31
SWEP.RPM      = 580
SWEP.Accuracy = 67
SWEP.Handling = 87

SWEP.Primary.ClipSize    = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "545x39"

SWEP.OriginPos = Vector(-2.5, 0, -7.5)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-7.63, 4, -6.4)
SWEP.AimAng = Vector(1.5, 0.05, 0)

SWEP.ScopeAimPos = Vector(-7, -8, -7.5)
SWEP.ScopeAimAng = Vector(1, 0.5, 0)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair_red"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 2

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 3
SWEP.ReloadFillTime = 1.4

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.HiddenBones = { "wpn_launcher" }

SWEP.FireSound     = "COPAEK.aek971_shoot"
SWEP.SilencedSound = "COPAK74.ak74_shot_sil"
SWEP.EmptySound    = "COP_Generic.Empty"
SWEP.DeploySound   = "COPAK74.ak_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPAEK.aek971_reload"
