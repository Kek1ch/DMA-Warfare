ITEM.name = "Ручной фонарь"
ITEM.desc = "Для бойцов старой школы, очень прочный фонарь и, судя по потертостям, довольно-таки старый. \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-требует подзарядку"
ITEM.price = 2806
ITEM.exRender = false
ITEM.weight = 0.48
ITEM.class = "weapon_cop_flashlight"
ITEM.weaponCategory = "flashlight"
ITEM.category = "Оружие"

ITEM.model = "models/wick/weapons/stalker/stcopwep/w_lashlight_model_misery.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(68, 57.299999237061, 42.84973526001),
	ang = Angle(25, 220, -126.11464691162),
	fov = 4.2624916613982
}

ITEM:hook("drop", function(item)
	if (item.player:FlashlightIsOn()) then
		item.player:Flashlight(false)
	end
end)

function ITEM:onTransfered()
	local client = self:getOwner()

	if (IsValid(client) and client:FlashlightIsOn()) then
		client:Flashlight(false)
	end
end



