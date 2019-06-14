AddCSLuaFile()

SWEP.PrintName = "Mauser 98k"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/weapons/wick/stcopwep/v_kar98.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_kar98_stcop.mdl"
SWEP.ViewModelFOV  = 48
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 60
SWEP.RPM      = 30
SWEP.Accuracy = 85
SWEP.Handling = 75

SWEP.Primary.ClipSize    = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "762x54"

SWEP.OriginPos = Vector(-6.5, 0, -6.8)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-11.2, 7, -4.5)
SWEP.AimAng = Vector(0, 0.1, 0)

SWEP.ScopeAimPos = Vector(-11.2, -11, -5.2)
SWEP.ScopeAimAng = Vector(0, 0, 0)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair_zf9"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 2

SWEP.AimTime    = 0.25
SWEP.DeployTime = 0.8

SWEP.ReloadTime      = 1
SWEP.ReloadEndTime   = 1
SWEP.ReloadStartTime = 1
SWEP.ReloadFillTime  = 1
-- SWEP.SprintAnim = "idle_moving"

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 1

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.FireSound     = "COPKARYAKCOP.kar98k_shoot"
SWEP.SilencedSound = "COPKARYAKCOP.kar98k_shoot_sil"
SWEP.EmptySound    = "COP_Generic.Empty"
SWEP.DeploySound   = "COP_Generic.Draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPKARYAKCOP.kar98k_reload"
SWEP.OpenSound     = "COPKARYAKCOP.kar98k_reload_start"
SWEP.CloseSound    = "COPKARYAKCOP.kar98k_reload_end"