AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/kek1ch/wood_stove.mdl")
		self:SetSolid(MOVETYPE_VPHYSICS)
		self:PhysicsInit(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:DropToFloor()

		if (IsValid(self:GetPhysicsObject())) then
			self:GetPhysicsObject():EnableMotion(false)
		end
	end

	function ENT:Use(activator, caller)
		netstream.Start(activator, "cooking_kek1ch")
	end

	function ENT:OnRemove()
	end
end