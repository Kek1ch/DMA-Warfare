AddCSLuaFile( "shared.lua" ) --Send shared.lua to the client
include( 'shared.lua' ) --Include shared.lua              

AddCSLuaFile( "cl_init.lua" ) --Send shared.lua to the client     


if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/monolit.mdl")
		self:PhysicsInit(MOVETYPE_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		local physicsObject = self:GetPhysicsObject()
		if (IsValid(physicsObject)) then
			physicsObject:Wake()
		end
	end
function ENT:Think(client)
		if (!self.idle or self.idle < CurTime()) then
		self:EmitSound("mutants/ssk/poltergeist/tele_idle_0.wav")
		self.idle = CurTime() + 3
		end
	for k, v in pairs( ents.FindInSphere( self:GetPos(),500 ) ) do
		if (v:IsPlayer()) then
		if (v:Team() == FACTION_MONOLITH or v:Team() == FACTION_ZOMBIED or v:Team() == FACTION_ZOMBIFIED) then return end
			if (!self.psy or self.psy < CurTime()) then
			v:EmitSound("deadair/soundtrack/psi/psi_0"..math.random(1,9)..".ogg")
			v:setLocalVar("stm", v:getLocalVar("stm", 0) - 100)
			self.psy = CurTime() + 30
			end
		end
	end
	for k, v in pairs( ents.FindInSphere( self:GetPos(),10000	 ) ) do
		if (v:IsPlayer()) then
		if (v:Team() == FACTION_MONOLITH or v:Team() == FACTION_ZOMBIED or v:Team() == FACTION_ZOMBIFIED) then return end
			if (!self.open or self.open < CurTime()) then
				if !IsValid(v) then return end
				v:EmitSound("megafon/monolith_call_"..math.random(1,7)..".wav")
				v:EmitSound("deadair/psy_"..math.random(1,11)..".ogg")
				v:ScreenFade( SCREENFADE.IN, Color( 11, 216, 239, 128 ), 5, 0 )
			self.open = CurTime() + 18
			end
		end
	end
end

function ENT:Use(activator, caller)
	netstream.Start(activator, "monolet")
end

function ENT:OnRemove()
end
end