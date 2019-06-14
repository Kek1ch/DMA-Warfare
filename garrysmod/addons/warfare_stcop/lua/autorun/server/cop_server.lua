function stalker_cop.PlayerSpawn(ply)
	ply.COP_Addons = {}

	for k, v in pairs(stalker_cop.Addons) do
		if v.cvar:GetBool() then
			ply:COP_GiveAddon(k)
		end
	end
end

hook.Add("PlayerSpawn", "stalker_cop.PlayerSpawn", stalker_cop.PlayerSpawn)

local PLAYER = debug.getregistry()["Player"]

function PLAYER:COP_HasAddon(att)
	if not self.COP_Addons then
		return false
	end

	return table.HasValue(self.COP_Addons, att)
end

function PLAYER:COP_GiveAddon(att)
	if self:COP_HasAddon(att) then return false end
	table.insert(self.COP_Addons, att)

	umsg.Start("COP_GIVEADDON", self)
		umsg.String(att)
	umsg.End()

	return true
end

function PLAYER:COP_RemoveAddon(att)
	if not self:COP_HasAddon(att) then return false end

	for i = 1, #self.COP_Addons do
		local v = self.COP_Addons[i]

		if v == att then
			table.remove(self.COP_Addons, i)

			umsg.Start("COP_REMADDON", self)
				umsg.String(att)
			umsg.End()

			return true
		end
	end

	return false
end

function stalker_cop.PlayerSwitchWeapon(ply, oldWeapon, newWeapon)
	ply.COP_LastWeapon = oldWeapon
end

hook.Add("PlayerSwitchWeapon", "stalker_cop.PlayerSwitchWeapon", stalker_cop.PlayerSwitchWeapon)