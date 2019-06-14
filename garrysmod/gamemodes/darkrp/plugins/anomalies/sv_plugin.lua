local PLUGIN = PLUGIN

----------------------------------------
--Спавн артефактов
----------------------------------------
local AnomalyAnomalies = {
	["electra_anomaly"] = {"batary", "moonlight", "snejinka", "flash", "empty"},
	["electra_anomaly_type2"] = {"batary", "moonlight", "snejinka", "flash", "empty"},
	["gazirovka_anomaly"] = {"soul", "pyzir", "krovkamna", "colobok"},
	["jarka"] = {"kristal", "fireball", "glas", "momboosy"},
	["kisel_anomaly"] = {"krovkamna", "soul", "pyzir"},
	["maysorubka_anomaly"] = {"soul"},
	["maysorubka_anomaly_type2"] = {"soul"},
	["par"] = {"kristal", "fireball", "glas", "momboosy"},
	["tramplin_anomaly"] = {"meduza", "nightstar", "cvetok"},
	["voronka_anomaly"] = {"goldfish", "gravy", "vyvert"}
}

local entities = {}

function SpawnArts()
	for _,anomaly in pairs(ents.GetAll()) do
		if AnomalyAnomalies[anomaly:GetClass()] then
			for _,v in pairs(ents.FindInSphere(anomaly:GetPos(), 1000)) do
				entities[#entities + 1] = v:GetClass()
			end

			for i = 1, 20 do
				if (!table.HasValue(entities, "nut_item")) and (entities) then 
					nut.item.spawn(table.Random(AnomalyAnomalies[anomaly:GetClass()]), anomaly:GetPos() + Vector(math.random(-200, 200), math.random(-200, 200), 200))
					MsgC(Color(0, 255, 0), "Артефакты заспавнены.\n")
				end
			end
		end
	end
end

timer.Create( "SpawnUrArts", 800, 0, SpawnArts)


