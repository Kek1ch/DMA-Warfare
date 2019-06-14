ITEM.name = "Тайник бойца «Чистого Неба»"
ITEM.desc = "При вскрытии тайника вы принимаете идеологию группировки «Чистого Неба» и присоединяетесь к их взглядам, став одним из их немногочисленных членов.\n\nХАРАКТЕРИСТИКИ: \n-личная вещь \n-высокая ценность \n-не выпадает \n-нельзя выбросить"
ITEM.price = 20758
ITEM.exRender = false
ITEM.weight = 14.25

ITEM.model = "models/kek1ch/case.mdl"
ITEM.width = 3
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-496.81527709961, -500, 500),
	ang = Angle(35.099998474121, 45.169998168945, -18.343948364258),
	fov = 2.4
}

ITEM.functions.Use = {
	onRun = function(item)
		local client = item.player
		local faction = nut.faction.indices[FACTION_CLEARSKY]

		if (faction) then
    		client:getChar().vars.faction = faction.uniqueID
   		 	client:getChar():setFaction(faction.index)
		end
		client:SetModel("models/spenser/ssk/new_nebo_02_spen.mdl")
		client:ConCommand("say /zfracquestc"..nut.faction.indices[client:getChar():getFaction()].name.."") 
		client:getChar():getInv():add("9x39")
		client:getChar():getInv():add("9x39")
		client:getChar():getInv():add("9x39")
		client:getChar():getInv():add("wtorm")
		client:getChar():giveMoney(100000)
		client:EmitSound(client, "interface/inv_properties.ogg")
		client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
			client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
	end
}

ITEM:hook("drop", function(item)
	return false
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory) then
		return true
	end
end
