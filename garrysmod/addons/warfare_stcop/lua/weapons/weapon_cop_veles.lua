AddCSLuaFile()

SWEP.PrintName = "Детектор «Велес»"
SWEP.Category  = "Call of Pripyat"

SWEP.Base = "weapon_cop_base"

SWEP.Slot    = 4
SWEP.SlotPos = 2

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel = "models/wick/weapons/stalker/stcopwep/veles_model.mdl"
SWEP.WorldModel    = "models/wick/weapons/stalker/stcopwep/w_bin_model_stcop.mdl"
SWEP.ViewModelFOV  = 45
SWEP.ViewModelFlip = true
SWEP.HoldType      = "slam"

SWEP.Damage   = 0
SWEP.RPM      = 0
SWEP.Accuracy = 0
SWEP.Handling = 0

SWEP.Primary.ClipSize    = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "none"

SWEP.OriginPos = Vector(7, -5, -5.7)
SWEP.OriginAng = Vector(0, -14, -9)

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

SWEP.ReloadType = 0

SWEP.ZoomFOV  = 64
SWEP.ScopeFOV = 20

SWEP.DeploySound   = "COPBINOSCOP.bino_draw_stcop"
SWEP.HolsterSound  = "COPBINOSCOP.bino_holster"
SWEP.ZoomInSound   = ""
SWEP.ZoomOutSound  = ""

SWEP.DoAimAnimation = false

function SWEP:Initialize()
	if CLIENT then
		if self.VModel then
			self.VModel:Remove()
		end

		self.VModel = stalker_cop.ModelManager:CreateModel(self.ViewModel, self)
		stalker_cop.UpdatePlayerHands()
	end

	self:SetHoldType(self.HoldType)


		self.VElements = table.FullCopy(self.VElements)
		self.WElements = table.FullCopy(self.WElements)
		self.ViewModelBoneMods = table.FullCopy(self.ViewModelBoneMods)
		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					vm:SetColor(Color(255,255,255,1))
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end
end


	--[[SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		local vm = self.VModel
		if !IsValid(vm) then return end
		if (!self.VElements) then return end

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
			elseif (v.type == "Quad" and v.draw_func) then
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
			
				

				cam.Start3D2D(drawpos, ang, v.size)

				v.draw_func()

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
		
			bone = ent:LookupBone(tab.bone)

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
	end]]

	if CLIENT then
	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		local vm = self.VModel
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
				ent == self.VModel and self.ViewModelFlip) then
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
		local vm = self.VModel
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
		local vm = self.VModel
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
end
---

SWEP.ViewModelBoneMods = { --расположение и размеры(нахуй не нужно нормальному человеку)
	["cover"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.VElements = {
	["Veles"] = { type = "Model", model = "", bone = "cover", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0, 0, 0), color = Color(255, 255, 255, 255), surpresslightning = true, material = "", skin = 1, bodygroup = {} },
	["screen"] = { type = "Quad", bone = "", rel = "Veles", pos = Vector(1.5, 0.1, 2.710), angle = Angle(0, -90, 0), size = 0.080, draw_func = nil}
}

local math = math
local function PointOnCircle( ang, radius, offX, offY )
	ang = math.rad( ang )
	local x = math.cos( ang ) * -radius + offX
	local y = math.sin( ang ) * radius + offY
	return x, y
end

SWEP.LastBeep = 0
SWEP.DistDetector = 701
SWEP.DistBeep = 501
function SWEP:Think2()
	if CLIENT then
		self.VElements["screen"].draw_func = function()
			local function DrawPointOnThatShit(material, x, y, ang, size )
				surface.SetMaterial(Material(material))
				surface.DrawTexturedRectRotated(x, y, size, size, ang )
				
			end
		
			local dist, own, item = self.DistDetector, self.Owner, nut.item.list
			for _, v in ipairs(ents.FindByClass("nut_item")) do
				if (IsValid(v) and item[v:getNetVar("id", "")] != nil and item[v:getNetVar("id", "")].isAnomaly) then
					local tstdeg = ((v:GetPos() - own:GetPos()):Angle().yaw - own:EyeAngles().yaw) - 90
					local dest = own:GetPos():Distance(v:GetPos())
					local x, y = PointOnCircle(tstdeg, dest/30, -2, 21)
					
					if dest < (dist-1) then
						surface.SetDrawColor(0, 255, 0, 255)
						DrawPointOnThatShit("icon16/control_play.png", x, y, v:GetAngles().yaw, 2)
					end	
				end
			end
		end
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