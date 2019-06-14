local PANEL = {}
	function PANEL:Init()
		if (IsValid(nut.gui.info)) then
			nut.gui.info:Remove()
		end

		nut.gui.info = self

		self:SetSize(ScrW() * 0.6, ScrH() * 0.55)
		self:Center()

		local suppress = hook.Run("CanCreateCharInfo", self)
		local function paintDtextEntry(s, w, h)
		surface.SetDrawColor(0,0,0)
		surface.SetMaterial(Material("daui/droda_ui_3.png"))
		surface.DrawTexturedRect(0, 0, w, h)

		s:DrawTextEntryText(color_white, color_white, color_white)
		end

		if (!suppress or (suppress and !suppress.all)) then
			if (!suppress or !suppress.model) then
				self.model = self:Add("nutModelPanel")
				self.model:SetWide(ScrW() * 0.25)
				self.model:Dock(LEFT)
				self.model:SetFOV(50)
				self.model.enableHook = true
				self.model.copyLocalSequence = true
			end

			if (!suppress or !suppress.info) then
				self.info = self:Add("DPanel")
				self.info:SetWide(ScrW() * 0.4)
				self.info:Dock(RIGHT)
				self.info:SetDrawBackground(false)
				self.info:DockMargin(150, ScrH() * 0.2, 0, 0)
			end

			if (!suppress or !suppress.name) then
				self.name = self.info:Add("DLabel")
				self.name:SetFont("BigFontForSafe")
				self.name:SetTall(60)
				self.name:Dock(TOP)
				self.name:SetTextColor(Color(169, 169, 169))
				self.name:SetExpensiveShadow(1, Color(0, 0, 0, 150))
			end

			if (!suppress or !suppress.desc) then
				self.desc = self.info:Add("DTextEntry")
				self.desc:Dock(TOP)
				self.desc:SetFont("NameFactionFont")
				self.desc:DockMargin(10, 4, 10, 4)
				--self.desc:SetAllowNonAsciiCharacters(true)
				self.desc:SetTall(28)
				self.desc:SetTextColor(Color(64, 60, 56))
				self.desc.Paint = paintDtextEntry
				--[[function self.desc:Paint( w, h )
					local material = Material("daui/droda_ui_3.png") 
					--surface.SetDrawColor(color_white) 
					surface.SetMaterial(material) 
					surface.DrawTexturedRect(0, 0, w, h) 
				end ]]
			end

			if (!suppress or !suppress.time) then
				self.time = self.info:Add("DLabel")
				self.time:SetFont("NameFactionFont")
				self.time:SetTall(28)
				self.time:Dock(TOP)
				self.time:SetTextColor(Color(64, 60, 56))
				self.time:SetExpensiveShadow(1, Color(0, 0, 0, 150))
			end

			if (!suppress or !suppress.money) then
				self.money = self.info:Add("DLabel")
				self.money:Dock(TOP)
				self.money:SetFont("NameFactionFont")
				self.money:SetTextColor(Color(64, 60, 56))
				self.money:SetExpensiveShadow(1, Color(0, 0, 0, 150))
				self.money:DockMargin(0, 10, 0, 0)
			end

			if (!suppress or !suppress.faction) then
				self.faction = self.info:Add("DLabel")
				self.faction:Dock(TOP)
				self.faction:SetFont("NameFactionFont")
				self.faction:SetTextColor(Color(64, 60, 56))
				self.faction:SetExpensiveShadow(1, Color(0, 0, 0, 150))
				self.faction:DockMargin(0, 10, 0, 0)
			end

			if (!suppress or !suppress.class) then
				local class = nut.class.list[LocalPlayer():getChar():getClass()]
				
				if (class) then
					self.class = self.info:Add("DLabel")
					self.class:Dock(TOP)
					self.class:SetFont("NameFactionFont")
					self.class:SetTextColor(Color(66, 62, 56))
					self.class:SetExpensiveShadow(1, Color(0, 0, 0, 150))
					self.class:DockMargin(0, 10, 0, 0)
				end
			end

			hook.Run("CreateCharInfoText", self)

			if (!suppress or !suppress.attrib) then
				self.attribName = self.info:Add("DLabel")
				self.attribName:Dock(TOP)
				self.attribName:SetFont("NameFactionFont")
				self.attribName:SetTextColor(Color(64, 60, 56))
				self.attribName:SetExpensiveShadow(1, Color(0, 0, 0, 150))
				self.attribName:DockMargin(0, 10, 0, 0)
				self.attribName:SetText(L"attribs")

				self.attribs = self.info:Add("DScrollPanel")
				
				self.attribs:Dock(FILL)
				self.attribs:DockMargin(0, 10, 0, 0)
				local sbar = self.attribs:GetVBar()
				function sbar:Paint( w, h )
					local material = Material("daui/scroll3.png")  
					surface.SetDrawColor(color_white) 
					surface.SetMaterial(material) 
					surface.DrawTexturedRect(0, 0, w, h) 
				end
				function sbar.btnUp:Paint( w, h )
					local material = Material("daui/noimg.png") 
					surface.SetDrawColor(color_white) 
					surface.SetMaterial(material) 
					surface.DrawTexturedRect(0, 0, w, h) 
				end
				function sbar.btnDown:Paint( w, h )
					local material = Material("daui/noimg.png") 
					surface.SetDrawColor(color_white) 
					surface.SetMaterial(material) 
					surface.DrawTexturedRect(0, 0, w, h) 
				end
				function sbar.btnGrip:Paint( w, h )
					local material = Material("daui/scroller.png") 
					surface.SetDrawColor(color_white) 
					surface.SetMaterial(material) 
					surface.DrawTexturedRect(0, 0, w, h) 
				end 
			end
		end

		hook.Run("CreateCharInfo", self)
	end

	function PANEL:setup()
		local char = LocalPlayer():getChar()
		if (self.desc) then
			self.desc:SetText(char:getDesc())
			self.desc.OnEnter = function(this, w, h)
				nut.command.send("chardesc", this:GetText())
			end
		end

		if (self.name) then
			self.name:SetText(LocalPlayer():Name())
			self.name.Think = function(this)
				this:SetText(LocalPlayer():Name())
			end
		end

		if (self.money) then
			self.money:SetText(L("charMoney", nut.currency.get(char:getMoney())))
		end

		if (self.faction) then
			self.faction:SetText(L("charFaction", L(team.GetName(LocalPlayer():Team()))))
		end

		if (self.time) then
			local format = "%A, %d %B %Y %X"
			
			self.time:SetText(L("curTime", os.date(format, nut.date.get())))
			self.time.Think = function(this)
				if ((this.nextTime or 0) < CurTime()) then
					this:SetText(L("curTime", os.date(format, nut.date.get())))
					this.nextTime = CurTime() + 0.5
				end
			end
		end

		if (self.class) then
			local class = nut.class.list[char:getClass()]
			if (class) then
				self.class:SetText(L("charClass", L(class.name)))
			end
		end
		
		if (self.model) then
			self.model:SetModel(LocalPlayer():GetModel())
			self.model.Entity:SetSkin(LocalPlayer():GetSkin())

			for k, v in ipairs(LocalPlayer():GetBodyGroups()) do
				self.model.Entity:SetBodygroup(v.id, LocalPlayer():GetBodygroup(v.id))
			end

			local ent = self.model.Entity
			if (ent and IsValid(ent)) then
				local mats = LocalPlayer():GetMaterials()
				for k, v in pairs(mats) do
					ent:SetSubMaterial(k - 1, LocalPlayer():GetSubMaterial(k - 1))
				end
			end
		end

		if (self.attribs) then
			local boost = char:getBoosts()

			for k, v in SortedPairsByMemberValue(nut.attribs.list, "name") do
				local attribBoost = 0
				if (boost[k]) then
					for _, bValue in pairs(boost[k]) do
						attribBoost = attribBoost + bValue
					end
				end

				local bar = self.attribs:Add("nutAttribBar")
				bar:Dock(TOP)
				bar:DockMargin(0, 0, 0, 3)

				local attribValue = char:getAttrib(k, 0)
				if (attribBoost) then
					bar:setValue(attribValue - attribBoost or 0)
				else
					bar:setValue(attribValue)
				end

				local maximum = v.maxValue or nut.config.get("maxAttribs", 30)
				bar:setMax(maximum)
				bar:setReadOnly()
				bar:setText(Format("%s [%.1f/%.1f] (%.1f", L(v.name), attribValue, maximum, attribValue/maximum*100) .. "%)")

				if (attribBoost) then
					bar:setBoost(attribBoost)
				end
			end
		end

		hook.Run("OnCharInfoSetup", self)
	end

	function PANEL:Paint(w, h)
	end
vgui.Register("nutCharInfo", PANEL, "EditablePanel")