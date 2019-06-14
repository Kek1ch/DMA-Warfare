AddCSLuaFile()

SWEP.PrintName = "SPAS-12"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 3
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/spas_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_spas_model_stcop.mdl"
SWEP.ViewModelFOV  = 50
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 51
SWEP.RPM      = 115
SWEP.Accuracy = 95
SWEP.Handling = 60

SWEP.Primary.BulletNum = 8
SWEP.Primary.Spread    = 0.033

SWEP.Primary.ClipSize    = 8
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "12x70"

SWEP.OriginPos = Vector(-4, 0, -5.2)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(-7.6, 0, -4.2)
SWEP.AimAng = Vector(1, 0, 0)

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

SWEP.FireSound     = "COPSPAS.spas12_shoot"
SWEP.SilencedSound = ""
SWEP.EmptySound    = "COPSPAS.spas12_empty"
SWEP.DeploySound   = "COPSPAS.lr300_draw"
SWEP.HolsterSound  = "COPSPAS.spas12_holster"
SWEP.ReloadSound   = "COPSPAS.spas12_load"
SWEP.OpenSound     = "COPSPAS.spas12_open"
SWEP.CloseSound    = "COPSPAS.spas12_reload_end"