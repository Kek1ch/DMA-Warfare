AddCSLuaFile()

SWEP.PrintName = "ТОЗ-63"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/bm16_model_full.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_bm16_model_full_stcop.mdl"
SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.HoldType      = "shotgun"

SWEP.Damage   = 50
SWEP.RPM      = 1000
SWEP.Accuracy = 90
SWEP.Handling = 50

SWEP.Primary.BulletNum = 15
SWEP.Primary.Spread    = 0.1

SWEP.Primary.ClipSize    = 2
SWEP.Primary.DefaultClip = 2
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "12x70"

SWEP.OriginPos = Vector(1, -5, -4)
SWEP.OriginAng = Vector(2, 0, 0)

SWEP.AimPos = Vector(-3.7, 0, -1.2)
SWEP.AimAng = Vector(0.7, 0.05, 0)

SWEP.ScopeTexture = "wpn_crosshair"

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.6

SWEP.ReloadTime     = 4
SWEP.ReloadFillTime = 3

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.FireSound     = "COPBM16SCOP.bm16_shoot"
SWEP.SilencedSound = ""
SWEP.EmptySound    = "COPBM16SCOP.bm16_empty"
SWEP.DeploySound   = "COPBM16SCOP.bm16_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = ""

local ReloadSound_L  = "COPBM16SCOP.bm16_reload_l_stcop"
local ReloadSound_LR = "COPBM16SCOP.bm16_reload_lr_stcop"

local ang1, ang2 = Angle(0, 0, -45), Angle(0, 0, 0)

function SWEP:HandleBoneMods2(vm)
	local clip1 = self:Clip1()
	local seq   = vm:GetSequenceName( vm:GetSequence() )
	local seq2  = seq ~= "shoot_l" and seq ~= "reload_l" and seq ~= "reload_lr" and seq ~= "shoot_r"

	local FT = FrameTime()

	local desired_l = seq2 and clip1 <= 1 and ang1 or ang2
	local desired_r = seq2 and clip1 <= 0 and ang1 or ang2

	local boneID  = vm:LookupBone("capsul_l")
	local boneAng = vm:GetManipulateBoneAngles(boneID)

	boneAng.r = math.Approach(boneAng.r, desired_l.r, FT * 6 * math.abs(ang1.r - ang2.r) )
	vm:ManipulateBoneAngles(boneID, boneAng)

	local boneID  = vm:LookupBone("capsul_r")
	local boneAng = vm:GetManipulateBoneAngles(boneID)

	boneAng.r = math.Approach(boneAng.r, desired_r.r, FT * 6 * math.abs(ang1.r - ang2.r) )
	vm:ManipulateBoneAngles(boneID, boneAng)
end

function SWEP:GetFireAnimation()
	if self:Clip1() == 1 then
		return "shoot_l"
	end

	return "shoot_r"
end

function SWEP:PreReload()
	if self:Clip1() <= 0 then
		self.ReloadSound = ReloadSound_LR

		self.ReloadTime = 5.5
		self.ReloadFillTime = 3
		return
	end

	self.ReloadSound = ReloadSound_L

	self.ReloadTime = 4.5
	self.ReloadFillTime = 2.8
end

function SWEP:GetReloadAnimation()
	if self:Clip1() <= 0 then
		return "reload_lr"
	end

	return "reload_l"
end