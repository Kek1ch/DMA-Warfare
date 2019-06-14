local PANEL = {}
	local paintFunctions = {}
	paintFunctions[0] = function(this, w, h)
	end
	paintFunctions[1] = function(this, w, h)
	end

	function PANEL:Init()
		if (IsValid(nut.gui.score)) then
			nut.gui.score:Remove()
		end

		nut.gui.score = self

		self:SetSize(ScrW() * 0.35, ScrH() * 0.72)
		self:Center()

		self.title = self:Add("DLabel")
		self.title:SetText(GetHostName())
		self.title:SetFont("Tahoma13")	
		self.title:SetContentAlignment(5)
		self.title:SetTextColor(Color(211, 211, 211))
		self.title:SetExpensiveShadow(1, color_black)
		self.title:Dock(TOP)
		self.title:SizeToContentsY()
		self.title:SetTall(self.title:GetTall() + 16)

		self.scroll = self:Add("DScrollPanel")
		self.scroll:Dock(FILL)
		self.scroll:DockMargin(1, 0, 1, 0)
		self.scroll.VBar:SetWide(0)

		self.layout = self.scroll:Add("DListLayout")
		self.layout:Dock(TOP)

		self.teams = {}
		self.slots = {}
		self.i = {}

		for k, v in ipairs(nut.faction.indices) do
			local color = team.GetColor(k)
			local r, g, b = color.r, color.g, color.b

			local list = self.layout:Add("DListLayout")
			list:Dock(TOP)
			list:SetTall(28)
			list.Think = function(this)
				for k2, v2 in ipairs(team.GetPlayers(k)) do
					if (!IsValid(v2.nutScoreSlot) or v2.nutScoreSlot:GetParent() != this) then
						if (IsValid(v2.nutPlayerSlot)) then
							v2.nutPlayerSlot:SetParent(this)
						else
							self:addPlayer(v2, this)
						end
					end
				end
			end

			local header = list:Add("DLabel")
			header:Dock(TOP)
			header:SetText(L(v.name)) --название фракции
			header:SetTextInset(3, 0)
			header:SetFont("dobi4ikxyecockft1234444")
			header:SetTextColor(Color(211, 211, 211))
			header:SetExpensiveShadow(1, color_black)
			header:SetTall(28)
			header.Paint = function(this, w, h)
				surface.SetDrawColor(r, g, b, 20)
				surface.DrawRect(0, 0, w, h)
			end

			self.teams[k] = list
		end
	end

	function PANEL:Think()
		if ((self.nextUpdate or 0) < CurTime()) then
			self.title:SetText("S.T.A.L.K.E.R. Warfare Role-Play")

			local visible, amount

			for k, v in ipairs(self.teams) do
				visible, amount = v:IsVisible(), team.NumPlayers(k)

				if (visible and amount == 0) then
					v:SetVisible(false)
					self.layout:InvalidateLayout()
				elseif (!visible and amount > 0) then
					v:SetVisible(true)
				end
			end

			for k, v in pairs(self.slots) do
				if (IsValid(v)) then
					v:update()
				end
			end

			self.nextUpdate = CurTime() + 0.1
		end
	end

	function PANEL:addPlayer(client, parent)
		if (!client:getChar() or !IsValid(parent)) then
			return
		end

		local slot = parent:Add("DPanel")
		slot:Dock(TOP)
		slot:SetTall(64)
		slot:DockMargin(0, 0, 0, 1)
		slot.character = client:getChar()

		client.nutScoreSlot = slot
		slot.model = slot:Add("nutSpawnIcon")
		slot.model:SetModel(string.gsub(client:GetModel(), "spenser", "hdmodels"))
		slot.model:SetSize(64, 64)
		slot.model.DoClick = function()
			local menu = DermaMenu()
				local options = {}

				hook.Run("ShowPlayerOptions", client, options)

				if (table.Count(options) > 0) then
					for k, v in SortedPairs(options) do
						menu:AddOption(L(k), v[2]):SetImage(v[1])
					end
				end
			menu:Open()

			RegisterDermaMenuForClose(menu)
		end
		slot.model:SetToolTip(L("sbOptions", client:steamName()))

		timer.Simple(0, function()
			if (!IsValid(slot)) then
				return
			end

			local entity = slot.model.Entity

			if (IsValid(entity)) then
				if (IsValid(client)) then
					for k, v in ipairs(client:GetBodyGroups()) do
						entity:SetBodygroup(v.id, client:GetBodygroup(v.id))
					end

					for k, v in ipairs(client:GetMaterials()) do
						entity:SetSubMaterial(k - 1, client:GetSubMaterial(k - 1))
					end
				end
			end
		end)

		slot.name = slot:Add("DLabel")
		slot.name:SetText(client:Name()) --имя игрока
		slot.name:Dock(TOP) 
		slot.name:DockMargin(65, 0, 48, 0)
		slot.name:SetTall(18)
		slot.name:SetFont("gost8")
		slot.name:SetTextColor(Color(211, 211, 211))
		slot.name:SetExpensiveShadow(1, color_black)

		slot.ping = slot:Add("DLabel")
		slot.ping:SetPos(self:GetWide() - 48, 0)
		slot.ping:SetSize(48, 64)
		slot.ping:SetText("0")
		slot.ping.Think = function(this)
			if (IsValid(client)) then
				this:SetText(client:Ping())
			end
		end
		slot.ping:SetFont("gost8")
		slot.ping:SetContentAlignment(6)
		slot.ping:SetTextColor(Color(211, 211, 211))
		slot.ping:SetTextInset(16, 0)
		slot.ping:SetExpensiveShadow(1, color_black)

		slot.desc = slot:Add("DLabel")
		slot.desc:Dock(FILL)
		slot.desc:DockMargin(65, 0, 48, 0)
		slot.desc:SetWrap(true)
		slot.desc:SetContentAlignment(7)
		slot.desc:SetText(hook.Run("GetDisplayedDescription", client) or (client:getChar() and client:getChar():getDesc()) or "") --описание
		slot.desc:SetTextColor(Color(211, 211, 211))
		slot.desc:SetExpensiveShadow(1, Color(0, 0, 0, 100))
		slot.desc:SetFont("gost7")

		local oldTeam = client:Team()

		function slot:update()
			if (!IsValid(client) or !client:getChar() or !self.character or self.character != client:getChar() or oldTeam != client:Team()) then
				self:Remove()

				local i = 0

				for k, v in ipairs(parent:GetChildren()) do
					if (IsValid(v.model) and v != self) then
						i = i + 1
						v.Paint = paintFunctions[i % 2]
					end
				end

				return
			end

			local overrideName = hook.Run("ShouldAllowScoreboardOverride", client, "name") and hook.Run("GetDisplayedName", client)
			local name = overrideName or client:Name()
			local model = client:GetModel()
			local skin = client:GetSkin()
			local desc = hook.Run("ShouldAllowScoreboardOverride", client, "desc") and hook.Run("GetDisplayedDescription", client) or (client:getChar() and client:getChar():getDesc()) or ""

			self.model:setHidden(overrideName)

			if (self.lastName != name) then
				self.name:SetText(name)
				self.lastName = name
			end

			local entity = self.model.Entity

			if (self.lastDesc != desc) then
				self.desc:SetText(desc)
				self.lastDesc = desc
			end

			if (!IsValid(entity)) then
				return
			end

			if (self.lastModel != model or self.lastSkin != skin) then
				self.model:SetModel(string.gsub(client:GetModel(), "spenser", "hdmodels"))
				self.model:SetToolTip(L("sbOptions", client:steamName()))
				
				self.lastModel = model
				self.lastSkin = skin
			end

			timer.Simple(0, function()
				if (!IsValid(entity) or !IsValid(client)) then
					return
				end

				for k, v in ipairs(client:GetBodyGroups()) do
					entity:SetBodygroup(v.id, client:GetBodygroup(v.id))
				end
			end)
		end

		self.slots[#self.slots + 1] = slot

		parent:SetVisible(true)
		parent:SizeToChildren(false, true)
		parent:InvalidateLayout(true)

		local i = 0

		for k, v in ipairs(parent:GetChildren()) do
			if (IsValid(v.model)) then
				i = i + 1
				v.Paint = paintFunctions[i % 2]
			end
		end

		return slot
	end

	function PANEL:OnRemove()
		CloseDermaMenus()
	end

	function PANEL:Paint(w, h)
		nut.util.drawBlur(self, 10)

		surface.SetDrawColor(0, 0, 0, 210) 
		surface.DrawRect(0, 0, w, h) 
		surface.SetDrawColor(30, 30, 30, 100)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 0, 150)
		surface.DrawOutlinedRect(0, 0, w, h)
	end
vgui.Register("nutScoreboard", PANEL, "EditablePanel")

concommand.Add("dev_reloadsb", function()
	if (IsValid(nut.gui.score)) then
		nut.gui.score:Remove()
	end
end)
