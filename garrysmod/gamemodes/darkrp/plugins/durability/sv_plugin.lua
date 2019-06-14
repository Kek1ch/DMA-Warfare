local PLUGIN = PLUGIN

function PLUGIN:EntityFireBullets(entity, bullet)
	if (entity:IsPlayer()) then
	local weapon = entity:GetActiveWeapon()
		if (weapon) then
			for k, v in pairs(entity:getChar():getInv():getItems()) do
				if v.class == weapon:GetClass() and v:getData("equip", false) == true then
					local chance = math.random(1, 16)

					if chance == 1 and v:getData("durability", 100) > 0 then
						v:setData("durability", v:getData("durability") - 1)
					elseif chance == 1 and v:getData("durability", 100) == 0 then
						entity:notify("Оружие пришло в негодность!")
						v:setData("equip", nil)
						entity.carryWeapons = entity.carryWeapons or {}
							
						local weapon = entity.carryWeapons[v.weaponCategory]

						if (IsValid(weapon)) then
							v:setData("ammo", weapon:Clip1())
							entity:StripWeapon(v.class)
							entity.carryWeapons[v.weaponCategory] = nil
							entity:EmitSound("items/ammo_pickup.wav", 80)
						end
					end
					bullet.Damage = (bullet.Damage / 100) * v:getData("durability")
					bullet.Spread = bullet.Spread * (1 + (1 - ((1 / 100) * v:getData("durability"))))
				end
			end
		end
	end
end

function PLUGIN:PlayerHurt(entity)
	for k, v in pairs(entity:getChar():getInv():getItems()) do
		local chance = math.random(1, 16)
		if v.category == "Броня" then
			if v:getData("equip", false) == true then
				if chance == 1 and v:getData("durabilityarmor", 100) > 0 then
					v:setData("durabilityarmor", v:getData("durabilityarmor") - 1)
				elseif chance == 1 and v:getData("durabilityarmor", 100) == 0 then
					entity:notify("Броня пришла в негодность!")
					v:setData("equip", nil)
				end
			end
		end
		--[[if v.category == "Шлем" then
			if v:getData("equip", false) == true then
				if chance == 1 and v:getData("durabilityarmor", 100) > 0 then
					v:setData("durabilityarmor", v:getData("durabilityarmor") - 1)
				elseif chance == 1 and v:getData("durabilityarmor", 100) == 0 then
					entity:notify("Броня пришла в негодность!")
					v:setData("equip", nil)
				end
			end
		end]]
	end
end