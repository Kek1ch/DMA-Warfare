AddCSLuaFile()

SWEP.PrintName = "MP-153"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 3
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/mp153_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_mp153_model.mdl"
SWEP.ViewModelFOV  = 42
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 51
SWEP.RPM      = 260
SWEP.Accuracy = 95
SWEP.Handling = 70

SWEP.Primary.BulletNum = 8
SWEP.Primary.Spread    = 0.033

SWEP.Primary.ClipSize    = 6
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "12x70"

SWEP.OriginPos = Vector(-2, 4, -6)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-7.63, 0, -3.8)
SWEP.AimAng = Vector(0.5, 0, 0)

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime      = 1
SWEP.ReloadEndTime   = 0.8
SWEP.ReloadStartTime = 0.8
SWEP.ReloadFillTime  = 1.4

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 1

SWEP.ZoomFOV  = 75
SWEP.ScopeFOV = 50

SWEP.HiddenBones    = { "wpn_launcher" }

SWEP.FireSound     = "COPMP153STCOP.mp153_shoot"
SWEP.SilencedSound = ""
SWEP.EmptySound    = "COP_Generic.Empty"
SWEP.DeploySound   = "COPMP153STCOP.mp153_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPMP153STCOP.mp153_insertshell"
SWEP.OpenSound     = ""
SWEP.CloseSound    = ""