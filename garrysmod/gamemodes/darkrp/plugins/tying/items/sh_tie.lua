ITEM.name = "Веревка"
ITEM.desc = "Около 10 метров хорошей веревки, которая может послужить многим целям, особенно в таком месте, как Зона Отчуждения. \n-повсеместное применение \n-используется для обезоруживание стаолкера \n\nИнвентарь игрока можно осмотреть с помощью команды /charsearch \nЗапрещено отбираться именные вещи"
ITEM.price = 759
ITEM.exRender = false

ITEM.model = "models/kek1ch/rope.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 3.7
}

local relations_allies_f = {}
relations_allies_f["Одиночки"] = {allies = {"Одиночки", "Долг", "Свобода", "Чистое Небо", "Ученые", "Торговцы", "Миротворцы", "Последний День", "Стервятники"}}
relations_allies_f["Бандиты"] = {allies = {"Бандиты", "Свобода", "Наемники"}}
relations_allies_f["Долг"] = {allies = {"Долг", "Одиночки", "Ученые", "Военные", "Чистое Небо", "Торговцы", "Миротворцы", "Стервятники"}}
relations_allies_f["Свобода"] = {allies = {"Свобода", "Одиночки", "Ученые", "Бандиты", "Наемники", "Торговцы", "Чистое Небо", "Стервятники"}}
relations_allies_f["Монолит"] = {allies = {"Монолит", "Зомбированные"}}
relations_allies_f["Зомбированные"] = {allies = {"Монолит", "Зомбированные"}}
relations_allies_f["Ренегаты"] = {allies = {"Ренегаты"}}
relations_allies_f["Военные"] = {allies = {"Ученые", "Военные", "Долг", "Миротворцы"}}
relations_allies_f["Наемники"] = {allies = {"Наемники", "Свобода", "Бандиты"}}
relations_allies_f["Грех"] = {allies = {"Грех", "Послединй День", "Стервятники"}}
relations_allies_f["Ученые"] = {allies = {"Ученые", "Военные", "Одиночки", "Долг", "Миротворцы", "Последний День", "Чистое Небо", "Стервятники"}}
relations_allies_f["Миротворцы"] = {allies = {"Миротворцы", "Ученые", "Военные", "Одиночки", "Долг", "Ученые", "Чистое Небо", "Торговцы", "Стервятники"}}
relations_allies_f["Последний День"] = {allies = {"Последний День", "Ученые", "Свобода", "Наемники", "Одиночки", "Грех", "Стервятники"}}
relations_allies_f["Чистое Небо"] = {allies = {"Чистое Небо", "Одиночки", "Долг", "Свобода", "Торговцы", "Миротворцы", "Ученые", "Стервятники"}}
relations_allies_f["Торговцы"] = {allies = {"Торговцы", "Одиночки", "Долг", "Свобода", "Миротворцы", "Чистое Небо", "Ученые", "Стервятники"}}
relations_allies_f["Стервятники"] = {allies = {"Стервятники", "Торговцы", "Одиночки", "Долг", "Свобода", "Миротворцы", "Чистое Небо", "Грех", "Ученые", "Последний День"}}

--[[ITEM.functions.Use = {
	onRun = function(item)
		if (item.beingUsed) then
			return false
		end

		local client = item.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local target = util.TraceLine(data).Entity

		if table.HasValue(relations_allies_f[team.GetName(client:Team())].allies, team.GetName(target:Team())) then
			client:getChar():setData("rep", client:getChar():getData("rep") - 20)
		end

		if (IsValid(target) and target:IsPlayer() and target:getChar() and !target:getNetVar("tying") and !target:getNetVar("restricted")) then
			item.beingUsed = true

			client:EmitSound("physics/plastic/plastic_barrel_strain"..math.random(1, 3)..".wav")
			client:setAction("@tying", 5)
			client:doStaredAction(target, function()
				item:remove()

				target:setRestricted(true)
				target:setNetVar("tying")

				client:EmitSound("npc/barnacle/neck_snap1.wav", 100, 140)
			end, 5, function()
				client:setAction()

				target:setAction()
				target:setNetVar("tying")

				item.beingUsed = false
			end)

			target:setNetVar("tying", true)
			target:setAction("@beingTied", 5)
		else
			item.player:notifyLocalized("plyNotValid")
		end

		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity)
	end
}]]

function ITEM:onCanBeTransfered(inventory, newInventory)
	return !self.beingUsed
end