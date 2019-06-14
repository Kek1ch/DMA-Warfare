if SERVER then return end

local boneEnabled, boneDisabled = Vector(1, 1, 1), Vector(0, 0, 0)

function SWEP:HandleBoneMods2(vm)

end

function SWEP:HandleBoneMods()
	local vm = self.VModel

	if not vm then
		return
	end

	if self.WeaponAngle then
		local weaponBone = vm:LookupBone("lead_gun")

		if weaponBone then
			if vm:GetBoneMatrix(weaponBone) then
				vm:ManipulateBoneAngles(weaponBone, self.WeaponAngle)
			end
		end
	end

	if self.BoneMatrix then
		for k, v in pairs(self.BoneMatrix) do
			local boneID = vm:LookupBone(k)

			if boneID then
				if vm:GetBoneMatrix(boneID) then
					vm:ManipulateBonePosition(boneID, v.Pos)
					vm:ManipulateBoneAngles(boneID, v.Ang)
				end
			end
		end
	end

	if self.SilencerBone then
		local silencerBone = vm:LookupBone(self.SilencerBone)

		if silencerBone then
			if vm:GetBoneMatrix(silencerBone) then
				local b = self:GetSilenced()

				if self.AttachType == "silencer" and self.AttachTime > CurTime() then
					b = not b
				end

				vm:ManipulateBoneScale(silencerBone, b and boneEnabled or boneDisabled)
			end
		end
	end

	if self.ScopeBone then
		local scopeBone = vm:LookupBone(self.ScopeBone)

		if scopeBone then
			if vm:GetBoneMatrix(scopeBone) then
				local b = self:GetScoped()

				if self.AttachType == "scope" and self.AttachTime > CurTime() then
					b = not b
				end

				vm:ManipulateBoneScale(scopeBone, b and boneEnabled or boneDisabled)
			end
		end
	end

	if self.SlideBone then
		local boneID = vm:LookupBone(self.SlideBone.name)

		if boneID and vm:GetBoneMatrix(boneID) then
			local desired_pos = self:Clip1() == 0 and self.SlideBone.pos or boneDisabled
			local current_pos = vm:GetManipulateBonePosition(boneID)

			local FT = FrameTime()

			current_pos.x = math.Approach(current_pos.x, desired_pos.x, FT * 15)
			current_pos.y = math.Approach(current_pos.y, desired_pos.y, FT * 15)
			current_pos.z = math.Approach(current_pos.z, desired_pos.z, FT * 15)

			vm:ManipulateBonePosition(boneID, current_pos)
		end
	end

	local hiddenBones = self.HiddenBones

	if istable(hiddenBones) then
		for i = 1, #hiddenBones do
			local boneName = hiddenBones[i]

			if boneName then
				local boneID = vm:LookupBone(boneName)

				if boneID and vm:GetBoneMatrix(boneID) then
					vm:ManipulateBoneScale(boneID, boneDisabled)
				end
			end
		end
	end

	self:HandleBoneMods2(vm)
end

function SWEP:DrawViewModel()
	local viewModel  = self.VModel
	local handsModel = self.Owner.COP_Hands

	local FT = FrameTime()

	if self.ViewModelFlip then
		render.CullMode(MATERIAL_CULLMODE_CW)
	end

	viewModel:FrameAdvance(FT)
	viewModel:SetupBones()
	viewModel:DrawModel()

	if handsModel then
		handsModel:SetParent(viewModel)
		handsModel:AddEffects(EF_BONEMERGE)
		handsModel:DrawModel()
	end

	if self.ViewModelFlip then
		render.CullMode(MATERIAL_CULLMODE_CCW)
	end

	if self.ShellTable then
		for k, v in pairs(self.ShellTable) do
			if !IsValid(v) then
				self.ShellTable[k] = nil
			else
				v:DrawModel()
			end
		end
	end
end

local normalizeAngle = math.NormalizeAngle

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

SWEP.AimMul = 0
SWEP.SmoothAimMul = 0
SWEP.SwayAngle = Angle()
SWEP.BobPos = Vector()

SWEP.PitchMul = 0

local angTab, oldDelta = Angle(), Angle()

function SWEP:GetDesiredFOV(fov)
	local desiredFOV = self.ZoomFOV or fov

	if self:GetScoped() then
		if self:ShouldDrawViewModel_COP() then
			return fov
		end

		desiredFOV = self.ScopeFOV or desiredFOV
	end

	return fov - (fov - desiredFOV) * self.AimMul
end

SWEP.SwayPos = 0

SWEP.AttachTime = 0
SWEP.AttachAng = 0
SWEP.AttachAng2 = 0

SWEP.ImpulseMul = 0
SWEP.HitImpulse = 0
SWEP.ImpulseTime = 0

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

local cop_viewbob_scale = CreateClientConVar("cop_viewbob_scale", 1, true, false)
local view = {}

SWEP.DoMuzzleAnim = false
SWEP.MuzzleAng    = Angle(0, 0, 0)

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

	if vm then
		local att = vm:GetAttachment(1)

		if (self.DoMuzzleAnim or self.boreAnim) and att then
			if self:GetNextPrimaryFire() <= CT or self.AttachTime > CT then
				self.DoMuzzleAnim = false
			end

			self.MuzzleAng.p = math.ApproachAngle(self.MuzzleAng.p, -att.Ang.p * 0.15 * mul, FT * 15)
			self.MuzzleAng.y = math.ApproachAngle(self.MuzzleAng.y, -math.NormalizeAngle(att.Ang.y - math.NormalizeAngle(angles.y - 90)) * 0.15 * mul, FT * 15)
			self.MuzzleAng.r = math.ApproachAngle(self.MuzzleAng.r, math.NormalizeAngle(att.Ang.r + math.NormalizeAngle(angles.p)) * 0.033 * mul, FT * 15)
		else
			if self:GetReloading() then
				self.DoMuzzleAnim = true
			end

			self.MuzzleAng.p = math.ApproachAngle(self.MuzzleAng.p, 0, FT * 15)
			self.MuzzleAng.y = math.ApproachAngle(self.MuzzleAng.y, 0, FT * 15)
			self.MuzzleAng.r = math.ApproachAngle(self.MuzzleAng.r, 0, FT * 15)
		end
	end

	view.angles:RotateAroundAxis(right, self.MuzzleAng.p)
	view.angles:RotateAroundAxis(up, self.MuzzleAng.y)
	view.angles:RotateAroundAxis(forward, self.MuzzleAng.r)

	local vel = clamp( self.Owner:GetVelocity():Length2D() / 200 * (1.25 - self.AimMul), 0, 1 ) * mul

	if self.Owner:GetMoveType() ~= MOVETYPE_WALK or not self.Owner:OnGround() then
		vel = 0
	end

	self.BobPos.x = math.sin(CT * 8) * vel
	self.BobPos.y = (math.abs(math.cos(CT * 8)) - 0.5) * vel

	view.angles:RotateAroundAxis(right,   -self.BobPos.y)
 	view.angles:RotateAroundAxis(up,      self.BobPos.x)
 	view.angles:RotateAroundAxis(forward, self.BobPos.x * 0.5)

	view.origin   = view.origin - (self.SwayPos) * view.angles:Right()
	view.origin.z = view.origin.z - self.HitImpulse

	local desiredFOV = self:GetDesiredFOV(fov)
	view.fov = mix(view.fov or fov, desiredFOV, FT * 15)

	return view.origin, view.angles, view.fov
end

function SWEP:AdjustMouseSensitivity()
	return (view.fov or 90) / self.Owner:GetFOV()
end

function SWEP:PreDrawViewModel(vm, weapon, ply)
	local pos = self.Owner:GetShootPos()
	local FT  = FrameTime()

	if self.VModel then
		render.SetBlend(0)
		local origin, angles = self:CalcViewModelPos()

		self.VModel:SetPos(origin)
		self.VModel:SetAngles(angles)

		self:HandleBoneMods()
	end
end

function SWEP:ShouldDrawViewModel_COP()
	return not (self:GetScoped() and self.AimMul >= 0.99)
end

function SWEP:PostDrawViewModel(vm, weapon, ply)
	if self.VModel then
		render.SetBlend(1)
		cam.IgnoreZ(true)

		if self:ShouldDrawViewModel_COP() then
			self:DrawViewModel()
		end

		cam.IgnoreZ(false)
	end
end

local function COP_PlayAnimation(um)
	local seq   = um:ReadString()
	local speed = um:ReadFloat()
	local cycle = um:ReadFloat()

	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.IsCOPWeapon then
		wep:PlayAnimation(seq, speed, cycle)
	end
end

usermessage.Hook("COP_PLAYANIMATION", COP_PlayAnimation)

local function COP_EmitShell()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.IsCOPWeapon then
		wep:EmitShell()
	end
end

usermessage.Hook("COP_EMITSHELL", COP_EmitShell)

local function COP_AddonAttach(um)
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	local addon_type = um:ReadString()

	if IsValid(wep) and wep.IsCOPWeapon then
		wep.AttachTime = CurTime() + 1
		wep.AttachType = addon_type

		if addon_type == "silencer" then
			wep:EmitSound(wep:GetSilenced() and "COP_Addon.Detach" or "COP_Addon.Attach")
		else
			wep:EmitSound(wep:GetScoped() and "COP_Addon.Detach" or "COP_Addon.Attach")
		end
	end
end

usermessage.Hook("COP_ADDON_ATTACH", COP_AddonAttach)