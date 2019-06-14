AddCSLuaFile()

SWEP.PrintName = "ОЦ-14 «Гроза»"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/groza_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_groza_model_stcop.mdl"
SWEP.ViewModelFOV  = 54
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 40
SWEP.RPM      = 620
SWEP.Accuracy = 73
SWEP.Handling = 87

SWEP.Primary.ClipSize    = 20
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "9x39"

SWEP.OriginPos = Vector(-3.5, 4, -6)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(-7.6, 4, -7.32)
SWEP.AimAng = Vector(1, 0, 0)

SWEP.ScopeAimPos = Vector(-7.6, 0, -9)
SWEP.ScopeAimAng = Vector(1.5, 0, 0)

SWEP.ScopeBone    = "wpn_scope"
SWEP.SilencerBone = "wpn_silencer"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SprintAnim = "idle_sprint"

SWEP.ScopeTexture = "wpn_crosshair_4x34"

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 2

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 4
SWEP.ReloadFillTime = 1.4

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.FireSound     = "COPGROZA.groza_shoot"
SWEP.SilencedSound = "COPGROZA.groza_shot_sil"
SWEP.EmptySound    = "COP_Generic.Empty"
SWEP.DeploySound   = "COPGROZA.groza_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPGROZA.groza_reload"