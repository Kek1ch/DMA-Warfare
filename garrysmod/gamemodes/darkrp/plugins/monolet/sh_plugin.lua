local PLUGIN = PLUGIN

PLUGIN.name = "Monolit"
PLUGIN.author = "WickedRabbit&Kek1ch"
PLUGIN.desc = "Prepare ur monolit, если ты понял о чем я."

local IncludeFiles = {"cl_hooks.lua"}
for k, v in ipairs(IncludeFiles) do nut.util.include(v) end

nut.util.include("sv_plugin.lua")
