AddCSLuaFile()

SWEP.PrintName = "Beretta 92"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 1
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/bereta_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_bereta_model_stcop.mdl"
SWEP.ViewModelFOV  = 50
SWEP.ViewModelFlip = false
SWEP.HoldType      = "pistol"

SWEP.Damage   = 35
SWEP.RPM      = 320
SWEP.Accuracy = 76
SWEP.Handling = 95

SWEP.Primary.ClipSize    = 15
SWEP.Primary.DefaultClip = 15
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "9x19"

SWEP.OriginPos = Vector(-1, -6, -7)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(-6, 0, -5.56)
SWEP.AimAng = Vector(-0.2, 0.075, 0)

--SWEP.ShellModel = "models/shells/shell_9mm.mdl"

SWEP.SilencerBone = "wpn_silencer"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.6

SWEP.ReloadTime     = 3
SWEP.ReloadFillTime = 2.5

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.LastFire = true

SWEP.SlideBone = { name = "breachblock", pos = Vector(0, -1.5, 0) }

SWEP.ZoomFOV  = 70
SWEP.ScopeFOV = 50

SWEP.HiddenBones    = { "wpn_launcher" }

SWEP.FireSound     = "COPBERETASTCOP.beretta_shoot"
SWEP.SilencedSound = "COPBERETASTCOP.beretta_shot_sil"
SWEP.EmptySound    = "COPBERETASTCOP.beretta_empty"
SWEP.DeploySound   = "COPBERETASTCOP.beretta_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPBERETASTCOP.beretta_reload"
