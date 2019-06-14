ENT.Type = "anim"
ENT.PrintName = "Тайник c Бартыханчиком"
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
		self:SetModel("models/kek1ch/sumka4.mdl")	
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
	if self:GetNetworkedBool("Usable") == true then
	self:EmitSound("interface/inv_iam_open.ogg")
		self:SetNetworkedBool("Usable", false)
		activator:setAction("Ведётся поиск вещей...", 4)
		activator:doStaredAction(self, 
		function()
			if activator:getChar():getInv():add(table.Random(tbl), 1) then
				activator:notify("Вы нашли что-то полезное")
				self:EmitSound("interface/inv_iam_close.ogg")
			else
				activator:notify("Вам не хватает места в инвентаре")
			end
			if activator:getChar():getInv():add("bartihan4ik_life", 1) then
				activator:notify("Вы нашли что-то полезное")
				self:EmitSound("interface/inv_iam_close.ogg")
			else
				activator:notify("Вам не хватает места в инвентаре")
			end
			timer.Simple(math.random(1800, 1801), function()
				self:SetNetworkedBool("Usable", true)
			end)
		end, 4, 
		function()
			self:SetNetworkedBool("Usable", true)
			if (IsValid(activator)) then
				activator:setAction()
			end
		end)
	else
		activator:notify("Здесь ничего нет")
	end
end

