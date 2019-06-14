PLUGIN.name = "Bleeding"
PLUGIN.author = "Dobytchick"
PLUGIN.desc = "This plugin add`s bleeding for player"

nut.util.include("sv_plugin.lua")

if (CLIENT) then
    function PLUGIN:HUDPaint()
    if IsValid(LocalPlayer()) and LocalPlayer():getChar() then
        if LocalPlayer():getNetVar("bleeding", false) == true then
            surface.SetDrawColor(color_white)
            surface.SetMaterial(Material("nsrp/krovyaka.png"))
            surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
        end
        end
    end
end
