ITEM.name = "Бинт"
ITEM.desc = "Аспетический бинт для остановки кровотечения и предотвращения попадания в рану инфекции. При обычном кровотечении позволяет перевязать рану, при артериальном - перетянуть артерию. \n\nХАРАКТЕРИСТИКИ: \n-изделие первой помощи"
ITEM.category = "Медицина"
ITEM.price = 520
ITEM.weight = 0.14

ITEM.model = "models/kek1ch/dev_bandage.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-1, -0.10000000149012, 200),
	ang = Angle(90, 0, -158.21656799316),
	fov = 3.5
}

ITEM.functions.Use = {
	sound = "interface/inv_bandage_2p9.ogg",
	onRun = function(item)
		local client = item.player
		client:ScreenFade(SCREENFADE.OUT, Color(0, 0, 0), 1, 3)
		timer.Simple(1,function()
			client:ScreenFade(SCREENFADE.IN, Color(0, 0, 0), 1, 3)
		end)
		client:setNetVar("bleeding",false)
		client:SetHealth(math.min(client:Health() + 12, 100))
	end
}
