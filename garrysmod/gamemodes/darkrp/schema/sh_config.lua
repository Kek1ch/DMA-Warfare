nut.anim.stalker = {
	normal = {
		[ACT_MP_STAND_IDLE] = {"idle_0_idle_1"},
		[ACT_MP_CROUCH_IDLE] = {"cr_torso_0_aim_0", "cr_torso_0_aim_0"},
		[ACT_MP_WALK] = {"walk_test", "walk_test_a"},
		[ACT_MP_CROUCHWALK] = {"walk_test_cr", "walk_test_cr"},
		[ACT_MP_RUN] = {"run_test_nowep", "run_test_nowep_a"}
	},
	pistol = {
		[ACT_MP_STAND_IDLE] = {"norm_torso_1_idle_0", "norm_torso_1_aim_1"},
		[ACT_MP_CROUCH_IDLE] = {"cr_idle_1_0", "cr_torso_1_aim_0"},
		[ACT_MP_WALK] = {"walk_test_pr", "walk_test_pa"},
		[ACT_MP_CROUCHWALK] = {"walk_test_crp", "walk_test_crp"},
		[ACT_MP_RUN] = {"run_test_pr", "run_test_pa"},
		attack = ACT_GESTURE_RANGE_ATTACK_PISTOL,
		reload = ACT_RELOAD_PISTOL
	},
	smg = {
		[ACT_MP_STAND_IDLE] = {"norm_torso_9_idle_0", "norm_torso_2_aim_0"},
		[ACT_MP_CROUCH_IDLE] = {"cr_idle_9_0", "cr_torso_8_aim_0"},
		[ACT_MP_WALK] = {"walk_test_gr", "walk_test_ga"},
		[ACT_MP_CROUCHWALK] = {"walk_test_crg", "walk_test_crg"},
		[ACT_MP_RUN] = {"run_test_gr", "run_test_ga"},
		attack = ACT_GESTURE_RANGE_ATTACK_SMG1,
		reload = ACT_GESTURE_RELOAD_SMG1
	},
	shotgun = {
		[ACT_MP_STAND_IDLE] = {"norm_torso_3_idle_0", "norm_torso_3_aim_0"},
		[ACT_MP_CROUCH_IDLE] = {"cr_torso_3_aim_0", "cr_torso_3_aim_0"},
		[ACT_MP_WALK] = {"walk_test_sr", "walk_test_sa"},
		[ACT_MP_CROUCHWALK] = {"walk_test_crs", "walk_test_crs"},
		[ACT_MP_RUN] = {"run_test_sr", "run_test_sa"},
		attack = ACT_GESTURE_RANGE_ATTACK_SHOTGUN
	},
	grenade = {
		[ACT_MP_STAND_IDLE] = {"norm_torso_9_idle_0", "norm_torso_9_aim_0"},
		[ACT_MP_CROUCH_IDLE] = {"cr_torso_9_aim_0", "cr_torso_9_aim_0"},
		[ACT_MP_WALK] = {"walk_test_shotr", "walk_test_shota"},
		[ACT_MP_CROUCHWALK] = {"walk_test_crg", "walk_test_crg"},
		[ACT_MP_RUN] = {"run_test_shotr", "run_test_shota"},
		attack = ACT_RANGE_ATTACK_THROW
	},
	melee = {
		[ACT_MP_STAND_IDLE] = {"norm_torso_7_aim_0", "norm_torso_7_aim_0"},
		[ACT_MP_CROUCH_IDLE] = {"cr_torso_0_aim_0", "cr_torso_0_aim_0"},
		[ACT_MP_WALK] = {"walk_test", "walk_test_a"},
		[ACT_MP_CROUCHWALK] = {"walk_test_cr", "walk_test_cr"},
		[ACT_MP_RUN] = {"run_test_nowep", "run_test_nowep_a"},
		attack = ACT_MELEE_ATTACK_SWING
	},
	glide = ACT_GLIDE,
	vehicle = {
		chair = {"animpoint_sit_normal_drink_idle_0", Vector(0, 0, 0)}, 
		["prop_vehicle_jeep"] = {"steering_idle", Vector(0, 0, 0)}, 
		["prop_vehicle_prisoner_pod"] = {"animpoint_sit_normal_idle_rnd_1"} --animpoint_sit_normal_idle_rnd_1  lead_0_idle_0
	}
}

nut.anim.zombie = {
	normal = {
		[ACT_MP_STAND_IDLE] = {"idle_0_idle_"..math.random(0, 4), "idle_0_idle_"..math.random(0, 4)},
		[ACT_MP_WALK] = {"norm_torso_0_walk_0", "norm_torso_0_walk_0"},
	},
	pistol = {
		[ACT_MP_STAND_IDLE] = {"idle_1_idle_"..math.random(0, 4), "norm_torso_1_aim_0"},
		[ACT_MP_WALK] = {"norm_torso_1_walk_0", "norm_torso_1_aim_walk"},
		attack = ACT_GESTURE_RANGE_ATTACK_PISTOL,
		reload = ACT_GESTURE_RELOAD_PISTOL
	},
	smg = {
		[ACT_MP_STAND_IDLE] = {"idle_2_idle_"..math.random(0, 4), "norm_torso_2_aim_0"},
		[ACT_MP_WALK] = {"norm_torso_2_walk_0", "norm_torso_2_aim_fwd"},
		attack = ACT_GESTURE_RANGE_ATTACK_SMG1,
		reload = ACT_GESTURE_RELOAD_SMG1
	},
	shotgun = {
		[ACT_MP_STAND_IDLE] = {"idle_3_idle_"..math.random(0, 4), "norm_torso_3_aim_0"},
		[ACT_MP_WALK] = {"norm_torso_3_walk_0", "norm_torso_3_aim_1"},
		attack = ACT_GESTURE_RANGE_ATTACK_SHOTGUN,
		reload = ACT_GESTURE_RELOAD_SHOTGUN
	},
	grenade = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE_SMG1_RELAXED, "idle_gun_aim_0"},
		[ACT_MP_WALK] = {"norm_torso_2_walk_0", "walk_gun_0"},
		attack = ACT_RANGE_ATTACK_SMG1,
		reload = ACT_GESTURE_RELOAD_SMG1
	},
	melee = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE_SMG1_RELAXED, "idle_gun_aim_0"},
		[ACT_MP_WALK] = {"norm_torso_2_walk_0", "walk_gun_0"},
		attack = ACT_RANGE_ATTACK_SMG1,
		reload = ACT_GESTURE_RELOAD_SMG1
	},
	glide = ACT_GLIDE
}

nut.anim.izlom = {
	normal = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "stand_idle_dmg_0"},
		[ACT_MP_CROUCH_IDLE] = {"sit_idle_0", "sit_idle_1"},
		[ACT_MP_WALK] = {ACT_WALK,  "stand_walk_fwd_dmg_0"},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, "stand_walk_fwd_dmg_0"},
		[ACT_MP_RUN] = {ACT_RUN, "stand_run_dmg_0"}
	},
	pistol = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "stand_idle_dmg_0"},
		[ACT_MP_CROUCH_IDLE] = {"sit_idle_0", "sit_idle_1"},
		[ACT_MP_WALK] = {ACT_WALK,  "stand_walk_fwd_dmg_0"},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, "stand_walk_fwd_dmg_0"},
		[ACT_MP_RUN] = {ACT_RUN, "stand_run_dmg_0"},
		attack = ACT_GESTURE_RANGE_ATTACK_PISTOL,
		reload = ACT_RELOAD_PISTOL
	},
	smg = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "stand_idle_dmg_0"},
		[ACT_MP_CROUCH_IDLE] = {"sit_idle_0", "sit_idle_1"},
		[ACT_MP_WALK] = {ACT_WALK,  "stand_walk_fwd_dmg_0"},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, "stand_walk_fwd_dmg_0"},
		[ACT_MP_RUN] = {ACT_RUN, "stand_run_dmg_0"},
		reload = ACT_GESTURE_RELOAD_SMG1
	},
	shotgun = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "stand_idle_dmg_0"},
		[ACT_MP_CROUCH_IDLE] = {"sit_idle_0", "sit_idle_1"},
		[ACT_MP_WALK] = {ACT_WALK,  "stand_walk_fwd_dmg_0"},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, "stand_walk_fwd_dmg_0"},
		[ACT_MP_RUN] = {ACT_RUN, "stand_run_dmg_0"},
		attack = "shoot_shotgun"
	},
	grenade = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "stand_idle_dmg_0"},
		[ACT_MP_CROUCH_IDLE] = {"sit_idle_0", "sit_idle_1"},
		[ACT_MP_WALK] = {ACT_WALK,  "stand_walk_fwd_dmg_0"},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, "stand_walk_fwd_dmg_0"},
		[ACT_MP_RUN] = {ACT_RUN, "stand_run_dmg_0"},
		attack = ACT_RANGE_ATTACK_THROW
	},
	melee = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "stand_idle_dmg_0"},
		[ACT_MP_CROUCH_IDLE] = {"sit_idle_0", "sit_idle_1"},
		[ACT_MP_WALK] = {ACT_WALK,  "stand_walk_fwd_dmg_0"},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, "stand_walk_fwd_dmg_0"},
		[ACT_MP_RUN] = {ACT_RUN, "stand_run_dmg_0"},
		attack = ACT_MELEE_ATTACK_SWING
	},
	glide = ACT_GLIDE
}


nut.anim.setModelClass("models/spenser/kek1ch/new_izlom_spen.mdl", "izlom")
nut.anim.setModelClass("models/hdmodels/kek1ch/new_izlom_spen.mdl", "izlom")

nut.anim.setModelClass("models/spenser/kek1ch/stalker_zombie1.mdl", "zombie")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_zombie2.mdl", "zombie")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_zombie2.mdl", "zombie")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_zombie4.mdl", "zombie")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_zombie7.mdl", "zombie")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_zombie8.mdl", "zombie")
nut.anim.setModelClass("models/spenser/kek1ch/zombie_fresh_0.mdl", "zombie")

nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_zombie1.mdl", "zombie")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_zombie2.mdl", "zombie")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_zombie2.mdl", "zombie")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_zombie4.mdl", "zombie")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_zombie7.mdl", "zombie")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_zombie8.mdl", "zombie")
nut.anim.setModelClass("models/hdmodels/kek1ch/zombie_fresh_0.mdl", "zombie")

nut.anim.setModelClass("models/spenser/ssk/new_zomb_02_spen.mdl", "zombie")
nut.anim.setModelClass("models/spenser/ssk/new_test.mdl", "stalker")

nut.anim.setModelClass("models/spenser/kek1ch/soldier_mask_donbass.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/soldier_obichniy_urkain_warrior.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/bandit1a_mask.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/soldier_spetsnaz_wtyrmyem_vawix_mam.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_band2a_mask.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_band_2_mask.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit1a.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit1a_gas.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit_3_face_1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit1b.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit1c.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit1c_gas.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit1c_mask.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit2a.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit2a_mask.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit2a_old.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit3a.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit3b.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit4a.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit_1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit_1_gas.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit_1_mask.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit_2a.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit_2a_gp5.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit_2a_merc.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit_3.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit_4.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit_a.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit_exo.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandit_tr.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandita1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandita2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bandita3.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_bar_security.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_do_balon_1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_do_balon_3.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_do_komandir.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_dolg2a.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_dolg2a_mas2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_dolg2a_mas3.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_dolg2a_mas4.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_dolg2a_mask.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_dolg2a_old.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_dolg_0.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_dolg_2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_dolg_2_mas2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_dolg_2_mas4.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_dolg_2_old.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_dolg_exoskeleton.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_dolg_mehanik.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_dolg_nauchniy.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_dolggas2a.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_dolggas_2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_ecolog.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_ecolog_blue.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_ecolog_brown.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_ecolog_guard.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_ecolog_military.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_ecolog_white.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_ecolog_yellow.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom1a.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom2a.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom2a_mas2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom2a_mas3.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom2a_mas4.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom2b.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom2b_mas2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom2b_mas4.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom2b_mas3.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom2b_mask.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom2b_old.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom3a.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom_0.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom_1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom_2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom_2_face_2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom_2_mas2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom_2_mas4.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom_2_old.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom_3.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom_3_face_1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_freedom_4_face_1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_izgoy.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_ki_exoskeleton.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_ki_head_2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_ki_nauchniy.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_merc2a.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_merc2b.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_merc2c.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_merc_0.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_merc_2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_merc_2_face_2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_merc_sun1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_merc_sun1_old.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_mercen2a_mask.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_mercen2b_mask.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_mercen_2_mask.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_militari_1_new.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_militari_antigas_2_new.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_mo_exo.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_monolith1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_monolith1_gp5.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_monolith1b.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_monolith2a_old.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_monolith_0.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_monolith_1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_monolith_2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral0a.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral0c.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral1a.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral2c.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral2gmask2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral_1_face_2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral_1_face_2_hq.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral_1_hq.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral_1_mas2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral_1_mask.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral_2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral_2_face_1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral_2_face_7.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral_2_gp5.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral_2_mas2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral_2_mask.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral_2_merc.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral_2_old.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral_3_face_1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral_a.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutral_nauchniy_face_3.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutrala1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutrala4.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutrala5.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neutrala6.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neytral_balon_1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neytral_exoskeleton.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neytral_nauchniy.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_neytral_rukzak_3.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_soldier1b.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_soldier1c.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_soldier1d.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_soldier1e.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_soldier1f.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_soldier1f.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_soldier3a_beret.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_soldier3b_beret.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_soldier3c_beret.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_soldier_1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_soldier_2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_soldier_3_beret.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_soldier_5_beret.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_sv_balon_1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_sv_cook.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_sv_exoskeleton.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_sv_leader.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_sv_nauchniy.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/renegat_kek1ch_plash.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/renegat_kek1ch_kurtka.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/renegat_normal_kek1ch.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/monolit_pp_vadim.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/nato_seva_vadim.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/nato_soldier_obichniy_vadim.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/nato_soldier_spetsnaz_vadim.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/nato_exo_vadim.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/sbu_stalker_militari_antigas_2_vadim.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/sbu_stalker_militari_1_vadim.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/lastday_stalker_1_vadim.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/lastday_stalker_2_vadim.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/lastday_stalker_3_vadim.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/lastday_stalker_4_vadim.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/lastday_stalker_exo_vadim.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/lastday_stalker_seva_vadim.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/podpiwek_baz_baz_1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_likemilitary_final.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_nebo_1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_nebo_2.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/stalker_nebo_3.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/renegat_test_exo_1.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/new_barman_spen.mdl", "stalker")
nut.anim.setModelClass("models/spenser/kek1ch/aaa_dolg.mdl", "stalker")

----------------------------
--Широфванный путь
----------------------------
nut.anim.setModelClass("models/hdmodels/kek1ch/soldier_mask_donbass.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/soldier_obichniy_urkain_warrior.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/bandit1a_mask.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/soldier_spetsnaz_wtyrmyem_vawix_mam.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_band2a_mask.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_band_2_mask.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit1a.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit1a_gas.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit_3_face_1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit1b.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit1c.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit1c_gas.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit1c_mask.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit2a.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit2a_mask.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit2a_old.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit3a.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit3b.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit4a.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit_1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit_1_gas.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit_1_mask.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit_2a.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit_2a_gp5.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit_2a_merc.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit_3.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit_4.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit_a.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit_exo.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandit_tr.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandita1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandita2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bandita3.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_bar_security.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_do_balon_1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_do_balon_3.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_do_komandir.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_dolg2a.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_dolg2a_mas2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_dolg2a_mas3.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_dolg2a_mas4.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_dolg2a_mask.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_dolg2a_old.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_dolg_0.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_dolg_2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_dolg_2_mas2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_dolg_2_mas4.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_dolg_2_old.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_dolg_exoskeleton.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_dolg_mehanik.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_dolg_nauchniy.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_dolggas2a.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_dolggas_2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_ecolog.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_ecolog_blue.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_ecolog_brown.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_ecolog_guard.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_ecolog_military.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_ecolog_white.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_ecolog_yellow.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom1a.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom2a.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom2a_mas2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom2a_mas3.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom2a_mas4.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom2b.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom2b_mas2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom2b_mas4.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom2b_mas3.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom2b_mask.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom2b_old.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom3a.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom_0.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom_1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom_2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom_2_face_2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom_2_mas2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom_2_mas4.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom_2_old.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom_3.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom_3_face_1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_freedom_4_face_1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_izgoy.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_ki_exoskeleton.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_ki_head_2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_ki_nauchniy.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_merc2a.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_merc2b.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_merc2c.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_merc_0.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_merc_2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_merc_2_face_2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_merc_sun1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_merc_sun1_old.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_mercen2a_mask.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_mercen2b_mask.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_mercen_2_mask.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_militari_1_new.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_militari_antigas_2_new.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_mo_exo.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_monolith1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_monolith1_gp5.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_monolith1b.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_monolith2a_old.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_monolith_0.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_monolith_1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_monolith_2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral0a.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral0c.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral1a.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral2c.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral2gmask2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral_1_face_2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral_1_face_2_hq.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral_1_hq.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral_1_mas2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral_1_mask.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral_2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral_2_face_1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral_2_face_7.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral_2_gp5.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral_2_mas2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral_2_mask.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral_2_merc.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral_2_old.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral_3_face_1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral_a.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutral_nauchniy_face_3.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutrala1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutrala4.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutrala5.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neutrala6.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neytral_balon_1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neytral_exoskeleton.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neytral_nauchniy.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_neytral_rukzak_3.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_soldier1b.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_soldier1c.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_soldier1d.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_soldier1e.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_soldier1f.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_soldier1f.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_soldier3a_beret.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_soldier3b_beret.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_soldier3c_beret.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_soldier_1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_soldier_2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_soldier_3_beret.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_soldier_5_beret.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_sv_balon_1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_sv_cook.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_sv_exoskeleton.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_sv_leader.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_sv_nauchniy.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/renegat_kek1ch_plash.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/renegat_kek1ch_kurtka.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/renegat_normal_kek1ch.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/monolit_pp_vadim.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/nato_seva_vadim.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/nato_soldier_obichniy_vadim.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/nato_soldier_spetsnaz_vadim.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/nato_exo_vadim.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/sbu_stalker_militari_antigas_2_vadim.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/sbu_stalker_militari_1_vadim.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/lastday_stalker_1_vadim.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/lastday_stalker_2_vadim.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/lastday_stalker_3_vadim.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/lastday_stalker_4_vadim.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/lastday_stalker_exo_vadim.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/lastday_stalker_seva_vadim.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/podpiwek_baz_baz_1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_likemilitary_final.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_nebo_1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_nebo_2.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/stalker_nebo_3.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/renegat_test_exo_1.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/new_barman_spen.mdl", "stalker")
nut.anim.setModelClass("models/hdmodels/kek1ch/aaa_dolg.mdl", "stalker")
