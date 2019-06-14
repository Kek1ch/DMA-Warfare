SCHEMA.name = "DarkRP"
SCHEMA.author = "Kek1ch"
SCHEMA.desc = "DarkRP"
SCHEMA.IncludeFilesTable = {"sh_config.lua"} 

nut.command.add("getpos", {
	adminOnly = true,
	onRun = function(client, arguments)
		client:ChatPrint(tostring(client:GetPos()))
	end
})

function SCHEMA:DownloadMaterial(url, path)
    if (!file.Exists(path, "DATA")) then
        http.Fetch(url, function(result)
            if (result) then
                file.Write(path, result)
            end
        end)
    end
end

nut.command.add("findallflags", {
	adminOnly = true,
	onRun = function(client, arguments)
		for k, v in pairs(player.GetAll()) do
			if IsValid(v) then
				if (v:getChar():getFlags() == "") then continue end
				client:ChatPrint(v:Name().." — "..v:getChar():getFlags())
			end
		end
	end
})

nut.util.include("sh_config.lua")
nut.util.includeDir("hooks")

nut.flag.add("Y", "Доступ к Q-меню")
nut.flag.add("F", "Флаг на /plytransfer и /charsetname ")
nut.flag.add("M", "Флаг на /itemclean")
nut.flag.add("L", "Флаг на невыпадение вещей")
nut.flag.add("P", "Доступ к редактору PAC3")
nut.flag.add("O", "Флаг создателя")

nut.currency.set("", "RU", "RU")

game.AddAmmoType( { name = "9x18", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "9x19", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "9x39", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "762x54", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "762x51", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "556x45", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "545x39", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "45acp", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "12x70", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "338", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "grenate", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "762x25", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "pkm", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "57x28", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "bolt", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "gaus", dmgtype = DMG_BULLET } )
game.AddAmmoType( { name = "vog", dmgtype = DMG_BULLET } )

hook.Add("PrePACEditorOpen", "FlagCheck", function( client )
	if not client:getChar():hasFlags("P") then
		return false
	end
end)


if (CLIENT) then
	hook.Add( "SpawnMenuOpen", "FlagCheckPET", function()
		if not LocalPlayer():getChar():hasFlags("Y") and not IsValid(LocalPlayer():getChar()) then
			return false
		end
	end)
end
