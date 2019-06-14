ITEM.name = "Container base"
ITEM.desc = "Base as it is."
ITEM.category = "Тайники"
ITEM.model = "models/props_c17/FurnitureCouch001a.mdl"
ITEM.invW = 0
ITEM.invH = 0
ITEM.isContainer = true
ITEM.locksound = "hgn/crussaria/devices/door_regular_stopclose.wav"
ITEM.opensound = "hgn/crussaria/devices/door_regular_opening.wav"

ITEM.functions.use = {
	name = "установить",
	tip = "placeTip",
	icon = "icon16/anchor.png",	
	onRun = function(item)
		local client = item.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local trace = util.TraceLine(data)

		if (trace.HitPos) then
			local container = ents.Create("nut_container")
			container:SetPos(trace.HitPos + trace.HitNormal)
			container:Spawn()
			hook.Run("OnContainerSpawned", container, item)
			nut.item.newInv(0, "cn_"..item.name, function(inventory)
				if (IsValid(container)) then
					container:setInventory(inventory)
				end
			end)
			return true
		end
		return false
	end,
}

function ITEM:onRegistered()
	nut.item.registerInv("cn_"..ITEM.name, ITEM.invW, ITEM.invH)
end