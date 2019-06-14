AddCSLuaFile()

SWEP.PrintName = "РПГ-7"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/rpg_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_rpg_model_stcop.mdl"
SWEP.ViewModelFOV  = 60
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 0
SWEP.RPM      = 100
SWEP.Accuracy = 90
SWEP.Handling = 90

SWEP.Primary.ClipSize    = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "rpg"

SWEP.OriginPos = Vector(-2, 0, -10)
SWEP.OriginAng = Vector(1, 0, 0)

SWEP.AimPos = Vector(-7.52, -3, -10.2)
SWEP.AimAng = Vector(2, 0.1, 0)

-- SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 0

SWEP.WorldMatrix = {
	Pos = Vector(0, 3, 8),
	Ang = Vector(-10, 180, 0)
}

SWEP.AimTime    = 0.25
SWEP.DeployTime = 1

SWEP.SprintAnim   = "idle_sprint"
SWEP.ScopeTexture = "wpn_crosshair_rpg_stcop"

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadTime     = 3
SWEP.ReloadFillTime = 2.4

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.FireSound     = "COPRPGSTCOP.rpg7_shoot"
SWEP.EmptySound    = "COPRPGSTCOP.rpg7_empty"
SWEP.DeploySound   = "COPRPGSTCOP.rpg7_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPRPGSTCOP.rpg7_reload"
SWEP.EmptySound    = "COPRPGSTCOP.rpg7_empty"

function SWEP:FireBullet()
	if SERVER then
		local ang = self.Owner:EyeAngles()
		local pos = self.Owner:EyePos() + ang:Up() * -6

		if not self:GetAiming() then
			pos = pos + ang:Right() * 14
		end

		local ang2 = ang * 1
		ang2:RotateAroundAxis(ang2:Up(), 180)

		local nade = ents.Create("cop_grenade_pg7v")
		nade:SetOwner(self.Owner)
		nade:SetPos(pos)
		nade:SetAngles(ang2)
		nade:Spawn()
		nade:Activate()

		local phys = nade:GetPhysicsObject()
		if IsValid(phys) then
			phys:ApplyForceCenter(ang:Forward() * 2000)
		end
	end
end

local enabled, disabled = Vector(1, 1, 1), Vector(0, 0, 0)

function SWEP:HandleBoneMods2(vm)
	local b = vm:LookupBone("grenade")

	if b then
		if vm:GetBoneMatrix(b) then
			vm:ManipulateBoneScale(b, (self:Clip1() >= 1 or self:GetReloading()) and enabled or disabled)
		end
	end
end