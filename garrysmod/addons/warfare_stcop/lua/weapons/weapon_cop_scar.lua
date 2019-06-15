AddCSLuaFile()

SWEP.PrintName = "FN SCAR-H"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/scar_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_scar_model_stcop.mdl"
SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 36
SWEP.RPM      = 620
SWEP.Accuracy = 77
SWEP.Handling = 88

SWEP.Primary.ClipSize    = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "556x45"

SWEP.OriginPos = Vector(-3, -1, -7)
SWEP.OriginAng = Vector(2, -3, 0)

SWEP.AimPos = Vector(-7.7, -1, -5.6)
SWEP.AimAng = Vector(0.2, 0.1, 0)

SWEP.ScopeAimPos = Vector(-7.6, -9, -6.5)
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

SWEP.ReloadTime     = 3.6
SWEP.ReloadFillTime = 2.5

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 40

SWEP.HiddenBones = { "wpn_launcher", "joint13", "joint9", "joint10", "joint12" }

SWEP.FireSound     = "COPSCARSTCOP.scar_shoot"
SWEP.SilencedSound = "COPSCARSTCOP.scar_shot_sil"
SWEP.EmptySound    = "COPSG550.sig550_empty"
SWEP.DeploySound   = "COPSG550.sig550_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPSCARSTCOP.scar_reload"
