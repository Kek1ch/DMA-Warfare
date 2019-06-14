local PLUGIN = PLUGIN
PLUGIN.name = "Vehicle: Remastered"
PLUGIN.author = "Black Tea"
PLUGIN.desc = [[Vehicle Item Plugin with pretty good compatibility.
\nFollowing vehicle mods are supported:
\nDefault Source Vehicles, SCARS]]

nut.util.include("sv_plugin.lua")

local langkey = "english"
do
	local langTable = {
		vehicleDesc = "You changed your vehicle's desc to %s.",
		vehicleExists = "You already have at least one vehicle outside.",
		vehicleStored = "You stored your vehicles into your virtual garage.",
		notSky = "You need to be outside to bring your vehicle out.",
		vehicleSpawned = "You spawned your vehicle on the world.",
		vehicleCloser = "You need to be closer to your vehicle.",
		vehicleStoredDestroyed = "Your vehicle is destoryed or removed. But stored successfully.",
		vehicleGasFilled = "The vehicle now filled to %d%%.",
		vehicleGasLook = "You must look at the vehicle that you can fill the gas.",
	}

	table.Merge(nut.lang.stored[langkey], langTable)
end

if (CLIENT) then
	function SCHEMA:ShouldDrawEntityInfo(vehicle)
		if (vehicle:IsVehicle()) then
			return true
		end
	end
	
	function SCHEMA:DrawEntityInfo(vehicle, alpha)
		if (vehicle:IsVehicle() and vehicle:getNetVar("carName")) then
			local vh = LocalPlayer():GetVehicle()
			if (!vh or !IsValid(vh)) then
				local position = vehicle:LocalToWorld(vehicle:OBBCenter()):ToScreen()
				local x, y = position.x, position.y
				
				nut.util.drawText(vehicle:getNetVar("carName", "gay car"), x, y, ColorAlpha(nut.config.get("color"), alpha), 1, 1, nil, alpha * 0.65)
				nut.util.drawText(vehicle:getNetVar("carPhysDesc", "faggy car"), x, y + 16, ColorAlpha(color_white, alpha), 1, 1, "nutSmallFont", alpha * 0.65)
			end
		end	
	end
end

nut.command.add("vehicledesc", {
	syntax = "<string text>",
	onRun = function(client, arguments)
		if (!arguments[1]) then
			return L("invalidArg", client, 1)
		end

		local phyDesc = table.concat(arguments, " ")
		local trace = client:GetEyeTraceNoCursor()

		local ent = trace.Entity
		if (ent and IsValid(ent)) then
			local char = client:getChar()

			if (ent:getNetVar("owner", 0) == char:getID()) then
				ent:setNetVar("carPhysDesc", phyDesc)
				client:notify(L("vehicleDesc", client, phyDesc))
			end
		end
	end
})
