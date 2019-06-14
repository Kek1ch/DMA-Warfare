AddCSLuaFile()

SWEP.PrintName = "Болт"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 4
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/bold_model.mdl"
SWEP.WorldModel    = ""
SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.HoldType      = "grenade"

SWEP.Damage   = 0
SWEP.RPM      = 0
SWEP.Accuracy = 0
SWEP.Handling = 0

SWEP.Primary.ClipSize    = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "none"

SWEP.OriginPos = Vector(2, 0, -8)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(0, 0, 0)
SWEP.AimAng = Vector(0, 0, 0)


SWEP.SilencerMode = 0
SWEP.ScopeMode    = 0

SWEP.DeployTime = 0.6

SWEP.CanZoom       = false
SWEP.ZoomCrosshair = false

SWEP.ReloadType = -1

--SWEP.BoreAnimations = { "idle_bore" }

SWEP.DeploySound   = "COP_Generic.Draw"
SWEP.HolsterSound  = "COP_Generic.Holster"

function SWEP:PrimaryAttack()
	if self:GetWeaponState() ~= COP_WEPSTATE_NONE then
		return false
	end

	local CT = CurTime()

	self:SetNextPrimaryFire(CT + 0.5)
	self:SetNextIdle(CT + 0.5)
	self:SetWeaponState(COP_WEPSTATE_THROWING)

	if game.SinglePlayer() and SERVER or CLIENT then
		if IsFirstTimePredicted() then
			self:PlayAnimation("throw_begin")
		end
	end
end

function SWEP:GetThrowing()
	return self:GetWeaponState() == COP_WEPSTATE_THROWING
end

function SWEP:SecondaryAttack()

end

function SWEP:Reload()
	local CT = CurTime()

	self:SetNextPrimaryFire(CT + 1)
	self:SetNextIdle(CT + 1)

	if game.SinglePlayer() and SERVER or CLIENT then
		if IsFirstTimePredicted() then
			self:PlayAnimation(self:DrawAnimation())
		end
	end

	self:SetClip1(1)
end

function SWEP:ReloadThink()
	local nextFire = self:GetNextPrimaryFire()
	local CT       = CurTime()

	if self:GetThrowing() then
		if nextFire < CT and not self.Owner:KeyDown(IN_ATTACK) then
			self:SetWeaponState(COP_WEPSTATE_NONE)
			local throwTime = 0.5 + math.Clamp((CT - nextFire) * 2, 0, 1)

			if game.SinglePlayer() and SERVER or CLIENT then
				if IsFirstTimePredicted() then
					self:PlayAnimation("throw")
				end
			end

			self:SetNextPrimaryFire(CT + 1)
			self:SetNextIdle(CT + 1)

			if SERVER then
				timer.Simple(0.4, function()
					if IsValid(self) then
						self:TakePrimaryAmmo(1)

						local bolt = ents.Create("cop_bolt")
						bolt:SetOwner(self.Owner)
						bolt:SetPos(self.Owner:EyePos() + self.Owner:GetAimVector() * 6)
						bolt:Spawn()
						bolt:Activate()

						SafeRemoveEntityDelayed(bolt, 10)

						local phys = bolt:GetPhysicsObject()
						if IsValid(phys) then
							local throwForce = self.Owner:GetAimVector() * 1000 * throwTime

							phys:ApplyForceCenter(throwForce)
							phys:AddAngleVelocity(VectorRand() * 300)
						end
					end
				end)
			end
		end

		return
	end
end

function SWEP:Think2()
	if self:GetNextPrimaryFire() < CurTime() and self:Clip1() <= 0 then
		self:Reload()
	end
end