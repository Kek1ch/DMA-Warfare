AddCSLuaFile()

SWEP.PrintName = "СВУ"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/svu_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_svu_model_stcop.mdl"
SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 49
SWEP.RPM      = 180
SWEP.Accuracy = 85
SWEP.Handling = 75

SWEP.Primary.ClipSize    = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "762x54"

SWEP.OriginPos = Vector(-1, 2, -6)
SWEP.OriginAng = Vector(2, -2, 0)

SWEP.AimPos = Vector(-4.9, -2, -5)
SWEP.AimAng = Vector(1, -0.65, 0)

SWEP.ScopeAimPos = Vector(-4.6, -2, -6.2)
SWEP.ScopeAimAng = Vector(0, 0, 0)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair_red"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 1

SWEP.AimTime    = 0.25
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 5.1
SWEP.ReloadFillTime = 4

-- SWEP.SprintAnim = "idle_moving"

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.FireSound     = "COPSVUSCOP.svu_shoot"
SWEP.SilencedSound = "COP_AK74.Sil"
SWEP.EmptySound    = "COP_Generic.Empty"
SWEP.DeploySound   = "COPSVUSCOP.svu_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPSVUSCOP.svu_reload_stcop"