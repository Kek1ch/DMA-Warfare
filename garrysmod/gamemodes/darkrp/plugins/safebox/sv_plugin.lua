local PLUGIN = PLUGIN

function PLUGIN:saveBox()
	local data = {}

	for k, v in ipairs(ents.FindByClass("nut_safebox")) do
		data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetModel()} -- money = v:getMoney()
	end

	self:setData(data)
end
	
function PLUGIN:SaveData()
	self:saveBox()
end

function PLUGIN:LoadData()
	local data = self:getData()

	--if (data) then
		for k, v in ipairs(data) do
			local storage = ents.Create("nut_safebox")
			storage:SetPos(v[1])
			storage:SetAngles(v[2])
			storage:Spawn()
			storage:SetModel(v[3])
			storage:SetSolid(SOLID_VPHYSICS)
			storage:PhysicsInit(SOLID_VPHYSICS)
			
			local physObject = storage:GetPhysicsObject()

			if (physObject) then
				physObject:EnableMotion()
			end
			--storage.money = v.money
		end
	--end
end
