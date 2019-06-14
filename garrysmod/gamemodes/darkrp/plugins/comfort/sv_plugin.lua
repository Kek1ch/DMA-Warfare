local PLUGIN = PLUGIN

local saveEnts = {
    ["fireplace"] = true,
    ["mine"] = true,
    ["spalnit"] = true,
    ["nut_kerosinka"] = true,
    ["nut_tent"] = true,
    ["multipechka"] = true,
    ["pechka"] = true
}

function SCHEMA:SaveData()
    local savedEntities = {}

    for k, v in ipairs(ents.GetAll()) do
        local class = v:GetClass():lower()
            
        if (saveEnts[class]) then
            table.insert(savedEntities, {
                class = class, 
                pos = v:GetPos(),
                ang = v:GetAngles(),
            })
        end
    end

    self:setData(savedEntities)
end

function SCHEMA:LoadData()
    local savedEntities = self:getData() or {}
    
    for k, v in ipairs(ents.GetAll()) do
        local class = v:GetClass():lower()
        if (saveEnts[class]) then
            v:Remove()
        end
    end
    
    for k, v in ipairs(savedEntities) do
        local ent = ents.Create(v.class)
        ent:SetPos(v.pos)
        ent:SetAngles(v.ang)
        ent:Spawn()
        ent:Activate()

        local phys = ent:GetPhysicsObject()
        if (IsValid(phys)) then
            phys:Wake()
            phys:EnableMotion()
        end

    end
end

--[[netstream.Hook("start_sleep2", function(client, amount)
    x = (amount * 4) + client:getChar():getData("sleep_need", 0)
    client:getChar():setData("sleep_need", math.Clamp(x, 0, 100))
 end)

netstream.Hook("sleep_need", function(client)
    client:getChar():setData("sleep_need", client:getChar():getData("sleep_need") - 5)
 end)

function PLUGIN:PlayerSpawn(client)
    if client:getChar() then
        client:getChar():setData("sleep_need", 100)
    end
end]]