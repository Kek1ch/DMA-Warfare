include("shared.lua")

local toScreen = FindMetaTable("Vector").ToScreen
local colorAlpha = ColorAlpha
local drawText = nut.util.drawText
local configGet = nut.config.get

function ENT:onDrawEntityInfo(alpha)
	--local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
	--local x, y = position.x, position.y
	--local tx, ty = drawText("Рюкзак..", x, y, colorAlpha(Color(128, 0, 0), alpha), 1, 1, nil, alpha * 0.65)
end

function ENT:Draw()
	local dist = LocalPlayer():GetPos():Distance(self:GetPos())

	if (dist < 1800) then
		self.Entity:DrawModel()
	end
end