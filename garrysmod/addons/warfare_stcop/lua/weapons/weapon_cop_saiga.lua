AddCSLuaFile()

SWEP.PrintName = "Сайга"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/weapons/wick/stcopwep/saiga_model.mdl"
SWEP.WorldModel    = "models/weapons/wick/stcopwep/w_saiga_model.mdl"
SWEP.ViewModelFOV  = 42
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 34
SWEP.RPM      = 400
SWEP.Accuracy = 80
SWEP.Handling = 65

SWEP.Primary.BulletNum = 8
SWEP.Primary.Spread    = 0.033

SWEP.Primary.ClipSize    = 8
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "12x70"

SWEP.OriginPos = Vector(-4, 4, -6.5)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-7.6, 0, -4.35)
SWEP.AimAng = Vector(0.1, 0.1, 0)

SWEP.ScopeAimPos = Vector(-7.6, 0, -5)
SWEP.ScopeAimAng = Vector(0.5, 0, 0)

SWEP.ScopeBone    = "wpn_scope"
SWEP.SilencerBone = "wpn_silencer"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 2

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime      = 2.81
SWEP.ReloadFillTime  = 1.4
--SWEP.ReloadEndTime   = 0
--SWEP.ReloadStartTime = 0

SWEP.ScopeTexture = "wpn_crosshair_red"

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 75
SWEP.ScopeFOV = 50

SWEP.HiddenBones    = { "wpn_launcher" }

SWEP.FireSound     = "COPSAIGA.saiga_shoot"
SWEP.SilencedSound = "COPSAIGA.saiga_shot_sil"
SWEP.EmptySound    = "COP_Generic.Empty"
SWEP.DeploySound   = "COP_Generic.Draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPSAIGA.saiga_reload"