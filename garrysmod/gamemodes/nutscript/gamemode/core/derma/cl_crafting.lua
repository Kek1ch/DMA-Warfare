local PANEL = {}
	
local  gradient2 = Material("daui/droda_ui_3.png") --фон
local  gradient = Material("daui/next_but.png") --заполнение

	function PANEL:Init()
		self:SetTall(20)

		self.value = 0
		self.deltaValue = self.value
		self.max = 10
		
		self.click = self:Add("DButton")
		self.click:Dock(FILL)
		self.click:SetText("")
		--[[self.click.DoClick = function()
			self.selected = true
			netstream.Start("craftmaska")
		end]]

		self.label = self.click:Add("DLabel")
		self.label:Dock(LEFT)
		self.label:SetTextColor(Color(169, 169, 169)) --(Color(210, 180, 140))
		self.label:SetFont("ChatFontMisery32")
		self.label:SetSize(200, 0)	
	end
	
	function PANEL:setCallback(callback)
		self.click.DoClick = function(this)
			callback()
			self.selected = true
		end
	end

	function PANEL:Think()
		if (self.pressing) then
			if ((self.nextPress or 0) < CurTime()) then
				self:doChange()
			end
		end

		self.deltaValue = math.Approach(self.deltaValue, self.value, FrameTime() * 15)
	end

	function PANEL:doChange()
		if ((self.value == 0 and self.pressing == -1) or (self.value == self.max and self.pressing == 1)) then
			return
		end
		
		self.nextPress = CurTime() + 0.2
		
		if (self:onChanged(self.pressing) != false) then
			self.value = math.Clamp(self.value + self.pressing, 0, self.max)
		end
	end

	function PANEL:onChanged(difference)
	end

	function PANEL:getValue()
		return self.value
	end

	function PANEL:setValue(value)
		self.value = value
	end
	
	function PANEL:setBoost(value)
		self.boostValue = value
	end

	function PANEL:setMax(max)
		self.max = max
	end

	function PANEL:setText(text)
		self.label:SetText(text)
	end

	function PANEL:setReadOnly()
		--self.sub:Remove()
		--self.add:Remove()
	end
vgui.Register("nutCraftingBar", PANEL, "DPanel")