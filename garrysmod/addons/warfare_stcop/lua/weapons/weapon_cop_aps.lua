AddCSLuaFile()

SWEP.PrintName = "АПС"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 1
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/aps_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_aps_model.mdl"
SWEP.ViewModelFOV  = 50
SWEP.ViewModelFlip = false
SWEP.HoldType      = "pistol"

SWEP.Damage   = 32
SWEP.RPM      = 550
SWEP.Accuracy = 75
SWEP.Handling = 85

SWEP.Primary.ClipSize    = 20
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "9x18"

SWEP.OriginPos = Vector(-1, -5, -7.5)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(-5.99, -2, -6.24)
SWEP.AimAng = Vector(0.6, 0, 0)

--SWEP.ShellModel = "models/shells/shell_9mm.mdl"

SWEP.SilencerBone = "wpn_silencer"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.6

SWEP.ReloadTime     = 3.5
SWEP.ReloadFillTime = 3.5

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.LastFire = true

SWEP.SlideBone = { name = "breachblock", pos = Vector(0, -1.2, 0) }

SWEP.ZoomFOV  = 70
SWEP.ScopeFOV = 50

SWEP.HiddenBones    = { "wpn_launcher" }

SWEP.FireSound     = "COP_PM.FireAPS"
SWEP.SilencedSound = "COP_PB.FireAPS"
SWEP.EmptySound    = "COP_Pistol.Empty"
SWEP.DeploySound   = "COP_PM.Draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COP_Pistol.ReloadAPS"
