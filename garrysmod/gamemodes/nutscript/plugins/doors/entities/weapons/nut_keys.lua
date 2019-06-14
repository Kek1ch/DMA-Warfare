AddCSLuaFile()

if (CLIENT) then
	SWEP.PrintName = "Убрать оружие"
	SWEP.Slot = 0
	SWEP.SlotPos = 2
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Drop = false

--[[function SWEP:DrawHUD()
	if CLIENT then
		local x, y
		if ( self.Owner == LocalPlayer() and self.Owner:ShouldDrawLocalPlayer() ) then
			local tr = util.GetPlayerTrace( self.Owner )
			local trace = util.TraceLine( tr )
			local coords = trace.HitPos:ToScreen()
			x, y = coords.x, coords.y
		else
			x, y = ScrW() / 2, ScrH() / 2
		end
	surface.SetTexture( surface.GetTextureID( "stalkerrp/cursor/crosshair" ) )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( x - 16, y - 16, 32, 32 )
	end
end]]

local angTab, oldDelta = Angle(), Angle()

function SWEP:GetDesiredFOV(fov)
	local desiredFOV = self.ZoomFOV or fov


	return fov - (fov - desiredFOV)
end

local cop_viewbob_scale = CreateClientConVar("cop_viewbob_scale", 1, true, false)
local view = {}

local normalizeAngle = math.NormalizeAngle

SWEP.SwayAngle = Angle()
SWEP.BobPos = Vector()

function util_NormalizeAngles(a)
	a.p = normalizeAngle(a.p)
	a.y = normalizeAngle(a.y)
	a.r = normalizeAngle(a.r)
	return a
end

local clamp = math.Clamp
local function mix(from, to, dt)
	local dt = clamp(dt, 0, 1)

	if type(from) == "Angle" then
		from = util_NormalizeAngles(from)
		to   = util_NormalizeAngles(to)
	end

	return from + (to - from) * dt
end

function SWEP:CalcViewModelPos(origin, angles)
	local vm = self.VModel

	origin = origin or EyePos()
	angles = angles or (self.Owner:EyeAngles() + self.Owner:GetViewPunchAngles())

	local FT, CT = FrameTime(), CurTime()

	self.AimMul = math.Approach(self.AimMul, self:GetAiming() and 1 or 0, FT * (1 / self.AimTime))

	local AimMul = 1 - self.AimMul
	self.PitchMul = mix(self.PitchMul, angles.p / 90, FT * 5)

	angTab.p = angles.p
	angTab.y = angles.y

	self.AttachAng  = math.Approach(self.AttachAng, self.AttachTime > CT and 1 or 0, FT * 4)
	self.AttachAng2 = mix(self.AttachAng2, self.AttachAng, FT * 15)

	local delta = util_NormalizeAngles(angTab - oldDelta)

	oldDelta.p = angles.p
	oldDelta.y = angles.y

	local ang = util_NormalizeAngles(delta * math.pi)

	ang.p = clamp(ang.p, -math.pi, math.pi)
	ang.y = clamp(ang.y, -math.pi, math.pi)

	self.SwayAngle = mix(self.SwayAngle, ang, FT * 3)

	local angles_p = self.OriginAng.x * AimMul - self.BobPos.y
	local angles_y = self.OriginAng.y * AimMul + self.BobPos.x
	local angles_r = self.OriginAng.z * AimMul + self.BobPos.x * 0.5

	local AimPos = self:GetScoped() and self.ScopeAimPos or self.AimPos
	local AimAng = self:GetScoped() and self.ScopeAimAng or self.AimAng

	angles:RotateAroundAxis(angles:Right(),   angles_p + AimAng.x * self.AimMul - self.AttachAng2 * 45)
	angles:RotateAroundAxis(angles:Up(),      angles_y + AimAng.y * self.AimMul + self.AttachAng2 * 32)
	angles:RotateAroundAxis(angles:Forward(), angles_r + AimAng.z * self.AimMul)

	local right   = angles:Right()
	local up      = angles:Up()
	local forward = angles:Forward()

	local origin_x = (self.OriginPos.x * AimMul + (AimPos.x) * self.AimMul) * (self.ViewModelFlip and -1 or 1)
	local origin_y = (self.OriginPos.y * AimMul + (AimPos.y) * self.AimMul)
	local origin_z = (self.OriginPos.z * AimMul + (AimPos.z) * self.AimMul)

	local onGround = self.Owner:IsOnGround()
	if onGround and self.LastVelocity then
		self.ImpulseTime = CurTime() + 0.25
		self.ImpulseMul  = math.Clamp(-self.LastVelocity.z / 200, 0, 2)

		self.LastVelocity = nil
	elseif not onGround then
		self.LastVelocity = self.Owner:GetVelocity()
	end

	if self.SwayTime then
		local desired = math.sin((self.SwayTime - CT) * math.pi) * self.SwayDir * 2 * (0.25 + AimMul * 0.75)
		self.SwayPos = mix(self.SwayPos, desired, FT * 8)
	else
		self.SwayPos = mix(self.SwayPos, 0, FT * 8)
	end

	local impulse   = math.Clamp(-(CT - self.ImpulseTime), 0, 0.25) * 4
	self.HitImpulse = math.sin(impulse * math.pi) * self.ImpulseMul

	origin = origin + (origin_x + self.PitchMul * AimMul + self.SwayPos) * right
	origin = origin + (origin_y) * forward
	origin = origin + (origin_z + self.PitchMul * AimMul) * up

	origin.z = origin.z - self.HitImpulse

	local swayP = self.SwayAngle.p * AimMul
	local swayY = self.SwayAngle.y * AimMul

	origin = origin + swayP * up

	local c = math.cos(swayY) - 1
	local s = math.sin(swayY)

	origin = origin + s * right
	origin = origin + c * forward

	return origin, angles 
end


function SWEP:CalcView(ply, origin, angles, fov)

	view.origin = origin
	view.angles = angles

	if ply:GetViewEntity() ~= ply then
		return origin, angles, fov
	end

	local vm = self.VModel

	local up      = angles:Up()
	local right   = angles:Right()
	local forward = angles:Forward()

	local CT = CurTime()
	local FT = FrameTime()

	local mul = math.Clamp(cop_viewbob_scale:GetFloat(), 0, 2)

	local vel = clamp( self.Owner:GetVelocity():Length2D() / 200, 0, 1 ) * mul

	if self.Owner:GetMoveType() ~= MOVETYPE_WALK or not self.Owner:OnGround() then
		vel = 0
	end

	self.BobPos.x = math.sin(CT * 8) * vel
	self.BobPos.y = (math.abs(math.cos(CT * 8)) - 0.5) * vel

	view.angles:RotateAroundAxis(right,   -self.BobPos.y)
 	view.angles:RotateAroundAxis(up,      self.BobPos.x)
 	view.angles:RotateAroundAxis(forward, self.BobPos.x * 0.5)

	local desiredFOV = self:GetDesiredFOV(fov)
	view.fov = mix(view.fov or fov, desiredFOV, FT * 15)


	return view.origin, view.angles, view.fov
end

SWEP.ViewModelFOV = 45
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"

SWEP.ViewTranslation = 4

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Primary.Damage = 5
SWEP.Primary.Delay = 0.75

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.ViewModel = Model("models/weapons/c_arms_animations.mdl")
SWEP.WorldModel = ""

SWEP.UseHands = false
SWEP.LowerAngles = Angle(0, 5, -14)
SWEP.LowerAngles2 = Angle(0, 5, -22)

SWEP.IsAlwaysLowered = true
SWEP.FireWhenLowered = true
SWEP.HoldType = "passive"

function SWEP:PreDrawViewModel(viewModel, weapon, client)
	local hands = player_manager.TranslatePlayerHands(player_manager.TranslateToPlayerModelName(client:GetModel()))

	if (hands and hands.model) then
		--viewModel:SetModel(hands.model)
		--viewModel:SetSkin(hands.skin)
		--viewModel:SetBodyGroups(hands.body)
	end
end

ACT_VM_FISTS_DRAW = 3
ACT_VM_FISTS_HOLSTER = 2

function SWEP:Deploy()
	if (!IsValid(self.Owner)) then
		return
	end

	local viewModel = self.Owner:GetViewModel()

	if (IsValid(viewModel)) then
		--viewModel:SetPlaybackRate(1)
		--viewModel:ResetSequence(ACT_VM_FISTS_DRAW)
	end

	return true
end

function SWEP:Holster()
	if (!IsValid(self.Owner)) then
		return
	end

	local viewModel = self.Owner:GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(1)
		viewModel:ResetSequence(ACT_VM_FISTS_HOLSTER)
	end

	return true
end

function SWEP:Precache()
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:PrimaryAttack()
	local time = nut.config.get("doorLockTime", 1)
	local time2 = math.max(time, 1)

	self:SetNextPrimaryFire(CurTime() + time2)
	self:SetNextSecondaryFire(CurTime() + time2)

	if (!IsFirstTimePredicted()) then
		return
	end

	if (CLIENT) then
		return
	end

	local data = {}
		data.start = self.Owner:GetShootPos()
		data.endpos = data.start + self.Owner:GetAimVector()*96
		data.filter = self.Owner
	local entity = util.TraceLine(data).Entity

	--[[
		Locks the entity if the contiditon fits:
			1. The entity is door and client has access to the door.
			2. The entity is vehicle and the "owner" variable is same as client's character ID.
	--]]
	if (IsValid(entity) and
		(
			(entity:isDoor() and entity:checkDoorAccess(self.Owner)) or
			(entity:IsVehicle() and entity.CPPIGetOwner and entity:CPPIGetOwner() == self.Owner)
		)
	) then
		self.Owner:setAction("@locking", time, function()
			self:toggleLock(entity, true)
		end)			

		return
	end
end

function SWEP:toggleLock(door, state)
	if (IsValid(self.Owner) and self.Owner:GetPos():Distance(door:GetPos()) > 96) then
		return
	end

	if (door:isDoor()) then
		local partner = door:getDoorPartner()

		if (state) then
			if (IsValid(partner)) then
				partner:Fire("lock")
			end

			door:Fire("lock")
			self.Owner:EmitSound("doors/door_latch3.wav")
		else
			if (IsValid(partner)) then
				partner:Fire("unlock")
			end

			door:Fire("unlock")
			self.Owner:EmitSound("doors/door_latch1.wav")
		end
	elseif (door:IsVehicle()) then
		if (state) then
			door:Fire("lock")
			if (door.IsSimfphyscar) then
				door.IsLocked = true
			end
			self.Owner:EmitSound("doors/door_latch3.wav")
		else
			door:Fire("unlock")
			if (door.IsSimfphyscar) then
				door.IsLocked = nil
			end
			self.Owner:EmitSound("doors/door_latch1.wav")
		end
	end
end

function SWEP:SecondaryAttack()
	local time = nut.config.get("doorLockTime", 1)
	local time2 = math.max(time, 1)

	self:SetNextPrimaryFire(CurTime() + time2)
	self:SetNextSecondaryFire(CurTime() + time2)

	if (!IsFirstTimePredicted()) then
		return
	end

	if (CLIENT) then
		return
	end

	local data = {}
		data.start = self.Owner:GetShootPos()
		data.endpos = data.start + self.Owner:GetAimVector()*96
		data.filter = self.Owner
	local entity = util.TraceLine(data).Entity


	/*
		Unlocks the entity if the contiditon fits:
			1. The entity is door and client has access to the door.
			2. The entity is vehicle and the "owner" variable is same as client's character ID.
	*/
	if (IsValid(entity) and
		(
			(entity:isDoor() and entity:checkDoorAccess(self.Owner)) or
			(entity:IsVehicle() and entity.CPPIGetOwner and entity:CPPIGetOwner() == self.Owner)
		)
	) then
		self.Owner:setAction("@unlocking", time, function()
			self:toggleLock(entity, false)
		end)

		return	
	end
end
