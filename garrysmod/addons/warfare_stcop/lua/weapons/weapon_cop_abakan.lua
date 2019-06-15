AddCSLuaFile()

SWEP.PrintName = "АН-94"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/weapons/wick/stcopwep/v_abakan.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_abakan_stcop.mdl"
SWEP.ViewModelFOV  = 50
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 31
SWEP.RPM      = 570
SWEP.Accuracy = 70
SWEP.Handling = 88

SWEP.Primary.ClipSize    = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "545x39"

SWEP.OriginPos = Vector(-7, -2, -7)
SWEP.OriginAng = Vector(2, -2, 0)

SWEP.AimPos = Vector(-10.935, 3, -5.39)
SWEP.AimAng = Vector(0.6, 0.1, 0)

SWEP.ScopeAimPos = Vector(-10.935, 3, -6)
SWEP.ScopeAimAng = Vector(0.6, 0.1, 0)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair_red"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 2

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 3.25
SWEP.ReloadFillTime = 1.4

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.HiddenBones = { "wpn_launcher", "joint6" }

SWEP.FireSound     = "COPABAKANSCOP.abakan_shoot"
SWEP.SilencedSound = "COPABAKANSCOP.abakan_shot_sil"
SWEP.EmptySound    = "COPABAKANSCOP.abakan_empty"
SWEP.DeploySound   = "COPABAKANSCOP.abakan_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPABAKANSCOP.abakan_reload"
