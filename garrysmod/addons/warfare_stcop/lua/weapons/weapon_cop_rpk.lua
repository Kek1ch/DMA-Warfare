AddCSLuaFile()

SWEP.PrintName = "РПК"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/rpk_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_rpk_model_stcop.mdl"
SWEP.ViewModelFOV  = 45
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 44
SWEP.RPM      = 550
SWEP.Accuracy = 79
SWEP.Handling = 84

SWEP.Primary.ClipSize    = 45
SWEP.Primary.DefaultClip = 45
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "545x39"

SWEP.OriginPos = Vector(-8, 2, -8)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-10.865, -2, -5.89)
SWEP.AimAng = Vector(-0.1, -0, 0)

SWEP.ScopeAimPos = Vector(-10, -3, -6.6)
SWEP.ScopeAimAng = Vector(-0.1, -0, 0)

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 2

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair_red"

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.6

SWEP.ReloadTime     = 3.55
SWEP.ReloadFillTime = 3

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.LastFire = false

SWEP.ZoomFOV  = 70
SWEP.ScopeFOV = 25

SWEP.HiddenBones    = { "wpn_launcher" }

SWEP.FireSound     = "COPRPKSCOP.rpk74_shoot"
SWEP.SilencedSound = "COPAK_74SCOP.ak74_shot_sil_stcop"
SWEP.EmptySound    = "COP_Pistol.Empty"
SWEP.DeploySound   = "COP_PM.Draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPRPKSCOP.rpk74_reload"
