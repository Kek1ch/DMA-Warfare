local PLUGIN = PLUGIN
local PANEL = {}

function PANEL:Init()
	self:SetTitle(L("areaManager"))
	self:SetSize(500, 400)
	self:Center()
	self:MakePopup()

	local noticeBar = self:Add("nutNoticeBar")
	noticeBar:Dock(TOP)
	noticeBar:setType(4)
	noticeBar:setText(L("areaManagerTip"))

	self.list = self:Add("PanelList")
	self.list:Dock(FILL)
	self.list:DockMargin(0, 5, 0, 0)
	self.list:SetSpacing(5)
	self.list:SetPadding(5)
	self.list:EnableVerticalScrollbar()

	self:loadBusinesses()
end

function PANEL:loadBusinesses()
	for class, data in pairs(PLUGIN.areaTable) do
		local panel = self.list:Add("DButton")
		panel:SetText(data.NameZone)
		panel:SetFont("ChatFont")
		panel:SetTextColor(color_white)
		panel:SetTall(30)
		local onConfirm = function(newName)
			netstream.Start("areaEdit", class, {NameZone = newName})
			self:Close()
		end
		panel.OnMousePressed = function(this, code)
			if (code == MOUSE_RIGHT) then
				surface.PlaySound("buttons/blip2.wav")

				local menu = DermaMenu()
					menu:AddOption(L"deleteArea", function()
						netstream.Start("ZoneRemove", class)
						self:Close()
					end):SetImage("icon16/cross.png")
				menu:Open()
			end
		end
		self.list:AddItem(panel)
	end
end

vgui.Register("ZoneManager", PANEL, "DFrame")

netstream.Hook("ZoneManager", function(AreaList)
	PLUGIN.areaTable = AreaList
	areaManager = vgui.Create("ZoneManager")
end)

