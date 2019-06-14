PLUGIN.name = "Tying"
PLUGIN.author = "Chessnut"
PLUGIN.desc = "Adds the ability to tie players."

nut.util.include("sh_charsearch.lua")
nut.util.include("sv_plugin.lua")

if (CLIENT) then
	local COLOR_TIED = Color(245, 215, 110)

	function PLUGIN:DrawCharInfo(client, character, info)
		if (client:getNetVar("restricted")) then
			info[#info + 1] = {L"isTied", COLOR_TIED}
		end
	end
end
