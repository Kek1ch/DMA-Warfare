AddCSLuaFile()
AddCSLuaFile("client/cop_client.lua")

stalker_cop = stalker_cop or {}
stalker_cop.CrosshairEnabled = CreateConVar("cop_crosshair_enabled", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE})

game.AddParticles("particles/cop_particles_gauss.pcf")
game.AddParticles("particles/cop_particles_explosion.pcf")

PrecacheParticleSystem("cop_gauss_rail")
PrecacheParticleSystem("cop_rgd_explosion")

COP_WEPSTATE_NONE = 0
COP_WEPSTATE_AIMING = 1
COP_WEPSTATE_RELOADING = 2
COP_WEPSTATE_HOLSTERING = 3
COP_WEPSTATE_THROWING = 4

stalker_cop.Addons = {
	["scope_pso"]   = { name = "PSO-1 Scope", type = "scope"    },
	["scope_susat"] = { name = "SUSAT Scope", type = "scope"    },
	["silencer"]    = { name = "Silencer",    type = "silencer" }
}

for k, v in pairs(stalker_cop.Addons) do
	v.cvar = CreateConVar("cop_upgrade_" .. k, 1, true, false)

	if CLIENT then
		language.Add("COP_ADDON_" .. string.upper(k), v.name)
	end
end

if CLIENT then
	stalker_cop.HandType = CreateClientConVar("cop_hands",   0, true, true)
	stalker_cop.HandTex  = CreateClientConVar("cop_handtex", 1, true, true)

	stalker_cop.DynamicCrosshair = CreateClientConVar("cop_crosshair_dynamic", 1, true, true)

	stalker_cop.ModelManager = {}
	stalker_cop.ModelManager.ActiveModels = {}

	function stalker_cop.ModelManager:CreateModel(modelname, ent)
		local model = ClientsideModel(modelname, RENDERGROUP_VIEWMODEL_TRANSLUCENT)

		if model then
			model:SetNoDraw(true)
			model.entParent = ent

			table.insert(self.ActiveModels, model)
			return model
		end
	end

	function stalker_cop.ModelManager:Validate()
		local i = 1
		while i <= #self.ActiveModels do
			local model = self.ActiveModels[i]
			if not IsValid(model.entParent) then
				SafeRemoveEntity(model)
				table.remove(self.ActiveModels, i)
			else
				i = i + 1
			end
		end
	end

	timer.Create("stalker_cop.ModelManager", 5, 0, function()
		stalker_cop.ModelManager:Validate()
	end)

	local hands = { "models/weapons/wick/stcopwep/wpn_black_gloves_hands.mdl", "models/weapons/stalker_cop/v_hands_exo.mdl" }

	function stalker_cop.UpdatePlayerHands()
		local ply = LocalPlayer()

		local t   = stalker_cop.HandType:GetInt()
		local tex = stalker_cop.HandTex:GetInt()

		if IsValid(ply) then
			local handmodel = hands[math.Clamp(t, 1, #hands)]
			if handmodel then
				if ply.COP_Hands then
					SafeRemoveEntity(ply.COP_Hands)
				end

				ply.COP_Hands = stalker_cop.ModelManager:CreateModel(handmodel, ply)

				if IsValid(ply.COP_Hands) then
					local skinCount = ply.COP_Hands:SkinCount()
					ply.COP_Hands:SetSkin(math.Clamp(tex, 0, skinCount - 1))
				end
			end
		end
	end

	cvars.AddChangeCallback("cop_hands", function(cvar, old, new)
		stalker_cop.UpdatePlayerHands()
	end, "stalker_cop.cop_hands")

	cvars.AddChangeCallback("cop_handtex", function(cvar, old, new)
		stalker_cop.UpdatePlayerHands()
	end, "stalker_cop.cop_handtex")

	local td = {}
	function stalker_cop.DrawAmmoInfo()
		local ply = LocalPlayer()

		if IsValid(ply) and ply:Alive() then
			if ply:KeyDown(IN_USE) then
				local _ents = ents.FindInSphere(ply:GetPos(), 320)

				surface.SetFont("TargetID")
				surface.SetTextColor(255, 255, 255, 255)

				for i = 1, #_ents do
					local ent = _ents[i]

					if IsValid(ent) and ent.IsCOPEntity then
						td.start  = ply:EyePos()
						td.endpos = td.start + (ent:GetPos() - td.start):GetNormal() * 1024
						td.filter = ply

						local tr = util.TraceLine(td)
						if not tr.Hit or (tr.Entity == ent) then
							local pos = ent:GetPos()
							pos.z = pos.z + 20

							local screen = pos:ToScreen()
							if screen.visible then
								local w, h = surface.GetTextSize(ent.PrintName)

								surface.SetTextPos(screen.x - w * 0.5, screen.y - h * 0.5)
								surface.DrawText(ent.PrintName)
							end
						end
					end
				end
			end
		end
	end

	hook.Add("HUDPaint", "stalker_cop.DrawAmmoInfo", stalker_cop.DrawAmmoInfo)
end

local function AddSound(id, name)
	if istable(name) then
		for i = 1, #name do
			name[i] = "weapons/stalker_cop/" .. name[i] .. ".wav"
		end
	else
		name = "weapons/stalker_cop/" .. name .. ".wav"
	end

    sound.Add {
        name    = id,
        channel = CHAN_STATIC,
        volume  = 1,
        level   = 80,
        pitch   = { 96, 104 },
        sound   = name
    }
end

local function AddAmmoType(id, name, give_amount)
    game.AddAmmoType{ name = id, dmgtype = DMG_BULLET }

    if CLIENT then
        language.Add(id .. "_ammo", name)
    end

	local ENT = {}

	ENT.PrintName = name
	ENT.Base = "cop_ammo_base"
	ENT.Category = "Call of Pripyat - Ammo"
	ENT.Spawnable = true

	ENT.AmmoType = id
	ENT.GiveAmount = give_amount or 20

	local classname = string.lower(id) .. "_ammo"
	scripted_ents.Register(ENT, classname)
end

AddAmmoType("COP_545", "5.45x39mm Ammo", 30)
AddAmmoType("COP_556", "5.56x45mm Ammo", 30)
AddAmmoType("COP_9x19MM", "9x19mm Ammo", 20)
AddAmmoType("COP_9x18MM", "9x18mm Ammo", 20)
AddAmmoType("COP_9x39MM", "9x39mm Ammo", 20)
AddAmmoType("COP_12x70BUCK", "12x70 Buckshot", 12)
AddAmmoType("COP_762x54PP", "7.62x54mm PP Ammo", 20)
AddAmmoType("COP_762x42MMR", "7.62x54mmR Ammo", 20)
AddAmmoType("COP_45ACP", ".45 ACP Ammo", 20)
AddAmmoType("COP_RGD5", "RGD-5 Grenades", 3)
AddAmmoType("COP_F1", "F1 Grenades", 3)
AddAmmoType("COP_VOG25", "VOG-25 Grenades", 10)
AddAmmoType("COP_BATTERY", "Batteries", 10)
AddAmmoType("COP_PG7VL", "PG-7VL Warheads", 3)

AddSound("COP_Addon.Attach", "addon_attach")
AddSound("COP_Addon.Detach", "addon_detach")

AddSound("COP_Knife.Swing", {"knife_1", "knife_2", "knife_3"})
AddSound("COP_Knife.Hurt",  {"knife_hurt1", "knife_hurt2"})
AddSound("COP_Knife.Hit",    "knife_hit")

AddSound("COP_Generic.Draw",    "generic_draw_stcop")
AddSound("COP_Generic.Empty",   "generic_empty")
AddSound("COP_Generic.Reload",  "")
AddSound("COP_Generic.Holster", "generic_holster_stcop")

AddSound("COP_Pistol.Empty",  "pistol_empty")

AddSound("COP_AK74.Draw", "ak74_draw")
AddSound("COP_AK74.Fire", "n_ak74_shot")
AddSound("COP_AK74.Bore", "ak74_bore")
AddSound("COP_AK74.Sil",  "w_ak74_shot1")

AddSound("COP_AK74u.Fire", "n_ak74u_shot")

AddSound("COP_Bino.Draw",    "bino_draw")
AddSound("COP_Bino.Holster", "bino_holster")

AddSound("COP_Gauss.Fire",   "gauss_shoot")
AddSound("COP_Gauss.Reload", "gauss_reload")

AddSound("COP_PM.FireAPS", "aps_shoot")
AddSound("COP_PB.FireAPS", "aps_shot_sil")
AddSound("COP_Pistol.ReloadAPS", "aps_reload")

AddSound("COPSNPER.FireSVDSTCOP", "svd_shoot")
AddSound("COPSNPER.FireSVDSTCOPSILENS", "svd_shot_sil")
AddSound("COPSNPER.SVDDRAWSTCOP", "svd_draw")
AddSound("COPSNPER.SVDRELOADSTCOP", "svd_reload")

AddSound("COPMP5.SHOOTSTCOP", "mp5_shoot")
AddSound("COPMP5.SHOOTSILSTCOP", "mp5_shot_sil")
AddSound("COPMP5.RELOADSTCOP", "mp5_reload")
AddSound("COPMP5.EMPTSTCOP", "mp5_empty")
AddSound("COPMP5.DELPOY", "mp5_draw")

AddSound("COPGROZA.groza_draw", "groza_draw")
AddSound("COPGROZA.groza_reload", "groza_reload")
AddSound("COPGROZA.groza_shoot", "groza_shoot")
AddSound("COPGROZA.groza_shot_sil", "groza_shot_sil")

AddSound("COPBIZON.SHOOTSTCOP", "bizon_shoot")
AddSound("COPBIZON.SHOOTSILSTCOP", "bizon_shot_sil")
AddSound("COPBIZON.RELOADSTCOP", "bizon_reload")

AddSound("COPFN2000.fn2000_draw", "fn2000_draw")
AddSound("COPFN2000.fn2000_empty", "fn2000_empty")
AddSound("COPFN2000.fn2000_reload", "fn2000_reload")
AddSound("COPFN2000.fn2000_shoot", "fn2000_shoot")
AddSound("COPFN2000.fn2000_shot_sil", "fn2000_shot_sil")

AddSound("COPP99.walther_draw", "walther_draw")
AddSound("COPP99.walther_empty", "walther_empty")
AddSound("COPP99.walther_reload", "walther_reload")
AddSound("COPP99.walther_shoot", "walther_shoot")
AddSound("COPP99.walther_shot_sil", "walther_shot_sil")

AddSound("COPPKM.pkm_draw", "pkm_draw")
AddSound("COPPKM.pkm_empty", "pkm_empty")
AddSound("COPPKM.pkm_holster", "pkm_holster")
AddSound("COPPKM.pkm_reload", "pkm_reload")
AddSound("COPPKM.pkm_shoot", "pkm_shoot")

AddSound("COPDEAGLE.de_draw", "de_draw")
AddSound("COPDEAGLE.de_empty", "de_empty")
AddSound("COPDEAGLE.de_reload", "de_reload")
AddSound("COPDEAGLE.de_shoot", "de_shoot")
AddSound("COPDEAGLE.de_shot_sil", "de_shot_sil")

AddSound("COPCOLT.colt_draw", "colt_draw")
AddSound("COPCOLT.colt_empty", "colt_empty")
AddSound("COPCOLT.de_reload", "de_reload")
AddSound("COPCOLT.colt_shot_sil", "colt_shot_sil")
AddSound("COPCOLT.colt_shoot", "colt_shoot")

AddSound("COPUSP.usp_draw", "usp_draw")
AddSound("COPUSP.usp_empty", "usp_empty")
AddSound("COPUSP.usp_reload", "usp_reload")
AddSound("COPUSP.usp_shoot", "usp_shoot")
AddSound("COPUSP.usp_shot_sil", "usp_shot_sil")

AddSound("COPLR300.lr300_draw", "lr300_draw")
AddSound("COPLR300.lr300_empty", "lr300_empty")
AddSound("COPLR300.lr300_reload", "lr300_reload")
AddSound("COPLR300.lr300_shoot", "lr300_shoot")
AddSound("COPLR300.lr300_shot_sil", "lr300_shot_sil")

AddSound("COPHK416STCOP.hk416_reload", "hk416_reload")

AddSound("COPSPAS.spas12_reload_end", "spas12_reload_end")
AddSound("COPSPAS.spas12_holster", "spas12_holster")
AddSound("COPSPAS.spas12_draw", "spas12_draw")
AddSound("COPSPAS.spas12_empty", "spas12_empty")
AddSound("COPSPAS.spas12_load", "spas12_load")
AddSound("COPSPAS.spas12_open", "spas12_open")
AddSound("COPSPAS.spas12_shoot", "spas12_shoot")

AddSound("COPPROTECTA.protecta_draw", "protecta_draw")
AddSound("COPPROTECTA.protecta_empty", "protecta_empty")
AddSound("COPPROTECTA.protecta_load", "protecta_load")
AddSound("COPPROTECTA.protecta_open", "protecta_open")
AddSound("COPPROTECTA.protecta_shoot", "protecta_shoot")
AddSound("COPPROTECTA.protecta_close", "protecta_close")
AddSound("COPPROTECTA.protecta_open", "protecta_open")

AddSound("COPRPGSTCOP.rpg7_shoot", "rpg7_shoot")
AddSound("COPRPGSTCOP.rpg7_reload", "rpg7_reload")
AddSound("COPRPGSTCOP.rpg7_explode", "rpg7_explode")
AddSound("COPRPGSTCOP.rpg7_shot", "rpg7_shot")
AddSound("COPRPGSTCOP.rpg7_draw", "rpg7_draw")
AddSound("COPRPGSTCOP.rpg7_empty", "rpg7_empty")

AddSound("COPRG6.rg6_close", "rg6_close")
AddSound("COPRG6.rg6_draw", "rg6_draw")
AddSound("COPRG6.rg6_empty", "rg6_empty")
AddSound("COPRG6.rg6_shoot", "rg6_shoot")
AddSound("COPRG6.rg6_reload", "rg6_reload")
AddSound("COPRG6.rg6_open", "rg6_open")

AddSound("COPPM.pm_close", "pm_close")
AddSound("COPPM.pm_draw", "pm_draw")
AddSound("COPPM.pm_empty", "pm_empty")
AddSound("COPPM.pm_reload", "pm_reload")
AddSound("COPPM.pm_shoot", "pm_shoot")
AddSound("COPPM.pm_shot_sil", "pm_shot_sil")

AddSound("COPSG550.sig550_draw", "sig550_draw")
AddSound("COPSG550.sig550_empty", "sig550_empty")
AddSound("COPSG550.sig550_reload", "sig550_reload")
AddSound("COPSG550.sig550_shoot", "sig550_shoot")
AddSound("COPSG550.sig550_shot_sil", "sig550_shot_sil")

AddSound("COPLR85.l85_reload", "l85_reload")
AddSound("COPLR85.l85_draw", "l85_draw")
AddSound("COPLR85.l85_empty", "l85_empty")
AddSound("COPLR85.l85_shot_sil", "l85_shot_sil")
AddSound("COPLR85.l85_shoot", "l85_shoot")

AddSound("COPAEK.aek971_reload", "aek971_reload")
AddSound("COPAEK.aek971_shoot", "aek971_shoot")

AddSound("COPAK74.ak74_shot_sil", "ak74_shot_sil")
AddSound("COPAK74.ak_draw", "ak_draw")

AddSound("COPSAIGA.saiga_reload", "saiga_reload")
AddSound("COPSAIGA.saiga_shoot", "saiga_shoot")
AddSound("COPSAIGA.saiga_shot_sil", "saiga_shot_sil")

AddSound("COPBERETASTCOP.beretta_shot_sil", "beretta_shot_sil")
AddSound("COPBERETASTCOP.beretta_reload", "beretta_reload")
AddSound("COPBERETASTCOP.beretta_shoot", "beretta_shoot")
AddSound("COPBERETASTCOP.beretta_draw", "beretta_draw")
AddSound("COPBERETASTCOP.beretta_empty", "beretta_empty")

AddSound("COPVSSSTCOP.vintorez_draw", "vintorez_draw")
AddSound("COPVSSSTCOP.vintorez_empty", "vintorez_empty")
AddSound("COPVSSSTCOP.vintorez_reload", "vintorez_reload")
AddSound("COPVSSSTCOP.vintorez_shoot", "vintorez_shoot")

AddSound("COPSCARSTCOP.scar_reload", "scar_reload")
AddSound("COPSCARSTCOP.scar_shoot", "scar_shoot")
AddSound("COPSCARSTCOP.scar_shot_sil", "scar_shot_sil")

AddSound("COPFNPSTCOP.fnp45_draw", "fnp45_draw")
AddSound("COPFNPSTCOP.fnp45_reload", "fnp45_reload")
AddSound("COPFNPSTCOP.fnp45_shoot", "fnp45_shoot")
AddSound("COPFNPSTCOP.fnp45_shot_sil", "fnp45_shot_sil")

AddSound("COPMOSINSTCOP.mosin_reload1", "mosin_reload1")
AddSound("COPMOSINSTCOP.mosin_shoot_sound", "mosin_shoot_conv")

AddSound("COPGLOCKSTCOP.glock_reload", "glock_reload")
AddSound("COPGLOCKSTCOP.glock_shoot", "glock_shoot")
AddSound("COPGLOCKSTCOP.glock_shot_sil", "glock_shot_sil")

AddSound("COPSV98STCOP.sv98_draw", "sv98_draw")
AddSound("COPSV98STCOP.sv98_reload", "sv98_reload")
AddSound("COPSV98STCOP.sv98_empty", "sv98_empty")
AddSound("COPSV98STCOP.sv98_shoot", "sv98_shoot")

AddSound("COPL96STCOP.l96a1_reload", "l96a1_reload")
AddSound("COPL96STCOP.l96a1_shoot", "l96a1_shoot")

AddSound("COPVALSTCOP.val_draw", "val_draw")
AddSound("COPVALSTCOP.val_empty", "val_empty")
AddSound("COPVALSTCOP.val_reload", "val_reload")
AddSound("COPVALSTCOP.val_shoot", "val_shoot")

AddSound("COPG36SCOP.g36_draw", "g36_draw")
AddSound("COPG36SCOP.g36_empty", "g36_empty")
AddSound("COPG36SCOP.g36_holster", "g36_holster")
AddSound("COPG36SCOP.g36_reload_stcop", "g36_reload_stcop")
AddSound("COPG36SCOP.g36_shoot", "g36_shoot")
AddSound("COPG36SCOP.g36_shot_sil", "g36_shot_sil")

AddSound("COPAK_74SCOP.ak74_draw_stcop", "ak74_draw_stcop")
AddSound("COPAK_74SCOP.ak74_holster", "ak74_holster")
AddSound("COPAK_74SCOP.ak74_reload", "ak74_reload")
AddSound("COPAK_74SCOP.ak74_shoot", "ak74_shoot")
AddSound("COPAK_74SCOP.ak74_shot_sil_stcop", "ak74_shot_sil_stcop")


AddSound("COPFORTSCOP.fort_draw", "fort_draw")
AddSound("COPFORTSCOP.fort_empty", "fort_empty")
AddSound("COPFORTSCOP.fort_reload", "fort_reload")
AddSound("COPFORTSCOP.fort_shoot", "fort_shoot")
AddSound("COPFORTSCOP.fort_shot_sil", "fort_shot_sil")

AddSound("COPBINOSCOP.bino_draw_stcop", "bino_draw_stcop")
AddSound("COPBINOSCOP.bino_holster", "bino_holster")

AddSound("COPBROWINGSCOP.hpsa_shot_sil", "hpsa_shot_sil")
AddSound("COPBROWINGSCOP.hpsa_draw", "hpsa_draw")
AddSound("COPBROWINGSCOP.hpsa_empty", "hpsa_empty")
AddSound("COPBROWINGSCOP.hpsa_reload", "hpsa_reload")
AddSound("COPBROWINGSCOP.hpsa_shoot", "hpsa_shoot")

AddSound("COPRPKSCOP.rpk74_reload", "rpk74_reload")
AddSound("COPRPKSCOP.rpk74_shoot", "rpk74_shoot")

AddSound("COPSVUSCOP.svu_draw", "svu_draw")
AddSound("COPSVUSCOP.svu_reload_stcop", "svu_reload_stcop")
AddSound("COPSVUSCOP.svu_shoot", "svu_shoot")

AddSound("COPBM16SCOP.bm16_draw", "bm16_draw")
AddSound("COPBM16SCOP.bm16_empty", "bm16_empty")
AddSound("COPBM16SCOP.bm16_reload_l_stcop", "bm16_reload_l_stcop")
AddSound("COPBM16SCOP.bm16_reload_lr_stcop", "bm16_reload_lr_stcop")
AddSound("COPBM16SCOP.bm16_shoot", "bm16_shoot")
AddSound("COPBM16SCOP.bm16_shoot_both", "bm16_shoot_both")

AddSound("COPABAKANSCOP.abakan_draw", "abakan_draw")
AddSound("COPABAKANSCOP.abakan_empty", "abakan_empty")
AddSound("COPABAKANSCOP.abakan_reload", "abakan_reload_cut")
AddSound("COPABAKANSCOP.abakan_shoot", "abakan_shoot")
AddSound("COPABAKANSCOP.abakan_shot_sil", "abakan_shot_sil")

AddSound("COPAKMSCOP.akm_shoot", "akm_shoot")

AddSound("COPSKSSCOP.sks_draw", "sks_draw")
AddSound("COPSKSSCOP.sks_reload", "sks_reload")
AddSound("COPSKSSCOP.sks_shoot", "sks_shoot")

AddSound("COPTOZ34COP.toz34_draw", "toz34_draw")
AddSound("COPTOZ34COP.toz34_empty", "toz34_empty")
AddSound("COPTOZ34COP.toz34_reload_l", "toz34_reload_l")
AddSound("COPTOZ34COP.toz34_reload_lr", "toz34_reload_lr")
AddSound("COPTOZ34COP.toz34_shoot", "toz34_shoot")

AddSound("COPKARYAKCOP.kar98k_pump", "kar98k_pump")
AddSound("COPKARYAKCOP.kar98k_reload", "kar98k_reload")
AddSound("COPKARYAKCOP.kar98k_reload_end", "kar98k_reload_end")
AddSound("COPKARYAKCOP.kar98k_reload_start", "kar98k_reload_start")
AddSound("COPKARYAKCOP.kar98k_shoot", "kar98_shoot_conv")
AddSound("COPKARYAKCOP.kar98k_shoot_sil", "kar98k_shoot_sil")

AddSound("COPFLASHLIGHT.flashlight_draw", "flashlight_draw")
AddSound("COPFLASHLIGHT.flashlight_holster", "flashlight_holster")

AddSound("COPAKSUSTCOP.aks74u_draw", "aks74u_draw")
AddSound("COPAKSUSTCOP.aks74u_reload", "aks74u_reload")
AddSound("COPAKSUSTCOP.aks74u_shoot", "aks74u_shoot")
AddSound("COPAKSUSTCOP.aks74u_shot_sil", "aks74u_shot_sil")

AddSound("COPMP153STCOP.mp153_draw", "mp153_draw")
AddSound("COPMP153STCOP.mp153_insertshell", "mp153_insertshell")
AddSound("COPMP153STCOP.mp153_shoot", "mp153_shoot")

AddSound("gauss_shot", "gauss_shot")
AddSound("gauss_reload", "gauss_reload")
AddSound("gauss_holster", "gauss_holster")
AddSound("gauss_empty", "gauss_empty")
AddSound("gauss_draw", "gauss_draw")

AddSound("m60_reload", "m60_reload")
AddSound("m60_shoot", "m60_shoot")