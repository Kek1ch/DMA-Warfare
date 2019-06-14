local function InitializeLoot()
	local anom_a = ents.Create("tramplin_anomaly")
	anom_a:SetPos(Vector(-11618.812500, 6682.173340, -246.709503))
	anom_a:Spawn()

	local anom_b = ents.Create("tramplin_anomaly")
	anom_b:SetPos(Vector(-9878.495117, 1062.551636, 0.031250))
	anom_b:Spawn()

	local anom_c = ents.Create("gazirovka_anomaly")
	anom_c:SetPos(Vector(-9731.376953, -4767.331543, 102.639435))
	anom_c:Spawn()

	local anom_d = ents.Create("gazirovka_anomaly")
	anom_d:SetPos(Vector(-10171.745117, -5080.776367, 188.396057))
	anom_d:Spawn()

	local anom_e = ents.Create("electra_anomaly")
	anom_e:SetPos(Vector(-10858.403320, -10752.905273, 640.031250))
	anom_e:Spawn()

	local anom_f = ents.Create("electra_anomaly")
	anom_f:SetPos(Vector(-10505.772461, -9770.549805, 640.031250))
	anom_f:Spawn()

	local anom_g = ents.Create("electra_anomaly")
	anom_g:SetPos(Vector(-11218.987305, -9417.483398, 640.031250))
	anom_g:Spawn()

	local anom_h = ents.Create("jarka")
	anom_h:SetPos(Vector(169.392303, -11679.071289, -409.010101))
	anom_h:Spawn()

	local anom_i = ents.Create("jarka")
	anom_i:SetPos(Vector(-368.193359, -11635.861328, -368.886688))
	anom_i:Spawn()

	local anom_j = ents.Create("tramplin_anomaly")
	anom_j:SetPos(Vector(3404.257080, -10416.835938, 0.031249))
	anom_j:Spawn()

	local anom_k = ents.Create("tramplin_anomaly")
	anom_k:SetPos(Vector(13110.275391, -2603.083496, 350.031219))
	anom_k:Spawn()

	local anom_l = ents.Create("tramplin_anomaly")
	anom_l:SetPos(Vector(6836.178223, 10191.809570, -627.117004))
	anom_l:Spawn()
	
	local anom_m = ents.Create("maysorubka_anomaly_type2")
	anom_m:SetPos(Vector(11638.573242, 8348.984375, -634.968750))
	anom_m:Spawn()

	local anom_n = ents.Create("maysorubka_anomaly_type2")
	anom_n:SetPos(Vector(11976.409180, 7847.511230, -634.968750))
	anom_n:Spawn()

	local anom_o = ents.Create("par")
	anom_o:SetPos(Vector(12960.593750, 11999.363281, -639.968750))
	anom_o:Spawn()

	local anom_p = ents.Create("par")
	anom_p:SetPos(Vector(13041.109375, 12594.854492, -639.968750))
	anom_p:Spawn()

	local anom_q = ents.Create("jarka")
	anom_q:SetPos(Vector(-656.313782, 10534.238281, 512.031250))
	anom_q:Spawn()

	local anom_r = ents.Create("jarka")
	anom_r:SetPos(Vector(-1569.187256, 11610.129883, 513.870911))
	anom_r:Spawn()

	local anom_s = ents.Create("jarka")
	anom_s:SetPos(Vector(-1569.187256, 11610.129883, 513.870911))
	anom_s:Spawn()

	local anom_t = ents.Create("gazirovka_anomaly")
	anom_t:SetPos(Vector(-13332.771484, 5202.788086, -674.276306))
	anom_t:Spawn()
end

hook.Add("Initialize", "InitializeLoot", InitializeLoot)