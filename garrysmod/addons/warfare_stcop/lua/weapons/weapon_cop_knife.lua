AddCSLuaFile()

SWEP.PrintName = "Нож"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 0
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/weapons/wick/stcopwep/v_knife_1.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_knife_stcop.mdl"
SWEP.ViewModelFOV  = 50
SWEP.ViewModelFlip = false
SWEP.HoldType      = "knife"

SWEP.Damage   = 52
SWEP.RPM      = 155
SWEP.Accuracy = 75
SWEP.Handling = 80

SWEP.Primary.ClipSize    = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "none"

SWEP.OriginPos = Vector(2, 0, -9)
SWEP.OriginAng = Vector(5, 0, 0)

SWEP.AimPos = Vector(0, 0, 0)
SWEP.AimAng = Vector(0, 0, 0)

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 0

SWEP.DeployTime = 0.2

SWEP.CanZoom       = false
SWEP.ZoomCrosshair = false

SWEP.ReloadType = -1

SWEP.DeploySound   = "COP_Generic.Draw"
SWEP.HolsterSound  = "COP_Generic.Holster"

function SWEP:PrimaryAttack()
	if self:GetSprinting() then return end
	local CT = CurTime()

	self:SetNextPrimaryFire(CT + 0.4)
	self:SetNextSecondaryFire(CT + 0.4)

	self:SetNextIdle(CT + 0.4)
	self:SetReloadFillTime(CT + 0.1)
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	if game.SinglePlayer() and SERVER or CLIENT then
		if IsFirstTimePredicted() then
			self:PlayAnimation("kick_1")
		end
	end

	if (game.SinglePlayer() and SERVER) or (not game.SinglePlayer() and IsFirstTimePredicted()) then
		self:EmitSound("COP_Knife.Swing")
	end
end

function SWEP:SecondaryAttack()
	if self:GetSprinting() then return end
	local CT = CurTime()

	self:SetNextPrimaryFire(CT + 0.6)
	self:SetNextSecondaryFire(CT + 0.6)

	self:SetNextIdle(CT + 0.6)
	self:SetReloadFillTime(CT + 0.25)

	self.Owner:SetAnimation(PLAYER_ATTACK1)

	if game.SinglePlayer() and SERVER or CLIENT then
		if IsFirstTimePredicted() then
			self:PlayAnimation("kick_2")
		end
	end

	if (game.SinglePlayer() and SERVER) or (not game.SinglePlayer() and IsFirstTimePredicted()) then
		self:EmitSound("COP_Knife.Swing")
	end
end

local HitDistance = 45

function SWEP:DealDamage()
	self.Owner:LagCompensation(true)

	local tr = util.TraceLine({
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * HitDistance,
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	})

	if not IsValid(tr.Entity) then
		tr = util.TraceHull({
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * HitDistance,
			filter = self.Owner,
			mins = Vector(-10, -10, -8),
			maxs = Vector(10, 10, 8),
			mask = MASK_SHOT_HULL
		})
	end

	if tr.Hit and not (game.SinglePlayer() and CLIENT) then
		if tr.HitWorld then
			self:EmitSound("COP_Knife.Hit")
		else
			self:EmitSound("COP_Knife.Hurt")
		end
	end

	--if SERVER and IsValid(tr.Entity) and (tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:Health() > 0) then
	if SERVER and IsValid(tr.Entity) then
		local dmginfo  = DamageInfo()
		local attacker = self.Owner

		if not IsValid(attacker) then attacker = self end
		dmginfo:SetAttacker(attacker)
		dmginfo:SetInflictor(self)
		dmginfo:SetDamage(math.random( 8, 12 ))


		--if (tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:Health() > 0) then
			tr.Entity:TakeDamageInfo(dmginfo)
		--end
	end

	self.Owner:LagCompensation( false )
end

function SWEP:Think2()
	local swingTime = self:GetReloadFillTime()

	if swingTime > 0 and swingTime <= CurTime() then
		self:SetReloadFillTime(0)
		self:DealDamage()
	end
end