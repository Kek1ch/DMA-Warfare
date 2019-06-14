AddCSLuaFile()

SWEP.PrintName = "Детектор «Отклик»"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 4
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel = "models/wick/weapons/stalker/stcopwep/otklik_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_bin_model_stcop.mdl"
SWEP.ViewModelFOV  = 50
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

SWEP.OriginPos = Vector(-2, 0, -9.5)
SWEP.OriginAng = Vector(0, 0, 0)

SWEP.AimPos = Vector(0, 0, 0)
SWEP.AimAng = Vector(0, 0, 0)

SWEP.SilencerMode = 0
SWEP.ScopeMode    = 1

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 2.85
SWEP.ReloadFillTime = 1.4

SWEP.CanZoom       = false
SWEP.ZoomCrosshair = false

--SWEP.SlideBone = { name = "breachblock", pos = Vector(0, -1.2, 0) }

SWEP.BoneMatrix = {
	l_finger01 = {
		Pos = Vector(-1, 0, 0),
		Ang = Angle(0, 0, 2)
	}
}


SWEP.SprintAnim = "idle_moving"

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 20

SWEP.DeploySound   = "COPBINOSCOP.bino_draw_stcop"
SWEP.HolsterSound  = "COPBINOSCOP.bino_holster"
SWEP.ZoomInSound   = ""
SWEP.ZoomOutSound  = ""

SWEP.DoAimAnimation = false

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

SWEP.LastBeep = 0
SWEP.DistBeep = 501
function SWEP:Think2()
	local vm = self.VModel
	if CLIENT then
		local dist, own, item = self.DistBeep, self.Owner, nut.item.list
		local pos = own:GetPos()
		local dek = pos - own:GetShootPos()
		local aimvec = own:GetAimVector()
		local sos = dek:GetNormalized()
		local dot = sos:Dot(aimvec)
		local clampdot = (1-math.Clamp(dot, 0, 0.5))
		for _, v in ipairs(ents.FindByClass("nut_item")) do
			if (IsValid(v) and item[v:getNetVar("id", "")] != nil and item[v:getNetVar("id", "")].isAnomaly) then
				dist = v:GetPos():Distance(own:GetPos())*clampdot
			end
		end
		if dist < (self.DistBeep - 1) then
			if self.LastBeep + dist/300 - CurTime() <= 0 then
				self.LastBeep = CurTime()
				vm:SetSkin(2)
				timer.Simple(0.1, function()
					if IsValid(self) and IsValid(self.Weapon) then vm:SetSkin(1) end
				end)
				own:EmitSound(Sound("stalkerdetectors/echo.wav"), 100, 100)//math.Clamp(250-dist/2,50,250))
			end
		end
	end
end