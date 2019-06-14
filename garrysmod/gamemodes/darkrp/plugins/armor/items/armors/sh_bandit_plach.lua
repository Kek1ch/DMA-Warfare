ITEM.name = "Черный кожаный плащ"
ITEM.desc = "Обычный плащ из чёрной кожи. Заметной защиты носителю не обеспечивает. Разве что не даст замёрзнуть ночью и смягчит укус слепого пса. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-легкая бронезащита \n-возможно разобрать с помощью лома"
ITEM.price = 13012
ITEM.ric = 15
ITEM.dmgsteal = 20
ITEM.exRender = false
ITEM.addition = 8
ITEM.weight = 3.12

ITEM.model = "models/kek1ch/novice_outfit.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(1.2999999523163, 0, 200),
	ang = Angle(90, 0, 180),
	fov = 10
}

ITEM.ArmorFade = {}
ITEM.ArmorFade[FACTION_MILITARY] = {Models = {
"models/spenser/kek1ch/stalker_militari_1_new.mdl",
"models/spenser/kek1ch/soldier_mask_donbass.mdl"
}}
ITEM.ArmorFade[FACTION_RAIDERS] = {Models = {
"models/spenser/kek1ch/stalker_bandit_4.mdl",
"models/spenser/kek1ch/stalker_bandit_3.mdl",
"models/spenser/kek1ch/stalker_bandit4a.mdl"
}}
ITEM.ArmorFade[FACTION_LONER] = {Models = {
"models/spenser/kek1ch/stalker_neutrala6.mdl",
"models/spenser/kek1ch/stalker_neutrala1.mdl",
"models/spenser/kek1ch/stalker_neutral_a.mdl"
}}
ITEM.ArmorFade[FACTION_MERCHANTS] = {Models = {
"models/spenser/kek1ch/stalker_neutrala6.mdl",
"models/spenser/kek1ch/stalker_neutrala1.mdl",
"models/spenser/kek1ch/stalker_neutral_a.mdl"
}}
ITEM.ArmorFade[FACTION_CLEARSKY] = {Models = {
"models/spenser/kek1ch/stalker_nebo_3.mdl"
}}
ITEM.ArmorFade[FACTION_FREEDOM] = {Models = {
"models/spenser/kek1ch/stalker_freedom2b_mask.mdl",
"models/spenser/kek1ch/stalker_freedom_2_old.mdl"
}}
ITEM.ArmorFade[FACTION_DUTY] = {Models = {
"models/spenser/kek1ch/stalker_dolg2a_mas2.mdl",
"models/spenser/kek1ch/stalker_dolg2a_mas4.mdl",
"models/spenser/kek1ch/stalker_dolg2a_mask.mdl",
"models/spenser/kek1ch/stalker_dolg2a_old.mdl",
"models/spenser/kek1ch/stalker_dolg_2.mdl",
"models/spenser/kek1ch/stalker_dolg_2_old.mdl"
}}
ITEM.ArmorFade[FACTION_SCIENTISTS] = {Models = {
"models/spenser/kek1ch/stalker_neutrala6.mdl",
"models/spenser/kek1ch/stalker_neutrala1.mdl",
"models/spenser/kek1ch/stalker_neutral_a.mdl"
}}
ITEM.ArmorFade[FACTION_MONOLIT] = {Models = {
"models/spenser/kek1ch/stalker_monolith_0.mdl"
}}
ITEM.ArmorFade[FACTION_MERCENARIES] = {Models = {
"models/spenser/kek1ch/stalker_mercen2a_mask.mdl",
"models/spenser/kek1ch/stalker_mercen2b_mask.mdl",
"models/spenser/kek1ch/stalker_mercen_2_mask.mdl"
}}
ITEM.ArmorFade[FACTION_RENEGAT] = {Models = {
"models/spenser/kek1ch/renegat_kek1ch_plash.mdl"
}}
ITEM.ArmorFade[FACTION_NATO] = {Models = {
"models/spenser/kek1ch/nato_soldier_obichniy_vadim.mdl"
}}
ITEM.ArmorFade[FACTION_LASTDAY] = {Models = {
"models/spenser/kek1ch/lastday_stalker_3_vadim.mdl",
"models/spenser/kek1ch/lastday_stalker_4_vadim.mdl"
}}

local DuseArmor = {
	"kevlar",
	"armbr",
	"trapk",
	"kevlar",
	"dlarmor"
}

ITEM.functions.duse = {
	name = "разобрать",
	onRun = function(item)
		if (IsValid(item.player) && item.player:Alive()) then
			if not item.player:getChar():getInv():hasItem("crowboar") then
				item.player:notify("У вас нет лома!")
				return false
			end
			
			item.player:EmitSound("interface/crowbreak.ogg", 50, 100)

			for i = 3, 4 do
				item.player:getChar():getInv():add(table.Random(DuseArmor))
			end
		end
	end,
	
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

