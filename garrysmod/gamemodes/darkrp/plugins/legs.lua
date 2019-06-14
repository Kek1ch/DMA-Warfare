PLUGIN.name = "Legs"
PLUGIN.author = "Chessnut"
PLUGIN.desc = "Increases 'immersion' by adding legs."

if (CLIENT) then
	local NUT_CVAR_LEGS = CreateClientConVar("nut_legs", "1")
	local HIDDEN_BONES = {
		"ValveBiped.Bip01_Spine1",
		"ValveBiped.Bip01_Spine2",
		"ValveBiped.Bip01_Spine4",
		"ValveBiped.Bip01_Neck1",
		"ValveBiped.Bip01_Head1",
		"ValveBiped.forward",
		"ValveBiped.Bip01_R_Clavicle",
		"ValveBiped.Bip01_R_UpperArm",
		"ValveBiped.Bip01_R_Forearm",
		"ValveBiped.Bip01_R_Hand",
		"ValveBiped.Anim_Attachment_RH",
		"ValveBiped.Bip01_L_Clavicle",
		"ValveBiped.Bip01_L_UpperArm",
		"ValveBiped.Bip01_L_Forearm",
		"ValveBiped.Bip01_L_Hand",
		"ValveBiped.Anim_Attachment_LH",
		"ValveBiped.Bip01_L_Finger4",
		"ValveBiped.Bip01_L_Finger41",
		"ValveBiped.Bip01_L_Finger42",
		"ValveBiped.Bip01_L_Finger3",
		"ValveBiped.Bip01_L_Finger31",
		"ValveBiped.Bip01_L_Finger32",
		"ValveBiped.Bip01_L_Finger2",
		"ValveBiped.Bip01_L_Finger21",
		"ValveBiped.Bip01_L_Finger22",
		"ValveBiped.Bip01_L_Finger1",
		"ValveBiped.Bip01_L_Finger11",
		"ValveBiped.Bip01_L_Finger12",
		"ValveBiped.Bip01_L_Finger0",
		"ValveBiped.Bip01_L_Finger01",
		"ValveBiped.Bip01_L_Finger02",
		"ValveBiped.Bip01_R_Finger4",
		"ValveBiped.Bip01_R_Finger41",
		"ValveBiped.Bip01_R_Finger42",
		"ValveBiped.Bip01_R_Finger3",
		"ValveBiped.Bip01_R_Finger31",
		"ValveBiped.Bip01_R_Finger32",
		"ValveBiped.Bip01_R_Finger2",
		"ValveBiped.Bip01_R_Finger21",
		"ValveBiped.Bip01_R_Finger22",
		"ValveBiped.Bip01_R_Finger1",
		"ValveBiped.Bip01_R_Finger11",
		"ValveBiped.Bip01_R_Finger12",
		"ValveBiped.Bip01_R_Finger0",
		"ValveBiped.Bip01_R_Finger01",
		"ValveBiped.Bip01_R_Finger02",

		"bip01_spine4",
		"jaw_1",
		"eyelid_1",
		"bip01_spine",

		"bip01_head",
		"bip01_l_clavicle" ,
		"bip01_l_upperarm" ,
		"bip01_l_forearm" ,
		"bip01_l_hand",
		"bip01_l_finger0" ,
		"bip01_l_finger01",
		"bip01_l_finger02",
		"bip01_l_finger1",
		"bip01_l_finger11",
		"bip01_l_finger12",
		"bip01_l_finger2",
		"bip01_l_finger21",
		"bip01_l_finger22",
		"bip01_r_clavicle" ,
		"bip01_r_upperarm" ,
		"bip01_r_forearm" ,
		"bip01_r_hand",

		"bip01_spine1",
		"bip01_spine2",
		"bip01_neck",

		"bip01_r_finger0" ,
		"bip01_r_finger01",
		"bip01_r_finger02" ,
		"bip01_r_finger1",
		"bip01_r_finger11",
		"bip01_r_finger12" ,
		"bip01_r_finger2" ,
		"bip01_r_finger21",
		"bip01_r_finger22",
		"ValveBiped.baton_parent"
	}

	function PLUGIN:createLegs()
		if (!NUT_CVAR_LEGS:GetBool()) then
			return
		end

		if (IsValid(self.legs)) then
			self.legs:Remove()
		end

		self.legs = ClientsideModel(string.gsub(LocalPlayer():GetModel(), "spenser", "hdmodels"), 10)

		if (IsValid(self.legs)) then
			self.legs:SetSkin(LocalPlayer():GetSkin())
			
			for k, v in ipairs(LocalPlayer():GetMaterials()) do
				self.legs:SetSubMaterial(k - 1, v)
			end

			for k, v in pairs(HIDDEN_BONES) do
				local index = self.legs:LookupBone(v)

				if (index) then
					self.legs:ManipulateBoneScale(index, vector_origin)
					self.legs:ManipulateBonePosition(index, Vector(-100, -100, -50))
				end
			end

			self.legs:SetNoDraw(true)
			self.legs:SetIK(false)
		end
	end

	function PLUGIN:checkChanges()
		local client = LocalPlayer()

		if (!IsValid(self.legs)) then
			return true
		end

		if (self.legs:GetModel() != client:GetModel()) then
			return true
		end

		if (self.legs:GetSkin() != client:GetSkin()) then
			return true
		end

		local newMaterials = client:GetMaterials()
		local materials = self.legs:GetMaterials()

		for k, v in ipairs(materials) do
			if (v != newMaterials[k]) then
				return true
			end
		end
	end

	local PLUGIN = PLUGIN

	timer.Create("nutLegCheck", 0.5, 0, function()
		local client = LocalPlayer()

		if (IsValid(client) and NUT_CVAR_LEGS:GetBool()) then
			if (PLUGIN:checkChanges()) then
				PLUGIN:createLegs()
			end
		end
	end)

	function PLUGIN:PostDrawViewModel()
		if (NUT_CVAR_LEGS:GetBool() and IsValid(self.legs)) then
			local realTime = RealTime()
			local angles = LocalPlayer():GetAngles()

			angles.p = 0
			angles.r = 0

			self.legs:SetPos(LocalPlayer():GetPos() + LocalPlayer():GetForward()*15 + LocalPlayer():GetUp()*-19)
			self.legs:SetSequence(LocalPlayer():GetSequence())
			self.legs:SetAngles(angles)
			self.legs:SetPoseParameter("move_yaw", 360 * LocalPlayer():GetPoseParameter("move_yaw") - 180)
			self.legs:SetPoseParameter("move_x", LocalPlayer():GetPoseParameter("move_x")*2 - 1)
			self.legs:SetPoseParameter("move_y", LocalPlayer():GetPoseParameter("move_y")*2 - 1)
			self.legs:FrameAdvance(realTime - (self.lastDraw or realTime))
			self.legs:DrawModel()

			self.lastDraw = realTime
		end
	end
end
