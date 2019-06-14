AddCSLuaFile()
ENT.Base            = "base_nextbot"
ENT.PrintName = "Зомбированные"
ENT.Author = "Kek1ch"
ENT.Category = "Warfare NPC"
ENT.Spawnable = true
ENT.AdminOnly = true

local guns = {
"weapon_cop_ak_74",
"weapon_cop_rpk",
"weapon_cop_svd",
"weapon_cop_pkm",
"weapon_cop_bizon",
"weapon_cop_val",
"weapon_cop_ak74u",
"weapon_cop_lr300",
"weapon_cop_groza"
}

local ZModel = {
"models/hdmodels/kek1ch/stalker_zombie1.mdl",
"models/hdmodels/kek1ch/stalker_zombie2.mdl",
"models/hdmodels/kek1ch/stalker_zombie2.mdl",
"models/hdmodels/kek1ch/stalker_zombie4.mdl",
"models/hdmodels/kek1ch/stalker_zombie7.mdl",
"models/hdmodels/kek1ch/stalker_zombie8.mdl",
"models/hdmodels/kek1ch/zombie_fresh_0.mdl"
}

function ENT:Initialize()
	self:SetModel(table.Random(ZModel))
	self:SetHealth( 300 )
	self.LoseTargetDist	= 900
	self.SearchRadius 	= 900
	self:SetCollisionBounds(Vector(-12,-12,0), Vector(12,12,80))
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:GiveWeapon(table.Random(guns))
end

function ENT:GiveWeapon(wep)
	if (SERVER) then
		local wep = ents.Create(wep)
		local pos = self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos
		wep:SetOwner(self)
		wep:SetPos(pos)
		wep:Spawn()
		wep:SetNotSolid(true)
		wep:SetTrigger(false)
		wep:SetSolid(SOLID_NONE)
		wep:SetParent(self)
		wep:Fire("setparentattachment", "anim_attachment_RH")
		wep:AddEffects(EF_BONEMERGE)
		self.Weapon = wep
	end
end

function ENT:FireWeapon()
	local bullet = {} 

	if (self.Weapon) then
		local muzzle = self.Weapon:GetAttachment(self.Weapon:LookupAttachment("muzzle"))
		local shootPos = muzzle.Pos
		local bulletDir = ( (self:GetEnemy():GetPos() + Vector(math.random(-30,30), math.random(-30,30), 40) ) - shootPos):GetNormalized()

		bullet.Num = self.Weapon.NumberofShots 
		bullet.Src = shootPos
		bullet.Dir = bulletDir
		bullet.Tracer = 1
		bullet.TracerName = "Tracer"
		bullet.Force = self.Weapon.Force 
		bullet.Damage = math.random(20,32)
		bullet.AmmoType = self.Weapon.Ammo
		self.Weapon:FireBullets( bullet )
	end
end

local gunsound = {
["weapon_cop_ak_74"] = "weapons/stalker_cop/ak74_shoot.wav",
["weapon_cop_rpk"] = "weapons/stalker_cop/rpk74_shoot.wav",
["weapon_cop_svd"] = "weapons/stalker_cop/svd_shoot.wav",
["weapon_cop_pkm"] = "weapons/stalker_cop/pkm_shoot.wav",
["weapon_cop_bizon"] = "weapons/stalker_cop/bizon_shoot.wav",
["weapon_cop_val"] = "weapons/stalker_cop/val_shoot.wav",
["weapon_cop_ak74u"] = "weapons/stalker_cop/aks74u_shoot.wav",
["weapon_cop_lr300"] = "weapons/stalker_cop/lr300_shoot.wav",
["weapon_cop_groza"] = "weapons/stalker_cop/groza_shoot.wav",
["weapon_cop_groza"] = "weapons/stalker_cop/sks_shoot.wav"
}

if (SERVER) then
	function ENT:Think()
		if not (self:Health() < 60) then
			if ( self:GetEnemy() and IsValid( self:GetEnemy() ) ) then
				if (!self.timer_zombied_attack or self.timer_zombied_attack < CurTime()) then
					if (self:GetRangeTo(self:GetEnemy():GetPos()) < 600 and self:GetRangeTo(self:GetEnemy():GetPos()) > 220) then
						if self:GetEnemy():IsPlayer() then
							self:FireWeapon()
							self:StartActivity( ACT_HL2MP_SIT_PISTOL )
							if !(self:GetSequence() == "norm_torso_2_aim_fwd") then
								self:ResetSequence("norm_torso_2_aim_fwd")
								self:SetPlaybackRate(1)
							end
							self.loco:SetDesiredSpeed( 50 )

							for k, v in pairs(gunsound) do
								if (self.Weapon:GetClass() == k) then
									self.Weapon:EmitSound(v)
								end
							end
						end
					elseif (self:GetRangeTo(self:GetEnemy():GetPos()) < 220) then
						if self:GetEnemy():IsPlayer() then

							self:FireWeapon()
							self:StartActivity( ACT_HL2MP_SIT_PISTOL )
							self.loco:SetDesiredSpeed( 0 )
							if !(self:GetSequence() == "norm_torso_2_attack_0") then
								self:ResetSequence("norm_torso_2_attack_0")
								self:SetPlaybackRate(1)
							end

							for k, v in pairs(gunsound) do
								if (self.Weapon:GetClass() == k) then
									self.Weapon:EmitSound(v)
								end
							end
						end
					end
					self.timer_zombied_attack = CurTime() + math.random(0.9 ,1.1)
				end
			end
		end
	end
end

local idle_anim = {
"trans_0_idle_"..math.random(0,6),
"idle_0_idle_"..math.random(0,4)
}

function ENT:RunBehaviour()
	while ( true ) do
		if not (self:Health() < 60) then
			if ( self:HaveEnemy() ) then
				self.loco:FaceTowards( self:GetEnemy():GetPos() )
				self:StartActivity( ACT_WALK )
				self:ResetSequence("norm_torso_"..math.random(1,3).."_walk_0")
				self:SetPlaybackRate(1)
				self.loco:SetDesiredSpeed( 50 )
				self.loco:SetAcceleration( 50 )
				self:ChaseEnemy()
				self:StartActivity( ACT_IDLE )
				self:SetSequence( table.Random(idle_anim) )
				--звук при агре
			else
				self:StartActivity( ACT_WALK )
				self:ResetSequence("norm_torso_"..math.random(1,3).."_walk_0")
				self:SetPlaybackRate(1)
				self.loco:SetDesiredSpeed( 50 )
				self.loco:SetAcceleration( 50 )
				self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 350 )
				self:StartActivity( ACT_IDLE )
				self:SetSequence( "idle_0_idle_"..math.random(0,4) )
				self:PlaySequenceAndWait( table.Random(idle_anim) )
				--звук в простое
			end
		end
		coroutine.wait( 2 )
		coroutine.yield()
	end 
end

function ENT:OnInjured(dmginfo)
	if IsValid(self) then
		--звук получения дамага
		if (self:Health() < 60) then
			self:ResetSequence( "wounded_idle_1" )
			self:SetPlaybackRate(1)
			self.loco:SetDesiredSpeed( 0 )
			timer.Simple(3, function()
				if IsValid(self) then
					--звук при попытке встать
					self:ResetSequence( "wounded_to_idle_0" )
					self:SetPlaybackRate(1)
					timer.Simple(1.4, function()
						if IsValid(self) then
							self:SetHealth(61)
						end
					end)
				end
			end)
		end
	end
end

function ENT:OnKilled( dmginfo )
	hook.Call( "OnNPCKilled", GAMEMODE, self, dmginfo:GetAttacker(), dmginfo:GetInflictor() )

	--[[local body = ents.Create( "prop_ragdoll" )
  	body:SetPos( self:GetPos() )
  	body:SetModel( self:GetModel() )
  	body:SetModel( self:GetModel() )
  	body:Spawn()]]

  	self:Remove()

  	--[[timer.Simple(5, function()
  	  body:Remove()
  	end)]]
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
		elseif ( self:GetEnemy():IsPlayer() and !self:GetEnemy():Alive() and self:GetEnemy():GetMoveType() != MOVETYPE_NOCLIP and self:GetEnemy():Team() != FACTION_MONOLIT and self:GetEnemy():Team() != FACTION_ZOMBIED) then
			return self:FindEnemy()
		end
		return true
	else
		return self:FindEnemy()
	end
end

function ENT:FindEnemy()
	local _ents = ents.FindInSphere( self:GetPos(), self.SearchRadius )
	for k, v in pairs( _ents ) do
		if ( v:IsPlayer() and v:GetMoveType() != MOVETYPE_NOCLIP and v:Team() != FACTION_MONOLIT and v:Team() != FACTION_ZOMBIED) then
			self:SetEnemy( v )
			return true
		end
	end
	self:SetEnemy( nil )
	return false
end

function ENT:ChaseEnemy( options )
	local options = options or {}
	local path = Path( "Follow" )
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
