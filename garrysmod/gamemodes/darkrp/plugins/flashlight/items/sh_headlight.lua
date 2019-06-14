ITEM.name = "Налобный фонарик"
ITEM.desc = "Фонарь с креплением на голову. Пригодится сталкеру, которого ночь застала в дороге; с другой стороны, может привлечь чье-то нежелательное внимаение. \n\nХАРАКТЕРИСТИКИ: \n-технологическое приспособление \n-умеренное потребление энергии"
ITEM.category = "misc"
ITEM.price = 5048
ITEM.exRender = false
ITEM.weight = 0.19

ITEM.model = "models/kek1ch/dev_torch_light.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-200, 0, 85),
	ang = Angle(22.929935455322, 0, 0),
	fov = 2.8662420382166
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