ITEM.name = "Armor Base"
ITEM.category = "Броня"
ITEM.isCloth = true
ITEM.isArmor = true
ITEM.weight = 0
ITEM.ric = 0
ITEM.dmgsteal = 0

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if (item:getData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
		
		if (item:getData("durabilityarmor")) then
			local durabilityarmor = item:getData("durabilityarmor") or 100
			draw.SimpleText(item:getData("durabilityarmor") .. "%", "LFontForSafe", x, y, Color((255 / 100) * (100 - durabilityarmor), (255 / 100) * durabilityarmor, 0, 255))
			if item:getData("durabilityarmor") < 1 then
				surface.SetDrawColor(255, 110, 110, 100)
				surface.DrawRect(w - 14, h - 14, 8, 8)
			end
		end
	end
end

ITEM.functions.Equip = {
	name = "надеть",
	onRun = function(item)
		local client = item.player
		for k, v in pairs(client:getChar():getInv():getItems()) do
			if (v.id != item.id) then
				local itemTable = nut.item.instances[v.id]
				if (itemTable) and (itemTable.isCloth and itemTable:getData("equip")) then
					client:notify("На вас уже надета броня")
					return false
				end
			end
		end

		client:EmitSound("weapons/aks74/cloth.wav")
		client:getChar():setModel((string.gsub(table.Random(item.ArmorFade[client:Team()].Models), "spenser", "hdmodels")))
		client:ConCommand("say /actequip_bron")
		client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1, function()
			client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
		item:setData("equip", true)
        client:getChar():setData("armored",true)

		return false
	end,
	onCanRun = function(item)
		--return (!IsValid(item.entity) and item:getData("equip") != true)
		return (!IsValid(item.entity) and item:getData("equip") != true and item:getData("durabilityarmor", 100) > 0)
	end
}

function ITEM:onInstanced()
	if (self:getData("durabilityarmor")) == nil then
		self:setData("durabilityarmor", 100)
	end
end

function ITEM:getDesc()
	local description = self.desc
	description = description.."\n\nСостояние: "..self:getData("durabilityarmor", 100).."/100"
	return description
end

ITEM.functions.EquipUn = {
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	onRun = function(item)
		local client = item.player
		client:setNetVar("mask1", false)
		client:setNetVar("mask2", false)
		client:setNetVar("mask3", false)
		client:getChar():setModel(nut.faction.indices[client:Team()].models[1])
		client:EmitSound("weapons/aks74/cloth.wav")
		item:setData("equip", false)
		client:getChar():setData("armored",false)
		client:setNetVar("gassound", false)
		client:ConCommand("say /actequip_bron")
		client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
			client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") == true)
	end
}

ITEM.functions.Repair = {
	name = "починить",
	tip = "equipTip",
	icon = "icon16/bullet_wrench.png",
	onRun = function(item)
		local client = item.player
		local items = client:getChar():getInv()
		
		if items:hasItem("remnabor_armor") then
			items:remove(items:hasItem("remnabor_armor"):getID())
			item:setData("durabilityarmor", math.Clamp(item:getData("durabilityarmor", 100) + 25, 0, 100))
			item:setData("durabilityarmor", 100)
			client:EmitSound("interface/inv_repair_kit.ogg", 80)
			client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
			timer.Simple(1,function()
			client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
			end)
		else
			client:notify("У Вас нет профессионального набора для ремонта брони")
		end		
		
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	return !self:getData("equip")
end
