AddCSLuaFile()

SWEP.PrintName = "Desert Eagle"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 1
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/deagle_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_deagle_model.mdl"
SWEP.ViewModelFOV  = 42
SWEP.ViewModelFlip = false
SWEP.HoldType      = "pistol"

SWEP.Damage   = 50
SWEP.RPM      = 145
SWEP.Accuracy = 82
SWEP.Handling = 80

SWEP.Primary.ClipSize    = 8
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "45acp"

SWEP.OriginPos = Vector(-1, -3, -7)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(-5.85, 10, -6.25)
SWEP.AimAng = Vector(0.15, 0, 0)

--SWEP.ShellModel = "models/shells/shell_9mm.mdl"

SWEP.SilencerBone = "wpn_silencer"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.6

SWEP.ReloadTime     = 2.2
SWEP.ReloadFillTime = 1.8

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.LastFire = true

SWEP.SlideBone = { name = "breachblock", pos = Vector(0, -1.2, 0) }

SWEP.ZoomFOV  = 70
SWEP.ScopeFOV = 50

SWEP.HiddenBones    = { "wpn_launcher" }

SWEP.FireSound     = "COPDEAGLE.de_shoot"
SWEP.SilencedSound = "COPDEAGLE.de_shot_sil"
SWEP.EmptySound    = "COPDEAGLE.de_empty"
SWEP.DeploySound   = "COPDEAGLE.de_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPDEAGLE.de_reload"
