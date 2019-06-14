AddCSLuaFile()
ENT.Base            = "base_nextbot"
ENT.PrintName = "Крыса"
ENT.Author = "Kek1ch x WickedRabbit"
ENT.Category = "Warfare NPC"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.AutomaticFrameAdvance = true

function ENT:Initialize()
	self:SetModel( "models/wick/rat/wick_rat.mdl" )
	self:SetHealth( 9 )
	self.LoseTargetDist	= 1500
	self:SetCollisionBounds(Vector(-15,-15,0), Vector(15,15,15))
	self.SearchRadius 	= 1000
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSkin(math.random(1,4))

	--[[for k,v in pairs(ents.FindInSphere( self:GetPos(), 500 )) do
		if #(v:GetClass() == "ssk_rat") > 4 then
			self.leader = true
		end
	end]]
	--если рядом 4 крысы и нет лидера, то крыса становится лидером

	--игроку при покупке выдается "свисток" с уникальным айди, при призыве айди ставится на питомца; питомец следует за персонажем со свистком, айди которого равен айди питомца
end

function ENT:RunBehaviour()
	while ( true ) do
		if ( self:HaveEnemy() and self:GetEnemy():Alive()) then
			self.loco:FaceTowards( self:GetEnemy():GetPos() )
			self:ResetSequence("norm_run_fwd")
			self.loco:SetDesiredSpeed( 300 )
			self:ChaseEnemy()
			self:SetSequence( "norm_idle_"..math.random(1,2) )
			self:EmitSound("wick/rat/voice_"..math.random(1,2)..".ogg")
		else
			self:ResetSequence("norm_run_fwd")
			self.loco:SetDesiredSpeed( 300 )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 350 )
			self:SetSequence( "norm_idle_"..math.random(1,2) )
			self:PlaySequenceAndWait( "norm_idle_"..math.random(1,2) )
			self:EmitSound("wick/rat/idle_"..math.random(0,3)..".ogg")
		end
		--если рядом есть лидер, то идет за лидером
		coroutine.wait( 2 )
		coroutine.yield()
	end 
end

function ENT:PunchEnemy()
	local seq_h, dur_h = self:LookupSequence("attack_"..math.random(1,3))

	self:SetSequence(seq_h)
	self.loco:SetDesiredSpeed( 0 )

	local RatDamage = DamageInfo()
	RatDamage:SetDamage(2)
	RatDamage:SetAttacker( self )
	RatDamage:SetInflictor( self )
	RatDamage:SetDamageType( DMG_SLASH )
	self:GetEnemy():TakeDamageInfo( RatDamage )

	timer.Simple(dur_h, function()
		if (self.loco) then
			self.loco:SetDesiredSpeed( 300 )
			self:ResetSequence("norm_run_fwd")
		end
	end)
end

function ENT:OnContact( ent )
	if (!self.attack_delay_rat or self.attack_delay_rat < CurTime()) then
		if (ent:IsPlayer()) then
			self:EmitSound("wick/rat/hit_"..math.random(0,1)..".ogg")
			self:PunchEnemy()
		end
	self.attack_delay_rat = CurTime() + 0.7
	end 
end

function ENT:OnInjured(dmginfo)
	if (dmginfo:GetAttacker():IsPlayer() and !self:GetEnemy()) then
		self:SetEnemy( dmginfo:GetAttacker() )
	end
end

function ENT:OnKilled( dmginfo )
	self:EmitSound("wick/rat/death_"..math.random(0,3)..".ogg")

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
	for k, v in pairs( _ents ) do
		if ( v:IsPlayer() and v:GetMoveType() != MOVETYPE_NOCLIP )  then
			self:SetEnemy( v )
			return true
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
	return "ok"
end