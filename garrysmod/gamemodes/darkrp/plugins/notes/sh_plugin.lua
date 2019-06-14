local PLUGIN = PLUGIN
PLUGIN.name = "Notes+"
PLUGIN.author = "AleXXX_007"
PLUGIN.desc = "Write text on notes and pick up them like items."
NOTELIMIT = 10000
WRITINGDATA = WRITINGDATA or {}

nut.util.include("sv_plugin.lua")
nut.util.include("cl_vgui.lua")

if (CLIENT) then
	netstream.Hook("receiveNote", function(id, contents, write)
		local note = vgui.Create("noteRead")
		note:allowEdit(write)
		note:setText(contents)
		note.id = id
	end)
end
