ENT.Type = "anim"
ENT.PrintName = "Talker"
ENT.Category = "NutScript"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.AutomaticFrameAdvance = true 

function ENT:Initialize()
	if (SERVER) then
		self:SetModel("models/spenser/kek1ch/stalker_neutrala1.mdl")
		self:SetMoveType( MOVETYPE_NONE )
		self:SetSolid( SOLID_BBOX )
		self:SetUseType( SIMPLE_USE )
		self:DrawShadow( false )
		self:PhysicsInit(SOLID_VPHYSICS)
		self:DropToFloor()


		self.messages = {}
		self.factions = {}
		self.classes = {}

		self:setNetVar("name", "Вова Вист")
		self:setNetVar("desc", "Одиночки")
		self:setNetVar("anim", "idle_0_idle_1")
		self:setNetVar("sound", "")

		self.receivers = {}

	end
end

function ENT:Think(client)
	if (SERVER) then
		if (!self.anim_vendor or self.anim_vendor < CurTime()) then
			self:PhysicsInitBox(  Vector( -13, -5, -1 ),  Vector( 13, 5, 70 ) )

			if (IsValid(self:GetPhysicsObject())) then
				self:GetPhysicsObject():EnableMotion(false)
			end

			self:ResetSequence(self:getNetVar("anim"))
			self:SetPlaybackRate(1)

			self.anim_vendor = CurTime() + 8
		end
	end
end

function ENT:canAccess(client)
	if (client:IsAdmin()) then
		return true
	end

	local allowed = false
	local uniqueID = nut.faction.indices[client:Team()].uniqueID

	if (self.factions and table.Count(self.factions) > 0) then
		if (self.factions[uniqueID]) then
			allowed = true
		else
			return false
		end
	end

	if (allowed and self.classes and table.Count(self.classes) > 0) then
		local class = nut.class.list[client:getChar():getClass()]
		local uniqueID = class and class.uniqueID

		if (!self.classes[uniqueID]) then
			return false
		end
	end

	return true
end

if (CLIENT) then
	netstream.Hook("nut_Dialogue", function(data)
		if (IsValid(nut.gui.dialogue)) then
			nut.gui.dialogue:Remove()
			return
		end
		nut.gui.dialogue = vgui.Create("Nut_Dialogue")
		nut.gui.dialogue:Center()
		nut.gui.dialogue:SetEntity(data)
		if LocalPlayer():IsAdmin() and LocalPlayer():getChar():hasFlags("O") then
			if (IsValid(nut.gui.edialogue)) then
				nut.gui.dialogue:Remove()
				return
			end
			nut.gui.edialogue = vgui.Create("Nut_DialogueEditor")
			nut.gui.edialogue:SetEntity(data)
		end
	end)
	local TEXT_OFFSET = Vector(0, 0, 20)
	local toScreen = FindMetaTable("Vector").ToScreen
	local colorAlpha = ColorAlpha
	local drawText = nut.util.drawText
	local configGet = nut.config.get

	ENT.DrawEntityInfo = true

	function ENT:onDrawEntityInfo(alpha)
		local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)) + TEXT_OFFSET)
		local x, y = position.x, position.y
		local desc = self.getNetVar(self, "desc")

		drawText(self.getNetVar(self, "name", "John Doe"), x, y, colorAlpha(Color(211, 211, 211)), 1, 1, "gost10", alpha * 0.65)

		if (desc) then
			drawText(desc, x, y + 23, colorAlpha(Color(62, 95, 138)), 1, 1, "gost10", alpha * 0.65)
		end
	end 
else
	function ENT:Use(activator)

		local stored = stored or {}
		stored.talkername = self.getNetVar(self, "name")

		local factionData = self:getNetVar("factiondata", {})
		if !factionData[nut.faction.indices[activator:Team()].uniqueID] and !activator:IsSuperAdmin() then
			activator:ChatPrint( self:getNetVar( "name", "John Doe" )..": Я не буду с тобой разговаривать." )
			return
		end

		
		netstream.Start(activator, "nut_Dialogue", self)
		if (self:getNetVar("sound") != "") then
			self:EmitSound(self:getNetVar("sound"))
		end
	end

	netstream.Hook("nut_DialogueData", function( client, data )
		if (!client:IsSuperAdmin()) then
			return
		end
		local entity = data[1]
		local dialogue = data[2]
		local factionData = data[3]
		local classData = data[4]
		local name = data[5]
		local desc = data[6]
		local model = data[7]
		local anim = data[8]
		local sound = data[9]

		
		if (IsValid(entity)) then
			entity:setNetVar("dialogue", dialogue)
			entity:setNetVar("factiondata", factionData)
			entity:setNetVar("classdata", classData)
			entity:setNetVar("name", name)
			entity:setNetVar("desc", desc)
			entity:setNetVar("anim", anim)
			entity:setNetVar("sound", sound)
			entity:SetModel(model)

			client:notify("You have updated this talking npc's data.")
		end
	end)
end
