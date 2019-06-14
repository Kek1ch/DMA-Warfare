AddCSLuaFile()

SWEP.PrintName = "SIG SG 550"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/sig550_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_sig550_model_stcop.mdl"
SWEP.ViewModelFOV  = 60
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 33
SWEP.RPM      = 590
SWEP.Accuracy = 77
SWEP.Handling = 85

SWEP.Primary.ClipSize    = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "556x45"

SWEP.OriginPos = Vector(-2, -1, -8)
SWEP.OriginAng = Vector(2, -3, 0)

SWEP.AimPos = Vector(-7.6, -1, -5.6)
SWEP.AimAng = Vector(0.2, 0.1, 0)

SWEP.ScopeAimPos = Vector(-7.6, -9, -5.6)
SWEP.ScopeAimAng = Vector(0.2, 0.1, 0)

SWEP.ScopeBone    = "wpn_scope"
SWEP.SilencerBone = "wpn_silencer"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 2

SWEP.ScopeAddon = "scope_susat"
SWEP.ScopeTexture = "wpn_crosshair_acog"

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 5
SWEP.ReloadFillTime = 2.5

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 40

SWEP.HiddenBones = { "wpn_launcher" }

SWEP.FireSound     = "COPSG550.sig550_shoot"
SWEP.SilencedSound = "COPSG550.sig550_shot_sil"
SWEP.EmptySound    = "COPSG550.sig550_empty"
SWEP.DeploySound   = "COPSG550.sig550_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPSG550.sig550_reload"