AddCSLuaFile()

SWEP.PrintName = "АКС74У"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/weapons/wick/stcopwep/v_ak74u.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_ak74u_stcop.mdl"
SWEP.ViewModelFOV  = 42
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 30
SWEP.RPM      = 575
SWEP.Accuracy = 65
SWEP.Handling = 82

SWEP.Primary.ClipSize    = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "545x39"

SWEP.OriginPos = Vector(-5, 4, -5.2)
SWEP.OriginAng = Vector(1, 0, 0)

SWEP.AimPos = Vector(-7.59, 16, -4.75)
SWEP.AimAng = Vector(-0.05, 0.02, 0)

SWEP.SilencerBone = "wpn_silencer"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 2.85
SWEP.ReloadFillTime = 1.4

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 45

SWEP.FireSound     = "COPAKSUSTCOP.aks74u_shoot"
SWEP.SilencedSound = "COPAKSUSTCOP.aks74u_shot_sil"
SWEP.EmptySound    = "COP_Generic.Empty"
SWEP.DeploySound   = "COPAKSUSTCOP.aks74u_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPAKSUSTCOP.aks74u_reload"
