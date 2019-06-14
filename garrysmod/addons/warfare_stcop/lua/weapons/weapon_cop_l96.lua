AddCSLuaFile()

SWEP.PrintName = "L96A1"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/l96_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_l96_model_stcop.mdl"
SWEP.ViewModelFOV  = 65
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 90
SWEP.RPM      = 32
SWEP.Accuracy = 70
SWEP.Handling = 95

SWEP.Primary.ClipSize    = 5
SWEP.Primary.DefaultClip = 5
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "338"

SWEP.OriginPos = Vector(-3, -6, -6.7)
SWEP.OriginAng = Vector(3, -1, 0)

SWEP.AimPos = Vector(-7.61, -6, -4.8)
SWEP.AimAng = Vector(-0.8, 0.1, 0)

SWEP.ScopeAimPos = Vector(-7.61, -11, -6.5)
SWEP.ScopeAimAng = Vector(0, 0, 0)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair_m821"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 2

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 4.35
SWEP.ReloadFillTime = 2

SWEP.SprintAnim = "idle_sprint"

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.FireSound     = "COPL96STCOP.l96a1_shoot"
SWEP.SilencedSound = ""
SWEP.EmptySound    = "COPSV98STCOP.sv98_empty"
SWEP.DeploySound   = "COPSV98STCOP.sv98_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPL96STCOP.l96a1_reload"