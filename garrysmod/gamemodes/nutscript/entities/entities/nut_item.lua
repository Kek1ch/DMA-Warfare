AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.Type = "anim"
ENT.PrintName = "Item"
ENT.Category = "NutScript"
ENT.Spawnable = false
ENT.Base = "base_gmodentity"
//ENT.RenderGroup = RENDERGROUP_BOTH

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props_junk/watermelon01.mdl")
		--self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR )

		--[[local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end]]
	end

	function ENT:setItem(itemID)
		local itemTable = nut.item.instances[itemID]

		if (itemTable) then
			local model = itemTable.onGetDropModel and itemTable:onGetDropModel(self) or itemTable.model

			self:SetSkin(itemTable.skin or 0)
			if (itemTable.worldModel) then
				self:SetModel(itemTable.worldModel == true and "models/props_junk/cardboard_box004a.mdl" or itemTable.worldModel)
			else
				self:SetModel(model)
			end
			self:SetModel(model)
			self:PhysicsInit(SOLID_VPHYSICS)
			--self:SetSolid(SOLID_VPHYSICS)
			self:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR )
			self:setNetVar("id", itemTable.uniqueID)
			self.nutItemID = itemID

			if (table.Count(itemTable.data) > 0) then
				self:setNetVar("data", itemTable.data)
			end

			if (!IsValid(self:GetPhysicsObject())) then
				local min, max = Vector(-8, -8, -8), Vector(8, 8, 8)

				self:PhysicsInitBox(min, max)
				self:SetCollisionBounds(min, max)
			end

			--[[if (IsValid(self:GetPhysicsObject())) then
				self:GetPhysicsObject():EnableMotion(false)
			end]]

			self:DropToFloor()

			if (itemTable.onEntityCreated) then
				itemTable:onEntityCreated(self)
			end
		end
	end

	function ENT:OnRemove()
		if (!nut.shuttingDown and !self.nutIsSafe and self.nutItemID) then
			local item = nut.item.instances[self.nutItemID]

			if (item) then
				if (item.onRemoved) then
					item:onRemoved()
				end

				nut.db.query("DELETE FROM nut_items WHERE _itemID = "..self.nutItemID)
			end
		end
	end
	
	function ENT:Think()
		local it = self:getItemTable()
		
		if (it) then
			if (!it.id or it.id == 0) then
				self:Remove()
			end
		end
	end
else
	ENT.DrawEntityInfo = true

	local toScreen = FindMetaTable("Vector").ToScreen
	local colorAlpha = ColorAlpha

	function ENT:onDrawEntityInfo(alpha)
		local itemTable = self.getItemTable(self)

		if (itemTable) then
			local oldData = itemTable.data
			itemTable.data = self.getNetVar(self, "data", {})
			itemTable.entity = self

			local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
			local x, y = position.x, position.y
			
			nut.util.drawText(L(itemTable.name), x, y, colorAlpha(Color(211, 211, 211)), 1, 1, "gost6", alpha * 0.65)

			itemTable.entity = nil
			itemTable.data = oldData
		end		
	end

	function ENT:DrawTranslucent()
		local itemTable = self:getItemTable()

		if (itemTable and itemTable.drawEntity) then
			itemTable:drawEntity(self, itemTable)
		end
	end
end

function ENT:getItemTable()
	return nut.item.list[self:getNetVar("id", "")]
end

function ENT:getData(key, default)
	local data = self:getNetVar("data", {})

	return data[key] or default
end