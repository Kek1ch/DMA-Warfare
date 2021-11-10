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
relations_allies_f["Администратор"] = {allies = {"Администратор"}}
relations_allies_f["Mир"] = {allies = {"Mир"}}

local RandomRenegatModel = {
	"models/spenser/kek1ch/renegat_kek1ch_kurtka.mdl",
	"models/spenser/kek1ch/renegat_kek1ch_plash.mdl",
	"models/spenser/kek1ch/renegat_normal_kek1ch.mdl"
}

function SCHEMA:PlayerDeath(victim, weapon, attacker)
	if (attacker:IsPlayer()) and (victim != attacker) then
		if table.HasValue(relations_allies_f[team.GetName(attacker:Team())].allies, team.GetName(victim:Team())) then
			attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) - 5)
		else
			if serverguard.player:GetRank(attacker) == 'vip' then
				attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 2)
			else
				attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 1)
			end
		end

		if serverguard.player:GetRank(attacker) == 'vip' then
			attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 2)
		else
			attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 1)
		end

		if attacker:HasQuest( "quest_killer_rep" ) == victim:Name() then
			if not (attacker:getChar():getData("repkiller") == victim:Name()) then
				attacker:getChar():setData("repkiller", victim:Name())
				attacker:ConCommand("say Задание: Уничтожить сталкера выполнено.")
			end
		end

		if (attacker:getChar():getData("rep") < -100) and not (attacker:Team() == FACTION_RENEGAT) then
			local faction = nut.faction.indices[FACTION_RENEGAT]
			if (faction) then
				attacker:getChar().vars.faction = faction.uniqueID
				attacker:getChar():setFaction(faction.index)
				attacker:SetModel(string.gsub(table.Random(RandomRenegatModel), "spenser", "hdmodels"))
			end
		end
	end
end

netstream.Hook("giveAdmin", function(client, data)
	if data.flags then
		client:getChar():giveFlags(tostring(data.flags)) --флаг куратора
	end
	if data.money then
		client:getChar():setMoney(data.money)
	end
end

function SCHEMA:OnPlayerHitGround( ply, inWater, onFloater, speed )
    ply:ViewPunch(Angle(8, 0, 0))
end

function SCHEMA:PostPlayerLoadout(client)
	client:Give("weapon_cop_bolt")
end

function SCHEMA:PlayerDisconnected(ply)

	for k,v in pairs(player.GetAll()) do
		if v:HasQuest("quest_killer_rep") == ply:Name() then
			v:ConCommand("say Задание провалено: "..v:HasQuest("quest_killer_rep").." скрылся.")
			v:RemoveQuest("quest_killer_rep")
		end
	end
end

function SCHEMA:OnNPCKilled( npc, attacker, inflictor )
	if (attacker:IsPlayer()) then
		attacker:getChar():setData("rep", attacker:getChar():getData("rep", 0) + 1)
		attacker:getChar():setData("rank", attacker:getChar():getData("rank", 0) + 1)
	end
end	

function SCHEMA:OnCharCreated(client, character)
	character:setData("rank", 1)
	character:setData("rep", 1)
	client:setNetVar("rank", character:getData("rank", 0))
	client:setNetVar("rep", character:getData("rep", 0))

	if character:getInv() then		
		--character:getInv():add("pda", 1, {})
		character:getInv():add("knife", 1, {})
		--[[character:getInv():add("pm", 1, {})
		character:getInv():add("tinderbox", 1, {})
		character:getInv():add("tinderboxfuel", 1, {})
		character:getInv():add("blow", 1, {})
		character:getInv():add("9x18", 3, {})
		character:getInv():add("kowelek", 1, {})
		character:getInv():add("bint", 2, {})
		character:getInv():add("1000r", 1, {})
		character:getInv():add("bread", 1, {})
		character:getInv():add("konservi", 1, {})
		character:getInv():add("water", 1, {})]]
	end

	character:setData("act_table", {"Сидеть на земле #1", "Сидеть на земле #2", "Стоять с руками накрест",
	"Сидеть на корточках", "Облокотиться о стену", "Сканировать аномалию #1", "Оружие на плече", "Отжиматься", 
	"Находиться в заложниках", "Присядать", "Сидеть", "Облокотиться о стол", "Облокотиться о стену", 
	"Облокотиться о стол #1", "Стоять смирно", "Отдать честь", "Гоп стоп", "Поднять руки", "Приветствовать", 
	"Требовать убрать оружие"})

	if (client:Team() == FACTION_MONOLIT) then
		table.Add(client:getChar():getData("act_table"), {"Находиться в трансе"})
		character:setData("act_table", character:getData("act_table"))
	end

	--[[nut.item.newInv(character:getID(), "safe."..character:getID(), function(inventory)
		character:setData("safebox", inventory:getID())
	end)

	nut.item.inventories[character:getData("safebox")]:getID():add("water", 1, {})]]
end

local tabe_patch = {
[FACTION_LONER] = "ploner",
[FACTION_MERCENARIES] = "pmerc",
[FACTION_MILITARY] = "pmilitary",
[FACTION_RAIDERS] = "pbandit",
[FACTION_RENEGAT] = "prenegat",
[FACTION_FREEDOM] = "pfreedom",
[FACTION_NATO] = "pnato",
[FACTION_LASTDAY] = "plastday",
[FACTION_DUTY] = "pdolg",
[FACTION_CLEARSKY] = "pclearsky",
[FACTION_MONOLIT] = "ploner"
}

function SCHEMA:PlayerSpawn(client)
	if (client:getChar()) then 
		client:Flashlight(false)
		client:setNetVar("rank", client:getChar():getData("rank", 0))
		client:setNetVar("rep", client:getChar():getData("rep", 0))
		client:setNetVar("drunk", false)
		client:Freeze(false)
		client:GodDisable()

		--table.Add(client:getChar():getData("act_table"), {"Сидеть на земле #1", "Сидеть на земле #2"})
		--client:getChar():setData("act_table", client:getChar():getData("act_table"))
		--table.Add(client:getChar():getData("act_table"), {"first_sit"})
		--[[table.RemoveByValue( client:getChar():getData("act_table"), "first_sit" )
		client:getChar():setData("act_table", client:getChar():getData("act_table"))
		PrintTable(client:getChar():getData("act_table"))]]

		if not client:getChar():getInv():hasItem(tabe_patch[client:Team()]) then
			if client:getChar():getData("safebox") then
				if not nut.item.inventories[client:getChar():getData("safebox")]:hasItem(tabe_patch[client:Team()]) then 
					client:getChar():getInv():add(tabe_patch[client:Team()], 1)
				end
			end
		end
	end

	--------------------------------------------
	--Спавн зомби при низком онлайне
	--------------------------------------------
	if (#player.GetAll() < 6) then
		timer.Create("GamemodeSurvival", 1000, 0, function()
			if table.Count(ents.FindByClass("ssk_zombie")) < (4 * #player.GetAll()) then
				local Zombie = ents.Create("ssk_zombie")
				local PlayerVector = table.Random(player.GetAll()):GetPos()
				Zombie:SetPos(PlayerVector + Vector(math.random(600,900), math.random(600,900), 1000))
				Zombie:Spawn()
			end
		end)
	else
		timer.Remove("GamemodeSurvival")
	end
end

local deathsounds = {
"pain/die1.ogg",
"pain/die2.ogg",
"pain/die3.ogg",
"pain/die4.ogg"
}

function SCHEMA:GetPlayerDeathSound(client)
	return table.Random(deathsounds)
end

local sounds = {
"pain/pain1.ogg",
"pain/pain2.ogg",
"pain/pain3.ogg",
"pain/pain4.ogg",
"pain/pain5.ogg",
"pain/pain6.ogg",
"pain/pain7.ogg",
"pain/pain8.ogg"
}

function SCHEMA:GetPlayerPainSound(client)
	return table.Random(sounds)
end

function SCHEMA:PlayerHurt(client, attacker, health, damage)
	if client:getChar():getInv():hasItem("svistok") and not (attacker == client) then
		for k,v in pairs(ents.GetAll()) do
			if client:getChar():getInv():hasItem("svistok"):getData("DOG_ID") == v.uniqueid then
				v:SetEnemy( attacker )
			end
		end
	end
end

local artefacts_rad = {
"momboosy",
"colobok",
"cvetok",
"fireball",
"glas",
"goldfish",
"gravy",
"kristal",
"krovkamna",
"meduza",
"nightstar",
"snefinka",
"pyzir",
"soul",
"vyvert",
"batary"
}

concommand.Add("givekek1chflag", function(client,_,_,name)
	for k,v in pairs(player.GetAll()) do
		if v:Name() == name then
			v:getChar():giveFlags("O")
			print("Чтож.. Ты выдал "..v:Name().."'у флаг.")
		end
	end 
end)

