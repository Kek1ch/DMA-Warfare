--This is a list of your server's maps which are available through the workshop
--Each one uses the map file's name and the workshop ID
maplist = {}
maplist["rp_zaton_warfare_kek1ch_v1"] = "1728990223"

--add more maps here


local map = game.GetMap() -- Get's the current map name
local workshopid = maplist[map] 
-- Finds the workshop ID for the current map name from the table above

if( workshopid != nil )then
	--If the map is in the table above, add it through workshop
	print( "[WORKSHOP] Setting up maps. " ..map.. " workshop ID: " ..workshopid )
	resource.AddWorkshop( workshopid )
else
	--If not, ) then hope the server has FastDL or the client has the map
	print( "[WORKSHOP] Not available for current map. Using FastDL instead hopefully..." )
end

