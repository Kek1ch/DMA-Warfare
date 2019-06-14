local function facingWall(client)
	local data = {}
	data.start = client:GetPos()
	data.endpos = data.start + client:GetAimVector()*54
	data.filter = client

	if (!util.TraceLine(data).HitWorld) then
		return "@faceWall"
	end
end

local function facingWallBack(client)
	local data = {}
	data.start = client:GetPos()
	data.endpos = data.start - client:GetAimVector()*54
	data.filter = client

	if (!util.TraceLine(data).HitWorld) then
		return "@faceWallBack"
	end
end

ACT_ENDSEQ = 0
ACT_STARTSEQ = 1

PLUGIN.acts["item_3_attack_0"] = { --Сидеть на земле #1
	["stalker"] = {sequence = {"item_3_attack_0", "item_3_aim_0"}, untimed = true}
}

PLUGIN.acts["idler_0_to_sit_1"] = { --Сидеть на земле #2
	["stalker"] = {sequence = {"idler_0_to_sit_1", "item_2_aim_0"}, untimed = true}
}

PLUGIN.acts["equip_bron"] = { --Надеть снаряжение
	["stalker"] = {sequence = "equip_bron", untimed = false}
}

PLUGIN.acts["cut_scene_idle_0"] = { --Стоять с руками накрест
	["stalker"] = {sequence = "cut_scene_idle_0", untimed = true}
}

PLUGIN.acts["cut_scene_actor"] = { --Лечь на спину
	["stalker"] = {sequence = "cut_scene_actor", untimed = true}
}

PLUGIN.acts["item_0_idle"] = { --Сидеть на корточках
	["stalker"] = {sequence = {"item_0_idle_0", "item_0_idle_1", "item_0_idle_2", "item_0_idle_3"}, untimed = true}
}

PLUGIN.acts["k_stene"] = { --Облокотиться о стену
	["stalker"] = {sequence = "k_stene", untimed = true, onCheck = facingWall}
}

PLUGIN.acts["knopka_0"] = { --Нажать кнопку
	["stalker"] = {sequence = "knopka_0", untimed = false}
}

PLUGIN.acts["lead_0_idle_0"] = { --Стойка лидера
	["stalker"] = {sequence = "lead_0_idle_0", untimed = true}
}

PLUGIN.acts["lead_1_idle_1"] = { --Стойка лидера #2
	["stalker"] = {sequence = {"lead_1_idle_1", "lead_1_idle_2", "lead_1_idle_3", "lead_1_idle_4", "lead_1_idle_5", "lead_1_idle_6", "lead_1_idle_7", "lead_1_idle_8"}, untimed = true}
}

PLUGIN.acts["lead_0_sleep_idle_0"] = { --Спать, сидя на стуле (Лидер)
	["stalker"] = {sequence = "lead_0_sleep_idle_0", untimed = true}
}

PLUGIN.acts["lead_1_bar_idle_0"] = { --Облокотиться о стол (Лидер)
	["stalker"] = {sequence = "lead_1_bar_idle_0", untimed = true}
}

PLUGIN.acts["metering_anomalys_1_idle_1"] = { --Сканировать аномалию, пригнувшись
	["stalker"] = {sequence = {"metering_anomalys_1_idle_1", "metering_anomalys_1_idle_2", "metering_anomalys_1_idle_3", "metering_anomalys_1_idle_4", "metering_anomalys_1_idle_5", "metering_anomalys_1_idle_6"}, untimed = true}
}

PLUGIN.acts["metering_anomalys_0_idle_1"] = { --Сканировать аномалию стоя
	["stalker"] = {sequence = {"metering_anomalys_0_idle_1", "metering_anomalys_0_idle_2", "metering_anomalys_0_idle_3", "metering_anomalys_0_idle_4", "metering_anomalys_0_idle_5", "metering_anomalys_0_idle_6"}, untimed = true}
}

PLUGIN.acts["norm_talk_2_idle_0"] = { --Стоять с оружием на плече
	["stalker"] = {sequence = {"norm_talk_2_idle_0", "norm_talk_2_idle_1", "norm_talk_2_idle_2", "norm_talk_2_idle_3", "norm_talk_2_idle_4"}, untimed = true}
}

PLUGIN.acts["norm_panic_stand_0"] = { --Пригнуться, закрыв говоу руками
	["stalker"] = {sequence = "norm_panic_stand_0", untimed = true}
}

PLUGIN.acts["ohrana_0"] = { --Охранять
	["stalker"] = {sequence = "ohrana_0", untimed = true}
}

PLUGIN.acts["otzhim"] = { --Отжиматься
	["stalker"] = {sequence = "otzhim", untimed = true}
}

PLUGIN.acts["prisoner_0_sit_idle_0"] = { --Находиться в заложниках
	["stalker"] = {sequence = "prisoner_0_sit_idle_0", untimed = true}
}

PLUGIN.acts["prisyad"] = { --Присядать
	["stalker"] = {sequence = "prisyad", untimed = true}
}

PLUGIN.acts["idle_0_to_psy_0"] = { --Находиться под воздействием ПСИ
	["stalker"] = {sequence = {"idle_0_to_psy_0", "idle_0_to_psy_1", "psy_0_idle_0", "psy_0_idle_1", "psy_0_idle_2", "psy_0_idle_3", "psy_0_idle_4"}, untimed = true}
}

PLUGIN.acts["racya_2_talk_0"] = { --Говорить по рации
	["stalker"] = {sequence = "racya_2_talk_0", untimed = true}
}

PLUGIN.acts["sit_2_idle_0"] = { --Сидеть на копчике
	["stalker"] = {sequence = {"sit_2_idle_0", "sit_2_idle_1", "sit_2_idle_2", "sit_2_idle_3"}, untimed = true}
}

PLUGIN.acts["sit_0_idle_1"] = { --Сидеть
	["stalker"] = {sequence = "sit_0_idle_1", untimed = true}
}

PLUGIN.acts["sleep_idle_0"] = { --Спать полулежа
	["stalker"] = {sequence = {"sleep_idle_0", "sleep_idle_1", "sleep_idle_2"}, untimed = true}
}

PLUGIN.acts["spit"] = { --Спать на копчике
	["stalker"] = {sequence = "spit", untimed = true}
}

PLUGIN.acts["trans_1_idle_0"] = { --Находиться в трансе
	["stalker"] = {sequence = {"trans_1_idle_0", "trans_0_idle_0"}, untimed = true}
}

PLUGIN.acts["animpoint_stay_table_idle_rnd_1"] = { --Облокотиться о стол
	["stalker"] = {sequence = {"animpoint_stay_table_idle_rnd_1", "animpoint_stay_table_idle_rnd_2", "animpoint_stay_table_idle_rnd_3", "animpoint_stay_table_idle_rnd_4", "animpoint_stay_table_idle_rnd_5"}, untimed = true}
}

PLUGIN.acts["animpoint_stay_wall_visual"] = { --Облокотиться о стену
	["stalker"] = {sequence = "animpoint_stay_wall_visual", untimed = true}
}

PLUGIN.acts["bar_1_idle_0"] = { --Облокотиться боком о стол
	["stalker"] = {sequence = {"bar_1_idle_0", "bar_1_idle_1", "bar_1_idle_2", "bar_1_idle_3"}, untimed = true}
}

PLUGIN.acts["bar_2_idle_0"] = { --Облокотиться о стол (задумчиво)
	["stalker"] = {sequence = "bar_2_idle_0", untimed = true}
}

PLUGIN.acts["bar_3_idle_0"] = { --Облокотиться о стол, дремая
	["stalker"] = {sequence = "bar_3_idle_0", untimed = true}
}

PLUGIN.acts["idle_band_0"] = { --Стоять с руками в карманах
	["stalker"] = {sequence = {"idle_band_0", "idle_band_1", "idle_band_2", "idle_band_3", "idle_band_4"}, untimed = true}
}

PLUGIN.acts["idle_ban_2_0"] = { --Стоять с поднятым оружием
	["stalker"] = {sequence = {"idle_ban_2_0", "idle_ban_2_1", "idle_ban_2_2", "idle_ban_2_3"}, untimed = true}
}

PLUGIN.acts["chest_0"] = { --Стоять смирно
	["stalker"] = {sequence = "chest_0", untimed = true}
}

PLUGIN.acts["chest_1"] = { --Отдать честь
	["stalker"] = {sequence = "chest_1", untimed = false}
}

PLUGIN.acts["cr_torso_0_check_corps_0"] = { --Осмотреть тело
	["stalker"] = {sequence = "cr_torso_0_check_corps_0", untimed = true}
}

PLUGIN.acts["dinamit_0"] = { --Разжигать костер
	["stalker"] = {sequence = {"dinamit_0", "dinamit_1"}, untimed = false}
}

PLUGIN.acts["gop_stop_1"] = { --Приказывать подойти
	["stalker"] = {sequence = {"gop_stop_1", "gop_stop_2", "gop_stop_3"}, untimed = true}
}

PLUGIN.acts["hand_up_0"] = { --Поднять руки
	["stalker"] = {sequence = "hand_up_0", untimed = true}
}

PLUGIN.acts["hello_0_idle_0"] = { --Приветствовать
	["stalker"] = {sequence = {"hello_0_idle_0", "hello_1_idle_0", "hello_2_idle_0"}, untimed = true}
}

PLUGIN.acts["waunded_1_idle_0"] = { --Лежать раненным
	["stalker"] = {sequence = "waunded_1_idle_0", untimed = true}
}

PLUGIN.acts["uhodi_1_0"] = { --Требовать убрать оружие
	["stalker"] = {sequence = {"uhodi_1_0", "uhodi_2_0"}, untimed = true}
}

PLUGIN.acts["torso_2_draw_0"] = { --Передернуть затвор
	["stalker"] = {sequence = "torso_2_draw_0", untimed = false}
}

PLUGIN.acts["sleep_1_idle_0"] = { --Спать на земле
	["stalker"] = {sequence = "sleep_1_idle_0", untimed = true}
}

PLUGIN.acts["free_facer_0"] = { --Бить кулаками
	["stalker"] = {sequence = "free_facer_0", untimed = true}
}

PLUGIN.acts["free_facer_1"] = { --Бить прикладом
	["stalker"] = {sequence = "free_facer_1", untimed = true}
}