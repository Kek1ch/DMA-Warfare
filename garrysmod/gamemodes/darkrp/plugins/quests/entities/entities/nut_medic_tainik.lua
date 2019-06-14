ENT.Type = "anim"
ENT.PrintName = "Тайник медика"
ENT.Category = "Warfare ENT"
ENT.Spawnable = true
ENT.AdminOnly = true

if (CLIENT) then
	function ENT:Draw()
		local mypos = self:GetPos()
		local dist = LocalPlayer():GetPos():Distance(mypos)

		if (dist < 1800) then
			self.Entity:DrawModel()
		end
	end
end

function ENT:Initialize()
	if (SERVER) then
		self:SetModel("models/z-o-m-b-i-e/st/equipment_cache/st_equipment_box_01.mdl")	
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetPersistent(true)
		self:Fire("SetAnimation", "ACT_IDLE2", 0)
		self:Activate()

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end
end

function ENT:Use(activator)
	if activator:HasQuest( "quest_medicamenti" ) and !(activator:getChar():getData("quest_medicamenti") == 1) then
		self:EmitSound("interface/inv_open.ogg")
		activator:setAction("Ведётся поиск вещей...", 4)
		activator:doStaredAction(self, function()
			if activator:getChar():getInv():add("medic_container", 1) then
				self:EmitSound("interface/inv_close.ogg")
				activator:getChar():setData("quest_medicamenti", 1)
			else
				activator:notify("Вам не хватает места в инвентаре")
			end
		end, 4, 
		function()
			if (IsValid(activator)) then
				activator:setAction()
			end
		end)
	else
		activator:notify("Здесь ничего нет")
	end
end