AddCSLuaFile()
ENT.Base            = "base_nextbot"
ENT.PrintName = "Монолитовец"
ENT.Author = "Kek1ch x WickedRabbit x DrodA"
ENT.Category = "Warfare NPC"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.AutomaticFrameAdvance = true

local models_t = {"models/spenser/kek1ch/stalker_monolith1.mdl", "models/spenser/kek1ch/stalker_monolith1_gp5.mdl", "models/spenser/kek1ch/stalker_monolith1b.mdl",
"models/spenser/kek1ch/stalker_monolith2a_old.mdl", "models/spenser/kek1ch/stalker_monolith_2.mdl", "models/spenser/kek1ch/stalker_monolith_1.mdl",
"models/spenser/kek1ch/stalker_monolith_0.mdl", "models/spenser/kek1ch/stalker_mo_exo.mdl"}

local ranks_t2 = {"Мастер", "Эксперт", "Ветеран", "Профессионал", "Опытный", "Стажер", "Новичок"}

local reps_t = {"Великолепно", "Отлично", "Оч. Хорошо", "Хорошо", "Безразлично", "Плохо", "Оч. Плохо", "Ужасно", "Хуже всех"}

local names_f = {"Антон", "Олег", "Олесь", "Рома", "Руслан", "Саша", "Слава", "Толик", "Юра", "Богдан", "Вениамин", "Виталий", "Вова", "Дима", "Иван", "Костя",
"Леша", "Санек", "Шурик", "Вадя", "Васян", "Васек"}

local names_s = {"Резкий", "Рвач", "Рваный", "Работяга", "Псих", "Простак", "Праведный", "Покойник", "Подлец", "Плут", "Неуязвимый", "Пижон", "Одноглазый", "Нытик", "Нудный", 
"Неумеха", "Неудачник", "Небрежный", "Черный", "Нарцисс", "Мятый", "Мутный", "Мрачный", "Местный", "Мертвый", "Мертвец", "Малыш", "Лютый", "Любимчик", "Косой", "Фантом",
"Упырь", "Туз", "Опер"}

local weapon_options = {}
weapon_options['weapon_cop_ak_74'] = {clip = 30, rate = 24, sound = 'weapons/stalker_cop/ak74_shoot.wav', item = 'aks74'}
--[[weapon_options['weapon_cop_rpk'] = {clip = 45, rate = 24, sound = 'weapons/stalker_cop/rpk74_shoot.wav', item = 'rpk'}
weapon_options['weapon_cop_svd'] = {clip = 10, rate = 6, sound = 'weapons/stalker_cop/svd_shoot.wav', item = 'svd'}
weapon_options['weapon_cop_pkm'] = {clip = 100, rate = 32, sound = 'weapons/stalker_cop/pkm_shoot.wav', item = 'pkm'}
weapon_options['weapon_cop_bizon'] = {clip = 64, rate = 20, sound = 'weapons/stalker_cop/bizon_shoot.wav', item = 'bizon'}
weapon_options['weapon_cop_val'] = {clip = 20, rate = 24, sound = 'weapons/stalker_cop/val_shoot.wav', item = 'asval'}
weapon_options['weapon_cop_ak74u'] = {clip = 30, rate = 22, sound = 'weapons/stalker_cop/aks74u_shoot.wav', item = 'aksu'}
weapon_options['weapon_cop_lr300'] = {clip = 30, rate = 24, sound = 'weapons/stalker_cop/lr300_shoot.wav', item = 'lr300'}
weapon_options['weapon_cop_groza'] = {clip = 30, rate = 24, sound = 'weapons/stalker_cop/groza_shoot.wav', item = 'groza'}
weapon_options['weapon_cop_sks'] = {clip = 10, rate = 10, sound = 'weapons/stalker_cop/sks_shoot.wav', item = 'sks'}]]

function ENT:Initialize()
	self:SetModel(string.gsub(table.Random(models_t), "spenser", "hdmodels"))
	self:SetHealth(math.random(150, 300))
	self.LoseTargetDist	= 2100
	self.SearchRadius 	= 2000
	self:SetCollisionBounds(Vector(-12,-12,0), Vector(12,12,80))
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self.isDisabled = false

	self.rank = table.Random(ranks_t2)
	self.rep = table.Random(reps_t)
	self.name = table.Random(names_f).." "..table.Random(names_s)
	self.frac = "Монолит"

	local weapons = {}
	for k, v in pairs(weapon_options) do
		weapons[#weapons + 1] = k
	end

	self:GiveWeapon(table.Random(weapons))
end

function ENT:GiveWeapon(wep)
	if (SERVER) then
		local wep = ents.Create(wep)
		local pos = self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos
		wep:SetOwner(self)
		wep:SetPos(pos)
		wep:Spawn()
		wep:SetSolid(SOLID_NONE)
		wep:SetNotSolid(true)
		wep:SetTrigger(false)
		wep:SetParent(self)
		wep:Fire("setparentattachment", "anim_attachment_RH")
		wep:AddEffects(EF_BONEMERGE)
		self.Weapon = wep

		self.Weapon.Ammo = weapon_options[self.Weapon:GetClass()].clip
		self.Weapon.Clip = weapon_options[self.Weapon:GetClass()].clip
	end
end

function ENT:FireWeapon()
	local bullet = {} 

	if (self.Weapon) then
		if self.Weapon.Ammo <= 0 then self:ReloadWeapon() return end
		self.Weapon.Ammo = self.Weapon.Ammo - 1

		local muzzle = self.Weapon:GetAttachment(self.Weapon:LookupAttachment("muzzle"))
		if (muzzle) then
			local shootPos = muzzle.Pos
			local bulletDir = ( (self:GetEnemy():GetPos() + Vector(math.random(-30,30), math.random(-30,30), math.random(30,70)) ) - shootPos):GetNormalized()

			local effectdata2 = EffectData()
			effectdata2:SetEntity(self.Weapon)
			effectdata2:SetAttachment(self.Weapon:LookupAttachment("muzzle"))
			util.Effect("CS_MuzzleFlash", effectdata2)

			bullet.Num = 1
			bullet.Src = shootPos
			bullet.Dir = bulletDir
			bullet.Tracer = 1
			bullet.TracerName = "Tracer"
			bullet.Force = self.Weapon.Force 
			bullet.Damage = math.random(22,32)
			bullet.AmmoType = self.Weapon.Ammo
			self.Weapon:FireBullets( bullet )

			self.Weapon:EmitSound(weapon_options[self.Weapon:GetClass()].sound)
		end
	end
end

function ENT:ReloadWeapon()
	if self.Weapon.Ammo >= self.Weapon.Clip then return end
	if self.isDisabled == false then
		self.isDisabled = true
		self:ResetSequence("torso_2_draw_0")
		self.loco:SetDesiredSpeed(0)
		local seq_r, dur_r = self:LookupSequence("torso_2_draw_0")
		timer.Simple(dur_r, function()
			if IsValid(self.Weapon) then
				self.Weapon.Ammo = self.Weapon.Clip
				self.isDisabled = false
			end
		end)
	end
end

function ENT:Use(activator)
	--звук (я не буду с тобой раговаривать)
end

if (SERVER) then
	function ENT:Think()
		if (!self.timer_zombied_attack or self.timer_zombied_attack < CurTime()) then
			if (self.isDisabled == false) then
				if ( self:GetEnemy() and IsValid( self:GetEnemy() ) and self:GetEnemy():IsPlayer() ) then
					if (self:GetRangeTo(self:GetEnemy():GetPos()) < 2000 and self:GetRangeTo(self:GetEnemy():GetPos()) > 150) then
						self:FireWeapon()
						
						for i = 1, 3 do
							timer.Create("firerate", i/weapon_options[self.Weapon:GetClass()].rate, 0, function() 
								self:FireWeapon()
							end)
						end

						self:ResetSequence("norm_torso_2_aim_1")
						self.loco:SetDesiredSpeed( 60 )
					elseif (self:GetRangeTo(self:GetEnemy():GetPos()) < 150 and self:GetRangeTo(self:GetEnemy()) > 25) then
						self.loco:SetDesiredSpeed( 0 )
						self:ResetSequence("norm_torso_2_aim_4")

						for i = 1, 3 do
							timer.Create("firerate", i/weapon_options[self.Weapon:GetClass()].rate, 0, function() 
								self:FireWeapon()
							end)
						end

					elseif (self:GetRangeTo(self:GetEnemy()) < 25) then
						self:PunchEnemy()
						timer.Remove("firerate")
					end
				end
			end
			self.timer_zombied_attack = CurTime() + 0.8
		end
	end
end

function ENT:PunchEnemy()
	self.isDisabled = true
	self:ResetSequence("free_facer_1")
	self.loco:SetDesiredSpeed( 0 )

	timer.Simple(1, function()
		self.isDisabled = false
		self:GetEnemy():ViewPunch(Angle( 30, 0, 0 )) 
		self:GetEnemy():TakeDamage( 40 )
	end)
end

local idle_anim = {"idle_2_idle_"..math.random(0, 9), "idle_3_idle_"..math.random(0, 4)}

function ENT:RunBehaviour()
	while ( true ) do
		if (self.isDisabled == false) then
			if ( self:HaveEnemy() ) then
				self.loco:FaceTowards( self:GetEnemy():GetPos() )
				self:ResetSequence("norm_torso_9_walk_0")
				self.loco:SetDesiredSpeed( 60 )
				self.loco:SetAcceleration( 50 )
				self:ChaseEnemy()
				self:SetSequence( table.Random(idle_anim) )
				--звук при агре
			else
				self:ResetSequence("norm_torso_9_walk_0")
				self.loco:SetDesiredSpeed( 50 )
				self.loco:SetAcceleration( 50 )
				self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 350 )
				self:SetSequence( table.Random(idle_anim) )
				self:PlaySequenceAndWait( table.Random(idle_anim) )
				--звук в простое
			end
		end
		coroutine.wait( 2 )
		coroutine.yield()
	end 
end

local flinch_anim = {"norm_2_critical_hit_head_0", "norm_2_critical_hit_hend_left_0", "norm_2_critical_hit_hend_right_0", "norm_2_critical_hit_torso_0",
"norm_2_critical_hit_torso_1", "norm_2_critical_hit_legs_left_0"}

function ENT:OnInjured(dmginfo)
	local seq_h, dur_h = self:LookupSequence(table.Random(flinch_anim))
	if (math.Rand(1, 100) < 35) then
		self.isDisabled = true
		self:ResetSequence(seq_h)
		self.loco:SetDesiredSpeed( 0 )
		--звук получения дамага
		timer.Simple(dur_h, function()
			if IsValid(self) then
				self.isDisabled = false
				self.loco:SetDesiredSpeed( 50 )
				self:ResetSequence("norm_torso_9_walk_0")
			end
		end)
    end

	local seq_f, dur_f = self:LookupSequence("waunded_1_idle_0")
	local seq_s, dur_s = self:LookupSequence("wounded_3_out")

	if (self:Health() < 15) then
		self:ResetSequence( "waunded_1_idle_0" )
		self.loco:SetDesiredSpeed( 0 )
		self.isDisabled = true
		timer.Simple(dur_f*20, function()
			if IsValid(self) then
				if (math.Rand(1, 100) < 50) then
					self:ResetSequence( "wounded_3_out" )
					timer.Simple(dur_s*0.55, function()
						self.isDisabled = false
					end)
				else
					self:OnKilled()
				end
			end
		end)
	end

	if (dmginfo:GetAttacker():IsPlayer() and !self:GetEnemy()) then
		self:SetEnemy( dmginfo:GetAttacker() )
	end
end

function ENT:OnRemove()
	timer.Remove("firerate")
end

local drops_t = {"trapk", "tkan", "tinderbox", "nitka_sintetichesk", "brezent", "armbr", "banka_s_xlamom", "rozshig_kit", "perenosnoe_radio",
"swiss", "tie", "cigar", "ctabak", "geigerbrok", "glue", "pils", "swkit1", "swkit3", "kerosin", "bint", "10r", "100r", "1000r", "500r", "50r", 
"5000r", "200r", "bighealth", "tinderboxfuel", "crowboar", "kowelek", "mirror", "scienmediumhealth", "9x18", "9x19", "9x39", "12x70", "45acp",
"545x39", "556x45", "762x54", "vodka", "vodka_def", "water", "konservi", "bread", "kolbasa", "energy"}

function ENT:OnKilled( dmginfo )
	timer.Remove("firerate")

	local entity = ents.Create("nut_loot")
	entity:SetPos( self:GetPos())
	entity:SetAngles(self:GetAngles())
	entity:Spawn()
	entity:SetModel("models/kek1ch/sumka2.mdl")
	entity:SetSolid(SOLID_VPHYSICS)
	entity:PhysicsInit(SOLID_VPHYSICS)
	entity:setNetVar("model", self:GetModel() )
	entity:setNetVar("plyName", self.name)
	entity:setNetVar("rep", self.rep)
	entity:setNetVar("rank", self.rank)
	entity:setNetVar("frac", self.frac)
	entity:DropToFloor()

	if (IsValid(entity:GetPhysicsObject())) then
		entity:GetPhysicsObject():EnableMotion(false)
	end

	nut.item.newInv(0, "loot", function(inventory)
		if (IsValid(entity)) then
			inventory:setSize(nut.config.get("invW"), nut.config.get("invH"))
			entity:setInventory(inventory)
		end
	end)

	for i = 2, 5 do
		entity:getInv():add(drops_t[math.random( 1, #drops_t )])
	end

	if (math.random(1,16) == 1) then
		entity:getInv():add(weapon_options[self.Weapon:GetClass()].item, 1, { 
			durability = math.random(3, 12)
		})
	end

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

--хитбоксы головы
--возможность вести за собой
--звуки
--возможность нпсов поднять раненного игрока или нпс