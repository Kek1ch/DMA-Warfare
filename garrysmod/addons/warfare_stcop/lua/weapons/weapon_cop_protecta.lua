AddCSLuaFile()

SWEP.PrintName = "Protecta «Striker»"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 3
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/protecta_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_protecta_model_stcop.mdl"
SWEP.ViewModelFOV  = 45
SWEP.ViewModelFlip = false
SWEP.HoldType      = "smg"

SWEP.Damage   = 52
SWEP.RPM      = 195
SWEP.Accuracy = 75
SWEP.Handling = 80

SWEP.Primary.BulletNum = 15
SWEP.Primary.Spread    = 0.033

SWEP.Primary.ClipSize    = 12
SWEP.Primary.DefaultClip = 12
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "12x70"

SWEP.OriginPos = Vector(5, 11, -2)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(0, 2, -2.7)
SWEP.AimAng = Vector(2.8, 0.1, 0)

-- SWEP.ShellModel = "models/shells/shell_12gauge.mdl"

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 2

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime      = 1.6
SWEP.ReloadEndTime   = 0.6
SWEP.ReloadStartTime = 0.6
SWEP.ReloadFillTime  = 1.4

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 1

SWEP.ZoomFOV  = 75
SWEP.ScopeFOV = 40

SWEP.HiddenBones    = { "wpn_launcher" }

SWEP.FireSound     = "COPPROTECTA.protecta_shoot"
SWEP.SilencedSound = ""
SWEP.EmptySound    = "COPPROTECTA.protecta_empty"
SWEP.DeploySound   = "COPPROTECTA.protecta_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPPROTECTA.protecta_load"
SWEP.OpenSound     = ""
SWEP.CloseSound    = "COPPROTECTA.protecta_close"
SWEP.OpenSound    = "COPPROTECTA.protecta_open"