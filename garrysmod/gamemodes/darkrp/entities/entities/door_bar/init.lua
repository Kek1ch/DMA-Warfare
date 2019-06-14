AddCSLuaFile( "shared.lua" ) --Send shared.lua to the client
include( 'shared.lua' ) --Include shared.lua              

if (SERVER) then

	function ENT:Initialize()
		self:SetModel("models/spenser/ssk/props/door_katakomb_big_2.mdl")
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow( false )
		self:SetSolid(SOLID_OBB)
		self:PhysicsInit(SOLID_OBB)
		--local min, max = self:GetCollisionBounds()
		--self:PhysicsInitBox(  min,  Vector( 30, 30, 30 ) )
	end

function ENT:Think(client)
	for k, v in pairs( ents.FindInSphere( self:GetPos(),120 ) ) do
		if (v:IsPlayer() and v:GetActiveWeapon():GetClass() == "ssk_aksu") then
			if (!self.open or self.open < CurTime()) then
				if ( !self.Opened ) then -- If we are not "opened"
					self:ResetSequence( "open" ) -- Play the open sequence
					self:SetPlaybackRate(1)
					self.Opened = true -- We are now opened
					self:PhysicsInit(SOLID_NONE)
				end
				if (!self.gravi1 or self.gravi1 < CurTime()) then
					self:EmitSound("wick/device/door_servomotor.ogg")
					timer.Simple(4, function()
						self:EmitSound("doors/door_closing.ogg")
					end)
					self.gravi1 = CurTime() + 20
				end
				if (self:GetSequence( "open" )) then
					timer.Simple(10, function()
						self:PhysicsInit(SOLID_OBB)
						self:SetPlaybackRate(1)
						self:ResetSequence( "close" ) -- Play the close sequence
						self:EmitSound("doors/door_closing.ogg")
						self.Opened = false -- We are now closed----
					end)
					timer.Simple(14, function()
						self:EmitSound("doors/metal_small_close_stop.ogg")
					end)
				end
			end
			self.open = CurTime() + 15
		elseif (v:IsPlayer() and v:GetActiveWeapon():GetClass() == "weapon_cop_fort") then
			if (!self.holsterwep or self.holsterwep < CurTime()) then
			self:EmitSound("zona/stalker/scenario/jupiter/jup_a6_base_megaphone_"..math.random(1,3)..".ogg")
			self.holsterwep = CurTime() + 6
			end
        end
	end
end

function ENT:OnRemove()
end
end