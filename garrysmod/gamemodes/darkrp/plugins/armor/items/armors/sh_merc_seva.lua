ITEM.name = "Научный костюм наёмников"
ITEM.desc = "Костюм наёмников, которые промышляют в аномальных зонах. Системы защиты с замкнутым циклом, встроенная система подавления действия аномальных полей. Предоставляет неплохую защиту от пулевого и осколочного попадания, но явно недостаточную для масштабных боевых действий. \n\nВНИМАНИЕ! \n\n При разборке рекомендуется освободить инвентарь! \n\nХАРАКТЕРИСТИКИ: \n-усиленная бронезащита \n-возможно разобрать с помощью лома \n-защищает от радиации при наличии балона"
ITEM.price = 154254
ITEM.ric = 30
ITEM.dmgsteal = 50
ITEM.exRender = false
ITEM.addition = 30
ITEM.weight = 9.18

ITEM.model = "models/kek1ch/scientific_outfit_merc.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 8.5987261146497
}

ITEM.ArmorFade = {}
ITEM.ArmorFade[FACTION_MILITARY] = {Models = {
"models/spenser/kek1ch/stalker_soldier3a_beret.mdl",
"models/spenser/kek1ch/stalker_soldier3b_beret.mdl"
}}
ITEM.ArmorFade[FACTION_RAIDERS] = {Models = {
"models/spenser/kek1ch/stalker_bandit_3.mdl",
"models/spenser/kek1ch/stalker_bandit_4.mdl",
"models/spenser/kek1ch/stalker_bandit4a.mdl"
}}
ITEM.ArmorFade[FACTION_LONER] = {Models = {
"models/spenser/kek1ch/stalker_neytral_nauchniy.mdl"
}}
ITEM.ArmorFade[FACTION_MERCHANTS] = {Models = {
"models/spenser/kek1ch/stalker_neytral_nauchniy.mdl"
}}
ITEM.ArmorFade[FACTION_CLEARSKY] = {Models = {
"models/spenser/kek1ch/stalker_neytral_nauchniy.mdl"
}}
ITEM.ArmorFade[FACTION_FREEDOM] = {Models = {
"models/spenser/kek1ch/stalker_sv_nauchniy.mdl"
}}
ITEM.ArmorFade[FACTION_DUTY] = {Models = {
"models/spenser/kek1ch/stalker_dolg_nauchniy.mdl"
}}
ITEM.ArmorFade[FACTION_SCIENTISTS] = {Models = {
"models/spenser/kek1ch/stalker_ecolog_military.mdl",
"models/spenser/kek1ch/stalker_ecolog_white.mdl",
"models/spenser/kek1ch/stalker_ecolog_yellow.mdl",
"models/spenser/kek1ch/stalker_ecolog.mdl",
"models/spenser/kek1ch/stalker_ecolog_blue.mdl",
"models/spenser/kek1ch/stalker_ecolog_brown.mdl"
}}
ITEM.ArmorFade[FACTION_MONOLIT] = {Models = {
"models/spenser/kek1ch/stalker_monolith_1.mdl"
}}
ITEM.ArmorFade[FACTION_MERCENARIES] = {Models = {
"models/spenser/kek1ch/stalker_ki_nauchniy.mdl"
}}
ITEM.ArmorFade[FACTION_RENEGAT] = {Models = {
"models/spenser/kek1ch/renegat_kek1ch_plash.mdl"
}}
ITEM.ArmorFade[FACTION_NATO] = {Models = {
"models/spenser/kek1ch/nato_seva_vadim.mdl"
}}
ITEM.ArmorFade[FACTION_LASTDAY] = {Models = {
"models/spenser/kek1ch/lastday_stalker_seva_vadim.mdl"
}}

local DuseArmor = {
	"armbr",
	"trapk",
	"dharmor",
	"armbr",
	"kevlar",
	"plate"
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

			for i = 5, 6 do
				item.player:getChar():getInv():add(table.Random(DuseArmor))
			end
		end
	end,
	
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

