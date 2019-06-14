AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Металлический ящик"
ENT.Author = "Spenser&Kek1ch"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Warfare ENT"
ENT.RenderGroup = RENDERGROUP_BOTH

local items = {"bint", "mediumhealth", "9x18", "9x19", "12x70", "45acp", "545x39", "bone", "trapk", "tinderbox", "drug", "glue", "helmetrepait", "instument",
"instument2", "instument3", "solvent", "swkit1", "swkit2", "mirror", "swkit3", "sex", "shovel", "swiss", "twomatras", "armbr", "boots", "geigerbrok",
"tinderboxfuel", "crowboar", "dlarmor", "dharmor", "kevlar", "plate", "plate", "pm", "bint", "mediumhealth", "9x18", "9x19", "12x70", "45acp", "545x39",
"bone", "trapk", "tinderbox", "drug", "glue", "helmetrepait", "nitka_sintetichesk"}

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/z-o-m-b-i-e/st/box/st_box_metall_01.mdl")
		--self:PhysicsInit(SOLID_VPHYSICS)
		--self:SetMoveType(MOVETYPE_VPHYSICS)
		--self:SetUseType(SIMPLE_USE)

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR )
		self.IsDamaged = false

		if (IsValid(self:GetPhysicsObject())) then
			self:GetPhysicsObject():EnableMotion(false)
		end
	end

	function ENT:OnTakeDamage(damageInfo)
		local pos = self:GetPos()
		local ang = self:GetAngles()

		if (!self.IsDamaged) then
			self.IsDamaged = true
			timer.Simple(1200, function()
				local NewBox = ents.Create("nut_entbox")
				NewBox:SetPos(pos)
				NewBox:SetAngles(ang)
				NewBox:SetModel("models/z-o-m-b-i-e/st/box/st_box_metall_01.mdl")
				NewBox:Spawn()
				NewBox:Activate()
				NewBox.IsDamaged = false

				if (IsValid(NewBox:GetPhysicsObject())) then
					NewBox:GetPhysicsObject():EnableMotion(false)
				end
			end)

			for i = 1,4 do
				if (math.random(1, 2) == 2) then
					nut.item.spawn(table.Random(items), self:GetPos()+Vector(0,0,2))
				end
			end
		end

		self:Remove()
	end
end

if (CLIENT) then
	function ENT:Draw()
		self:DrawModel()
	end
end

