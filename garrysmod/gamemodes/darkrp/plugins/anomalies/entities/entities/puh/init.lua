AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )   
AddCSLuaFile( "cl_init.lua" ) 

function ENT:Initialize()
	self:SetModel("models/wick/anomaly/puh/puh.mdl")		
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(SOLID_VPHYSICS)

	if (IsValid(self:GetPhysicsObject())) then
		self:GetPhysicsObject():EnableMotion(false)
	end

	timer.Create("puh_rofl", 10, 0, function()
		self:EmitSound("wick/anomaly/bfuzz_blowout.ogg")
		ParticleEffect("gazirovka_activated", self:GetPos()+Vector(0,0,-60), Angle(0,0,180), nil)
	end)
end

function ENT:Think()
	if !self.delay_puh or self.delay_puh < CurTime() then 
		for k, v in pairs( ents.FindInSphere( self:GetPos()+Vector(0,0,-160),70 ) ) do
			if (v:IsPlayer() and v:Alive()) then
				self:EmitSound("wick/bushes/bush0"..math.random(1,6).."gr.ogg")
				self:EmitSound("wick/anomaly/pux_blast.ogg")
				ParticleEffect("gazirovka_activated", v:GetPos()+Vector(0,0,55), Angle(0,0,0), nil)
				v:ScreenFade( SCREENFADE.IN, Color( 85, 115, 15, 128 ), 0.3, 0 )
				v:TakeDamage(10)
			end
		end
		self.delay_puh = CurTime() + 1
	end
end

function ENT:OnRemove()
	timer.Remove("puh_rofl")
end
