AddCSLuaFile()

SWEP.PrintName = "СВ-98"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/sv98_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_sv98_model_stcop.mdl"
SWEP.ViewModelFOV  = 65
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 90
SWEP.RPM      = 32
SWEP.Accuracy = 70
SWEP.Handling = 95

SWEP.Primary.ClipSize    = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "762x54"

SWEP.OriginPos = Vector(-4.5, -6, -7.1)
SWEP.OriginAng = Vector(1, 0, 0)

SWEP.AimPos = Vector(-7.61, -6, -4.35)
SWEP.AimAng = Vector(-0.15, 0.1, 0)

SWEP.ScopeAimPos = Vector(-7.61, -8, -5.5)
SWEP.ScopeAimAng = Vector(0, 0, 0)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair_pks07"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 2

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 4.1
SWEP.ReloadFillTime = 3

SWEP.SprintAnim = "idle_sprint"

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.FireSound     = "COPSV98STCOP.sv98_shoot"
SWEP.SilencedSound = ""
SWEP.EmptySound    = "COPSV98STCOP.sv98_empty"
SWEP.DeploySound   = "COPSV98STCOP.sv98_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPSV98STCOP.sv98_reload"