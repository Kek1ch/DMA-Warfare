ITEM.name = "Палатка"
ITEM.desc = "Брезентовая палатка является широко известным временным сооружение, способным предоставить укрытие от ветра, дождя или пыли. Используемый материал был подвергнут огнеупорной водоотталкивающей и противогнилостной пропитками. \n\nХАРАКТЕРИСТИКИ: \n-повсеместное применение \n-восстанавливает здоровье \n-для установки требуется: матрас, два синтетических каната, лопата"
ITEM.category = "Комфорт"
ITEM.price = 13500
ITEM.exRender = false
ITEM.weight = 7.75

ITEM.model = "models/kek1ch/item_sleepbag.mdl"
ITEM.width = 3
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(0, 205, 8.6000003814697),
	ang = Angle(0, 270, -91.719741821289),
	fov = 6.2
}

local NeedItems = {
	"twomatras",
	"twosincan",
	"shovel"
}

ITEM.functions.use = { 
	name = "установить палатку",
	onRun = function(item)
		local client = item.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local trace = util.TraceLine(data)
		
		if (client:getChar():getInv():hasItem(NeedItems)) and (trace.HitPos) then
			local tent = ents.Create("nut_tent")
			tent:SetPos(trace.HitPos + trace.HitNormal * 10)
			tent:Spawn()
			client:EmitSound( Sound("interface/inv_put_up_tent.ogg"), Entity(1):GetPos(), 1, CHAN_AUTO, 1, 20, 0, 100)
			client:ScreenFade(SCREENFADE.OUT, Color(0, 0, 0), 1, 3)
			timer.Simple(1,function()
				client:ScreenFade(SCREENFADE.IN, Color(0, 0, 0), 1, 3)
			end)
		else
			return false
		end
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

