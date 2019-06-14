local PANEL = {}

local function PaintButtons( s, w, h )
	if s:GetDisabled() then
		surface.SetDrawColor( Color(255, 255, 255, 255) )
		surface.SetMaterial( Material("daui/locked_button.png") )
		surface.DrawTexturedRect(0, 0, w, h)

		surface.SetDrawColor( Color(255, 255, 255, 255) )
		surface.SetMaterial( Material("daui/lock_icon_v3.png") )
		surface.DrawTexturedRect(ScrW() * 0.1085, ScrH() * 0.01, ScrW() * 0.007, ScrH() * 0.012)

		surface.SetDrawColor(Color( 0, 0, 0, 235))
		surface.DrawOutlinedRect(0, 0, w, h)
	else
		if s:IsDown() then 
			surface.SetDrawColor(Color( 255, 176, 46, 40))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 176, 46, 45))
			surface.DrawOutlinedRect(0, 0, w, h)
		elseif s:IsHovered() then 
			surface.SetDrawColor(Color( 255, 176, 46, 20))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 176, 46, 25))
			surface.DrawOutlinedRect(0, 0, w, h)
		else
			surface.SetDrawColor(Color( 30, 30, 30, 200))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 0, 0, 0, 235))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
	end
end

local tips_table = {
"Сломался чат? - fixchatplz в консоль",
"F3 позволяет узнать вас игроку",
"В F1 можно изменить описание персонажа",
"Для отмены действия нажмите Пробел",
"Донат меню - F4"
}

local random_tip = table.Random(tips_table)

function PANEL:Init()
	self:SetSize(ScrW() * 0.15, ScrH() * 0.5)
	self:MakePopup()
	self:SetPos(ScrW() * 0.02, ScrH() * 0.03)
	self:SetTitle("")
	self:ShowCloseButton(false)
	self:SetDraggable(false)
	input.SetCursorPos( ScrW() * 0.09, ScrH() * 0.23 )

	self.dscrollact = self:Add("DScrollPanel")
	self.dscrollact:SetSize(ScrW() * 0.129, ScrH() * 0.356)
	self.dscrollact:SetPos(ScrW() * 0.01, ScrH() * 0.074)
	self.dscrollact:SetDrawBackground(false)

	local sbar = self.dscrollact:GetVBar()
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

	self.button_a = self.dscrollact:Add("DButton")
	self.button_a:Dock(TOP)
	self.button_a:DockMargin(3, 3, 3, 0)
	self.button_a:SetTall(ScrH() * 0.032)
	self.button_a:SetText("Сидеть на земле #1")
	self.button_a:SetFont("Dma6")
	self.button_a:SetTextColor(Color(255, 255, 255, 210))
	self.button_a.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_a:GetValue()) then self.button_a:SetDisabled(true) end
	self.button_a.DoClick = function(client)
		LocalPlayer():ConCommand("say /actitem_3_attack_0")
		surface.PlaySound("buttons/button3.wav")
	end

	self.button_b = self.dscrollact:Add("DButton")
	self.button_b:Dock(TOP)
	self.button_b:DockMargin(3, 3, 3, 0)
	self.button_b:SetTall(ScrH() * 0.032)
	self.button_b:SetText("Сидеть на земле #2")
	self.button_b:SetFont("Dma6")
	self.button_b:SetTextColor(Color(255, 255, 255, 210))
	self.button_b.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_b:GetValue()) then self.button_b:SetDisabled(true) end
	self.button_b.DoClick = function(client)
		LocalPlayer():ConCommand("say /actidler_0_to_sit_1")
	end

	self.button_c = self.dscrollact:Add("DButton")
	self.button_c:Dock(TOP)
	self.button_c:DockMargin(3, 3, 3, 0)
	self.button_c:SetTall(ScrH() * 0.032)
	self.button_c:SetText("Надеть снаряжение")
	self.button_c:SetFont("Dma6")
	self.button_c:SetTextColor(Color(255, 255, 255, 210))
	self.button_c.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_c:GetValue()) then self.button_c:SetDisabled(true) end
	self.button_c.DoClick = function(client)
		LocalPlayer():ConCommand("say /actequip_bron")
	end

	self.button_d = self.dscrollact:Add("DButton")
	self.button_d:Dock(TOP)
	self.button_d:DockMargin(3, 3, 3, 0)
	self.button_d:SetTall(ScrH() * 0.032)
	self.button_d:SetText("Стоять с руками накрест")
	self.button_d:SetFont("Dma6")
	self.button_d:SetTextColor(Color(255, 255, 255, 210))
	self.button_d.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_d:GetValue()) then self.button_d:SetDisabled(true) end
	self.button_d.DoClick = function(client)
		LocalPlayer():ConCommand("say /actcut_scene_idle_0")
	end

	self.button_e = self.dscrollact:Add("DButton")
	self.button_e:Dock(TOP)
	self.button_e:DockMargin(3, 3, 3, 0)
	self.button_e:SetTall(ScrH() * 0.032)
	self.button_e:SetText("Лечь на спину")
	self.button_e:SetFont("Dma6")
	self.button_e:SetTextColor(Color(255, 255, 255, 210))
	self.button_e.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_e:GetValue()) then self.button_e:SetDisabled(true) end
	self.button_e.DoClick = function(client)
		LocalPlayer():ConCommand("say /actcut_scene_actor")
	end

	self.button_f = self.dscrollact:Add("DButton")
	self.button_f:Dock(TOP)
	self.button_f:DockMargin(3, 3, 3, 0)
	self.button_f:SetTall(ScrH() * 0.032)
	self.button_f:SetText("Сидеть на корточках")
	self.button_f:SetFont("Dma6")
	self.button_f:SetTextColor(Color(255, 255, 255, 210))
	self.button_f.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_f:GetValue()) then self.button_f:SetDisabled(true) end
	self.button_f.DoClick = function(client)
		LocalPlayer():ConCommand("say /actitem_0_idle")
	end

	self.button_j = self.dscrollact:Add("DButton")
	self.button_j:Dock(TOP)
	self.button_j:DockMargin(3, 3, 3, 0)
	self.button_j:SetTall(ScrH() * 0.032)
	self.button_j:SetText("Облокотиться о стену")
	self.button_j:SetFont("Dma6")
	self.button_j:SetTextColor(Color(255, 255, 255, 210))
	self.button_j.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_j:GetValue()) then self.button_j:SetDisabled(true) end
	self.button_j.DoClick = function(client)
		LocalPlayer():ConCommand("say /actk_stene")
	end

	self.button_h = self.dscrollact:Add("DButton")
	self.button_h:Dock(TOP)
	self.button_h:DockMargin(3, 3, 3, 0)
	self.button_h:SetTall(ScrH() * 0.032)
	self.button_h:SetText("Нажать кнопку")
	self.button_h:SetFont("Dma6")
	self.button_h:SetTextColor(Color(255, 255, 255, 210))
	self.button_h.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_h:GetValue()) then self.button_h:SetDisabled(true) end
	self.button_h.DoClick = function(client)
		LocalPlayer():ConCommand("say /actknopka_0")
	end

	self.button_g = self.dscrollact:Add("DButton")
	self.button_g:Dock(TOP)
	self.button_g:DockMargin(3, 3, 3, 0)
	self.button_g:SetTall(ScrH() * 0.032)
	self.button_g:SetText("Стойка лидера")
	self.button_g:SetFont("Dma6")
	self.button_g:SetTextColor(Color(255, 255, 255, 210))
	self.button_g.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_g:GetValue()) then self.button_g:SetDisabled(true) end
	self.button_g.DoClick = function(client)
		LocalPlayer():ConCommand("say /actlead_0_idle_0")
	end

	self.button_k = self.dscrollact:Add("DButton")
	self.button_k:Dock(TOP)
	self.button_k:DockMargin(3, 3, 3, 0)
	self.button_k:SetTall(ScrH() * 0.032)
	self.button_k:SetText("Стойка лидера #2")
	self.button_k:SetFont("Dma6")
	self.button_k:SetTextColor(Color(255, 255, 255, 210))
	self.button_k.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_k:GetValue()) then self.button_k:SetDisabled(true) end
	self.button_k.DoClick = function(client)
		LocalPlayer():ConCommand("say /actlead_1_idle_1")
	end

	self.button_l = self.dscrollact:Add("DButton")
	self.button_l:Dock(TOP)
	self.button_l:DockMargin(3, 3, 3, 0)
	self.button_l:SetTall(ScrH() * 0.032)
	self.button_l:SetText("Спать, сидя на стуле") --(Лидер)
	self.button_l:SetFont("Dma6")
	self.button_l:SetTextColor(Color(255, 255, 255, 210))
	self.button_l.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_l:GetValue()) then self.button_l:SetDisabled(true) end
	self.button_l.DoClick = function(client)
		LocalPlayer():ConCommand("say /actlead_0_sleep_idle_0")
	end


	self.button_p = self.dscrollact:Add("DButton")
	self.button_p:Dock(TOP)
	self.button_p:DockMargin(3, 3, 3, 0)
	self.button_p:SetTall(ScrH() * 0.032)
	self.button_p:SetText("Облокотиться о стол") --(Лидер)
	self.button_p:SetFont("Dma6")
	self.button_p:SetTextColor(Color(255, 255, 255, 210))
	self.button_p.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_p:GetValue()) then self.button_p:SetDisabled(true) end
	self.button_p.DoClick = function(client)
		LocalPlayer():ConCommand("say /actlead_1_bar_idle_0")
	end

	self.button_o = self.dscrollact:Add("DButton")
	self.button_o:Dock(TOP)
	self.button_o:DockMargin(3, 3, 3, 0)
	self.button_o:SetTall(ScrH() * 0.032)
	self.button_o:SetText("Сканировать аномалию #1")
	self.button_o:SetFont("Dma6")
	self.button_o:SetTextColor(Color(255, 255, 255, 210))
	self.button_o.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_o:GetValue()) then self.button_o:SetDisabled(true) end
	self.button_o.DoClick = function(client)
		LocalPlayer():ConCommand("say /actmetering_anomalys_1_idle_1")
	end

	self.button_q = self.dscrollact:Add("DButton")
	self.button_q:Dock(TOP)
	self.button_q:DockMargin(3, 3, 3, 0)
	self.button_q:SetTall(ScrH() * 0.032)
	self.button_q:SetText("Сканировать аномалию #2")
	self.button_q:SetFont("Dma6")
	self.button_q:SetTextColor(Color(255, 255, 255, 210))
	self.button_q.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_q:GetValue()) then self.button_q:SetDisabled(true) end
	self.button_q.DoClick = function(client)
		LocalPlayer():ConCommand("say /actmetering_anomalys_0_idle_1")
	end

	self.button_r = self.dscrollact:Add("DButton")
	self.button_r:Dock(TOP)
	self.button_r:DockMargin(3, 3, 3, 0)
	self.button_r:SetTall(ScrH() * 0.032)
	self.button_r:SetText("Оружие на плече")
	self.button_r:SetFont("Dma6")
	self.button_r:SetTextColor(Color(255, 255, 255, 210))
	self.button_r.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_r:GetValue()) then self.button_r:SetDisabled(true) end
	self.button_r.DoClick = function(client)
		LocalPlayer():ConCommand("say /actnorm_talk_2_idle_0")
	end

	self.button_t = self.dscrollact:Add("DButton")
	self.button_t:Dock(TOP)
	self.button_t:DockMargin(3, 3, 3, 0)
	self.button_t:SetTall(ScrH() * 0.032)
	self.button_t:SetText("Сжаться")
	self.button_t:SetFont("Dma6")
	self.button_t:SetTextColor(Color(255, 255, 255, 210))
	self.button_t.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_t:GetValue()) then self.button_t:SetDisabled(true) end
	self.button_t.DoClick = function(client)
		LocalPlayer():ConCommand("say /actnorm_panic_stand_0")
	end

	self.button_u = self.dscrollact:Add("DButton")
	self.button_u:Dock(TOP)
	self.button_u:DockMargin(3, 3, 3, 0)
	self.button_u:SetTall(ScrH() * 0.032)
	self.button_u:SetText("Охранять")
	self.button_u:SetFont("Dma6")
	self.button_u:SetTextColor(Color(255, 255, 255, 210))
	self.button_u.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_u:GetValue()) then self.button_u:SetDisabled(true) end
	self.button_u.DoClick = function(client)
		LocalPlayer():ConCommand("say /actohrana_0")
	end

	self.button_v = self.dscrollact:Add("DButton")
	self.button_v:Dock(TOP)
	self.button_v:DockMargin(3, 3, 3, 0)
	self.button_v:SetTall(ScrH() * 0.032)
	self.button_v:SetText("Отжиматься")
	self.button_v:SetFont("Dma6")
	self.button_v:SetTextColor(Color(255, 255, 255, 210))
	self.button_v.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_v:GetValue()) then self.button_v:SetDisabled(true) end
	self.button_v.DoClick = function(client)
		LocalPlayer():ConCommand("say /actotzhim")
	end

	self.button_w = self.dscrollact:Add("DButton")
	self.button_w:Dock(TOP)
	self.button_w:DockMargin(3, 3, 3, 0)
	self.button_w:SetTall(ScrH() * 0.032)
	self.button_w:SetText("Находиться в заложниках")
	self.button_w:SetFont("Dma6")
	self.button_w:SetTextColor(Color(255, 255, 255, 210))
	self.button_w.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_w:GetValue()) then self.button_w:SetDisabled(true) end
	self.button_w.DoClick = function(client)
		LocalPlayer():ConCommand("say /actprisoner_0_sit_idle_0")
	end

	self.button_x = self.dscrollact:Add("DButton")
	self.button_x:Dock(TOP)
	self.button_x:DockMargin(3, 3, 3, 0)
	self.button_x:SetTall(ScrH() * 0.032)
	self.button_x:SetText("Присядать")
	self.button_x:SetFont("Dma6")
	self.button_x:SetTextColor(Color(255, 255, 255, 210))
	self.button_x.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_x:GetValue()) then self.button_x:SetDisabled(true) end
	self.button_x.DoClick = function(client)
		LocalPlayer():ConCommand("say /actprisyad")
	end

	self.button_y = self.dscrollact:Add("DButton")
	self.button_y:Dock(TOP)
	self.button_y:DockMargin(3, 3, 3, 0)
	self.button_y:SetTall(ScrH() * 0.032)
	self.button_y:SetText("Находиться под ПСИ")
	self.button_y:SetFont("Dma6")
	self.button_y:SetTextColor(Color(255, 255, 255, 210))
	self.button_y.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_y:GetValue()) then self.button_y:SetDisabled(true) end
	self.button_y.DoClick = function(client)
		LocalPlayer():ConCommand("say /actidle_0_to_psy_0")
	end

	self.button_z = self.dscrollact:Add("DButton")
	self.button_z:Dock(TOP)
	self.button_z:DockMargin(3, 3, 3, 0)
	self.button_z:SetTall(ScrH() * 0.032)
	self.button_z:SetText("Говорить по рации")
	self.button_z:SetFont("Dma6")
	self.button_z:SetTextColor(Color(255, 255, 255, 210))
	self.button_z.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_z:GetValue()) then self.button_z:SetDisabled(true) end
	self.button_z.DoClick = function(client)
		LocalPlayer():ConCommand("say /actracya_2_talk_0")
	end

	self.button_aa = self.dscrollact:Add("DButton")
	self.button_aa:Dock(TOP)
	self.button_aa:DockMargin(3, 3, 3, 0)
	self.button_aa:SetTall(ScrH() * 0.032)
	self.button_aa:SetText("Сидеть на копчике")
	self.button_aa:SetFont("Dma6")
	self.button_aa:SetTextColor(Color(255, 255, 255, 210))
	self.button_aa.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_aa:GetValue()) then self.button_aa:SetDisabled(true) end
	self.button_aa.DoClick = function(client)
		LocalPlayer():ConCommand("say /actsit_2_idle_0")
	end

	self.button_ab = self.dscrollact:Add("DButton")
	self.button_ab:Dock(TOP)
	self.button_ab:DockMargin(3, 3, 3, 0)
	self.button_ab:SetTall(ScrH() * 0.032)
	self.button_ab:SetText("Сидеть")
	self.button_ab:SetFont("Dma6")
	self.button_ab:SetTextColor(Color(255, 255, 255, 210))
	self.button_ab.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_ab:GetValue()) then self.button_ab:SetDisabled(true) end
	self.button_ab.DoClick = function(client)
		LocalPlayer():ConCommand("say /actsit_0_idle_1")
	end

	self.button_ad = self.dscrollact:Add("DButton")
	self.button_ad:Dock(TOP)
	self.button_ad:DockMargin(3, 3, 3, 0)
	self.button_ad:SetTall(ScrH() * 0.032)
	self.button_ad:SetText("Спать полулежа")
	self.button_ad:SetFont("Dma6")
	self.button_ad:SetTextColor(Color(255, 255, 255, 210))
	self.button_ad.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_ad:GetValue()) then self.button_ad:SetDisabled(true) end
	self.button_ad.DoClick = function(client)
		LocalPlayer():ConCommand("say /actsleep_idle_0")
	end

	self.button_ae = self.dscrollact:Add("DButton")
	self.button_ae:Dock(TOP)
	self.button_ae:DockMargin(3, 3, 3, 0)
	self.button_ae:SetTall(ScrH() * 0.032)
	self.button_ae:SetText("Спать на копчике")
	self.button_ae:SetFont("Dma6")
	self.button_ae:SetTextColor(Color(255, 255, 255, 210))
	self.button_ae.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_ae:GetValue()) then self.button_ae:SetDisabled(true) end
	self.button_ae.DoClick = function(client)
		LocalPlayer():ConCommand("say /actspit")
	end

	self.button_af = self.dscrollact:Add("DButton")
	self.button_af:Dock(TOP)
	self.button_af:DockMargin(3, 3, 3, 0)
	self.button_af:SetTall(ScrH() * 0.032)
	self.button_af:SetText("Находиться в трансе")
	self.button_af:SetFont("Dma6")
	self.button_af:SetTextColor(Color(255, 255, 255, 210))
	self.button_af.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_af:GetValue()) then self.button_af:SetDisabled(true) end
	self.button_af.DoClick = function(client)
		LocalPlayer():ConCommand("say /acttrans_1_idle_0")
	end

	self.button_ag = self.dscrollact:Add("DButton")
	self.button_ag:Dock(TOP)
	self.button_ag:DockMargin(3, 3, 3, 0)
	self.button_ag:SetTall(ScrH() * 0.032)
	self.button_ag:SetText("Облокотиться о стол")
	self.button_ag:SetFont("Dma6")
	self.button_ag:SetTextColor(Color(255, 255, 255, 210))
	self.button_ag.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_ag:GetValue()) then self.button_ag:SetDisabled(true) end
	self.button_ag.DoClick = function(client)
		LocalPlayer():ConCommand("say /actanimpoint_stay_table_idle_rnd_1")
	end

	self.button_ah = self.dscrollact:Add("DButton")
	self.button_ah:Dock(TOP)
	self.button_ah:DockMargin(3, 3, 3, 0)
	self.button_ah:SetTall(ScrH() * 0.032)
	self.button_ah:SetText("Облокотиться о стену")
	self.button_ah:SetFont("Dma6")
	self.button_ah:SetTextColor(Color(255, 255, 255, 210))
	self.button_ah.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_ah:GetValue()) then self.button_ah:SetDisabled(true) end
	self.button_ah.DoClick = function(client)
		LocalPlayer():ConCommand("say /actanimpoint_stay_wall_visual")
	end

	self.button_ai = self.dscrollact:Add("DButton")
	self.button_ai:Dock(TOP)
	self.button_ai:DockMargin(3, 3, 3, 0)
	self.button_ai:SetTall(ScrH() * 0.032)
	self.button_ai:SetText("Облокотиться о стол #1")
	self.button_ai:SetFont("Dma6")
	self.button_ai:SetTextColor(Color(255, 255, 255, 210))
	self.button_ai.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_ai:GetValue()) then self.button_ai:SetDisabled(true) end
	self.button_ai.DoClick = function(client)
		LocalPlayer():ConCommand("say /actbar_1_idle_0")
	end

	self.button_aj = self.dscrollact:Add("DButton")
	self.button_aj:Dock(TOP)
	self.button_aj:DockMargin(3, 3, 3, 0)
	self.button_aj:SetTall(ScrH() * 0.032)
	self.button_aj:SetText("Облокотиться о стол #2")
	self.button_aj:SetFont("Dma6")
	self.button_aj:SetTextColor(Color(255, 255, 255, 210))
	self.button_aj.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_aj:GetValue()) then self.button_aj:SetDisabled(true) end
	self.button_aj.DoClick = function(client)
		LocalPlayer():ConCommand("say /actbar_2_idle_0")
	end

	self.button_ak = self.dscrollact:Add("DButton")
	self.button_ak:Dock(TOP)
	self.button_ak:DockMargin(3, 3, 3, 0)
	self.button_ak:SetTall(ScrH() * 0.032)
	self.button_ak:SetText("Облокотиться о стол #3")
	self.button_ak:SetFont("Dma6")
	self.button_ak:SetTextColor(Color(255, 255, 255, 210))
	self.button_ak.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_ak:GetValue()) then self.button_ak:SetDisabled(true) end
	self.button_ak.DoClick = function(client)
		LocalPlayer():ConCommand("say /actbar_3_idle_0")
	end

	self.button_al = self.dscrollact:Add("DButton")
	self.button_al:Dock(TOP)
	self.button_al:DockMargin(3, 3, 3, 0)
	self.button_al:SetTall(ScrH() * 0.032)
	self.button_al:SetText("Руками в карманах")
	self.button_al:SetFont("Dma6")
	self.button_al:SetTextColor(Color(255, 255, 255, 210))
	self.button_al.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_al:GetValue()) then self.button_al:SetDisabled(true) end
	self.button_al.DoClick = function(client)
		LocalPlayer():ConCommand("say /actidle_band_0")
	end

	self.button_am = self.dscrollact:Add("DButton")
	self.button_am:Dock(TOP)
	self.button_am:DockMargin(3, 3, 3, 0)
	self.button_am:SetTall(ScrH() * 0.032)
	self.button_am:SetText("Стоять с поднятым оружием")
	self.button_am:SetFont("Dma5")
	self.button_am:SetTextColor(Color(255, 255, 255, 210))
	self.button_am.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_am:GetValue()) then self.button_am:SetDisabled(true) end
	self.button_am.DoClick = function(client)
		LocalPlayer():ConCommand("say /actidle_ban_2_0")
	end

	self.button_an = self.dscrollact:Add("DButton")
	self.button_an:Dock(TOP)
	self.button_an:DockMargin(3, 3, 3, 0)
	self.button_an:SetTall(ScrH() * 0.032)
	self.button_an:SetText("Стоять смирно")
	self.button_an:SetFont("Dma6")
	self.button_an:SetTextColor(Color(255, 255, 255, 210))
	self.button_an.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_an:GetValue()) then self.button_an:SetDisabled(true) end
	self.button_an.DoClick = function(client)
		LocalPlayer():ConCommand("say /actchest_0")
	end

	self.button_ao = self.dscrollact:Add("DButton")
	self.button_ao:Dock(TOP)
	self.button_ao:DockMargin(3, 3, 3, 0)
	self.button_ao:SetTall(ScrH() * 0.032)
	self.button_ao:SetText("Отдать честь")
	self.button_ao:SetFont("Dma6")
	self.button_ao:SetTextColor(Color(255, 255, 255, 210))
	self.button_ao.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_ao:GetValue()) then self.button_ao:SetDisabled(true) end
	self.button_ao.DoClick = function(client)
		LocalPlayer():ConCommand("say /actchest_1")
	end

	self.button_ap = self.dscrollact:Add("DButton")
	self.button_ap:Dock(TOP)
	self.button_ap:DockMargin(3, 3, 3, 0)
	self.button_ap:SetTall(ScrH() * 0.032)
	self.button_ap:SetText("Осмотреть тело")
	self.button_ap:SetFont("Dma6")
	self.button_ap:SetTextColor(Color(255, 255, 255, 210))
	self.button_ap.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_ap:GetValue()) then self.button_ap:SetDisabled(true) end
	self.button_ap.DoClick = function(client)
		LocalPlayer():ConCommand("say /actcr_torso_0_check_corps_0")
	end

	self.button_aq = self.dscrollact:Add("DButton")
	self.button_aq:Dock(TOP)
	self.button_aq:DockMargin(3, 3, 3, 0)
	self.button_aq:SetTall(ScrH() * 0.032)
	self.button_aq:SetText("Разжигать костер")
	self.button_aq:SetFont("Dma6")
	self.button_aq:SetTextColor(Color(255, 255, 255, 210))
	self.button_aq.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_aq:GetValue()) then self.button_aq:SetDisabled(true) end
	self.button_aq.DoClick = function(client)
		LocalPlayer():ConCommand("say /actdinamit_0")
	end

	self.button_ar = self.dscrollact:Add("DButton")
	self.button_ar:Dock(TOP)
	self.button_ar:DockMargin(3, 3, 3, 0)
	self.button_ar:SetTall(ScrH() * 0.032)
	self.button_ar:SetText("Гоп стоп")
	self.button_ar:SetFont("Dma6")
	self.button_ar:SetTextColor(Color(255, 255, 255, 210))
	self.button_ar.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_ar:GetValue()) then self.button_ar:SetDisabled(true) end
	self.button_ar.DoClick = function(client)
		LocalPlayer():ConCommand("say /actgop_stop_1")
	end

	self.button_as = self.dscrollact:Add("DButton")
	self.button_as:Dock(TOP)
	self.button_as:DockMargin(3, 3, 3, 0)
	self.button_as:SetTall(ScrH() * 0.032)
	self.button_as:SetText("Поднять руки")
	self.button_as:SetFont("Dma6")
	self.button_as:SetTextColor(Color(255, 255, 255, 210))
	self.button_as.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_as:GetValue()) then self.button_as:SetDisabled(true) end
	self.button_as.DoClick = function(client)
		LocalPlayer():ConCommand("say /acthand_up_0")
	end

	self.button_at = self.dscrollact:Add("DButton")
	self.button_at:Dock(TOP)
	self.button_at:DockMargin(3, 3, 3, 0)
	self.button_at:SetTall(ScrH() * 0.032)
	self.button_at:SetText("Приветствовать")
	self.button_at:SetFont("Dma6")
	self.button_at:SetTextColor(Color(255, 255, 255, 210))
	self.button_at.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_at:GetValue()) then self.button_at:SetDisabled(true) end
	self.button_at.DoClick = function(client)
		LocalPlayer():ConCommand("say /acthello_0_idle_0")
	end

	self.button_au = self.dscrollact:Add("DButton")
	self.button_au:Dock(TOP)
	self.button_au:DockMargin(3, 3, 3, 0)
	self.button_au:SetTall(ScrH() * 0.032)
	self.button_au:SetText("Лежать раненным")
	self.button_au:SetFont("Dma6")
	self.button_au:SetTextColor(Color(255, 255, 255, 210))
	self.button_au.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_au:GetValue()) then self.button_au:SetDisabled(true) end
	self.button_au.DoClick = function(client)
		LocalPlayer():ConCommand("say /actwaunded_1_idle_0")
	end

	self.button_av = self.dscrollact:Add("DButton")
	self.button_av:Dock(TOP)
	self.button_av:DockMargin(3, 3, 3, 0)
	self.button_av:SetTall(ScrH() * 0.032)
	self.button_av:SetText("Требовать убрать оружие")
	self.button_av:SetFont("Dma6")
	self.button_av:SetTextColor(Color(255, 255, 255, 210))
	self.button_av.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_av:GetValue()) then self.button_av:SetDisabled(true) end
	self.button_av.DoClick = function(client)
		LocalPlayer():ConCommand("say /actuhodi_1_0")
	end

	self.button_aw = self.dscrollact:Add("DButton")
	self.button_aw:Dock(TOP)
	self.button_aw:DockMargin(3, 3, 3, 0)
	self.button_aw:SetTall(ScrH() * 0.032)
	self.button_aw:SetText("Передернуть затвор")
	self.button_aw:SetFont("Dma6")
	self.button_aw:SetTextColor(Color(255, 255, 255, 210))
	self.button_aw.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_aw:GetValue()) then self.button_aw:SetDisabled(true) end
	self.button_aw.DoClick = function(client)
		LocalPlayer():ConCommand("say /acttorso_2_draw_0")
	end

	self.button_ax = self.dscrollact:Add("DButton")
	self.button_ax:Dock(TOP)
	self.button_ax:DockMargin(3, 3, 3, 0)
	self.button_ax:SetTall(ScrH() * 0.032)
	self.button_ax:SetText("Спать на земле")
	self.button_ax:SetFont("Dma6")
	self.button_ax:SetTextColor(Color(255, 255, 255, 210))
	self.button_ax.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_ax:GetValue()) then self.button_ax:SetDisabled(true) end
	self.button_ax.DoClick = function(client)
		LocalPlayer():ConCommand("say /actsleep_1_idle_0")
	end

	self.button_ay = self.dscrollact:Add("DButton")
	self.button_ay:Dock(TOP)
	self.button_ay:DockMargin(3, 3, 3, 0)
	self.button_ay:SetTall(ScrH() * 0.032)
	self.button_ay:SetText("Бить кулаками")
	self.button_ay:SetFont("Dma6")
	self.button_ay:SetTextColor(Color(255, 255, 255, 210))
	self.button_ay.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_ay:GetValue()) then self.button_ay:SetDisabled(true) end
	self.button_ay.DoClick = function(client)
		LocalPlayer():ConCommand("say /actfree_facer_0")
	end

	self.button_az = self.dscrollact:Add("DButton")
	self.button_az:Dock(TOP)
	self.button_az:DockMargin(3, 3, 3, 0)
	self.button_az:SetTall(ScrH() * 0.032)
	self.button_az:SetText("Бить прикладом")
	self.button_az:SetFont("Dma6")
	self.button_az:SetTextColor(Color(255, 255, 255, 210))
	self.button_az.Paint = PaintButtons
	if not table.HasValue( LocalPlayer():getChar():getData("act_table"), self.button_az:GetValue()) then self.button_az:SetDisabled(true) end
	self.button_az.DoClick = function(client)
		LocalPlayer():ConCommand("say /actfree_facer_1")
	end
end

function PANEL:Paint( w, h )
	nut.util.drawBlur(self, 10)
	surface.SetDrawColor(Color( 30, 30, 30, 190))
	surface.DrawRect( 0, 0, w, h )
	surface.DrawOutlinedRect(0, 0, w, h)

	surface.SetDrawColor(0, 0, 14, 150)
	surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033)

	surface.SetDrawColor(Color( 30, 30, 30, 50))
	surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.26, ScrH() * 0.033)

	draw.DrawText("Меню Действий", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )

	surface.SetDrawColor(Color( 138, 149, 151, 60))
	surface.DrawLine(ScrW() * 0.01, ScrH() * 0.0325, ScrW() * 0.14, ScrH() * 0.0325)

	surface.SetDrawColor(Color( 0, 33, 55, 160))
	surface.DrawRect(ScrW() * 0.01, ScrH() * 0.05, ScrW() * 0.129, ScrH() * 0.024)

	for k,v in pairs(LocalPlayer():getChar():getData("act_table")) do
		surface.SetDrawColor( Color(80, 80, 80, 255) )
		surface.DrawRect( ScrW() * 0.01, ScrH() * 0.05, math.Clamp(ScrW()*0.14*(k/47), 0, ScrW() * 0.129), ScrH() * 0.024 )

		surface.SetDrawColor( Color(125, 105, 0, 255) )
		surface.SetMaterial( Material("lgh/circle_gradient.png") )
		surface.DrawTexturedRectUV( ScrW() * 0.061, ScrH() * 0.055, ScrW() * 0.03, ScrH() * 0.02, 1, 0.9, 0, 0.3 )

		draw.DrawText(k.."/47", "Roh10", ScrW() * 0.074, ScrH() * 0.054, Color(255, 255, 255, 210), TEXT_ALIGN_CENTER )
	end

	surface.SetDrawColor(Color( 0, 0, 0, 150))
	surface.DrawRect(ScrW() * 0.01, ScrH() * 0.074, ScrW() * 0.129, ScrH() * 0.356)

	surface.SetDrawColor(Color( 0, 0, 0, 235))
	surface.DrawOutlinedRect(ScrW() * 0.01, ScrH() * 0.05, ScrW() * 0.129, ScrH() * 0.38)

	surface.SetDrawColor(Color(0, 0, 14, 150))
	surface.DrawRect(ScrW() * 0.01, ScrH() * 0.44, ScrW() * 0.129, ScrH() * 0.0325)

	draw.DrawText(random_tip, "Dma5", ScrW() * 0.013, ScrH() * 0.447, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT)

	surface.SetDrawColor( Color(125, 105, 0, 120) )
	surface.SetMaterial( Material("lgh/circle_gradient.png") )
	surface.DrawTexturedRectUV( ScrW() * 0.005, ScrH() * 0.48, ScrW() * 0.14, ScrH() * 0.032, 1, 0.9, 0, 0.3 )
end

vgui.Register("act4flexx", PANEL, "DFrame")
netstream.Hook("act4flexx", function()
	act4flexx = vgui.Create("act4flexx")
end)


