local PLUGIN = PLUGIN

function PLUGIN:EntityTakeDamage(target, dmginfo)
	if (target:IsPlayer() and dmginfo:IsFallDamage() == false) then
		if target:getChar():getData("armored") then
			for k, v in pairs(target:getChar():getInv():getItems()) do
				if (nut.item.instances[v.id].isCloth and nut.item.instances[v.id]:getData("equip")) then
					math.randomseed( os.time() )
					if ( math.random(100) <= nut.item.instances[v.id].ric) then
						dmginfo:ScaleDamage(0)
					end
					dmginfo:ScaleDamage(1 - (nut.item.instances[v.id].dmgsteal / 100) )
				end
			end
		end
	end 
end
