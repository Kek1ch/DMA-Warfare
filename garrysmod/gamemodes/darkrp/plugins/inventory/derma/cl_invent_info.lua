local PANEL = {}

function PANEL:Init(uniqueID)

	self:SetSize(ScrW() * 0.3059, ScrH() * 0.202)
	self:MakePopup()
	--self:Center()
	self:SetTitle("")
	self:ShowCloseButton(false)
	self:SetDraggable(false)

	self.icon = self:Add("nutModelPanel")
	self.icon:SetSize(ScrW() * 0.085, ScrH() * 0.121)
	self.icon:SetPos(ScrW() * 0.0115, ScrH() * 0.06)
	local playermodel = LocalPlayer():getChar():getModel()
	if (playermodel) then
		self.icon:SetModel(string.gsub(playermodel, "spenser", "hdmodels"))
		
		if self.icon.Entity:LookupBone("bip01_head") then
			function self.icon:LayoutEntity( Entity ) return end
			local headpos = self.icon.Entity:GetBonePosition( self.icon.Entity:LookupBone("bip01_head"))

			self.icon:SetLookAt(headpos)
			self.icon:SetCamPos(headpos-Vector( -18, 2.5, 4 ))
			self.icon:SetFOV(70)
		end
	end
end

function PANEL:Paint(w, h)
	nut.util.drawBlur(self, 10)
	surface.SetDrawColor(Color( 20, 20, 20, 220))
	surface.DrawRect( 0, 0, w, h )
	surface.DrawOutlinedRect(0, 0, w, h)

	surface.SetDrawColor(0, 0, 14, 150)
	surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033)

	surface.SetDrawColor(Color( 30, 30, 30, 90))
	surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033) --шапка

	surface.SetDrawColor(Color( 138, 149, 151, 60))
	surface.DrawLine(ScrW() * 0.018, ScrH() * 0.0325, ScrW() * 0.29, ScrH() * 0.0325)

	surface.SetDrawColor(0, 0, 14, 150)
	surface.DrawRect(ScrW() * 0.0115, ScrH() * 0.0575, ScrW() * 0.085, ScrH() * 0.125) --фон модели игрока

	surface.SetDrawColor(Color( 0, 0, 0, 255))
	surface.DrawOutlinedRect(ScrW() * 0.0115, ScrH() * 0.0575, ScrW() * 0.085, ScrH() * 0.125) --обводка модели игрока

	local reptext = LocalPlayer():getChar():getData("rep")
	local ranktext = LocalPlayer():getChar():getData("rank")

	draw.DrawText("Персонаж", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)

	draw.DrawText(LocalPlayer():getChar():getName(), "Roh20", ScrW() * 0.1, ScrH() * 0.06, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)

	draw.DrawText("Группировка:", "Roh10", ScrW() * 0.1, ScrH() * 0.085, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT) --team.GetColor(character:getFaction()) Фракция
	draw.DrawText(team.GetName(LocalPlayer():Team()), "Roh10", ScrW() * 0.292, ScrH() * 0.085, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)

	draw.DrawText("Ранг:", "Roh10", ScrW() * 0.1, ScrH() * 0.106, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)

	if (ranktext >= 12000) then --сюда репутацию
		draw.DrawText("Легенда", "Roh10", ScrW() * 0.292, ScrH() * 0.106, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	elseif (ranktext >= 5200 and ranktext <= 11999) then
		draw.DrawText("Мастер", "Roh10", ScrW() * 0.292, ScrH() * 0.106, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	elseif (ranktext >= 3200 and ranktext <= 5199) then
		draw.DrawText("Эксперт", "Roh10", ScrW() * 0.292, ScrH() * 0.106, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	elseif (ranktext >= 2000 and ranktext <= 3199) then
		draw.DrawText("Ветеран", "Roh10", ScrW() * 0.292, ScrH() * 0.106, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	elseif (ranktext >= 1000 and ranktext <= 1999) then
		draw.DrawText("Профессионал", "Roh10", ScrW() * 0.292, ScrH() * 0.106, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	elseif (ranktext >= 600 and ranktext <= 999) then
		draw.DrawText("Опытный", "Roh10", ScrW() * 0.292, ScrH() * 0.106, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	elseif (ranktext >= 200 and ranktext <= 599) then
		draw.DrawText("Стажер", "Roh10", ScrW() * 0.292, ScrH() * 0.106, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	elseif (ranktext <= 199) then
		draw.DrawText("Новичок", "Roh10", ScrW() * 0.292, ScrH() * 0.106, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	end

	draw.DrawText("Репутация:", "Roh10", ScrW() * 0.1, ScrH() * 0.127, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)

	if (reptext >= 2000) then 
		draw.DrawText("Великолепно", "Roh10", ScrW() * 0.292, ScrH() * 0.127, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	elseif (reptext >= 1000 and reptext <= 1999) then
		draw.DrawText("Отлично", "Roh10", ScrW() * 0.292, ScrH() * 0.127, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	elseif (reptext >= 500 and reptext <= 999) then
		draw.DrawText("Оч.Хорошо", "Roh10", ScrW() * 0.292, ScrH() * 0.127, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	elseif (reptext >= 100 and reptext <= 499) then
		draw.DrawText("Хорошо", "Roh10", ScrW() * 0.292, ScrH() * 0.127, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	elseif (reptext >= -29 and reptext <= 99) then
		draw.DrawText("Безразлично", "Roh10", ScrW() * 0.292, ScrH() * 0.127, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	elseif (reptext >= -79 and reptext <= -30) then
		draw.DrawText("Плохо", "Roh10", ScrW() * 0.292, ScrH() * 0.127, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	elseif (reptext >= -299 and reptext <= -80) then
		draw.DrawText("Оч.Плохо", "Roh10", ScrW() * 0.292, ScrH() * 0.127, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	elseif (reptext >= -599 and reptext <= -300) then
		draw.DrawText("Ужасно", "Roh10", ScrW() * 0.292, ScrH() * 0.127, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	elseif (reptext <= -600) then
		draw.DrawText("Хуже всех", "Roh10", ScrW() * 0.292, ScrH() * 0.127, Color(255, 255, 255, 210), TEXT_ALIGN_RIGHT)
	end

	surface.SetDrawColor(0, 0, 14, 150)
	surface.DrawRect(ScrW() * 0.1, ScrH() * 0.15, ScrW() * 0.193, ScrH() * 0.0325) --информация о предмете

	draw.DrawText(LocalPlayer():getChar():getMoney().."₽", "Roh20", ScrW() * 0.105, ScrH() * 0.155, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)
end

vgui.Register("invent_info_kek", PANEL, "DFrame")
netstream.Hook("invent_info_kek", function()
	invent_info_kek = vgui.Create("invent_info_kek")
end)