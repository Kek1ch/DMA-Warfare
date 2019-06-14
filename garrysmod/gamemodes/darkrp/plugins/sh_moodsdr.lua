local plugin = PLUGIN
plugin.name = "Emote moods"
plugin.author = "DrodA"
plugin.desc = "With this plugin, characters can set their mood."
plugin.version = 1.1

local stored = plugin.moods or {}
plugin.moods = stored

local defaultIndex = "unidentified"
function plugin:GetPlayerMood(client)
	return client:getNetVar("mood", defaultIndex)
end

function plugin:ResetPlayerMood(client)
	return client:setNetVar("mood", defaultIndex)
end

function plugin:SetPlayerMood(client, strIndex)
	return (self.moods[strIndex] and client:setNetVar("mood", self.moods[strIndex].index))
end

function plugin:GetMood(strIndex)
	return (strIndex and plugin.moods[strIndex]) or self.moods
end

function plugin:AddMood(strIndex, tblData)
	strIndex = strIndex or "unidentified"
	tblData = tblData or {}
	tblData.index = tblData.index or strIndex

	self.moods[strIndex] = tblData
end

local tblWorkaround = {["nut_keys"] = true, ["nut_hands"] = true}
function plugin:CalcMainActivity(client, velocity)
	if (plugin:GetPlayerMood(client) != defaultIndex and tblWorkaround[client:GetActiveWeapon():GetClass()]) then
		local modelClass = self.moods[plugin:GetPlayerMood(client)][nut.anim.getModelClass(client:GetModel())]

		if (!GAMEMODE:HandlePlayerDriving(client) and !GAMEMODE:HandlePlayerJumping(client) and !GAMEMODE:HandlePlayerDucking(client, velocity) and !GAMEMODE:HandlePlayerSwimming(client)) then
			if (velocity:Length2D() < 0.5) and modelClass.idle then
				client.CalcSeqOverride = modelClass.idle
			elseif (velocity:Length2D() >= 0.5 and !client:isRunning()) and modelClass.walk then
				client.CalcSeqOverride = modelClass.walk
			elseif (velocity:Length2D() >= 0.5 and client:isRunning()) and modelClass.run then
				client.CalcSeqOverride = modelClass.run
			end
		end

		if (client.CalcSeqOverride ~= -1) then
			client.CalcSeqOverride = client:LookupSequence(client.CalcSeqOverride)

			return client.CalcIdeal, client.CalcSeqOverride
		end
	end
end

--[[plugin:AddMood("run",
{
	["stalker"] = {["idle"] = "walk_test_pr", ["walk"] = "norm_escape_0"},
	["citizen_male"] = {["idle"] = "LineIdle01", ["walk"] = "walk_all"},
	["citizen_female"] = {["idle"] = "LineIdle01", ["walk"] = "walk_all"}
})]]

plugin:AddMood("ranen",
{
	["stalker"] = {["idle"] = "dmg_norm_torso_0_aim_0", ["walk"] = "dmg_norm_escape_0"},
	["citizen_male"] = {["idle"] = "LineIdle01", ["walk"] = "walk_all"},
	["citizen_female"] = {["idle"] = "LineIdle01", ["walk"] = "walk_all"}
})

plugin:AddMood("band",
{
	["stalker"] = {["idle"] = "idle_band_1", ["walk"] = "walk_band"},
	["citizen_male"] = {["idle"] = "LineIdle01", ["walk"] = "walk_all"},
	["citizen_female"] = {["idle"] = "LineIdle01", ["walk"] = "walk_all"}
})
plugin:AddMood("smirno",
{
	["stalker"] = {["idle"] = "chest_0", ["walk"] = "pace_all"},
	["citizen_male"] = {["idle"] = "LineIdle01", ["walk"] = "walk_all"},
	["citizen_female"] = {["idle"] = "LineIdle01", ["walk"] = "walk_all"}
})
plugin:AddMood("standart",
{
	["citizen_male"] = {["idle"] = "LineIdle02", ["walk"] = "pace_all"},
	["citizen_female"] = {["idle"] = "LineIdle02", ["walk"] = "walk_all"}
})

for k, v in pairs(plugin.moods) do
	local tblData = {}
	tblData.onRun = function(client, arguments)
		local modelClass = v[nut.anim.getModelClass(client:GetModel())]
		
		if (modelClass) then
			if (plugin:GetPlayerMood(client) == k) then
				return plugin:ResetPlayerMood(client)
			end

			return plugin:SetPlayerMood(client, k)
		end
	end

	nut.command.add("mood"..k, tblData)
end