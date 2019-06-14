local PLUGIN = PLUGIN

function PLUGIN:PlayerDisconnected(client)
	local char = client:getChar()

	if (char) then
		local vehicle = char:getVar("curVehicle")

		for k, v in ipairs(char:getInv():getItems()) do
			if (v.vehicleData) then
				if (v:getData("spawned")) then
					v:setData("spawned", nil)
					v:setData("gas", 0)
				end
			end
		end

		if (vehicle and IsValid(vehicle)) then
			vehicle:Remove()
		end
	end
end

function PLUGIN:PlayerLoadedChar(client, curChar, prevChar)
	if (prevChar and curChar:getID() != prevChar:getID()) then
		local vehicle = curChar:getVar("curVehicle")

		for k, v in ipairs(curChar:getInv():getItems()) do
			if (v.vehicleData) then
				if (v:getData("spawned")) then
					v:setData("spawned", nil)
					v:setData("gas",  0)
				end
			end
		end

		if (vehicle and IsValid(vehicle)) then
			vehicle:Remove()
		end
	end
end

local function kickPassengersGeneric(vehicle)
	if (vehicle.seats) then
		for k, v in ipairs(vehicle.seats) do
			if (v and IsValid(v)) then
				local driver = v:GetDriver()

				if (driver and IsValid(driver)) then
					driver:ExitVehicle()
				end
			end
		end
	end
end

local function kickPassengersSCAR(vehicle)
	if (vehicle.Seats) then
		for k, v in ipairs(vehicle.Seats) do
			if (k == 1) then
				continue 
			end

			if (v and IsValid(v)) then
				local driver = v:GetDriver()

				if (driver and IsValid(driver)) then
					driver:ExitVehicle()
				end
			end
		end
	end
end
	
local function scarFuel(vehicle)
	return (!vehicle.ranOut)
end

local function fillGas(vehicle, amount)
	vehicle:setNetVar("gas", math.min(vehicle:getNetVar("gas") + amount, vehicle.maxGas))
end

function NutSpawnVehicle(pos, ang, spawnInfo)
	local vehicleEnt

	if (spawnInfo.type == TYPE_GENERIC) then
		vehicleEnt = ents.Create("prop_vehicle_jeep")			
		vehicleEnt:SetModel(spawnInfo.model)
		vehicleEnt:SetKeyValue("vehiclescript", spawnInfo.script) 
		vehicleEnt:SetPos(pos)
		vehicleEnt:Spawn()
		vehicleEnt:SetRenderMode(1)
		vehicleEnt:SetColor(spawnInfo.color or color_white)
			
		if (spawnInfo.seats and hook.Run("CanSpawnPassengerSeats") != false) then
			vehicleEnt.seats = {}

			for k, v in ipairs(spawnInfo.seats) do
				local seatEnt = ents.Create("prop_vehicle_prisoner_pod")
				seatEnt:SetModel("models/nova/jeep_seat.mdl")
				seatEnt:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod.txt") 
				seatEnt:Spawn()
				seatEnt:SetNotSolid(true)
				seatEnt:SetParent(vehicleEnt)
				seatEnt:SetLocalPos(v.pos)
				seatEnt:SetLocalAngles(v.ang)
				if (!v.visible) then
					seatEnt:SetNoDraw(true)
				end
					
				vehicleEnt.seats[k] = seatEnt
			end
		end

		vehicleEnt.kickPassengers = kickPassengersGeneric
	elseif (spawnInfo.type == TYPE_SCAR) then
		vehicleEnt = ents.Create(spawnInfo.class)
		if (!IsValid(vehicleEnt)) then
			print("Scar entity does not exists.")

			return
		end

		vehicleEnt:SetPos(pos)
		vehicleEnt:Spawn()
		vehicleEnt.hasFuel = scarFuel

		if (vehicleEnt.Seats) then
			local mainSeat = vehicleEnt.Seats[1]

			if (mainSeat and IsValid(mainSeat)) then
				vehicleEnt.scarDriverSeat = mainSeat
				mainSeat.actualVehicle = vehicleEnt
			end
		end

		vehicleEnt.kickPassengers = kickPassengersSCAR
	else
		print("Tried call NutSpawnVehicle without vehicleType.")

		return
	end

	vehicleEnt:setNetVar("carName", spawnInfo.name)
	vehicleEnt:setNetVar("carPhysDesc", spawnInfo.physDesc)
	vehicleEnt.maxGas = spawnInfo.maxGas
	vehicleEnt.spawnedVehicle = true
	vehicleEnt.fillGas = fillGas

	return vehicleEnt
end

local function gasCalc()
	for k, v in ipairs(ents.GetAll()) do
		local class = v:GetClass():lower()

		-- vehicle or driveable vehicle.
		if (v:IsVehicle() and v.spawnedVehicle) then
			local gas = v:getNetVar("gas")

			if (gas and IsValid(v:GetDriver())) then

				if (gas <= 0) then
					-- If gas is ran out, Turn off the vehicle.
					if (v.IsScar) then
						-- SCARs
						v.ranOut = true
						v:TurnOffCar()
					else
						-- Generic Vehicles
						v:Fire("TurnOff")
						v.ranOut = true
					end
				else
					v:setNetVar("gas", math.max(gas - 1, 0))

					-- If gas filled, Make it run again.
					if (v.IsScar) then
						-- SCARs
						if (v.ranOut) then
							v.ranOut = false
							v:TurnOnCar()
						end
					else
						-- Generic Vehicles
						if (v.ranOut) then
							v:Fire("TurnOn")
							v.ranOut = false
						end
					end
				end
			end
		end
	end
end

	-- Calculate fuel.
timer.Create("ServerFuelEffects", 1, 0, function()
	local succ, err = pcall(gasCalc)	
		
	-- To make timer not get removed for the error.
	if (!succ) then
		print("VEHICLE: ")
		print(err)
	end
end)

function SCHEMA:PlayerLeaveVehicle(client, vehicle)
	if (vehicle.spawnedVehicle or vehicle.actualVehicle) then
		if (vehicle.actualVehicle and IsValid(vehicle.actualVehicle)) then
			vehicle = vehicle.actualVehicle	
		end

		local owner = vehicle:getNetVar("owner")
		local charID = client:getChar():getID()

		if (owner and charID and owner == charID) then
			vehicle:kickPassengers()
		end
	end
end

function SCHEMA:FindUseEntity(client, vehicle) 
	if (vehicle:IsValid() and vehicle:IsVehicle() and IsValid(vehicle:GetDriver()) and vehicle.seats) then
		for k, v in ipairs(vehicle.seats) do
			if (!IsValid(vehicle.seats[k]:GetDriver())) then
				print(vehicle.seats[k])
				return vehicle.seats[k]
			end
		end
	end
end

function SCHEMA:CanSpawnPassengerSeats()
	if (VCMod1) then
		return false
	end
end

