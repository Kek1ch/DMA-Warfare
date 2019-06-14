local PLUGIN = PLUGIN

function PLUGIN:PlayerSwitchFlashlight(client, state)
	local character = client:getChar()

	if (!character or !character:getInv()) then
		return false
	end

	if (character:getInv():hasItem("flashlight") and client:GetActiveWeapon():GetClass() == "weapon_cop_flashlight") or character:getInv():hasItem("headlight") then
		return true
	end
end

