AddCSLuaFile()

SWEP.PrintName = "Граната Ф-1"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 4
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/f1_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_f1_model_stcop.mdl"
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
SWEP.Primary.Ammo        = "COP_F1"

SWEP.OriginPos = Vector(-2.5, 0, -8)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(0, 0, 0)
SWEP.AimAng = Vector(0, 0, 0)

--SWEP.HiddenBones = { "jopa", "eka", "joint6", "joint5" }

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 0

SWEP.DeployTime = 0.6

SWEP.CanZoom       = false
SWEP.ZoomCrosshair = false

SWEP.ReloadType = -1

SWEP.DeploySound   = "COP_Generic.Draw"
SWEP.HolsterSound  = "COP_Generic.Holster"

function SWEP:PrimaryAttack()
	if self:GetWeaponState() ~= COP_WEPSTATE_NONE then
		return false
	end

	local CT = CurTime()

	self:SetNextPrimaryFire(CT + 1)
	self:SetNextIdle(CT + 1)
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

	self:FillMag()
end

function SWEP:ReloadThink()
	local nextFire = self:GetNextPrimaryFire()
	local CT       = CurTime()

	if self:GetThrowing() then
		if nextFire < CT and not self.Owner:KeyDown(IN_ATTACK) then
			self:SetWeaponState(COP_WEPSTATE_NONE)
			local throwTime = 1 + math.Clamp((CT - nextFire) * 2, 0, 1)

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

						local nade = ents.Create("cop_grenade_f1")
						nade:SetOwner(self.Owner)
						nade:SetPos(self.Owner:EyePos() + self.Owner:GetAimVector() * 6)
						nade:Fuse(3)
						nade:Spawn()
						nade:Activate()

						local phys = nade:GetPhysicsObject()
						if IsValid(phys) then
							local throwForce = self.Owner:GetAimVector() * 1500 * throwTime

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
		if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
			self:Reload()
		else
			if SERVER then
				local ply = self.Owner
				local wep = ply.COP_LastWeapon

				self.Owner:StripWeapon(self:GetClass())
				if IsValid(wep) then
					ply:SelectWeapon(wep:GetClass())
				end

				return
			end
		end
	end
end