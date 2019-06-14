AddCSLuaFile()

SWEP.PrintName = "СВД"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/svd_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_svd_model.mdl"
SWEP.ViewModelFOV  = 60
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 80
SWEP.RPM      = 90
SWEP.Accuracy = 90
SWEP.Handling = 90

SWEP.Primary.ClipSize    = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "762x54"

SWEP.OriginPos = Vector(0, 3, -1)
SWEP.OriginAng = Vector(4, 0, 0)

SWEP.AimPos = Vector(-3.775, 2.5, 1.42)
SWEP.AimAng = Vector(1.3, 0.5, 0)

SWEP.ScopeAimPos = Vector(-3.775, 2.5, 0.7)
SWEP.ScopeAimAng = Vector(0.1, 0, 0)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair_red"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 2

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 5
SWEP.ReloadFillTime = 2

SWEP.SprintAnim = "idle_sprint"

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.FireSound     = "COPSNPER.FireSVDSTCOP"
SWEP.SilencedSound = "COPSNPER.FireSVDSTCOPSILENS"
SWEP.EmptySound    = "COP_Generic.Empty"
SWEP.DeploySound   = "COPSNPER.SVDDRAWSTCOP"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPSNPER.SVDRELOADSTCOP"