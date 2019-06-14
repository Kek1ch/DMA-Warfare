include('shared.lua')

function ENT:Initialize()
	
	local trace = {}
	trace.start = self.Entity:GetPos()
	trace.endpos = trace.start + Vector( 0, 0, -500 )
	trace.filter = self.Entity
	local tr = util.TraceLine( trace )
	
	self.Normal = tr.HitNormal
	self.Timer = 0
	self.BurnTime = 0
	self.Size = 150
	self.Emitter = ParticleEmitter( self.Entity:GetPos() )

end



function ENT:Think()

	local dist = LocalPlayer():GetPos():Distance(self:GetPos())

	if(dist < 6000) then

		if self.Timer < CurTime() then

			self.Emitter = ParticleEmitter( self:GetPos() )

			if math.random(1,1) > 0.1 then

				local particle = self.Emitter:Add( "effects/yellowflare", self:GetPos() + VectorRand() * 30 )

				particle:SetVelocity( self.Normal * 300 + VectorRand() * 70 + Vector(0,0,360) ) 

				particle:SetLifeTime( 0 )  

				particle:SetDieTime( math.Rand( 1, 1.2 ) ) 

				particle:SetStartAlpha( 255 ) 

				particle:SetEndAlpha( 255 ) 

				particle:SetStartSize( math.random( 20, 30 ) ) 

				particle:SetEndSize( 0 ) 

				particle:SetColor( 0, 222, 225 )

				particle:SetAirResistance( 100 )

				particle:SetGravity( Vector( 100, 100, 100 ) )

			end

			

			particle = self.Emitter:Add( "effects/yellowflare", self:GetPos() + VectorRand() * 120 )

			particle:SetVelocity( self.Normal * 400 + VectorRand() * 120 + Vector(0,0,90) ) 

			particle:SetLifeTime( 0 )  

			particle:SetDieTime( math.Rand( 1.0, 1.5 ) ) 

			particle:SetStartAlpha( 255 ) 

			particle:SetEndAlpha( 100 ) 

			particle:SetStartSize( math.random( 10, 15 ) ) 

			particle:SetEndSize( 0 ) 

			particle:SetColor( 0, 222, 225 )

			particle:SetAirResistance( 1000 )

			particle:SetGravity( Vector( 0, 0, 100 ) )
			
			
			particle = self.Emitter:Add( "effects/yellowflare", self:GetPos() + VectorRand() * 160 )

			particle:SetVelocity( self.Normal * 120 + VectorRand() * 180 + Vector(0,0,40) ) 

			particle:SetLifeTime( 0 )  

			particle:SetDieTime( math.Rand( 2.5, 2.5 ) ) 

			particle:SetStartAlpha( 200 ) 

			particle:SetEndAlpha( 100 ) 

			particle:SetStartSize( math.random( 10, 15 ) ) 

			particle:SetEndSize( 0 )
			
			particle:SetRoll( math.Rand( -360, 360 ) )

			particle:SetRollDelta( math.Rand( -5, 5 ) )

			particle:SetColor( 0, 222, 225 )

			particle:SetAirResistance( 20 )

			particle:SetGravity( Vector( 0, 0, 100 ) )
			
			particle = self.Emitter:Add( "effects/yellowflare", self:GetPos() + VectorRand() * 160 )

			particle:SetVelocity( self.Normal * 120 + VectorRand() * 180 + Vector(0,0,40) ) 

			particle:SetLifeTime( 0 )  

			particle:SetDieTime( math.Rand( 2.5, 2.5 ) ) 

			particle:SetStartAlpha( 200 ) 

			particle:SetEndAlpha( 100 ) 

			particle:SetStartSize( math.random( 10, 15 ) ) 

			particle:SetEndSize( 0 )
			
			particle:SetRoll( math.Rand( -360, 360 ) )

			particle:SetRollDelta( math.Rand( -5, 5 ) )

			particle:SetColor( 0, 222, 225 )

			particle:SetAirResistance( 20 )

			particle:SetGravity( Vector( 0, 0, 100 ) )
			
			particle = self.Emitter:Add( "effects/yellowflare", self:GetPos() + VectorRand() * 160 )

			particle:SetVelocity( self.Normal * 120 + VectorRand() * 180 + Vector(0,0,40) ) 

			particle:SetLifeTime( 0 )  

			particle:SetDieTime( math.Rand( 2.5, 2.5 ) ) 

			particle:SetStartAlpha( 200 ) 

			particle:SetEndAlpha( 100 ) 

			particle:SetStartSize( math.random( 10, 15 ) ) 

			particle:SetEndSize( 0 )
			
			particle:SetRoll( math.Rand( -360, 360 ) )

			particle:SetRollDelta( math.Rand( -5, 5 ) )

			particle:SetColor( 0, 222, 225 )

			particle:SetAirResistance( 20 )

			particle:SetGravity( Vector( 0, 0, 100 ) )
			
			particle = self.Emitter:Add( "effects/yellowflare", self:GetPos() + VectorRand() * 160 )

			particle:SetVelocity( self.Normal * 120 + VectorRand() * 180 + Vector(0,0,40) ) 

			particle:SetLifeTime( 0 )  

			particle:SetDieTime( math.Rand( 2.5, 2.5 ) ) 

			particle:SetStartAlpha( 200 ) 

			particle:SetEndAlpha( 100 ) 

			particle:SetStartSize( math.random( 20, 50 ) ) 

			particle:SetEndSize( 0 )
			
			particle:SetRoll( math.Rand( -360, 360 ) )

			particle:SetRollDelta( math.Rand( -5, 5 ) )

			particle:SetColor( 0, 222, 225 )

			particle:SetAirResistance( 20 )

			particle:SetGravity( Vector( 0, 0, 100 ) )
			
			particle = self.Emitter:Add( "effects/yellowflare", self:GetPos() + VectorRand() * 160 )

			particle:SetVelocity( self.Normal * 120 + VectorRand() * 180 + Vector(0,0,40) ) 

			particle:SetLifeTime( 0 )  

			particle:SetDieTime( math.Rand( 2.5, 2.5 ) ) 

			particle:SetStartAlpha( 200 ) 

			particle:SetEndAlpha( 100 ) 

			particle:SetStartSize( math.random( 10, 15 ) ) 

			particle:SetEndSize( 0 )
			
			particle:SetRoll( math.Rand( -360, 360 ) )

			particle:SetRollDelta( math.Rand( -5, 5 ) )

			particle:SetColor( 0, 222, 225 )

			particle:SetAirResistance( 20 )

			particle:SetGravity( Vector( 0, 0, 100 ) )
			
			particle = self.Emitter:Add( "effects/combinemuzzle2", self:GetPos() + VectorRand() * 160 )

			particle:SetVelocity( self.Normal * 120 + VectorRand() * 180 + Vector(0,0,40) ) 

			particle:SetLifeTime( 0 )  

			particle:SetDieTime( math.Rand( 2.5, 2.5 ) ) 

			particle:SetStartAlpha( 200 ) 

			particle:SetEndAlpha( 100 ) 

			particle:SetStartSize( math.random( 10, 15 ) ) 

			particle:SetEndSize( 0 )
			
			particle:SetRoll( math.Rand( -360, 360 ) )

			particle:SetRollDelta( math.Rand( -5, 5 ) )

			particle:SetColor( 0, 222, 225 )

			particle:SetAirResistance( 20 )

			particle:SetGravity( Vector( 0, 0, 100 ) )
			
			particle = self.Emitter:Add( "effects/ar2_altfire1", self:GetPos() + VectorRand() * 160 )

			particle:SetVelocity( self.Normal * 120 + VectorRand() * 180 + Vector(0,0,40) ) 

			particle:SetLifeTime( 0 )  

			particle:SetDieTime( math.Rand( 2.5, 2.5 ) ) 

			particle:SetStartAlpha( 200 ) 

			particle:SetEndAlpha( 100 ) 

			particle:SetStartSize( math.random( 10, 15 ) ) 

			particle:SetEndSize( 0 )
			
			particle:SetRoll( math.Rand( -360, 360 ) )

			particle:SetRollDelta( math.Rand( -5, 5 ) )

			particle:SetColor( 0, 222, 225 )

			particle:SetAirResistance( 20 )

			particle:SetGravity( Vector( 0, 0, 100 ) )
			
			particle = self.Emitter:Add( "effects/strider_muzzle", self:GetPos() + VectorRand() * 160 )

			particle:SetVelocity( self.Normal * 120 + VectorRand() * 180 + Vector(0,0,40) ) 

			particle:SetLifeTime( 0 )  

			particle:SetDieTime( math.Rand( 2.5, 2.5 ) ) 

			particle:SetStartAlpha( 200 ) 

			particle:SetEndAlpha( 100 ) 

			particle:SetStartSize( math.random( 10, 15 ) ) 

			particle:SetEndSize( 0 )
			
			particle:SetRoll( math.Rand( -360, 360 ) )

			particle:SetRollDelta( math.Rand( -5, 5 ) )

			particle:SetColor( 0, 222, 225 )

			particle:SetAirResistance( 20 )
			particle:SetGravity( Vector( 0, 0, 100 ) )
			particle = self.Emitter:Add( "effects/rollerglow", self:GetPos() + VectorRand() * 160 )
			particle:SetVelocity( self.Normal * 120 + VectorRand() * 180 + Vector(0,0,40) ) 
			particle:SetLifeTime( 0 )  
			particle:SetDieTime( math.Rand( 2.5, 2.5 ) ) 
			particle:SetStartAlpha( 200 ) 
			particle:SetEndAlpha( 100 ) 
			particle:SetStartSize( math.random( 10, 15 ) ) 
			particle:SetEndSize( 0 )
			particle:SetRoll( math.Rand( -360, 360 ) )
			particle:SetRollDelta( math.Rand( -5, 5 ) )
			particle:SetColor( 0, 222, 225 )
			particle:SetAirResistance( 20 )
			particle:SetGravity( Vector( 0, 0, 100 ) )
			particle = self.Emitter:Add( "effects/stunstick", self:GetPos() + VectorRand() * 160 )
			particle:SetVelocity( self.Normal * 120 + VectorRand() * 180 + Vector(0,0,40) ) 
			particle:SetLifeTime( 0 )  
			particle:SetDieTime( math.Rand( 2.5, 2.5 ) ) 
			particle:SetStartAlpha( 200 ) 
			particle:SetEndAlpha( 100 ) 
			particle:SetStartSize( math.random( 10, 15 ) ) 
			particle:SetEndSize( 0 )
			particle:SetRoll( math.Rand( -360, 360 ) )
			particle:SetRollDelta( math.Rand( -5, 5 ) )
			particle:SetColor( 0, 222, 225 )
			particle:SetAirResistance( 20 )
			particle:SetGravity( Vector( 0, 0, 100 ) )
			particle = self.Emitter:Add( "effects/gunshipmuzzle", self:GetPos() + VectorRand() * 160 )
			particle:SetVelocity( self.Normal * 120 + VectorRand() * 180 + Vector(0,0,40) ) 
			particle:SetLifeTime( 0 )  
			particle:SetDieTime( math.Rand( 2.5, 2.5 ) ) 
			particle:SetStartAlpha( 200 ) 
			particle:SetEndAlpha( 100 ) 
			particle:SetStartSize( math.random( 10, 15 ) ) 
			particle:SetEndSize( 0 )
			particle:SetRoll( math.Rand( -360, 360 ) )
			particle:SetRollDelta( math.Rand( -5, 5 ) )
			particle:SetColor( 0, 222, 225 )
			particle:SetAirResistance( 20 )
			particle:SetGravity( Vector( 0, 0, 100 ) )

			self.FireLight1 = DynamicLight(self:EntIndex())
			if ( self.FireLight1 ) then
				self.FireLight1.Pos = self:GetPos()
				self.FireLight1.r = 0
				self.FireLight1.g = 222
				self.FireLight1.b = 225
				self.FireLight1.Brightness = 6
				self.FireLight1.Size = 1000
				self.FireLight1.Decay = 10
				self.FireLight1.DieTime = CurTime() + 1
			end
			self.Timer = CurTime() + 0.5
		end
		if self:GetNWBool( "Burn" ) == true then
			local particle = self.Emitter:Add( "effects/muzzleflash"..math.random(1,4), self.Entity:GetPos() + self.Normal * -5 )
			particle:SetVelocity( self.Normal * 150 + VectorRand() * 30 ) 
			particle:SetLifeTime( 0 )  
			particle:SetDieTime( math.Rand( 0.5, 1.0 ) ) 
			particle:SetStartAlpha( 255 ) 
			particle:SetEndAlpha( 0 ) 
			particle:SetStartSize( math.random( 60, 80 ) ) 
			particle:SetEndSize( math.random( 90, 100 ) ) 
			particle:SetColor( 209, 21, 46 )
			particle:SetRoll( math.Rand( -360, 360 ) )
			particle:SetRollDelta( math.Rand( -5, 5 ) )
			particle:SetAirResistance( 0 )
			particle:SetGravity( Vector( 0, 0, 50 ) )
		end
	end
end

function ENT:IsTranslucent()
	return false
end
