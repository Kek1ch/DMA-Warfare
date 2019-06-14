AddCSLuaFile()

SWEP.PrintName = "Фонарик"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 4
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/flashlight_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_lashlight_model_misery.mdl"
SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.HoldType      = "slam"

SWEP.Damage   = 0
SWEP.RPM      = 0
SWEP.Accuracy = 0
SWEP.Handling = 0

SWEP.Primary.ClipSize    = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "none"

SWEP.OriginPos = Vector(5, -2, -12)
SWEP.OriginAng = Vector(8.5, 9, 0)

SWEP.AimPos = Vector(0, 0, 0)
SWEP.AimAng = Vector(0, 0, 0)

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 0
SWEP.ReloadFillTime = 0

SWEP.CanZoom       = false
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.DeploySound   = "COPFLASHLIGHT.flashlight_draw"
SWEP.HolsterSound  = "COPFLASHLIGHT.flashlight_holster"
SWEP.ZoomInSound   = ""
SWEP.ZoomOutSound  = ""

SWEP.DoAimAnimation = false

function SWEP:ZoomThink()
end

function SWEP:Reload()
end