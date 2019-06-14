AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/scanner_anomaly.mdl")
		self:SetSolid(MOVETYPE_VPHYSICS)
		self:PhysicsInit(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:DropToFloor()

		if (IsValid(self:GetPhysicsObject())) then
			self:GetPhysicsObject():EnableMotion(false)
		end

		timer.Simple(math.random(400, 1200), function()
			if IsValid(self) then
				self:Remove()
			end
		end)
	end
end