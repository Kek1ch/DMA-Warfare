local PLUGIN = PLUGIN

function PLUGIN:PlayerDeath(victim, inflictor, attacker)
    if IsValid(victim) and victim:getChar() then
        victim:setNetVar("bleeding", false)
    end
end

function PLUGIN:PlayerShouldTakeDamage(ply, attacker)
    if IsValid(ply) and ply:getChar() then
        if math.random(1, 10) == 5 then
            ply:setNetVar("bleeding", true)
        end
        timer.Create("bleed"..ply:UserID(), 3, 0, function()
            if ply:getNetVar("bleeding", false) == true then
            	if IsValid(ply) then
	                ply:SetHealth(math.Clamp(ply:Health() - 1, 1, ply:GetMaxHealth()))
	                ply:SetHealth(ply:Health() - 1)
				end
                for i = 4,5 do
                    util.Decal( "blood", ply:GetPos() + Vector(math.random(1,30),math.random(1,30),0), ply:GetPos() - Vector(math.random(1,10),math.random(1,10),50))
                end
                if (ply:Health() <= 1) then
                    ply:Kill()
                end
            else 
                timer.Destroy("bleed"..ply:UserID())
            end
        end)
    end
end
