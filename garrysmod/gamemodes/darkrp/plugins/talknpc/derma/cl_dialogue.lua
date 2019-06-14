local PLUGIN = PLUGIN
surface.CreateFont( "Nut_NPCChatName",
{
	font = "Trebuchet MS",
	size = ScreenScale( 9 ),
	weight = 1000,
})
surface.CreateFont( "Nut_NPCChatName1",
{
	font = "Trebuchet24",
	size = ScreenScale( 9 ),
	weight = 1000,
})
surface.CreateFont( "Nut_NPCChatName111",
{
	font = "Trebuchet24",
	size = ScreenScale( 3 ),
	weight = 1000,
})
surface.CreateFont( "Nut_NPCChatName11",
{
	font = "ChatFont",
	size = ScreenScale( 9 ),
	weight = 1000,
})
surface.CreateFont( "Nut_NPCChatSel",
{
	font = "Myriad Pro",
	size = ScreenScale( 8 ),
	weight = 1000,
})
surface.CreateFont( "Nut_NPCChatText",
{
	font = "Myriad Pro",
	size = ScreenScale( 8 ),
	weight = 500,
})
local color_red = Color(255,0,0)
local color_white = Color(255,255,255)
local color_black = Color(0,0,0)
local color_yellow = Color(255, 140, 0)

local PLUGIN = PLUGIN

if CLIENT then
	local PANEL = {}
	function PANEL:Init()

		for k, v in pairs(ents.FindInSphere( LocalPlayer():GetPos(), 120 )) do
			if (v:GetClass() == "nut_talker") then
				client_time_tolkername = v:getNetVar("name")
				client_time_tolkerdesc = v:getNetVar("desc")
				client_time_tolkermodel =  v:GetModel()
			end
		end

		self:SetTitle("")
		self:SetSize( ScrW()*0.35, ScrH()*0.5 )
		timer.Simple(0.01, function()
			self:SetPos( ScrW()*0.325, ScrH()*0.16 )
		end)
		self:SetDraggable(false)
		self:ShowCloseButton(false)

		function self:Paint(w, h) --xxx
			nut.util.drawBlur(self, 10)
			surface.SetDrawColor(Color( 30, 30, 30, 230))
			surface.DrawRect( 0, 0, w, h )
			surface.DrawOutlinedRect(0, 0, w, h)

			surface.SetDrawColor(0, 0, 14, 150)
			surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033)

			surface.SetDrawColor(Color( 30, 30, 30, 50))
			surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033) --шапка

			surface.SetDrawColor(Color( 138, 149, 151, 60))
			surface.DrawLine(ScrW() * 0.05, ScrH() * 0.0325, ScrW() * 0.3, ScrH() * 0.0325)

			draw.DrawText("Диалоговое окно", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

			surface.SetDrawColor( Color(125, 105, 0, 40) )
			surface.SetMaterial( Material("lgh/circle_gradient.png") )
			surface.DrawTexturedRectUV( -ScrW() * 0.01, ScrH() * 0.477, ScrW() * 0.35, ScrH() * 0.032, 1, 0.9, 0, 0.3 )
		end

		self.content = vgui.Create( "Panel", self )
		self.content:Dock( FILL )

		self.btnlist = {}

		self.text = self.content:Add( "DPanel" )
		self.text:SetPos( ScrW()*0.01, 0 )
		self.text:SetSize( ScrW()*0.33, ScrH()*0.46 ) --текст

		function self.text:Paint( w, h )
			surface.SetDrawColor(0, 0, 0, 0) 
			surface.DrawTexturedRect(0, 0, w, h) 
		end

		self.dialouge = vgui.Create( "DScrollPanel", self.text )
		self.dialouge:DockMargin(10, 10, 10, 10)
		self.dialouge:Dock( FILL )
		local sbar = self.dialouge:GetVBar()
		function sbar:Paint( w, h )
			surface.SetDrawColor(Color( 30, 30, 30, 200))
			surface.DrawRect(0, 0, w, h)
		end
		function sbar.btnUp:Paint( w, h )
			surface.SetDrawColor(Color( 0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)
		end
		function sbar.btnDown:Paint( w, h )
			surface.SetDrawColor(Color( 0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)
		end
		function sbar.btnGrip:Paint( w, h )
			surface.SetDrawColor(Color( 60, 60, 60, 200))
			surface.DrawRect(0, 0, w, h)
		end 

		bottom = vgui.Create( "DFrame" )
		bottom:SetSize( ScrW()*0.35, ScrH()*0.22 )
		bottom:SetPos( ScrW()*0.325, ScrH()*0.675 )
		bottom:SetDraggable(false)
		bottom:SetTitle("")
		bottom:ShowCloseButton(false)

		function bottom:Paint(w, h) --xxx
			nut.util.drawBlur(self, 10)
			surface.SetDrawColor(Color( 30, 30, 30, 230))
			surface.DrawRect( 0, 0, w, h )
			surface.DrawOutlinedRect(0, 0, w, h)

			surface.SetDrawColor(0, 0, 14, 150)
			surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033)

			surface.SetDrawColor(Color( 30, 30, 30, 50))
			surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033) --шапка

			surface.SetDrawColor(Color( 138, 149, 151, 60))
			surface.DrawLine(ScrW() * 0.05, ScrH() * 0.0325, ScrW() * 0.3, ScrH() * 0.0325)

			draw.DrawText("Выбор реплики", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )
		end

		right_icon = vgui.Create( "DFrame" )
		right_icon:SetSize( ScrW()*0.13, ScrH()*0.24 )
		right_icon:SetPos( ScrW()*0.682, ScrH()*0.16 )
		right_icon:SetDraggable(false)
		right_icon:SetTitle("")
		right_icon:ShowCloseButton(false)

		right_icon.model = right_icon:Add("nutModelPanel")
		right_icon.model:SetModel(LocalPlayer():getChar():getModel())
		right_icon.model:SetSize(ScrW() * 0.085, ScrH() * 0.121)
		right_icon.model:SetPos(ScrW() * 0.022, ScrH() * 0.048)
		function right_icon.model:LayoutEntity( Entity ) return end
		if right_icon.model.Entity:LookupBone("bip01_head") then
			local headpos = right_icon.model.Entity:GetBonePosition( right_icon.model.Entity:LookupBone("bip01_head"))
			right_icon.model:SetLookAt(headpos)
			right_icon.model:SetCamPos(headpos-Vector( -18, 2.5, 4 ))
		end
		right_icon.model:SetFOV(70)

		local reptext = LocalPlayer():getChar():getData("rep")
		local ranktext = LocalPlayer():getChar():getData("rank")

		function right_icon:Paint(w, h) --xxx
			nut.util.drawBlur(self, 10)
			surface.SetDrawColor(Color( 30, 30, 30, 230))
			surface.DrawRect( 0, 0, w, h )
			surface.DrawOutlinedRect(0, 0, w, h)

			surface.SetDrawColor(0, 0, 14, 150)
			surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033)

			surface.SetDrawColor(Color( 30, 30, 30, 50))
			surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033) --шапка

			draw.DrawText(LocalPlayer():Name(), "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

			surface.SetDrawColor(Color( 138, 149, 151, 60))
			surface.DrawLine(ScrW() * 0.008, ScrH() * 0.0325, ScrW() * 0.123, ScrH() * 0.0325)

			surface.SetDrawColor(0, 0, 14, 150)
			surface.DrawRect(ScrW() * 0.008, ScrH() * 0.045, ScrW() * 0.116, ScrH() * 0.125) --фон модели игрока

			surface.SetDrawColor(Color( 0, 0, 0, 255))
			surface.DrawOutlinedRect(ScrW() * 0.008, ScrH() * 0.045, ScrW() * 0.116, ScrH() * 0.125) --обводка модели игрока

			draw.DrawText("Фракция:", "Roh10", ScrW() * 0.008, ScrH() * 0.17, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --team.GetColor(character:getFaction()) Фракция
			draw.DrawText(team.GetName(LocalPlayer():Team()), "Roh10", ScrW() * 0.123, ScrH() * 0.17, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			draw.DrawText("Ранг:", "Roh10", ScrW() * 0.008, ScrH() * 0.19, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --Ранг

			if (ranktext >= 12000) then
				draw.DrawText("Легенда", "Roh10", ScrW() * 0.123, ScrH() * 0.19, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (ranktext >= 5200 and ranktext <= 11999) then
				draw.DrawText("Мастер", "Roh10", ScrW() * 0.123, ScrH() * 0.19, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (ranktext >= 3200 and ranktext <= 5199) then
				draw.DrawText("Эксперт", "Roh10", ScrW() * 0.123, ScrH() * 0.19, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (ranktext >= 2000 and ranktext <= 3199) then
				draw.DrawText("Ветеран", "Roh10", ScrW() * 0.123, ScrH() * 0.19, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (ranktext >= 1000 and ranktext <= 1999) then
				draw.DrawText("Профессионал", "Roh10", ScrW() * 0.123, ScrH() * 0.19, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (ranktext >= 600 and ranktext <= 999) then
				draw.DrawText("Опытный", "Roh10", ScrW() * 0.123, ScrH() * 0.19, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (ranktext >= 200 and ranktext <= 599) then
				draw.DrawText("Стажер", "Roh10", ScrW() * 0.123, ScrH() * 0.19, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (ranktext <= 199) then
				draw.DrawText("Новичок", "Roh10", ScrW() * 0.123, ScrH() * 0.19, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			end

			draw.DrawText("Репутация:", "Roh10", ScrW() * 0.008, ScrH() * 0.21, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --Репутация

			if (reptext >= 2000) then
				draw.DrawText("Великолепно", "Roh10", ScrW() * 0.123, ScrH() * 0.21, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext >= 1000 and reptext <= 1999) then
				draw.DrawText("Отлично", "Roh10", ScrW() * 0.123, ScrH() * 0.21, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext >= 500 and reptext <= 999) then
				draw.DrawText("Оч.Хорошо", "Roh10", ScrW() * 0.123, ScrH() * 0.21, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext > 100 and reptext <= 499) then
				draw.DrawText("Хорошо", "Roh10", ScrW() * 0.123, ScrH() * 0.21, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext >= -29 and reptext <= 99) then
				draw.DrawText("Безразлично", "Roh10", ScrW() * 0.123, ScrH() * 0.21, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext >= -79 and reptext <= -30) then
				draw.DrawText("Плохо", "Roh10", ScrW() * 0.123, ScrH() * 0.21, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext >= -299 and reptext <= -80) then
				draw.DrawText("Оч.Плохо", "Roh10", ScrW() * 0.123, ScrH() * 0.21, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext >= -599 and reptext <= -300) then
				draw.DrawText("Ужасно", "Roh10", ScrW() * 0.123, ScrH() * 0.21, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			elseif (reptext <= -600) then
				draw.DrawText("Хуже всех", "Roh10", ScrW() * 0.123, ScrH() * 0.21, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
			end
		end

		left_icon = vgui.Create( "DFrame" )
		left_icon:SetSize( ScrW()*0.13, ScrH()*0.24 )
		left_icon:SetPos( ScrW()*0.1885, ScrH()*0.16 )
		left_icon:SetDraggable(false)
		left_icon:SetTitle("")
		left_icon:ShowCloseButton(false)

		left_icon.model = left_icon:Add("nutModelPanel")
		left_icon.model:SetModel(client_time_tolkermodel)
		left_icon.model:SetSize(ScrW() * 0.085, ScrH() * 0.121)
		left_icon.model:SetPos(ScrW() * 0.022, ScrH() * 0.048)
		function left_icon.model:LayoutEntity( Entity ) return end
		if left_icon.model.Entity:LookupBone("bip01_head") then
			local headpos = left_icon.model.Entity:GetBonePosition( left_icon.model.Entity:LookupBone("bip01_head"))
			left_icon.model:SetLookAt(headpos)
			left_icon.model:SetCamPos(headpos-Vector( -18, 2.5, 4 ))
		end
		left_icon.model:SetFOV(70)

		function left_icon:Paint(w, h)
			nut.util.drawBlur(self, 10)
			surface.SetDrawColor(Color( 30, 30, 30, 230))
			surface.DrawRect( 0, 0, w, h )
			surface.DrawOutlinedRect(0, 0, w, h)

			surface.SetDrawColor(0, 0, 14, 150)
			surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033)

			surface.SetDrawColor(Color( 30, 30, 30, 50))
			surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033) --шапка

			draw.DrawText(client_time_tolkername, "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

			surface.SetDrawColor(Color( 138, 149, 151, 60))
			surface.DrawLine(ScrW() * 0.008, ScrH() * 0.0325, ScrW() * 0.123, ScrH() * 0.0325)

			surface.SetDrawColor(0, 0, 14, 150)
			surface.DrawRect(ScrW() * 0.008, ScrH() * 0.045, ScrW() * 0.116, ScrH() * 0.125) --фон модели игрока

			surface.SetDrawColor(Color( 0, 0, 0, 255))
			surface.DrawOutlinedRect(ScrW() * 0.008, ScrH() * 0.045, ScrW() * 0.116, ScrH() * 0.125) --обводка модели игрока

			draw.DrawText("Группировка:", "Roh14", ScrW() * 0.008, ScrH() * 0.17, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)
			draw.DrawText(client_time_tolkerdesc, "Roh14", ScrW() * 0.123, ScrH() * 0.17, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)

			draw.DrawText("Ранг:", "Roh14", ScrW() * 0.008, ScrH() * 0.19, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --Ранг
			draw.DrawText("---", "Roh14", ScrW() * 0.123, ScrH() * 0.19, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)

			draw.DrawText("Репутация:", "Roh14", ScrW() * 0.008, ScrH() * 0.21, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --Репутация
			draw.DrawText("---", "Roh14", ScrW() * 0.123, ScrH() * 0.21, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
		end

		bottom.sdialouge = vgui.Create( "DScrollPanel", bottom )
		bottom.sdialouge:DockMargin(3, 3, 3, 3)
		bottom.sdialouge:Dock( FILL )

		openvendor = vgui.Create("DButton")
		openvendor:SetSize( ScrW() * 0.095, ScrH() * 0.0375)
		openvendor:SetPos(ScrW() * 0.4, ScrH() * 0.875)
		openvendor:SetText("Торговать")
		openvendor:SetFont("Roh20")
		openvendor:SetTextColor(Color(255, 255, 255, 210)) 
		openvendor:SetZPos(999)
		openvendor:MakePopup()

		function openvendor:Paint( w, h )
			surface.SetDrawColor(Color( 30, 30, 30, 255))
			surface.DrawRect( 0, 0, w, h )
			if self:IsDown() then 
				surface.SetDrawColor(Color( 255, 186, 0, 24))
				surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 255, 186, 0, 36))
				surface.DrawOutlinedRect(0, 0, w, h) 
			elseif self:IsHovered() then 
				surface.SetDrawColor(Color( 255, 186, 0, 12))
				surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 255, 186, 0, 24))
				surface.DrawOutlinedRect(0, 0, w, h) 
			else
				surface.SetDrawColor(Color( 30, 30, 30, 255))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 0, 0, 0, 255))
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		end
		openvendor.DoClick = function(this)
			for k, v in pairs(ents.FindInSphere( LocalPlayer():GetPos(), 120 )) do
				if (v:GetClass() == "nut_talker") then
					time_tolkername = v:getNetVar("name")
					netstream.Start("try_combine", time_tolkername)
					self:Close()
					bottom:Close()
					openvendor:Remove()
					exittalker:Remove()
					right_icon:Close()
					left_icon:Close()

					client_time_tolkermodel = nil
					client_time_tolkername = nil
					client_time_tolkerdesc = nil
					time_tolkername = nil
					collectgarbage()
				end
			end
		end

		exittalker = vgui.Create("DButton")
		exittalker:SetSize( ScrW() * 0.095, ScrH() * 0.0375)
		exittalker:SetPos(ScrW() * 0.5, ScrH() * 0.875)
		exittalker:SetText("Уйти")
		exittalker:SetFont("Roh20")
		exittalker:SetTextColor(Color(255, 255, 255, 210)) 
		exittalker:SetZPos(999)
		exittalker:MakePopup()

		function exittalker:Paint( w, h )
			surface.SetDrawColor(Color( 30, 30, 30, 255))
			surface.DrawRect( 0, 0, w, h )
			if self:IsDown() then 
				surface.SetDrawColor(Color( 255, 186, 0, 24))
				surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 255, 186, 0, 36))
				surface.DrawOutlinedRect(0, 0, w, h) 
			elseif self:IsHovered() then 
				surface.SetDrawColor(Color( 255, 186, 0, 12))
				surface.SetMaterial(nut.util.getMaterial("gui/center_gradient"))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 255, 186, 0, 24))
				surface.DrawOutlinedRect(0, 0, w, h) 
			else
				surface.SetDrawColor(Color( 30, 30, 30, 255))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 0, 0, 0, 255))
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		end
		exittalker.DoClick = function(this)
			self:Close()
			bottom:Close()
			openvendor:Remove()
			exittalker:Remove()
			right_icon:Close()
			left_icon:Close()

			client_time_tolkermodel = nil
			client_time_tolkername = nil
			client_time_tolkerdesc = nil
			time_tolkername = nil
			collectgarbage()
		end

	end

	function PANEL:SetEntity( ent )
		self.name = ent:getNetVar( "name", "John Doe" )
		self.dialogue = ent:getNetVar( "dialogue", PLUGIN.defaultDialogue )
		self:AddChat( self.name, self.dialogue.npc._start )
		self:AddSelection( self.dialogue.player )
	end

	function PANEL:AddSelection( tbl )
		for k, v in pairs( tbl ) do
			local btn = bottom.sdialouge:Add( "DButton" ) 
			btn:SetFont( "Nut_NPCChatSel" )
			btn:SetTextColor( color_red )

			if LocalPlayer():HasQuest(string.gsub( k, "!", "" )) then
				btn:SetText("По поводу задания...")
			else
				btn:SetText(v)
			end

			btn:SetContentAlignment( 1 )
			btn.Paint = function(s, w, h) 
				s:SetColor(s:IsHovered() and Color(62, 95, 138) or Color(211, 211, 211))
			end
			btn:DockMargin(0, 0, 0, 0)
			btn:Dock(TOP)
			btn.DoClick = function()

				if k == "quit" then 
					self:Close()
					bottom:Close()
					openvendor:Remove() 
					exittalker:Remove() 
					right_icon:Close() 
					left_icon:Close()

					client_time_tolkermodel = nil
					client_time_tolkername = nil
					client_time_tolkerdesc = nil
					time_tolkername = nil
					collectgarbage()
					return 
				end

				if k == "!quest_fixarmor" then
					vgui.Create("fixmygearplz_tehnik")
					self:Close()
					bottom:Close()
					openvendor:Remove()
					exittalker:Remove()
					right_icon:Close()
					left_icon:Close()

					client_time_tolkermodel = nil
					client_time_tolkername = nil
					client_time_tolkerdesc = nil
					time_tolkername = nil
					collectgarbage()
					return
				end

				if self.talking then return end

				timer.Simple(0.01, function()
				if LocalPlayer():HasQuest(string.gsub( k, "!", "" )) then
					btn:SetText("По поводу задания...")
					elseif !LocalPlayer():HasQuest(string.gsub( k, "!", "" )) then
						btn:SetText(v)
					end
				end)

				local dat = self.dialogue.npc[ k ]

				self:AddChat( LocalPlayer():Name(), btn:GetText() )

				self.talking = true
				if !( string.Left( k, 1 ) == "!" ) then
					timer.Simple( math.Rand( PLUGIN.chatDelay.min, PLUGIN.chatDelay.max ), function()
						if self:IsValid() then
							self.talking = false
							self:AddChat( self.name, self.dialogue.npc[ k ] )
						end
					end)
				else
					netstream.Start("nut_DialogueMessage", { name = self.name, request = k } )
					self.talking = true
				end
			end
		end
	end
	function PANEL:AddName( str )
		local lab = self.dialouge:Add( "DLabel" )
		lab:SetFont( "Nut_NPCChatName" )
		--lab:SetTextColor( Color(255, 176, 46) )
		lab:SetTextColor( Color(42, 82, 190) )
		lab:SetText(str )
		lab:SizeToContents()
		lab:DockMargin(3, 3, 3, 0)
		lab:Dock(TOP)
	end
	function PANEL:AddText( str )
		local lab = self.dialouge:Add( "DLabel" )
		lab:SetTextColor( Color(211, 211, 211) )
		lab:SetFont( "Nut_NPCChatText" )
		lab:SetText( str )
		lab:SetWrap( true )
		lab:DockMargin(10, 0, 3, 5)
		lab:Dock(TOP)
		lab:SetAutoStretchVertical( true )
	end
	function PANEL:AddCustomText( str, font, color )
		local lab = self.dialouge:Add( "DLabel" )
		lab:SetTextColor( color or Color(211, 211, 211) )
		lab:SetFont( font or "Nut_NPCChatText" )
		lab:SetText( str )
		lab:SetWrap( true )
		lab:DockMargin(10, 0, 3, 5)
		lab:Dock(TOP)
		lab:SetAutoStretchVertical( true )
	end
	function PANEL:AddChat( str1, str2 )
		self:AddName( str1 )
		self:AddText( str2 )
	end

	vgui.Register( "Nut_Dialogue", PANEL, "DFrame" )
end

/*---------------------------------------------------------
	DIALOGUE EDITOR PANEL
	SORRY FOR NASTY LOOKING CODE
	I WAS LAZY
	- rebel1324
---------------------------------------------------------*/

local PANEL = {}
function PANEL:Init()
	self:MakePopup()
	--self:Center()
	local sh = ScrH()/1.5
	self:SetTitle( " " )
	self:SetSize( sh*.8, sh )
	self:SetPos( 0, (ScrH()-sh)/2)
	--print( self:GetPos() )
	self.content = vgui.Create( "DPanel", self )
	self.content:Dock( FILL )
	self.btnlist = {}
	
	self.scroll = self.content:Add( "DScrollPanel" )
	self.scroll:Dock( FILL )
end

function PANEL:SetEntity( entity )
		local dialogue = entity:getNetVar( "dialogue", PLUGIN.defaultDialogue )
		local info = self.scroll:Add("DLabel")
		info:SetText("Left Click: Set UID, Right Click: Set Dialogue")
		info:DockMargin(3, 3, 3, 3)
		info:Dock(TOP)
		info:SetTextColor(color_white)
		info:SetFont("nut_ScoreTeamFont")
		info:SizeToContents()
		--- NPC dialogue
		local npcd = self.scroll:Add("DLabel")
		npcd:SetText("NPC Dialogues")
		npcd:DockMargin(3, 3, 3, 3)
		npcd:Dock(TOP)
		npcd:SetTextColor(color_white)
		npcd:SetFont("nut_ScoreTeamFont")
		npcd:SizeToContents()
		self.npcd = self.scroll:Add( "DListView" )
		self.npcd:SetPos( 0, 0 )
		self.npcd:SetSize( self.content:GetWide(), self.content:GetTall() )
		self.npcd:AddColumn("Unique ID")
		self.npcd:AddColumn("Dialogue")
		self.npcd.OnClickLine = function( p, l, s )				
			local menu = DermaMenu()
			menu:AddOption( "Write Unique ID", function()
				if l.uid == "_start" then return end
				Derma_StringRequest( "Write Unique ID", "Write Unique ID what you want to assign", l.uid, function( text )
					l:SetValue(1,  text or l.uid)
					l.uid = text
				end )
			end):SetImage("icon16/textfield_key.png")
			menu:AddOption( "Write Dialogue", function()
				Derma_StringRequest( "Write Dialogue", "Write Dialouge what you want to assign", l.text, function( text )
					l:SetValue(2,  text or l.text)
					l.text = text
				end )
			end):SetImage("icon16/textfield_rename.png")
			menu:AddOption( "Delete Line", function()
				if l.uid == "_start" then return end
				l:Remove()
				self.npcd.l = nil
			end):SetImage("icon16/textfield_delete.png")
			menu:AddOption( "Add New Line", function()	
				local line = self.npcd:AddLine( "uniqueid", "Sample Dialogue.")
			end):SetImage("icon16/textfield_add.png")
			menu:Open()
		end
		self.npcd:Dock( TOP )
		self.npcd:SetTall( 150 )
		--- Player dialogue
		local playerd = self.scroll:Add("DLabel")
		playerd:SetText("Player Dialogues")
		playerd:DockMargin(3, 3, 3, 3)
		playerd:Dock(TOP)
		playerd:SetTextColor(color_white)
		playerd:SetFont("nut_ScoreTeamFont")
		playerd:SizeToContents()
		self.plyd = self.scroll:Add( "DListView" )
		self.plyd:SetPos( 0, 0 )
		self.plyd:SetSize( self.content:GetWide(), self.content:GetTall() )
		self.plyd:AddColumn("Unique ID")
		self.plyd:AddColumn("Dialogue")
		self.plyd.OnClickLine = function( p, l, s )
			local menu = DermaMenu()
			menu:AddOption( "Write Unique ID", function()
				if l.uid == "quit" then return end
				Derma_StringRequest( "Write Unique ID", "Write Unique ID what you want to assign", l.uid, function( text )
					l:SetValue(1,  text or l.uid)
					l.uid = text
				end )
			end):SetImage("icon16/textfield_key.png")
			menu:AddOption( "Write Dialogue", function()
				Derma_StringRequest( "Write Dialogue", "Write Dialouge what you want to assign", l.text, function( text )
					l:SetValue(2,  text or l.text)
					l.text = text
				end )
			end):SetImage("icon16/textfield_rename.png")
			menu:AddOption( "Delete Line", function()
				if l.uid == "quit" then return end
				l:Remove()
				self.plyd.l = nil
			end):SetImage("icon16/textfield_delete.png")
			menu:AddOption( "Add New Line", function()	
				local line = self.plyd:AddLine( "uniqueid", "Sample Dialogue.")
			end):SetImage("icon16/textfield_add.png")
			menu:Open()
		end
		self.plyd:Dock( TOP )
		self.plyd:SetTall( 150 )
		for k, v in pairs( dialogue.npc ) do
			local line = self.npcd:AddLine( k, v )
			line.text = v
			line.uid = k 
		end
		for k, v in pairs( dialogue.player ) do
			local line = self.plyd:AddLine( k, v )
			line.text = v
			line.uid = k
		end
	---------------------
		self.factions = {}
		local faction = self.scroll:Add("DLabel")
		faction:SetText("Factions")
		faction:DockMargin(3, 3, 3, 3)
		faction:Dock(TOP)
		faction:SetTextColor(color_white)
		faction:SetFont("nut_ScoreTeamFont")
		faction:SizeToContents()
		local factionData = entity:getNetVar("factiondata", {})
		for k, v in SortedPairs(nut.faction.teams) do
			local panel = self.scroll:Add("DCheckBoxLabel")
			panel:Dock(TOP)
			panel:SetText("Talk to "..v.name..".")
			panel:SetValue(0)
			panel:DockMargin(12, 3, 3, 3)
			panel:SetDark(true)
			if (factionData[k]) then
				panel:SetChecked(factionData[k])
			end
			self.factions[k] = panel
		end
		local classes = self.scroll:Add("DLabel")
		classes:SetText("Classes")
		classes:DockMargin(3, 3, 3, 3)
		classes:Dock(TOP)
		classes:SetTextColor(color_white)
		classes:SetFont("nut_ScoreTeamFont")
		classes:SizeToContents()
		self.classes = {}
		local classData = entity:getNetVar("classdata", {})
		for k, v in SortedPairs(nut.class.list) do
			local panel = self.scroll:Add("DCheckBoxLabel")
			panel:Dock(TOP)
			panel:SetText("Sell to "..v.name..".")
			panel:SetValue(0)
			panel:DockMargin(12, 3, 3, 3)
			panel:SetDark(true)
			if (classData[k]) then
				panel:SetChecked(classData[k])
			end
			self.classes[k] = panel
		end
		local name = self.scroll:Add("DLabel")
		name:SetText("Name")
		name:DockMargin(3, 3, 3, 3)
		name:Dock(TOP)
		name:SetTextColor(color_white)
		name:SetFont("nut_ScoreTeamFont")
		name:SizeToContents()
		self.name = self.scroll:Add("DTextEntry")
		self.name:Dock(TOP)
		self.name:DockMargin(3, 3, 3, 3)
		self.name:SetText(entity:getNetVar("name", "John Doe"))
		-- Description
		local desc = self.scroll:Add("DLabel")
		desc:SetText("Description")
		desc:DockMargin(3, 3, 3, 3)
		desc:Dock(TOP)
		desc:SetTextColor(color_white)
		desc:SetFont("nut_ScoreTeamFont")
		desc:SizeToContents()
		self.desc = self.scroll:Add("DTextEntry")
		self.desc:Dock(TOP)
		self.desc:DockMargin(3, 3, 3, 3)
		self.desc:SetText(entity:getNetVar("desc", L"no_desc"))
		-- Anim
		local anim = self.scroll:Add("DLabel")
		anim:SetText("Anim")
		anim:DockMargin(3, 3, 3, 3)
		anim:Dock(TOP)
		anim:SetTextColor(color_white)
		anim:SetFont("nut_ScoreTeamFont")
		anim:SizeToContents()
		self.anim = self.scroll:Add("DTextEntry")
		self.anim:Dock(TOP)
		self.anim:DockMargin(3, 3, 3, 3)
		self.anim:SetText(entity:getNetVar("anim", ""))
		-- Sound
		local sound = self.scroll:Add("DLabel")
		sound:SetText("Sound")
		sound:DockMargin(3, 3, 3, 3)
		sound:Dock(TOP)
		sound:SetTextColor(color_white)
		sound:SetFont("nut_ScoreTeamFont")
		sound:SizeToContents()
		self.sound = self.scroll:Add("DTextEntry")
		self.sound:Dock(TOP)
		self.sound:DockMargin(3, 3, 3, 3)
		self.sound:SetText(entity:getNetVar("sound", ""))
		-- Model
		local model = self.scroll:Add("DLabel")
		model:SetText("Model")
		model:DockMargin(3, 3, 3, 3)
		model:Dock(TOP)
		model:SetTextColor(Color(60, 60, 60))
		model:SetFont("nut_ScoreTeamFont")
		model:SizeToContents()
		self.model = self.scroll:Add("DTextEntry")
		self.model:Dock(TOP)
		self.model:DockMargin(3, 3, 3, 3)
		self.model:SetText(entity:GetModel())
		-- Save button.
		self.save = self:Add("DButton")
		self.save:Dock(BOTTOM)
		self.save:DockMargin(0, 5, 0, 0)
		self.save:SetText("Save")
		self.save.DoClick = function()
			if (IsValid(entity) and (self.nextSend or 0) < CurTime()) then
				self.nextSend = CurTime() + 1
				local dialogue = {
					npc = {},
					player = {},
				}
				for k, v in pairs(self.npcd:GetLines()) do
					if v:IsValid() then
						dialogue.npc[ v.uid ] = v.text
					end
				end
				for k, v in pairs(self.plyd:GetLines()) do
					if v:IsValid() then
						dialogue.player[ v.uid ] = v.text
					end
				end
				local factionData = {}
				for k, v in pairs(self.factions) do
					if (v:GetChecked()) then
						factionData[k] = true
					end
				end
				local classData = {}
				for k, v in pairs(self.classes) do
					if (v:GetChecked()) then
						classData[k] = true
					end
				end
				netstream.Start("nut_DialogueData", { entity, dialogue, factionData, classData, self.name:GetText(), self.desc:GetText(), self.model:GetText(), self.anim:GetText(), self.sound:GetText() or entity:GetModel() } )
				self:Close()
			end
		end
end
vgui.Register( "Nut_DialogueEditor", PANEL, "DFrame" )


function PLUGIN:ShouldDrawTargetEntity(entity)
	if (string.lower(entity:GetClass()) == "nut_talker") then
		return true
	end
end

function PLUGIN:DrawTargetID(entity, x, y, alpha)
	if (string.lower(entity:GetClass()) == "nut_talker") then
		local mainColor = nut.config.mainColor
		local color = Color(mainColor.r, mainColor.g, mainColor.b, alpha)

		nut.util.DrawText(x, y, entity:getNetVar("name", "John Doe"), color)
			y = y + nut.config.targetTall
		nut.util.DrawText(x, y, entity:getNetVar("desc", nut.lang.Get("no_desc")), Color(255, 255, 255, alpha), "nut_TargetFontSmall")
	end
end