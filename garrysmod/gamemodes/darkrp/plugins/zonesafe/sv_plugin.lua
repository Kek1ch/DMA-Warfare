local PLUGIN = PLUGIN


function PLUGIN:PlayerSpawn(client)
	print("Тест")
	PrintTable(PLUGIN.areaTable)
end

function GetArea(areaID)
	return PLUGIN.areaTable[areaID]
end

function PLUGIN:SaveAreas()
	self:setData(self.areaTable)
end

local function SortVector(FirstPoint, SecondPoint)
	local MinVector = Vector(0, 0, 0)
	local MaxVector = Vector(0, 0, 0)

	for i = 1, 3 do
		if (FirstPoint[i] >= SecondPoint[i]) then
			MaxVector[i] = FirstPoint[i]
			MinVector[i] = SecondPoint[i]
		else
			MaxVector[i] = SecondPoint[i]
			MinVector[i] = FirstPoint[i]
		end
	end

	return MinVector, MaxVector
end

function AreaAdd(NameZone, FirstPoint, SecondPoint, Desc)
	if (!NameZone or !FirstPoint or !SecondPoint) then
		return false, "Required arguments are not provided."
	end

	local MinVector, MaxVector = SortVector(FirstPoint, SecondPoint)

	table.insert(PLUGIN.areaTable, {
		NameZone = NameZone,
		MinVector = MinVector,
		MaxVector = MaxVector, 
		Desc = Desc or "",
	})

	PLUGIN:SaveAreas()
end

netstream.Hook("ZoneRemove", function(client, areaID, editData)
	if (!client:IsSuperAdmin()) then
		return false
	end

	local areaData = table.Copy(GetArea(areaID))
	if (areaData) then
		client:notifyLocalized("areaRemoved", areaID)

		PLUGIN.areaTable[areaID] = nil
		PLUGIN:SaveAreas()
	end
end)

netstream.Hook("SafeMe", function(client, data)
	if data then
		client:GodEnable()
	else
		client:GodDisable()
	end
end)
