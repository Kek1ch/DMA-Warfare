if SERVER then
	AddCSLuaFile("shared.lua")
	AddCSLuaFile("cl_model.lua")
	AddCSLuaFile("cl_hud.lua")
	AddCSLuaFile("sh_bullet.lua")
end

include("sh_bullet.lua")

if CLIENT then
	include("cl_model.lua")
	include("cl_hud.lua")

	SWEP.ShellTable = {}

	SWEP.Slot    = 0
	SWEP.SlotPos = 10

	SWEP.DrawAmmo      = true
	SWEP.DrawCrosshair = false

	SWEP.DrawWeaponInfoBox = false
	SWEP.BounceWeaponIcon  = false

	SWEP.SwayScale = 0
	SWEP.BobScale  = 0
end

SWEP.Weight         = 5
SWEP.AutoSwitchTo   = false
SWEP.AutoSwitchFrom = false

SWEP.PrintName = "Call of Pripyat Base"

SWEP.ViewModel     = "models/weapons/v_pistol.mdl"
SWEP.WorldModel    = "models/weapons/w_pistol.mdl"
SWEP.HoldType      = "pistol"
SWEP.ViewModelFOV  = 62
SWEP.ViewModelFlip = false

SWEP.Spawnable = false
SWEP.AdminOnly = true

SWEP.m_WeaponDeploySpeed = 10

SWEP.Primary.Damage    = 0
SWEP.Primary.Force     = 0
SWEP.Primary.Delay     = 0
SWEP.Primary.Recoil    = 0
SWEP.Primary.Spread    = 0
SWEP.Primary.BulletNum = 1
SWEP.Primary.PenMul    = 1
SWEP.Primary.Ricochet  = true

SWEP.COP_DrawCrosshair = true

SWEP.IsCOPWeapon = true

SWEP.Damage   = 0
SWEP.RPM      = 0
SWEP.Accuracy = 0
SWEP.Handling = 0

SWEP.ScopeTexture = "wpn_crosshair"

SWEP.SilencerAddon = "silencer"
SWEP.ScopeAddon    = "scope_pso"

SWEP.Primary.ClipSize    = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "none"

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic   = false
SWEP.Secondary.Ammo        = "none"

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.4

SWEP.ReloadLength = 2

SWEP.FireSound     = ""
SWEP.SilencedSound = ""
SWEP.EmptySound    = ""
SWEP.DeploySound   = ""
SWEP.HolsterSound  = ""
SWEP.ReloadSound   = ""
SWEP.BoreSound     = ""

function SWEP:Initialize()
	if CLIENT then
		if self.VModel then
			self.VModel:Remove()
		end

		self.VModel = stalker_cop.ModelManager:CreateModel(self.ViewModel, self)
		stalker_cop.UpdatePlayerHands()
	end

	self:SetHoldType(self.HoldType)
end

function SWEP:DrawWorldModel()
	if not self.WorldMatrix then
		self:DrawModel()
		return
	end

	if not IsValid(self.Owner) then
		self:DrawModel()
		return
	end

	if not self.Hand then
		self.Hand = self.Owner:LookupAttachment("anim_attachment_rh")
	end

	local hand = self.Owner:GetAttachment(self.Hand)
	if not hand then
		self:DrawModel()
		return
	end

	local right, up, forward = hand.Ang:Right(), hand.Ang:Up(), hand.Ang:Forward()

	hand.Pos = hand.Pos + (self.WorldMatrix.Pos.x) * right
	hand.Pos = hand.Pos + (self.WorldMatrix.Pos.y) * up
	hand.Pos = hand.Pos + (self.WorldMatrix.Pos.z) * forward

	hand.Ang:RotateAroundAxis(right, self.WorldMatrix.Ang.x)
	hand.Ang:RotateAroundAxis(up, self.WorldMatrix.Ang.y)
	hand.Ang:RotateAroundAxis(forward, self.WorldMatrix.Ang.z)

	self:SetRenderOrigin(hand.Pos)
	self:SetRenderAngles(hand.Ang)

	self:DrawModel()
end

function SWEP:DrawAnimation()
	return "draw"
end

function SWEP:Deploy()
	if game.SinglePlayer() and SERVER or CLIENT then
		self:PlayAnimation(self:DrawAnimation())
	end

	if (game.SinglePlayer() and SERVER) or (CLIENT and IsFirstTimePredicted()) then
		self:EmitSound(self.DeploySound)
	end

	if SERVER and IsFirstTimePredicted() then
		self:CallOnClient("Deploy")
	end

	self:UpdateNextPrimaryFire(CurTime() + self.DeployTime)
	self:SetNextIdle(CurTime() + self.DeployTime)

	self:SetSprinting(false)
	self:SetWeaponState(COP_WEPSTATE_NONE)

	self.nextWeapon = nil
	return true
end

function SWEP:Holster(nextweapon)
	if self:GetHolstering() then
		if self:GetHolsterTime() > CurTime() then
			return false
		end

		self:SetWeaponState(COP_WEPSTATE_NONE)
		self.nextWeapon = nil

		return true
	end

	if IsFirstTimePredicted() then
		self:CallOnClient("Holster")
	end

	self:StopSound( self.ReloadSound )
	if ( game.SinglePlayer() and SERVER or CLIENT ) and IsFirstTimePredicted() then
		self:PlayAnimation("holster")
		self:EmitSound(self.HolsterSound)
	end

	self:UpdateNextPrimaryFire(CurTime() + 0.6)
	self:SetNextIdle(CurTime() + 0.6)

	self:SetHolsterTime(CurTime() + 0.5)
	self:SetWeaponState(COP_WEPSTATE_HOLSTERING)

	self.nextWeapon = nextweapon

	return false
end

function SWEP:GetReloadSound()
	return self.ReloadSound
end

function SWEP:PreReload()

end

function SWEP:Reload()
	local CT = CurTime()

	if self:GetNextPrimaryFire() + 0.05 >= CT then
		return
	end

	if self:GetWeaponState() ~= COP_WEPSTATE_NONE then
		return
	end

	if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 or self:Clip1() >= self.Primary.ClipSize then
		return
	end

	self:PreReload()

	if self:StartReload() then
		return
	end

	self:MagReload()
end

function SWEP:StartReload()
	if self.ReloadType ~= 1 then return false end
	self:SetWeaponState(COP_WEPSTATE_RELOADING)

	if ( game.SinglePlayer() and SERVER or CLIENT ) and IsFirstTimePredicted() then
		self:PlayAnimation("reload_start")
	end

	if IsFirstTimePredicted() then
		self:EmitSound(self.OpenSound)
	end

	local CT = CurTime()

	self:UpdateNextPrimaryFire(CT + self.ReloadStartTime)
	self:SetNextIdle(CT + self.ReloadStartTime)

	return true
end

function SWEP:EndReload()
	if self.ReloadType ~= 1 then return end

	if ( game.SinglePlayer() and SERVER or CLIENT ) and IsFirstTimePredicted() then
		self:PlayAnimation("reload_end")
	end

	if IsFirstTimePredicted() then
		self:EmitSound(self.CloseSound)
	end

	self:SetWeaponState(COP_WEPSTATE_NONE)
	local CT = CurTime()

	self:UpdateNextPrimaryFire(CT + self.ReloadEndTime)
	self:SetNextIdle(CT + self.ReloadEndTime)
end

function SWEP:ReloadThink()
	local CT = CurTime()

	if self:GetReloading() and self:GetReloadFillTime() < CT then
		if self.ReloadType == 0 then
			self:SetWeaponState(COP_WEPSTATE_NONE)

			if SERVER then
				self:FillMag()
			end
		elseif self.ReloadType == 1 then
			if self:GetNextPrimaryFire() >= CT then return end

			if self:Clip1() >= self.Primary.ClipSize or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 or self.Owner:KeyDown(IN_ATTACK) then
				self:EndReload()
				return
			end

			if ( game.SinglePlayer() and SERVER or CLIENT ) and IsFirstTimePredicted() then
				self:PlayAnimation("reload")
			end

			if IsFirstTimePredicted() then
				self:EmitSound(self.ReloadSound)
			end

			self.Owner:RemoveAmmo(1, self.Primary.Ammo)
			self:SetClip1(self:Clip1() + 1)

			self:UpdateNextPrimaryFire(CT + self.ReloadTime)
			self:SetNextIdle(CT + self.ReloadTime)
		end
	end
end

function SWEP:GetReloadAnimation()
	return "reload"
end

function SWEP:UpdateNextPrimaryFire(time)
	if self:GetNextPrimaryFire() < time then
		self:SetNextPrimaryFire(time)
	end
end

function SWEP:MagReload()
	self:SetWeaponState(COP_WEPSTATE_RELOADING)

	if ( game.SinglePlayer() and SERVER or CLIENT ) and IsFirstTimePredicted() then
		self:PlayAnimation( self:GetReloadAnimation() )
	end

	if IsFirstTimePredicted() then
		self:EmitSound( self:GetReloadSound() )
	end

	local CT       = CurTime()
	local fillTime = math.min(self.ReloadTime, self.ReloadFillTime)

	self:UpdateNextPrimaryFire(CT + self.ReloadTime)
	self:SetReloadFillTime(CT + math.max(fillTime, self.DeployTime))
	self:SetNextIdle(CT + self.ReloadTime)
end

function SWEP:SecondaryAttack()
	if self:AttachAddon(self.ScopeAddon) then
		return
	end
end

function SWEP:AttachAddon(addon_name)
	if self:GetWeaponState() ~= COP_WEPSTATE_NONE then
		return false
	end

	if self.Owner:KeyDown(IN_USE) and self:GetNextPrimaryFire() <= CurTime() then
		local data = stalker_cop.Addons[addon_name]
		if (data.type == "silencer" and (self.SilencerMode == 2)) or (data.type == "scope" and (self.ScopeMode == 2)) then
			if SERVER and self.Owner:COP_HasAddon(addon_name) then
				self:UpdateNextPrimaryFire(CurTime() + 1.5)

				if data.type == "silencer" then
					local silenced = self:GetSilenced()
					self:SetSilenced(not silenced)
				elseif data.type == "scope" then
					local scoped = self:GetScoped()
					self:SetScoped(not scoped)
				end

				umsg.Start("COP_ADDON_ATTACH", self.Owner)
					umsg.String(data.type)
				umsg.End()
			end
			return true
		end
	end

	return false
end

function SWEP:CanPrimaryAttack()
	if self:AttachAddon(self.SilencerAddon) then
		return false
	end

	if self:GetSprinting() then
		return false
	end

	if self:Clip1() <= 0 then
		self:EmitSound(self.EmptySound)
		self:UpdateNextPrimaryFire(CurTime() + 0.3)
		self:Reload()
		return false
	end

	return true
end

function SWEP:GetTracerOrigin()
	if CLIENT then
		if self:IsCarriedByLocalPlayer() and not self.Owner:ShouldDrawLocalPlayer() then
			if IsValid(self.VModel) then
				local att = self.VModel:GetAttachment(1)

				if att then
					return att.Pos, att.Ang
				end
			end
		end
	end

	return self.Owner:GetShootPos(), self.Owner:EyeAngles()
end

function SWEP:GetFireAnimation()
	if self.LastFire and self:Clip1() == 0 then
		return "shoot_last"
	end

	return "shoot"
end

function SWEP:GetFireSound()
	if self:GetSilenced() then
		return self.SilencedSound
	end

	return self.FireSound
end

function SWEP:GetAccuracy()
	local baseAccuracy = (100 - self.Accuracy) * 0.01

	if self.Owner:Crouching() then
		baseAccuracy = baseAccuracy * 0.65
	end

	local vel   = self.Owner:GetVelocity()
	local len2d = vel:Length() / self.Owner:GetWalkSpeed()

	baseAccuracy = baseAccuracy + len2d * 0.2
	baseAccuracy = baseAccuracy + math.Clamp( self:GetFireTime() - CurTime(), 0, 2 ) * 0.25

	if self:GetAiming() then
		return baseAccuracy * 0.1
	end

	return baseAccuracy
end

function SWEP:GetHandling()
	local handling = (100 - self.Handling)
	local fireRate = 60 / self.RPM

	return (handling * fireRate + math.max( self:GetFireTime() - CurTime(), 0 ) * handling) * 0.25
end


function SWEP:CreateAimPunch()
	local handling = self:GetHandling()

	if (game.SinglePlayer() and SERVER) or (not game.SinglePlayer() and CLIENT and IsFirstTimePredicted()) then
		local angles = self.Owner:EyeAngles()
		math.randomseed(CurTime())

		angles.p = angles.p - handling
		angles.y = angles.y + (math.random() - math.random()) * handling * 0.45

		self.Owner:SetEyeAngles(angles)
	end
end

function SWEP:OnRemove()
	if self.VModel then
		self.VModel:Remove()
		self.VModel = nil
	end
end

function SWEP:GetViewModel()
	return self.VModel or self.Owner:GetViewModel()
end

function SWEP:CreateMuzzleEffect()
	local effectdata = EffectData()
	effectdata:SetEntity(self)
	effectdata:SetAttachment(1)
	effectdata:SetNormal(self.Owner:GetAimVector())

	util.Effect(self:GetSilenced() and "cop_muzzleflash_sil" or "cop_muzzleflash", effectdata)
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	local fireDelay = math.Clamp(60 / self.RPM, 0, 1000)
	local CT        = CurTime()

	self:UpdateNextPrimaryFire(CT + fireDelay)

	if IsFirstTimePredicted() then
		local idleTime = self.FireIdleTime

		if not idleTime then
			local vm = self:GetViewModel()

			if IsValid(vm) then
				local fire_anim = self:GetFireAnimation()
				local seq_t     = vm:SequenceDuration( vm:LookupSequence( isstring(fire_anim) and fire_anim or "shoot" ) )

				if seq_t then
					idleTime = seq_t
				end
			end
		end

		self:SetNextIdle(CT + idleTime)
	end

	self:FireBullet()
	self:TakePrimaryAmmo(1)

	self:CreateAimPunch()
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	local fireTime = math.max( self:GetFireTime() - CT, 0 )
	self:SetFireTime( CT + math.min(fireTime + (100 - self.Handling) * 0.01, 1) )

	if game.SinglePlayer() and SERVER or CLIENT then
		if IsFirstTimePredicted() then
			local fire_anim = self:GetFireAnimation()
			self:PlayAnimation(isstring(fire_anim) and fire_anim or "shoot")

			self:EmitShell()
			self:CreateMuzzleEffect()
		end
	end

	if ( game.SinglePlayer() and SERVER ) or ( not game.SinglePlayer() and IsFirstTimePredicted() ) then
		local fire_snd = self:GetFireSound()
		self:EmitSound(fire_snd)
	end
end

function SWEP:FillMag()
	local Clip1     = self:Clip1()
	local AmmoCount = self.Owner:GetAmmoCount(self.Primary.Ammo)

	local TakeAmmoCount = self.Primary.ClipSize

	local TakeAmount = math.min(TakeAmmoCount - Clip1, AmmoCount)
	local ClipAmount = math.min(Clip1 + TakeAmount,    TakeAmmoCount)

	self.Owner:RemoveAmmo(TakeAmount, self.Primary.Ammo)
	self:SetClip1(ClipAmount)
end

--[[local WeaponTable = {
	["weapon_cop_beretta92fs"] = {OriginPos = Vector(-1, -6, -7), OriginAng = Vector(0, 0, 0)},
	["weapon_cop_m60"] = {OriginPos = Vector(-2, -1, -9), OriginAng = Vector(3, 0, 0)},
	["weapon_cop_mp133"] = {OriginPos = Vector(-2, 4, -6), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_spas12"] = {OriginPos = Vector(-4, 0, -5.2), OriginAng = Vector(0, 0, 0)},
	["weapon_cop_fort"] = {OriginPos = Vector(-1, -4, -8), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_hpsa"] = {OriginPos = Vector(-1, -8, -8), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_abakan"] = {OriginPos = Vector(-7, -2, -7), OriginAng = Vector(2, -2, 0)},
	["weapon_cop_aek"] = {OriginPos = Vector(-2.5, 0, -7.5), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_ak74"] = {OriginPos = Vector(-3, 0, -6.5), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_ak74u"] = {OriginPos = Vector(-5, 4, -5.2), OriginAng = Vector(1, 0, 0)},
	["weapon_cop_aps"] = {OriginPos = Vector(-1, -5, -7.5), OriginAng = Vector(0, 0, 0)},
	["weapon_cop_bizon"] = {OriginPos = Vector(-4, 5, -6), OriginAng = Vector(0, 0, 0)},
	["weapon_cop_bm16"] = {OriginPos =  Vector(1, -5, -4), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_colt1911"] = {OriginPos = Vector(-1.5, -5, -6.5), OriginAng = Vector(0, 0, 0)},
	["weapon_cop_desert_eagle"] = {OriginPos = Vector(-1, -3, -7), OriginAng = Vector(0, 0, 0)},
	["weapon_cop_fn2000"] = {OriginPos = Vector(-4, 4, -11), OriginAng = Vector(3, 0, 0)},
	["weapon_cop_fnp"] = {OriginPos = Vector(-1, -2, -7), OriginAng = Vector(0, 0, 0)},
	["weapon_cop_gauss"] = {OriginPos = Vector(-3.1, 4, -8.5), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_glock"] = {OriginPos = Vector(-2.5, -9, -8), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_groza"] = {OriginPos = Vector(-3.5, 4, -6), OriginAng = Vector(0, 0, 0)},
	["weapon_cop_karyak"] = {OriginPos = Vector(-6.5, 0, -6.8), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_l85"] = {OriginPos = Vector(-3, 2, -7.5), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_l96"] = {OriginPos = Vector(-3, -6, -6.7), OriginAng = Vector(3, -1, 0)},
	["weapon_cop_lr300"] = {OriginPos = Vector(-2, 7, -8), OriginAng = Vector(0, 0, 0)},
	["weapon_cop_mosin"] = {OriginPos = Vector(-3, 3, -7), OriginAng = Vector(0, 0, 0)},
	["weapon_cop_pb"] = {OriginPos = Vector(-2, -9, -7), OriginAng = Vector(0, -6, 0)},
	["weapon_cop_pkm"] = {OriginPos = Vector(-2, -1, -8), OriginAng = Vector(3, 0, 0)},
	["weapon_cop_pm"] = {OriginPos = Vector(0, -5, -7.1), OriginAng = Vector(0, 0, 0)},
	["weapon_cop_ppsh"] = {OriginPos = Vector(-6, 5, -6.6), OriginAng = Vector(1, 0, 0)},
	["weapon_cop_rpg7"] = {OriginPos = Vector(-2, 0, -10), OriginAng = Vector(1, 0, 0)},
	["weapon_cop_rpk"] = {OriginPos = Vector(-8, 2, -8), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_saiga"] = {OriginPos = Vector(-4, 4, -6.5), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_scar"] = {OriginPos = Vector(-3, -1, -7), OriginAng = Vector(2, -3, 0)},
	["weapon_cop_sig550"] = {OriginPos = Vector(-2, -1, -8), OriginAng = Vector(2, -3, 0)},
	["weapon_cop_sks"] = {OriginPos = Vector(0, 2, -6.5), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_spas12"] = {OriginPos = Vector(-4, 0, -5.2), OriginAng = Vector(0, 0, 0)},
	["weapon_cop_sv98"] = {OriginPos = Vector(-4.5, -6, -7.1), OriginAng = Vector(1, 0, 0)},
	["weapon_cop_svd"] = {OriginPos = Vector(0, 3, -1), OriginAng = Vector(4, 0, 0)},
	["weapon_cop_svt"] = {OriginPos = Vector(0, 5, 0), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_svu"] = {OriginPos = Vector(-1, 2, -6), OriginAng = Vector(2, -2, 0)},
	["weapon_cop_toz34"] = {OriginPos = Vector(-7, -2, -7), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_usp45"] = {OriginPos = Vector(-1, -1, -7), OriginAng = Vector(0, 0, 0)},
	["weapon_cop_val"] = {OriginPos = Vector(-3, 1, -6), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_vepr"] = {OriginPos = Vector(-2, 4, -6), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_vintorez"] = {OriginPos = Vector(-2, 4, -6.5), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_walther"] = {OriginPos = Vector(-1, -7, -7), OriginAng = Vector(0, 0, 0)},
	["weapon_cop_winchester1300"] = {OriginPos = Vector(-2, 4, -6), OriginAng = Vector(2, 0, 0)},
}

local WeaponTableSecond = {
	["weapon_cop_mp5"] = {OriginPos = Vector(0, 5, 0), OriginAng = Vector(0, 0, 0)},
	["weapon_cop_ak_74"] = {OriginPos = Vector(0.4, 3, 0.1), OriginAng = Vector(1, 0, 0)},
	["weapon_cop_g36"] = {OriginPos = Vector(0, -2, -10), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_hk416"] = {OriginPos = Vector(1, 3, 2.4), OriginAng = Vector(2, 0, 0)},
	["weapon_cop_protecta"] = {OriginPos = Vector(5, 11, -2), OriginAng = Vector(0, 0, 0)},
	["weapon_cop_rg6"] = {OriginPos = Vector(5, 0, -4), OriginAng = Vector(5, 0, 0)},
}]]

function SWEP:Tick()
	--[[if self.Owner:isWepRaised() then
		if WeaponTable[self.Owner:GetActiveWeapon():GetClass()] then
			self.OriginPos = WeaponTable[self.Owner:GetActiveWeapon():GetClass()].OriginPos
			self.OriginAng = WeaponTable[self.Owner:GetActiveWeapon():GetClass()].OriginAng
		elseif WeaponTableSecond[self.Owner:GetActiveWeapon():GetClass()] then
			self.OriginPos = WeaponTableSecond[self.Owner:GetActiveWeapon():GetClass()].OriginPos
			self.OriginAng = WeaponTableSecond[self.Owner:GetActiveWeapon():GetClass()].OriginAng
		end
	else
		if WeaponTable[self.Owner:GetActiveWeapon():GetClass()] then
			self.OriginPos = Vector(-1, -4, -6)
			self.OriginAng = Vector(-5, 9, 0)
		else
			self.OriginPos = Vector(5, -1, -1.5)
			self.OriginAng = Vector(-5, 9, 0)
		end
	end]]

	if (CLIENT) then
		if self.Owner:getChar():getInv():hasItem("silence") then
			if (self.Owner:getChar():getInv():hasItem("silence"):getData("equip") == true) and (self.SilencerMode == 2) then
				self:SetSilenced(true)
			else
				self:SetSilenced(false)
			end
		end

		if self.Owner:getChar():getInv():hasItem("scope_pso") then
			if (self.Owner:getChar():getInv():hasItem("scope_pso"):getData("equip") == true) and (self.ScopeMode == 2) then
				self:SetScoped(true)
			else
				self:SetScoped(false)
			end
		end
	end
end

function SWEP:Think2()

end

function SWEP:ZoomThink()
	local CT = CurTime()
	local reloading = self:GetReloading()
	local sprinting = self:GetSprinting()
	local aiming = self:GetAiming()
	local nextFire = self:GetNextPrimaryFire()
	local inAttack2 = self.Owner:KeyDown(IN_ATTACK2)

	if self.CanZoom and not aiming and inAttack2 and not sprinting and not reloading and not self.Owner:KeyDown(IN_USE) and nextFire < CT then
		self:SetWeaponState(COP_WEPSTATE_AIMING)
		self:UpdateNextPrimaryFire(CT + self.AimTime)
	elseif aiming and (not inAttack2 or sprinting or reloading) then
		self:SetWeaponState(COP_WEPSTATE_NONE)
		self:UpdateNextPrimaryFire(CT + self.AimTime)
	end
end

SWEP.DoAimAnimation = true

function SWEP:Think()
	local CT = CurTime()
	local FT = FrameTime()

	if self:GetHolstering() then
		if self:GetHolsterTime() <= CT then
			if SERVER then
				if IsValid(self.nextWeapon) then
					self.Owner:SelectWeapon( self.nextWeapon:GetClass() )
					self.nextWeapon = nil
				end
			end
		end

		return
	end

	self:ReloadThink()

	if self.VModel then
		local att = self.VModel:GetAttachment(1)

		if att then
			self.muzzleData = att
		end
	end

	if CLIENT then
		--[[if not IsValid(self.VModel) then
			self:UpdateViewModel()
		end]]

		if self.SwayTime then
			if self.SwayTime <= CT then
				self.SwayTime = nil
				self.SwayDir  = nil
			end
		else
			local in_left  = self.Owner:KeyPressed(IN_MOVELEFT)
			local in_right = self.Owner:KeyPressed(IN_MOVERIGHT)

			if in_left or in_right then
				self.SwayTime = CT + 1
				self.SwayDir  = (in_left and 1 or -1) * (self.Owner:Crouching() and 0.33 or 1)
			end
		end
	end

	if self.SilencerMode == 1 then
		if not self:GetSilenced() then
			self:SetSilenced(true)
		end
	elseif self.SilencerMode == 0 then
		if self:GetSilenced() then
			self:SetSilenced(false)
		end
	end

	if self.ScopeMode == 1 then
		if not self:GetScoped() then
			self:SetScoped(true)
		end
	elseif self.ScopeMode == 0 then
		if self:GetScoped() then
			self:SetScoped(false)
		end
	end

	self:ZoomThink()

	local reloading = self:GetReloading()
	local sprinting = self:GetSprinting()
	local aiming    = self:GetAiming()
	local nextFire  = self:GetNextPrimaryFire()

	local walkVelocity = self.Owner:GetWalkSpeed()

	local vel2d    = self.Owner:GetVelocity():Length2D()
	local moving   = self:GetMoving()
	local onGround = self.Owner:OnGround()
	local inSpeed  = self.Owner:KeyDown(IN_SPEED)
	local moveType = self.Owner:GetMoveType()

	if !sprinting and vel2d > walkVelocity and inSpeed and !reloading and moveType == MOVETYPE_WALK then
		self:SetSprinting(true)
	elseif sprinting and (vel2d <= walkVelocity or reloading or !inSpeed or moveType ~= MOVETYPE_WALK) then
		self:SetSprinting(false)

		if !reloading then
			self:UpdateNextPrimaryFire(CT + 0.2)
			self:SetNextIdle(math.max(CT + 0.2, self:GetNextIdle()))
		end
	end

	if !moving and vel2d > 50 and !inSpeed and !reloading and moveType == MOVETYPE_WALK then
		self:SetMoving(true)
	elseif moving and (vel2d <= 50 or reloading or inSpeed or moveType ~= MOVETYPE_WALK) then
		self:SetMoving(false)
	end

	if ( CLIENT and IsFirstTimePredicted() ) or (game.SinglePlayer() and CLIENT) then
		if not self.curIdle then
			self.curIdle = ""
		end

		if self.BoreAnimations then
			if not self.boreTime then
				self.boreTime = 0
			end

			if not (moving or sprinting or aiming or reloading) and nextFire <= CT then
				self.boreTime = self.boreTime + FT
			else
				if self.boreSound then
					self:StopSound(self.boreSound)
					self.boreSound = nil
				end

				self.boreAnim = false
				self.boreTime = 0
			end

			if self.boreTime > 10 then
				local n = math.random(1, #self.BoreAnimations)

				local boreAnim = self.BoreAnimations[n]
				if boreAnim then
					self.boreAnim = true
					self:PlayAnimation(boreAnim)

					if self.BoreSounds then
						local boreSound = self.BoreSounds[ math.min(n, #self.BoreSounds) ]

						if boreSound then
							self.boreSound = boreSound
							self:EmitSound(boreSound)
						end
					end

					self.boreTime = -15
				end
			end
		end

		local throwing = self:GetWeaponState() == COP_WEPSTATE_THROWING

		if self:GetNextIdle() < CT and not reloading then
			if sprinting and not aiming and not throwing and self.curIdle ~= "sprinting" then
				self.curIdle = "sprinting"
				self:PlayAnimation(self.SprintAnim or "idle_sprint")
			elseif not sprinting and moving and not aiming and not throwing and self.curIdle ~= "moving" then
				self.curIdle = "moving"
				self:PlayAnimation("idle_moving")
			elseif aiming and self.curIdle ~= "aiming" then
				self.curIdle = "aiming"
				self:PlayAnimation(self.DoAimAnimation and "idle_aim" or "idle")
			elseif throwing and self.curIdle ~= "throwing" then
				self.curIdle = "throwing"
				self:PlayAnimation("throw_idle")
			elseif not sprinting and not moving and not aiming and not throwing and self.curIdle ~= "idle" then
				self.curIdle = "idle"
				self:PlayAnimation("idle")
			end
		else
			self.curIdle = ""
		end
	end

	self:Think2()
end

function SWEP:GetAiming()
	return self:GetWeaponState() == COP_WEPSTATE_AIMING
end

function SWEP:GetReloading()
	return self:GetWeaponState() == COP_WEPSTATE_RELOADING
end

function SWEP:GetHolstering()
	return self:GetWeaponState() == COP_WEPSTATE_HOLSTERING
end

function SWEP:GetThrowing()
	return self:GetWeaponState() == COP_WEPSTATE_THROWING
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Moving")
	self:NetworkVar("Bool", 1, "Sprinting")
	self:NetworkVar("Bool", 2, "Silenced")
	self:NetworkVar("Bool", 3, "Scoped")

	self:NetworkVar("Float", 0, "HolsterTime")
	self:NetworkVar("Float", 1, "ReloadFillTime")
	self:NetworkVar("Float", 2, "NextIdle")
	self:NetworkVar("Float", 3, "FireTime")
	self:NetworkVar("Float", 4, "WeaponState")

	if self.SilencerMode == 1 then
		self:SetSilenced(true)
	end

	if self.ScopeMode == 1 then
		self:SetScoped(true)
	end
end

function SWEP:PlayAnimation(seq, speed, cycle)
	if istable(seq) then
		seq = table.Random(seq)
	end

	seq   = seq   or "none"
	speed = speed or 1
	cycle = cycle or 0

	if CLIENT then
		if IsValid(self.VModel) then
			local animID = self.VModel:LookupSequence(seq)

			if animID then
				self.VModel:ResetSequence(animID)
				self.VModel:SetCycle(cycle)
				self.VModel:SetPlaybackRate(speed)
			end
		else
			local VModel = self.Owner:GetViewModel()

			if IsValid(VModel) then
				local animID = VModel:LookupSequence(seq)

				if animID then
					VModel:SendViewModelMatchingSequence( animID )
					VModel:SetCycle(cycle)
					VModel:SetPlaybackRate(speed)
				end
			end
		end
	elseif game.SinglePlayer() and SERVER then
		umsg.Start("COP_PLAYANIMATION", self.Owner)
			umsg.String(seq)
			umsg.Float(speed)
			umsg.Float(cycle)
		umsg.End()
	end
end

function SWEP:EmitShell()
	if CLIENT and self.ShellModel then
		local VModel = self.VModel or self.Owner:GetViewModel()

		if VModel then
			local att = VModel:GetAttachment(2)

			if not att then
				return
			end

			local vel = -att.Ang:Forward() * 100
			local ang = VModel:GetAngles()

			local shell = ClientsideModel(self.ShellModel, RENDERGROUP_VIEWMODEL)
			shell:SetPos(att.Pos)
			shell:PhysicsInitBox(Vector(-0.5, -0.15, -0.5), Vector(0.5, 0.15, 0.5))
			shell:SetAngles(ang)
			shell:SetMoveType(MOVETYPE_VPHYSICS)
			shell:SetSolid(SOLID_VPHYSICS)
			shell:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			shell:SetNoDraw(true)

			if not self.ShellTable then
				self.ShellTable = {}
			end

			table.insert(self.ShellTable, shell)

			local phys = shell:GetPhysicsObject()
			phys:SetMaterial("gmod_silent")
			phys:SetMass(5)
			phys:SetVelocity(vel)
			phys:AddAngleVelocity(VectorRand()*400)

			SafeRemoveEntityDelayed(shell, 0.2)
		end
	elseif emitshell and SERVER then
		SendUserMessage("COP_EMITSHELL", self.Owner)
	end
end