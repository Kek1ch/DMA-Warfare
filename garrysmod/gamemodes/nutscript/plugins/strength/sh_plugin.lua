PLUGIN.name = "Strength"
PLUGIN.author = "Chessnut"
PLUGIN.desc = "Adds a strength attribute."

nut.util.include("sv_plugin.lua")

-- Configuration for the plugin
nut.config.add("strMultiplier", 0.3, "The strength multiplier scale", nil, {
	form = "Float",
	data = {min=0, max=1.0},
	category = "Strength"
})
