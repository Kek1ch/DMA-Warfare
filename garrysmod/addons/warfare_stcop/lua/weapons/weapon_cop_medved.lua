AddCSLuaFile()

SWEP.PrintName = "Детектор «Медведь»"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 4
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel = "models/wick/weapons/stalker/stcopwep/medved_modelk.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_bin_model_stcop.mdl"
SWEP.ViewModelFOV  = 50
SWEP.ViewModelFlip = false
SWEP.HoldType      = "slam"

SWEP.Damage   = 0
SWEP.RPM      = 0
SWEP.Accuracy = 0
SWEP.Handling = 0

SWEP.Primary.ClipSize    = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "none"

SWEP.OriginPos = Vector(-2, -2, -14)
SWEP.OriginAng = Vector(11, 0, 0)

SWEP.AimPos = Vector(0, 0, 0)
SWEP.AimAng = Vector(0, 0, 0)



SWEP.SilencerMode = 0
SWEP.ScopeMode    = 1

SWEP.AimTime    = 0.2
SWEP.DeployTime = 0.8

SWEP.ReloadTime     = 2.85
SWEP.ReloadFillTime = 1.4

SWEP.CanZoom       = false
SWEP.ZoomCrosshair = false

--SWEP.SlideBone = { name = "breachblock", pos = Vector(0, -1.2, 0) }



SWEP.HiddenBones = { "screen_bone" }


SWEP.SprintAnim = "idle_moving"

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 20

SWEP.DeploySound   = "COPBINOSCOP.bino_draw_stcop"
SWEP.HolsterSound  = "COPBINOSCOP.bino_holster"
SWEP.ZoomInSound   = ""
SWEP.ZoomOutSound  = ""

SWEP.DoAimAnimation = false

--[[
SWEP.BoneMatrix = {
	wpn_body = {
		Pos = Vector(0, 0, 0.3),
		Ang = Angle(0, -2, 0)
	}
}

function SWEP:DrawHUD()
	if CLIENT then
	local x, y
		if ( self.Owner == LocalPlayer() and self.Owner:ShouldDrawLocalPlayer() ) then
			local tr = util.GetPlayerTrace( self.Owner )
			local trace = util.TraceLine( tr )
			local coords = trace.HitPos:ToScreen()
			x, y = coords.x, coords.y
		else
			x, y = ScrW() / 2, ScrH() / 2
		end
		surface.SetTexture( surface.GetTextureID( "stalkerrp/cursor/crosshair" ) )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( x - 16, y - 16, 32, 32 )
	end
end

function SWEP:Initialize()
	if CLIENT then
		if self.VModel then
			self.VModel:Remove()
		end

		self.VModel = stalker_cop.ModelManager:CreateModel(self.ViewModel, self)
		stalker_cop.UpdatePlayerHands()
	end

	self:SetHoldType(self.HoldType)
end

local matScreen = Material("models/kali/miscstuff/stalker/detectors/detector_bear_c"); // “екстура, которую ищем
	local RTTexture = GetRenderTarget("DTC_BEAR", 512, 512); // Ћюбое название

	local dot = surface.GetTextureID("models/kali/miscstuff/stalker/detectors/detector_bear_segment_copy");
	local bg = surface.GetTextureID("models/kali/miscstuff/stalker/detectors/detector_bear_copy");

	function SWEP:RenderScreen()
		local NewRT = RTTexture;
		local oldW, oldH, ply = ScrW(), ScrH(), LocalPlayer()

		matScreen:SetTexture("$basetexture", NewRT);
	
		local OldRT = render.GetRenderTarget();
		render.SetRenderTarget(NewRT);
		render.SetViewPort( 0, 0, 512, 512);

		cam.Start2D();
			render.Clear( 50, 50, 100, 0 );
			surface.SetDrawColor( 255, 255, 255, 255 );
			surface.SetTexture( bg );
			surface.DrawTexturedRect( 0, 0, 512, 512);
			surface.SetTexture(dot);
			
            local dist, ent, item = self.DistBeep, self.VModel, nut.item.list
            for _, v in ipairs(ents.FindByClass("nut_item")) do
                if (IsValid(v) and item[v:getNetVar("id", "")] != nil and item[v:getNetVar("id", "")].isAnomaly) then
                    dist = v:GetPos():Distance(ply:GetPos())
                    ent = v
                end
            end
			if dist < (self.DistBeep-1) then
				local ang = ply:GetAngles();
				local pos = ent:GetPos() - ply:GetShootPos()
				surface.SetDrawColor(255, 255, 255, 255)
				pos:Rotate(Angle(0, -1*ang.Yaw, 0));
				if (math.abs(pos.z)<2000) then
					surface.DrawTexturedRectRotated( 131, 118, 150, 150, ((pos:Angle().y % 15) / 15 < 0.5 and pos:Angle().y - (pos:Angle().y % 15) or (pos:Angle().y % 15) / 15 >= 0.5 and pos:Angle().y - (pos:Angle().y % 15)  + 15) + 30  )//ѕо¤сн¤ю. ћы находим остаток делени¤ угла на 15(¬ детекторе 24 делени¤. 360/24 = 15) и если остаток меньше половины 15, то из угла вычитаем остаток, а если остаток больше половины 15, то из угла вычитаем остаток и прибавл¤ем 15. Ёто такой баланс. “аким образом мы получаем угол, кратный 15. —пасибо 'Black Pheonix'у за совет.
				end
			end
		cam.End2D();
		render.SetRenderTarget(OldRT);
		render.SetViewPort( 0, 0, oldW, oldH )
	end
--
SWEP.DistBeep = 501

SWEP.WElements = {
	["Bear"] = { type = "Model", model = "models/wick/weapons/stalker/stcopwep/medved_modelk.mdl", bone = "wpn_body", rel = "", pos = Vector(4.675, 1.557, -2.597), angle = Angle(-106.364, -167.144, 12.857), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} }
}

SWEP.VElements = {
	["detector"] = { type = "Model", model = "models/wick/weapons/stalker/stcopwep/medved_modelk.mdl", bone = "wpn_body", rel = "", pos = Vector(4, 1.1, -0.519), angle = Angle(-59.611, 31.558, 162.468), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
	--["element_name"] = { type = "Model", model = "models/kali/miscstuff/stalker/bolt.mdl", bone = "Base", rel = "", pos = Vector(0, 0, 0), angle = Angle(12.857, -29.222, 180), size = Vector(0.755, 0.755, 0.755), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


--[[function SWEP:Think2()
	local vm = self.VModel
	if CLIENT then
		local dist, own, item = self.DistBeep, self.Owner, nut.item.list
		local pos = own:GetPos()
		local dek = pos - own:GetShootPos()
		local aimvec = own:GetAimVector()
		local sos = dek:GetNormalized()
		local dot = sos:Dot(aimvec)
		local clampdot = (1-math.Clamp(dot, 0, 0.5))
		for _, v in ipairs(ents.FindByClass("nut_item")) do
			if (IsValid(v) and item[v:getNetVar("id", "")] != nil and item[v:getNetVar("id", "")].isAnomaly) then
				dist = v:GetPos():Distance(own:GetPos())*clampdot
			end
		end
		if dist < (self.DistBeep - 1) then
			if self.LastBeep + dist/300 - CurTime() <= 0 then
				self.LastBeep = CurTime()
				vm:SetSkin(2)
				timer.Simple(0.1, function()
					if IsValid(self) and IsValid(self.Weapon) then vm:SetSkin(1) end
				end)
				own:EmitSound(Sound("stalkerdetectors/echo.wav"), 100, 100)//math.Clamp(250-dist/2,50,250))
			end
		end
	end
end

SWEP.LastBeep = 0
function SWEP:Think2()
	if CLIENT then
		local dist, own, item = self.DistBeep, self.Owner, nut.item.list
		for _, v in ipairs(ents.FindByClass("nut_item")) do
			if (IsValid(v) and item[v:getNetVar("id", "")] != nil and item[v:getNetVar("id", "")].isAnomaly) then
				dist = v:GetPos():Distance(own:GetPos())
			end
		end
		if dist < (self.DistBeep-1) and self.LastBeep + dist/300 - CurTime() <= 0 then
			self.LastBeep = CurTime()
			own:EmitSound(Sound("stalkerdetectors/echo.wav"), 100, 100)
		end
	end
end




if CLIENT then
	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			self.vRenderOrder = {}

			for k, v in pairs(self.VElements) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
		end

		for k, name in ipairs( self.vRenderOrder ) do
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model, sprite = v.modelEnt, v.spriteMaterial
			
			if (!v.bone) then continue end
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then
				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then model:SetMaterial(v.material) end
				
				if (v.skin and v.skin != model:GetSkin()) then model:SetSkin(v.skin) end
				
				if (v.bodygroup) then
					for k, v in pairs(v.bodygroup) do
						if (model:GetBodygroup(k) != v) then model:SetBodygroup(k, v) end
					end
				end
				
				if (v.surpresslightning) then render.SuppressEngineLighting(true) end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then render.SuppressEngineLighting(false) end
			elseif (v.type == "Sprite" and sprite) then
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
			elseif (v.type == "Quad" and v.draw_func) then
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()
			end
		end
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then self:DrawModel() end
		if (!self.WElements) then return end
		if (!self.wRenderOrder) then
			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end
		end
		
		if (IsValid(self.Owner)) then bone_ent = self.Owner
		else bone_ent = self end
		
		for k, name in pairs( self.wRenderOrder ) do
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model, sprite = v.modelEnt, v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then
				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix("RenderMultiply", matrix)
				
				if (v.material == "") then model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then model:SetMaterial(v.material) end
				
				if (v.skin and v.skin != model:GetSkin()) then model:SetSkin(v.skin) end
				
				if (v.bodygroup) then
					for k, v in pairs(v.bodygroup) do
						if (model:GetBodygroup(k) != v) then model:SetBodygroup(k, v) end
					end
				end
				
				if (v.surpresslightning) then render.SuppressEngineLighting(true) end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then render.SuppressEngineLighting(false) end
			elseif (v.type == "Sprite" and sprite) then
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
			elseif (v.type == "Quad" and v.draw_func) then
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()
			end
		end
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )
		if (!tab) then return end

		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for _, j in ipairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
			end
		end
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		if self.ViewModelBoneMods then
			if (!vm:GetBoneCount()) then return end
			
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				s = s * ms
				
				if vm:GetManipulateBoneScale(bone) != s then vm:ManipulateBoneScale( bone, s ) end
				if vm:GetManipulateBoneAngles(bone) != v.angle then vm:ManipulateBoneAngles( bone, v.angle ) end
				if vm:GetManipulateBonePosition(bone) != p then vm:ManipulateBonePosition( bone, p ) end
			end
		else
			self:ResetBonePositions(vm)
		end
	end
	 
	function SWEP:ResetBonePositions(vm)
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
	end

	function table.FullCopy( tab )
		if (!tab) then return nil end
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		return res
	end
end]]

