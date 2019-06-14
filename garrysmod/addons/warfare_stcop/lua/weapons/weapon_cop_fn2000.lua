AddCSLuaFile()

SWEP.PrintName = "FN F2000"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/fn2000_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_fn2000_model_stcop.mdl"
SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 35
SWEP.RPM      = 630
SWEP.Accuracy = 80
SWEP.Handling = 85

SWEP.Primary.ClipSize    = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "556x45"

SWEP.OriginPos = Vector(-4, 4, -11)
SWEP.OriginAng = Vector(3, 0, 0)

SWEP.ScopeAimPos = Vector(-9.5, 2.5, -10)
SWEP.ScopeAimAng = Vector(0.1, 0, 0)

SWEP.ScopeBone    = "wpn_scope"
SWEP.SilencerBone = "wpn_silencer"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.ScopeTexture = "wpn_crosshair_fn2000"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 1

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 3
SWEP.ReloadFillTime = 0

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.HiddenBones = { "wpn_launcher" }

SWEP.SprintAnim = "idle_sprint"

SWEP.FireSound     = "COPFN2000.fn2000_shoot"
SWEP.SilencedSound = "COPFN2000.fn2000_shot_sil"
SWEP.EmptySound    = "COPFN2000.fn2000_empty"
SWEP.DeploySound   = "COPFN2000.fn2000_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPFN2000.fn2000_reload"

