AddCSLuaFile()
ENT.Base            = "base_nextbot"
ENT.PrintName = "Волк"
ENT.Author = "Kek1ch"
ENT.Category = "Warfare NPC"
ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:Initialize()
	self:SetModel( "models/kek1ch/wolf/wolf_grey.mdl" )
	self:SetHealth( 125 )
	self.LoseTargetDist	= 1000
	self:SetCollisionBounds(Vector(-15,-15,0), Vector(15,15,15))
	self.SearchRadius 	= 900
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSkin(math.random(0,4))
end

function ENT:RunBehaviour()
	while ( true ) do
		if ( self:HaveEnemy() ) then
			self.loco:FaceTowards( self:GetEnemy():GetPos() )
			self:ResetSequence("stand_run_0")
			self.loco:SetDesiredSpeed( 400 )
			self:ChaseEnemy()
			self:SetSequence( "stand_idle_"..math.random(0,2) )
			self:EmitSound("kek1ch/wolf/pdog_attack_"..math.random(0,2)..".ogg")
		else
			if (self.uniqueid) then
				for k,v in pairs(player.GetAll()) do
					if v:getChar():getInv():hasItem("svistok"):getData("DOG_ID") == self.uniqueid then
						self:Follow(v)
					end
				end
			else
				self:ResetSequence("walk")
				self.loco:SetDesiredSpeed( 90 )
				self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 600 )
				self:SetSequence( "stand_idle_"..math.random(0,2) )
				self:PlaySequenceAndWait( "stand_idle_"..math.random(0,2) )
				self:EmitSound("kek1ch/wolf/idle_"..math.random(0,2)..".ogg")
			end
		end
		coroutine.wait( 2 )
		coroutine.yield()
	end 
end

function ENT:Follow(v)
	local options = options or {}
	local path = Path( "Chase" )
	path:SetMinLookAheadDistance( options.lookahead or 300 )
	path:SetGoalTolerance( options.tolerance or 20 )
	path:Compute( self, v:GetPos() )	
	if ( !path:IsValid() ) then return "failed" end
	while ( path:IsValid()) do
		if ( self:HaveEnemy() ) then break end
		self.loco:FaceTowards( v:GetPos() )

		if (self:GetRangeTo(v:GetPos()) > 190) then
			self:ResetSequence("stand_run_0")
			self.loco:SetDesiredSpeed( 200 )
			if ( path:GetAge() > 0.1 ) then
				path:Compute( self, v:GetPos() )
			end
			path:Update( self )								
			if ( options.draw ) then path:Draw() end
			if ( self.loco:IsStuck() ) then
				self:HandleStuck()
				return "stuck"
			end
		elseif (self:GetRangeTo(v:GetPos()) > 100) then
			self:ResetSequence("walk")
			self.loco:SetDesiredSpeed( 90 )
			if ( path:GetAge() > 0.1 ) then
				path:Compute( self, v:GetPos() )
			end
			path:Update( self )								
			if ( options.draw ) then path:Draw() end
			if ( self.loco:IsStuck() ) then
				self:HandleStuck()
				return "stuck"
			end
		else
			if math.random(1,4) == 1 then
				self:ResetSequence("walk")
				self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 70 )
			end
			self:PlaySequenceAndWait( "stand_idle_"..math.random(0,2) )
		end
	coroutine.yield()
	end
end

--[[function ENT:Follow(v)
	local options = options or {}
	local path = Path( "Chase" )
	path:SetMinLookAheadDistance( options.lookahead or 300 )
	path:SetGoalTolerance( options.tolerance or 20 )
	path:Compute( self, v:GetPos() )	
	if ( !path:IsValid() ) then return "failed" end
	while ( path:IsValid()) do
		if ( self:HaveEnemy() ) then break end
		self.loco:FaceTowards( v:GetPos() )

		if (self:GetRangeTo(v:GetPos()) > 190) then
			self:ResetSequence("stand_run_0")
			self.loco:SetDesiredSpeed( 200 )
			self:Cnt(v)
		elseif (self:GetRangeTo(v:GetPos()) > 100) then
			self:ResetSequence("walk")
			self.loco:SetDesiredSpeed( 90 )
			self:Cnt(v)
		else
			if math.random(1,4) == 1 then
				self:ResetSequence("walk")
				self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 70 )
			end
			self:PlaySequenceAndWait( "stand_idle_"..math.random(0,2) )
		end
	coroutine.yield()
	end
end

function Cnt(v)
	if ( Path( "Chase" ):GetAge() > 0.1 ) then
		Path( "Chase" ):Compute( self, v:GetPos() )
	end
	Path( "Chase" ):Update( self )								
	if ( options.draw ) then Path( "Chase" ):Draw() end
	if ( self.loco:IsStuck() ) then
		self:HandleStuck()
		return "stuck"
	end
end]]

function ENT:PunchEnemy()
	local seq_h, dur_h = self:LookupSequence("stand_psi_attack_"..math.random(0,1))

	self:SetSequence(seq_h)
	self.loco:SetDesiredSpeed( 0 )

	local WolfDamage = DamageInfo()
	WolfDamage:SetDamage(10)
	WolfDamage:SetAttacker( self )
	WolfDamage:SetInflictor( self )
	WolfDamage:SetDamageType( DMG_SLASH )
	self:GetEnemy():TakeDamageInfo( WolfDamage )

	timer.Simple(dur_h, function()
		self.loco:SetDesiredSpeed( 400 )
		self:ResetSequence("stand_run_0")
	end)
end

function ENT:OnContact( ent )
	if (!self.attack_delay_rat or self.attack_delay_rat < CurTime()) then
		if (self:HaveEnemy()) then
			self:EmitSound("wick/rat/attack_hit_"..math.random(0,2)..".ogg")
			self:PunchEnemy()
		end
	self.attack_delay_rat = CurTime() + 0.7
	end 
end

function ENT:OnInjured(dmginfo)
	if (math.random(1,2) == 1) then
		self:EmitSound("kek1ch/wolf/pdog_hurt_"..math.random(0,1)..".ogg")
	end
	if (dmginfo:GetAttacker():IsPlayer() and !self:GetEnemy()) then
		self:SetEnemy( dmginfo:GetAttacker() )
	end
end

function ENT:OnKilled( dmginfo )
	self:EmitSound("kek1ch/wolf/pdog_death_"..math.random(0,1)..".ogg")
	local body = ents.Create( "prop_ragdoll" )
  	body:SetPos( self:GetPos() )
  	body:SetModel( self:GetModel() )
  	body:SetModel( self:GetModel() )
  	body:Spawn()

  	self:Remove()

  	timer.Simple(5, function()
  	  body:Remove()
  	end)
end

function ENT:SetEnemy( ent )
	self.Enemy = ent
end

function ENT:GetEnemy()
	return self.Enemy
end

function ENT:HaveEnemy()
	if ( self:GetEnemy() and IsValid( self:GetEnemy() ) ) then
		if ( self:GetRangeTo( self:GetEnemy():GetPos() ) > self.LoseTargetDist ) then
			return self:FindEnemy()
		elseif ( self:GetEnemy():IsPlayer() and !self:GetEnemy():Alive() and self:GetEnemy():GetMoveType() != MOVETYPE_NOCLIP ) then
			return self:FindEnemy()
		end
		return true
	else
		return self:FindEnemy()
	end
end

function ENT:FindEnemy()
	local st = GetConVarNumber("ai_ignoreplayers")
	local _ents = ents.FindInSphere( self:GetPos(), self.SearchRadius )
	if !self.uniqueid then
		for k, v in pairs( _ents ) do
			if ( v:IsPlayer() and v:GetMoveType() != MOVETYPE_NOCLIP )  then
				self:SetEnemy( v )
				return true
			end
		end
	end
	self:SetEnemy( nil )
	return false
end

function ENT:ChaseEnemy( options )
	local options = options or {}
	local path = Path( "Chase" )
	path:SetMinLookAheadDistance( options.lookahead or 300 )
	path:SetGoalTolerance( options.tolerance or 20 )
	path:Compute( self, self:GetEnemy():GetPos() )	
	if (self:GetRangeTo(self:GetEnemy():GetPos()) > 5) then
		if ( !path:IsValid() ) then return "failed" end
		while ( path:IsValid() and self:HaveEnemy() ) do
			if ( path:GetAge() > 0.1 ) then
				path:Compute( self, self:GetEnemy():GetPos() )
			end
			path:Update( self )								
			if ( options.draw ) then path:Draw() end
			if ( self.loco:IsStuck() ) then
				self:HandleStuck()
				return "stuck"
			end

			coroutine.yield()
		end
	end
	return "ok"
end