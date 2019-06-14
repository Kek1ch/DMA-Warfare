ITEM.name = "«Колобок»"
ITEM.desc = "Колобок — артефакт, порождаемый химической аномалией «газировка». Довольно редкий артефакт, образующийся в зонах сильного химического загрязнения. Весьма ценится за способность подстегнуть организм так, чтобы тот в считанные минуты восстановился после травм любой степени тяжести. Учёные распространяют информацию о воздействии артефакта на генетический материал владельца; впрочем, подтверждения этому пока нет. \n\nХАРАКТЕРИСТИКИ: \n-артефакт \n\nРадиация +3 / сек"
ITEM.price = 32976
ITEM.isAnomaly = true
ITEM.weight = 0.82

ITEM.model = "models/kek1ch/fuzz kolobok.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(250.9533996582, 210.91357421875, 161.35008239746),
	ang = Angle(25, 220, 0),
	fov = 2.5
}

ITEM.functions.Use = {
	name = "положить в СИМК",
	onRun = function(item)
		local client = item.player
		if (IsValid(item.player) && item.player:Alive()) then
			if not client:getChar():getInv():hasItem("simkemp") then
				client:notify("Вам нужны СИМК (пустой).")
				return false
			end

			client:EmitSound( Sound( "interface/inv_iam_close.ogg" ), Entity( 1 ):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100 )
			client:getChar():getInv():add("simk_colobok")
			client:getChar():getInv():remove(client:getChar():getInv():hasItem("simkemp"):getID()) 
			client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
			timer.Simple(1,function()
				client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
			end)
		end
	end,

	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}