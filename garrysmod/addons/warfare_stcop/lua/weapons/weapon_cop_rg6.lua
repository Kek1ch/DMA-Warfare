AddCSLuaFile()

SWEP.PrintName = "RG-6 «Бульдог»"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 2
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/rg6_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_rg6_model_stcop.mdl"
SWEP.ViewModelFOV  = 60
SWEP.ViewModelFlip = false
SWEP.HoldType      = "ar2"

SWEP.Damage   = 0
SWEP.RPM      = 100
SWEP.Accuracy = 25
SWEP.Handling = 85

SWEP.Primary.ClipSize    = 6
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "COP_VOG25"

SWEP.OriginPos = Vector(5, 0, -4)
SWEP.OriginAng = Vector(5, 0, 0)

SWEP.AimPos = Vector(0.5, 5, -4)
SWEP.AimAng = Vector(5, 0, 0)

-- SWEP.ShellModel = "models/shells/shell_556.mdl"

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 0

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false

SWEP.ReloadTime      = 1.6
SWEP.ReloadEndTime   = 1.9
SWEP.ReloadStartTime = 2
SWEP.ReloadFillTime  = 2

SWEP.ReloadType = 1

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 25

SWEP.BoreAnimations = { "idle_bore" }

SWEP.FireSound     = "COPRG6.rg6_shoot"
SWEP.EmptySound    = "COPRG6.rg6_empty"
SWEP.DeploySound   = "COPRG6.rg6_draw"
SWEP.HolsterSound  = "COP_Generic.Holster"
SWEP.ReloadSound   = "COPRG6.rg6_reload"
SWEP.OpenSound     = "COPRG6.rg6_open"
SWEP.CloseSound    = "COPRG6.rg6_close"

function SWEP:FireBullet()
	if SERVER then
		local ang = self.Owner:EyeAngles()
		local pos = self.Owner:EyePos() + ang:Up() * -6

		if not self:GetAiming() then
			pos = pos + ang:Right() * 6
		end

		ang:RotateAroundAxis(ang:Right(), 15)

		local nade = ents.Create("cop_grenade_vog25")
		nade:SetOwner(self.Owner)
		nade:SetPos(pos)
		nade:SetAngles(ang)
		nade:Spawn()
		nade:Activate()

		local phys = nade:GetPhysicsObject()
		if IsValid(phys) then
			phys:ApplyForceCenter(ang:Forward() * 6000)
			-- phys:AddAngleVelocity(VectorRand() * 300)
		end
	end
end