ITEM.name = "Российский табак"
ITEM.desc = "Сигареты довольно дорогие и редкие в Зоне, так что наличие табачкого сырья позволяет изготавливать собственные сигареты по более низкой цене. Герметичная упаковка из олова гарантирует, что табак будет оставаться свежим в течении нескольких дней или недель. \n\nХАРАКТЕРИСТКИ: \n-низкое качество \n-вредно для организма \n-используется для изготовления самокруток \n-для использования требуется: зажигалка"
ITEM.price = 3201
ITEM.exRender = false
ITEM.weight = 0.1
ITEM.bigtabakAmount = 3

ITEM.model = "models/kek1ch/tobacco.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(52.070404052734, 43.692253112793, 32.549373626709),
	ang = Angle(25, 220, 0),
	fov = 4.6
}

function ITEM:getDesc()
	local str
	str = self.desc.." \nОсталось %s использования"
	return Format(str, self:getData("bigtabakAmount"))
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		local bigtabakAmount = item:getData("bigtabakAmount", item.bigtabakAmount or 1)
	end
end

ITEM.functions.Smoke = {
	name = "закурить",
	onRun = function(item)
	local client = item.player
		if (IsValid(item.player) && item.player:Alive()) then
			if not item.player:getChar():getInv():hasItem("tinderbox") then
				item.player:notify("У вас нет зажигалки!")
				return false
			end

			local s = EffectData()
			s:SetOrigin(item.player:EyePos())
			util.Effect("cw_effect_smoke_cig", s)

			item.player:EmitSound("interface/inv_smoke.ogg", 50, 100)
			item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
			timer.Simple(1,function()
				client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
			end)
			item:setData("bigtabakAmount", item:getData("bigtabakAmount") - 1)
			
			if item:getData("bigtabakAmount") < 1 then
				item.player:notify("Табак кончился")
				return true
			end
		end
		return false
	end,
	
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

function ITEM:onInstanced()
	if not self:getData("bigtabakAmount") then
		self:setData("bigtabakAmount", self.bigtabakAmount)
	end
end