local PLUGIN = PLUGIN

local function cursorDraw()
    local x, y = gui.MousePos()
	local material = Material("daui/ui_ani_cursor_01.png") 
    if (x != 0 && y != 0) then 
        surface.SetDrawColor( 255, 255, 255, 255 );
        surface.SetMaterial(material)
        surface.DrawTexturedRect( x, y, 60, 60 )
    end
end

local function cursorThink() 
    local hover = vgui.GetHoveredPanel()
    if not IsValid(hover) then 
        return; 
    end; 
    hover:SetCursor('blank')
end; 

hook.Add("DrawOverlay", "Draw_Cursor_Function_FGSHAR", cursorDraw)
hook.Add("Think", "Cursor_Think_Function_FGSHAR", cursorThink)