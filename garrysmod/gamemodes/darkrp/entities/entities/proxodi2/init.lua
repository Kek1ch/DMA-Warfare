AddCSLuaFile( "shared.lua" ) --Send shared.lua to the client
include( 'shared.lua' ) --Include shared.lua              

if (SERVER) then

	function ENT:Initialize()
		self:SetModel("models/spenser/kek1ch/stalker_neutral0c.mdl")
		self:SetUseType(SIMPLE_USE)
		self:SetMoveType(MOVETYPE_NONE)
		self:DrawShadow( true )
		self:SetSolid(SOLID_BBOX)
		self:PhysicsInit(SOLID_BBOX)
		self:DropToFloor()
	end

function ENT:Think(client)
	for k, v in pairs( ents.FindInSphere( self:GetPos(),90 ) ) do
		if (v:IsPlayer() and v:GetActiveWeapon():GetClass() == "weapon_cop_ak74u") then
			self:PhysicsInit(SOLID_VPHYSICS)
			if (!self.proxodi1 or self.proxodi1 < CurTime()) then
			self:EmitSound("wick/characters_voice/scenario/bar/bar_guard/bar_guard_prohodi_1.ogg")
			self.proxodi1 = CurTime() + 9
			end
        elseif (v:IsPlayer() and v:GetActiveWeapon():GetClass() == "weapon_cop_fort") then
			if (!self.holsterwep or self.holsterwep < CurTime()) then
			self:EmitSound("zona/stalker/scenario/zaton/zat_a2_base_guard_"..math.random(1,3)..".ogg")
			self.holsterwep = CurTime() + 6
			end
		end
	end
	if (!self.anim or self.anim < CurTime()) then
	self:ResetSequence(self:LookupSequence("sit_2_idle_"..math.random(0, 4)))
	self:SetPlaybackRate(1) --скорость анимации
	self.anim = CurTime() + 8
	end
	if (!self.speak or self.speak < CurTime()) then
	self:EmitSound("zona/stalker/stalker/states/idle/idle_"..math.random(1,38)..".ogg")
	self.speak = CurTime() + 35
	end
end

function ENT:OnRemove()
end

end