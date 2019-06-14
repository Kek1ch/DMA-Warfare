local PLUGIN = PLUGIN
PLUGIN.name = "Quest/Journals."
PLUGIN.author = "Black Tea (NS 1.0), Neon (NS 1.1)"
PLUGIN.desc = "For someone who want to make server automatic game."

PLUGIN.curQuests = {}
PLUGIN.quests = {}

PLUGIN.journal = true
PLUGIN.maxQuestsim = 100

local entityMeta = FindMetaTable("Entity")
local playerMeta = FindMetaTable("Player")

function PLUGIN:RegisterQuest( str, data )
	if self.quests[ str ] then
		print( 'Sorry, ' .. str .. ' is already exists.' )
		return false
	else
		self.quests[ str ] = data
		return true
	end
end
nut.util.include("sh_quests.lua")

function playerMeta:GetQuests()
	return self:getNetVar( "questAssigned", {} )
end

function playerMeta:HasQuest( str )
	return self:GetQuests()[ str ]
end
function playerMeta:GetQuest( str )
	return self:GetQuests()[ str ]
end

function playerMeta:AddQuest( str, data )
	local quests = self:GetQuests()
	data = data or {}
	if #quests == maxQuestsim then
		return false
	else
		quests[ str ] = data
		self:setNetVar( "questAssigned", quests )
		return true
	end
end

function playerMeta:RemoveQuest( str )
	local quests = self:GetQuests()
	if quests[ str ] then
		quests[ str ] = nil
		self:setNetVar( "questAssigned", quests )
		return true
	else
		return false
	end
end

function PLUGIN:GetQuests()
	return self.quests
end

function PLUGIN:GetQuest( str )
	return self.quests[ str ]
end

function PLUGIN:PlayerDisconnected( player )
	if player:GetQuests() then
		self.curQuests[ player:SteamID() ] = player:GetQuests()
	end
end

