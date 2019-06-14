AddCSLuaFile()

SWEP.PrintName = "G36"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/g36_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_g36_model_stcop.mdl"
SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 32
SWEP.RPM      = 630
SWEP.Accuracy = 80
SWEP.Handling = 83

SWEP.Primary.ClipSize    = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "556x45"

SWEP.OriginPos = Vector(0, -2, -10)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-4, -5, -10)
SWEP.AimAng = Vector(0.7, 0, 0)

SWEP.ScopeBone    = "wpn_scope"
SWEP.SilencerBone = "wpn_silencer"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.ScopeTexture = "wpn_crosshair_g36_stcop"

SWEP.SilencerMode = 2
SWEP.ScopeMode    = 1

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 4
SWEP.ReloadFillTime = 2

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0
--l_foream_twist
--[[SWEP.BoneMatrix = {
	l_foream = {
		Pos = Vector(-99, 99, -99),
		Ang = Angle(99, 99, 99)
	}
}]]

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.HiddenBones = { "wpn_launcher", "muzzle_gl", "przesuw", "grenade2", "grenade", "gl_trigger" }

SWEP.FireSound     = "COPG36SCOP.g36_shoot"
SWEP.SilencedSound = "COPG36SCOP.g36_shot_sil"
SWEP.EmptySound    = "COPG36SCOP.g36_empty"
SWEP.DeploySound   = "COPG36SCOP.g36_draw"
SWEP.HolsterSound  = "COPG36SCOP.g36_holster"
SWEP.ReloadSound   = "COPG36SCOP.g36_reload_stcop"