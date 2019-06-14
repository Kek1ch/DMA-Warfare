local PLUGIN = PLUGIN

function PLUGIN:DoPlayerDeath( client, attacker, dmg )
	if (client:getChar():hasFlags("L")) or (team.GetName(client:Team()) == "Монолит") or (team.GetName(client:Team()) == "Чистое Небо") or (team.GetName(client:Team()) == "Миротворцы") then return end
	if !IsValid(client) then return end
	if !client:getChar() then return end
	if (!client:getChar():hasMoney(client:getChar():getMoney())) then return end
	if client:getChar():getMoney() < 1 then return end
	nut.currency.spawn(client:GetPos() + Vector( 0, 0, 15 ), 0.1 * client:getChar():getMoney())
	client:getChar():takeMoney(0.1 * client:getChar():getMoney())
end

function PLUGIN:PlayerDeath( ply, dmg, att )
	if (ply:getChar():hasFlags("L")) or (team.GetName(ply:Team()) == "Монолит") or (team.GetName(ply:Team()) == "Чистое Небо") or (team.GetName(ply:Team()) == "Миротворцы") then return end

	local entity = ents.Create("nut_loot")
	entity:SetPos( ply:GetPos() + Vector( 0, 0, 10 ) )
	entity:SetAngles(entity:GetAngles())
	entity:Spawn()
	entity:setNetVar("name", "Belongings" )
	entity:setNetVar("plyName", ply:Name())
	entity:setNetVar( "max", 5000 )
	entity:SetModel("models/kek1ch/sumka2.mdl")
	//entity:SetSolid(SOLID_VPHYSICS)
	entity:PhysicsInit(SOLID_VPHYSICS)
	//entity:SetMoveType(MOVETYPE_VPHYSICS)
	entity:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR )

	if (IsValid(entity:GetPhysicsObject())) then
		//entity:GetPhysicsObject():EnableMotion(false)
		entity:GetPhysicsObject():Wake()
	end

	nut.item.newInv(0, "loot"..ply:getChar():getID(), function(inventory)
		if (IsValid(entity)) then
			inventory:setSize(nut.config.get("invW"), nut.config.get("invH"))
			entity:setInventory(inventory)
		end
	end)


	local items = ply:getChar():getInv():getItems()
	for _, v in pairs(items) do
		local chance = math.random(1, 10)
		if (table.HasValue(self.ignored, v.uniqueID)) then continue end 

		--if ((chance == 1) and (v.category == "Оружие" or v.category == "armor")) then
		if (chance == 1) then
			if (v:getData("equip")) then
				entity:getInv():add(v.uniqueID)
				v:remove()
			else
				v:transfer(entity:getNetVar("id"))
				if (v.category == "Оружие" or v.category == "armor") then
					v:setData("durability", math.random(4, 13))
					v:setData("durabilityarmor", math.random(4, 13))
				end
			end
		end 

		ply:StripAmmo()
	end
end

function PLUGIN:saveLoot()
	local data = {}

	for k, v in ipairs(ents.FindByClass("nut_loot")) do
		if (v:getInv()) then
			data[#data + 1] = {v:GetPos(), v:GetAngles(), v:getNetVar("id"), v:GetModel()}
		end
	end

	self:setData(data)
end

function PLUGIN:loadLoot()
	local data = self:getData() or {}

	if (data) then
		for k, v in ipairs(data) do
			local container = ents.Create("nut_loot")
			container:SetPos(v[1])
			container:SetAngles(v[2])
			container:Spawn()
			container:SetModel(v[3])
			container:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR )
			//container:SetSolid(SOLID_VPHYSICS)
			container:PhysicsInit(SOLID_VPHYSICS)
			//container:SetMoveType(MOVETYPE_VPHYSICS)

			if (IsValid(container:GetPhysicsObject())) then
				//container:GetPhysicsObject():EnableMotion(false)
				container:GetPhysicsObject():Wake()
			end
		end
	end
end

function PLUGIN:SaveData()
	self:saveLoot()
end

function PLUGIN:LoadData()
	self:loadLoot()
end

function PLUGIN:LootItemRemoved(entity, inventory)
	self:saveLoot()
end

netstream.Hook("lootExit", function(client, index)
	local entity = client.nutBagEntity

	if (IsValid(entity)) then
		entity.receivers[client] = nil
	end
	client.nutBagEntity = nil
end)
