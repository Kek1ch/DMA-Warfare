AddCSLuaFile()

SWEP.PrintName = "Бинокль"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 4
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel     = "models/wick/weapons/stalker/stcopwep/bin_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_bin_model_stcop.mdl"
SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.HoldType      = "slam"

SWEP.Damage   = 0
SWEP.RPM      = 0
SWEP.Accuracy = 0
SWEP.Handling = 0

SWEP.Primary.ClipSize    = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "none"

SWEP.ScopeTexture = "wpn_crosshair_bino_stcop"

SWEP.OriginPos = Vector(0.5, 0, -7)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(0, -5, -3)
SWEP.AimAng = Vector(0, 0, 0)

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 1

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 2.85
SWEP.ReloadFillTime = 1.4

SWEP.COP_DrawCrosshair = false

SWEP.CanZoom       = true
SWEP.ZoomCrosshair = false



SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 20

SWEP.DeploySound   = "COPBINOSCOP.bino_draw_stcop"
SWEP.HolsterSound  = "COPBINOSCOP.bino_holster"
SWEP.ZoomInSound   = ""
SWEP.ZoomOutSound  = ""

SWEP.DoAimAnimation = false

function SWEP:ZoomThink()
	local CT = CurTime()
	local reloading = self:GetReloading()
	local sprinting = self:GetSprinting()
	local aiming = self:GetAiming()
	local nextFire = self:GetNextPrimaryFire()
	local inAttack2 = self.Owner:KeyDown(IN_ATTACK) or self.Owner:KeyDown(IN_ATTACK2)

	if self.CanZoom and !aiming and inAttack2 and !sprinting and !reloading and not self.Owner:KeyDown(IN_USE) and nextFire < CT then
		self:SetWeaponState(COP_WEPSTATE_AIMING)
		self:SetNextPrimaryFire(CT + self.AimTime)

		if IsFirstTimePredicted() then
			self:EmitSound(self.ZoomInSound)
		end
	elseif aiming and (!inAttack2 or sprinting or reloading) then
		self:SetWeaponState(COP_WEPSTATE_NONE)
		self:SetNextPrimaryFire(CT + self.AimTime)

		if IsFirstTimePredicted() then
			self:EmitSound(self.ZoomOutSound)
		end
	end

	if CLIENT then
		if not self:GetAiming() and self.EntInfo then
			self.EntInfo = nil
		end
	end
end

function SWEP:Reload()

end

if CLIENT then
	local function surface_DrawCorneredRect(x, y, w, h, len)
		local x2 = x + w
		local y2 = y + h

		surface.DrawLine(x, y, x + len, y)
		surface.DrawLine(x, y, x, y + len)

		surface.DrawLine(x2, y, x2 - len, y)
		surface.DrawLine(x2, y, x2, y + len)

		surface.DrawLine(x, y2, x + len, y2)
		surface.DrawLine(x, y2, x, y2 - len)

		surface.DrawLine(x2, y2, x2 - len, y2)
		surface.DrawLine(x2, y2, x2, y2 - len)
	end

	local function GetEntityAABB(ent)
		local mins = ent:OBBMins()
		local maxs = ent:OBBMaxs()

		local pos = {}

		pos[1] = ent:LocalToWorld(Vector(maxs.x, maxs.y, maxs.z)):ToScreen()
		pos[2] = ent:LocalToWorld(Vector(maxs.x, mins.y, maxs.z)):ToScreen()
		pos[3] = ent:LocalToWorld(Vector(maxs.x, maxs.y, mins.z)):ToScreen()
		pos[4] = ent:LocalToWorld(Vector(maxs.x, mins.y, mins.z)):ToScreen()
		pos[5] = ent:LocalToWorld(Vector(mins.x, maxs.y, maxs.z)):ToScreen()
		pos[6] = ent:LocalToWorld(Vector(mins.x, mins.y, maxs.z)):ToScreen()
		pos[7] = ent:LocalToWorld(Vector(mins.x, maxs.y, mins.z)):ToScreen()
		pos[8] = ent:LocalToWorld(Vector(mins.x, mins.y, mins.z)):ToScreen()

		local minX = pos[1].x
		local minY = pos[1].y

		local maxX = pos[1].x
		local maxY = pos[1].y

		for k = 2, 8 do
			if pos[k].x > maxX then
				maxX = pos[k].x
			end

			if pos[k].y > maxY then
				maxY = pos[k].y
			end

			if pos[k].x < minX then
				minX = pos[k].x
			end

			if pos[k].y < minY then
				minY = pos[k].y
			end
		end

		return Vector(minX, minY), Vector(maxX, maxY)
	end

	local function InRect(x, y, x2, y2, w2, h2)
		return x >= x2 and y >= y2 and x <= w2 and y <= h2
	end

	local td = {}
	local function GetEntityVisible(self, ent)
		local mins, maxs = ent:GetRotatedAABB(ent:OBBMins(), ent:OBBMaxs())
		local origin     = ent:GetPos() + (mins + maxs) * 0.5

		td.start  = self.Owner:EyePos()
		td.endpos = td.start + (origin - td.start):GetNormal() * 10000
		td.filter = self.Owner

		local tr = util.TraceLine(td)
		if not tr.HitWorld then
			return true
		end

		return false
	end

	local function IsEntityTarget(self, ent)
		local info = self.EntInfo[ent]

		local scrW = ScrW()
		local scrH = ScrH()

		local x = (info.x + info.w) * 0.5 / scrW
		local y = (info.y + info.h) * 0.5 / scrH

		return Vector(0.5, 0.5):Distance(Vector(x, y)) <= 0.1
	end

	function SWEP:PreDrawScope()
		local _ents = ents.GetAll()

		local CT = CurTime()
		local FT = FrameTime()

		if not self.EntInfo then
			self.EntInfo = {}
		end

		for i = 1, #_ents do
			local ent = _ents[i]

			if not self.EntInfo[ent] and IsValid(ent) and ent:IsNPC() and GetEntityVisible(self, ent) then
				self.EntInfo[ent] = { x = 0, y = 0, w = ScrW(), h = ScrH() }
				self:EmitSound("COP_Bino.Beep")
			end
		end

		td.filter = self.Owner

		for ent, info in pairs(self.EntInfo) do
			if IsValid(ent) then
				if info.marked or GetEntityVisible(self, ent) then
					local mins, maxs = GetEntityAABB(ent)

					info.x = Lerp(FT * 5, info.x, mins.x)
					info.y = Lerp(FT * 5, info.y, mins.y)

					info.w = Lerp(FT * 5, info.w, maxs.x)
					info.h = Lerp(FT * 5, info.h, maxs.y)

					if not info.marked then
						local vis = IsEntityTarget(self, ent)

						if vis then
							info.markTime = (info.markTime or 0) + FT

							if info.markTime >= 1 then
								info.marked = true
								self:EmitSound("COP_Bino.Beep")
							end
						else
							info.markTime = nil
						end
					end

					local scrW = ScrW() * 0.5
					local scrH = ScrH() * 0.5

					if info.marked then
						surface.SetDrawColor(255, 0, 0)
					else
						surface.SetDrawColor(255, 255, 255)
					end

					surface_DrawCorneredRect(info.x, info.y, info.w - info.x, info.h - info.y, 8)
				else
					self.EntInfo[ent] = nil
				end
			else
				self.EntInfo[ent] = nil
			end
		end
	end
end