local PLUGIN = PLUGIN

PLUGIN.name = "S.T.A.L.K.E.R. User Interface (DMA Warfare))))"
PLUGIN.author = "From Purin & DrodA with love XX Kek1ch"
PLUGIN.desc = ""
PLUGIN.version = 1

local IncludeFiles = {"sh_config.lua"}
for k, v in ipairs(IncludeFiles) do nut.util.include(v) end

if (SERVER) then
	netstream.Hook("save_my_sound", function(client)
		client:ConCommand("stopsound")
	end)
end
