AddCSLuaFile( "cl_init.lua" ) --Send shared.lua to the client
AddCSLuaFile( "shared.lua" ) --Send shared.lua to the client
include( 'shared.lua' ) --Include shared.lua

function ENT:Initialize()
	self:GetPos()
	self:SetModel(self.model)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)	
	self:SetColor( Color( 255, 255, 255, 20 ) )
end

function ENT:Think()  
	self:ResetSequence(self:LookupSequence("idle"))
	self:SetPlaybackRate(1)
	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
end
