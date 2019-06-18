local PANEL = {}

function PANEL:Init()
	self.total = 0
	self.enemyvalue = 0
	self.urvalue = 0
	self.nextcard = 0
	self.w_and_lose = 0

	self.scrW, self.scrH = ScrW(), ScrH()

	self:SetSize(self.scrW * 0.35, self.scrH * 0.55)
	self:MakePopup()
	self:Center()
	self:SetTitle("")
	self:ShowCloseButton( false )
	self:SetDraggable( false )

	local some_tipsWyes, some_tipsHyes = self.scrW * 0.2, self.scrH * 0.02
	local some_tipsXyes, some_tipsYyes = (self.scrW * 0.128) - (some_tipsWyes * 0.5), self.scrH * 0.42

	function self:Paint( w, h )
		local material = Material("carts/ui_mod_cards.png")
		surface.SetDrawColor(color_white) 
		surface.SetMaterial(material) 
		surface.DrawTexturedRect(0, 0, w, h) 
		surface.SetFont( "DescTipFont" )
		surface.SetTextColor(Color(169, 169, 169))
		surface.SetTextPos( some_tipsXyes, some_tipsYyes )
		if ScrW() == 1280 then
		surface.DrawText( "Вы: "..self.urvalue.."                     Ваша ставка на выигрыш: "..self.total.."               Враг: "..self.enemyvalue)
		else
		surface.DrawText( "Вы: "..self.urvalue.."                       Ваша ставка на выигрыш: "..self.total.."                         Враг: "..self.enemyvalue)
		end
	end

	local typo_logoWyes, typo_logoHyes = self.scrW * 0.1, self.scrH * 0.02
	local typo_logoXyes, typo_logoYyes = (self.scrW * 0.196) - (typo_logoWyes * 0.5), self.scrH * 0.011

	self.typo_logo = self:Add("DLabel")
	self.typo_logo:SetPos( typo_logoXyes, typo_logoYyes )
	self.typo_logo:SetSize( typo_logoWyes, typo_logoHyes )
	self.typo_logo:SetText("Игра: 21 очко")
	self.typo_logo:SetFont("DescCharFont1")

	local some_tipsWyes, some_tipsHyes = self.scrW * 0.22, self.scrH * 0.02
	local some_tipsXyes, some_tipsYyes = (self.scrW * 0.18) - (some_tipsWyes * 0.5), self.scrH * 0.375

	self.some_tips = self:Add("DLabel")
	self.some_tips:SetPos( some_tipsXyes, some_tipsYyes )
	self.some_tips:SetSize( some_tipsWyes, some_tipsHyes )
	self.some_tips:SetText("Минимальная ставка - 50. максимальная - 1000.")
	self.some_tips:SetFont("DescCharFont1")

	local char_moneyWyes, char_moneyHyes = self.scrW * 0.1, self.scrH * 0.02
	local char_moneyXyes, char_moneyYyes = (self.scrW * 0.18) - (char_moneyWyes * 0.5), self.scrH * 0.189

	self.value_char = self:Add("DLabel")
	self.value_char:SetPos( char_moneyXyes, char_moneyYyes )
	self.value_char:SetSize( char_moneyWyes, char_moneyHyes )
	self.value_char:SetText("У вас "..LocalPlayer():getChar():getMoney().." рублей")
	self.value_char:SetFont("DescCharFont1")

	local picwanWyes, picwanHyes = self.scrW * 0.055, self.scrH * 0.125
	local picwanXyes, picwanYyes = (self.scrW * 0.0535) - (picwanWyes * 0.55), self.scrH * 0.042

	self.picwan = self:Add( "DImage" )
	self.picwan:SetSize( picwanWyes, picwanHyes )
	self.picwan:SetPos( picwanXyes, picwanYyes )		
	self.picwan:SetImage( "carts/rybawka.png" )

	local pictwoWyes, pictwoHyes = self.scrW * 0.055, self.scrH * 0.125
	local pictwoXyes, pictwoYyes = (self.scrW * 0.115) - (pictwoWyes * 0.55), self.scrH * 0.042

	self.pictwo = self:Add( "DImage" )
	self.pictwo:SetSize( pictwoWyes, pictwoHyes )
	self.pictwo:SetPos( pictwoXyes, pictwoYyes )		
	self.pictwo:SetImage( "carts/rybawka.png" )

	local pictreeWyes, pictreeHyes = self.scrW * 0.055, self.scrH * 0.125
	local pictreeXyes, pictreeYyes = (self.scrW * 0.1765) - (pictreeWyes * 0.55), self.scrH * 0.042

	self.pictree = self:Add( "DImage" )
	self.pictree:SetSize( pictreeWyes, pictreeHyes )
	self.pictree:SetPos( pictreeXyes, pictreeYyes )		
	self.pictree:SetImage( "carts/rybawka.png" )

	local picforWyes, picforHyes = self.scrW * 0.055, self.scrH * 0.125
	local picforXyes, picforYyes = (self.scrW * 0.2380) - (picforWyes * 0.55), self.scrH * 0.042

	self.picfor = self:Add( "DImage" )
	self.picfor:SetSize( picforWyes, picforHyes )
	self.picfor:SetPos( picforXyes, picforYyes )		
	self.picfor:SetImage( "carts/rybawka.png" )

	local picfiveWyes, picfiveHyes = self.scrW * 0.055, self.scrH * 0.125
	local picfiveXyes, picfiveYyes = (self.scrW * 0.2990) - (picfiveWyes * 0.55), self.scrH * 0.042

	self.picfive = self:Add( "DImage" )
	self.picfive:SetSize( picfiveWyes, picfiveHyes )
	self.picfive:SetPos( picfiveXyes, picfiveYyes )		
	self.picfive:SetImage( "carts/rybawka.png" )


	local picsixWyes, picsixHyes = self.scrW * 0.055, self.scrH * 0.125
	local picsixXyes, picsixYyes = (self.scrW * 0.057) - (picsixWyes * 0.55), self.scrH * 0.232

	self.picsix = self:Add( "DImage" )
	self.picsix:SetSize( picsixWyes, picsixHyes )
	self.picsix:SetPos( picsixXyes, picsixYyes )		
	self.picsix:SetImage( "carts/rybawka.png" )


	local picsevenWyes, picsevenHyes = self.scrW * 0.055, self.scrH * 0.125
	local picsevenXyes, picsevenYyes = (self.scrW * 0.1185) - (picsevenWyes * 0.55), self.scrH * 0.232

	self.picseven = self:Add( "DImage" )
	self.picseven:SetSize( picsevenWyes, picsevenHyes )
	self.picseven:SetPos( picsevenXyes, picsevenYyes )		
	self.picseven:SetImage( "carts/rybawka.png" )

	local piceghtWyes, piceghtHyes = self.scrW * 0.055, self.scrH * 0.125
	local piceghtXyes, piceghtYyes = (self.scrW * 0.1800) - (piceghtWyes * 0.55), self.scrH * 0.232

	self.piceght = self:Add( "DImage" )
	self.piceght:SetSize( piceghtWyes, piceghtHyes )
	self.piceght:SetPos( piceghtXyes, piceghtYyes )		
	self.piceght:SetImage( "carts/rybawka.png" )

	local picnineWyes, picnineHyes = self.scrW * 0.055, self.scrH * 0.125
	local picnineXyes, picnineYyes = (self.scrW * 0.2410) - (picnineWyes * 0.55), self.scrH * 0.232

	self.picnine = self:Add( "DImage" )
	self.picnine:SetSize( picnineWyes, picnineHyes )
	self.picnine:SetPos( picnineXyes, picnineYyes )		
	self.picnine:SetImage( "carts/rybawka.png" )

	local pictenWyes, pictenHyes = self.scrW * 0.055, self.scrH * 0.125
	local pictenXyes, pictenYyes = (self.scrW * 0.3025) - (pictenWyes * 0.55), self.scrH * 0.232

	self.picten = self:Add( "DImage" )
	self.picten:SetSize( pictenWyes, pictenHyes )
	self.picten:SetPos( pictenXyes, pictenYyes )		
	self.picten:SetImage( "carts/rybawka.png" )

 
	local but_plusWyes, but_plusHyes = self.scrW * 0.015, self.scrH * 0.028
	local but_plusXyes, but_plusYyes = (self.scrW * 0.187) - (but_plusWyes * 0.5), self.scrH * 0.45

	self.but_plus = self:Add("DButton")
	self.but_plus:SetText("")
	self.but_plus:SetFont("NameFactionPingFont")
	self.but_plus:SetTextColor(color_white)
	function self.but_plus:Paint( w, h )
		if self:IsDown() then 
			local material = Material("carts/plus_press.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		else
			local material = Material("carts/plus_def.png")
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		end
	end
	self.but_plus:SetSize(but_plusWyes, but_plusHyes)	
	self.but_plus:SetPos(but_plusXyes, but_plusYyes)	
	self.but_plus.DoClick = function(client)
		if self.total < 1000 then
 			self.total = self.total + 50
 		else
 			return false
 		end
	end

	local but_minWyes, but_minHyes = self.scrW * 0.015, self.scrH * 0.028
	local but_minXyes, but_minYyes = (self.scrW * 0.167) - (but_minWyes * 0.5), self.scrH * 0.45

	self.but_min = self:Add("DButton")
	self.but_min:SetText("")
	self.but_min:SetFont("NameFactionPingFont")
	self.but_min:SetTextColor(color_white)
	function self.but_min:Paint( w, h )
		if self:IsDown() then 
			local material = Material("carts/minus_press.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		else
			local material = Material("carts/minus_def.png")
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		end
	end
	self.but_min:SetSize(but_minWyes, but_minHyes)	
	self.but_min:SetPos(but_minXyes, but_minYyes)	
	self.but_min.DoClick = function(client)
		if self.total > 0 then
 			self.total = self.total - 50
 		else
 			return false
 		end
	end

	local but_exitWyes, but_exitHyes = self.scrW * 0.075, self.scrH * 0.036
	local but_exitXyes, but_exitYyes = (self.scrW * 0.300) - (but_exitWyes * 0.5), self.scrH * 0.505

	self.but_exit = self:Add("DButton")
	self.but_exit:SetText("Выход")
	self.but_exit:SetColor(Color(169, 169, 169))
	self.but_exit:SetFont("DescCharFont1")
	self.but_exit:SetTextColor(color_white)
	function self.but_exit:Paint( w, h )
		if self:IsDown() then 
			local material = Material("carts/but_3k.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		elseif self:IsHovered() and !self:GetDisabled() then 
			local material = Material("carts/but_2k.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		elseif self:GetDisabled() then 
			local material = Material("carts/but_1k.png")
			surface.SetDrawColor(Color(169, 169, 169)) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		elseif self:GetDisabled() and self:IsHovered() then 
			local material = Material("carts/but_2k.png")
			surface.SetDrawColor(Color(169, 169, 169)) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		else
			local material = Material("carts/but_1k.png")
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		end
	end
	self.but_exit:SetSize(but_exitWyes, but_exitHyes)	
	self.but_exit:SetPos(but_exitXyes, but_exitYyes)	
	self.but_exit.DoClick = function(client)
		self:Close()
	end

	local but_startWyes, but_startHyes = self.scrW * 0.075, self.scrH * 0.036
	local but_startXyes, but_startYyes = (self.scrW * 0.05) - (but_startWyes * 0.5), self.scrH * 0.505

	self.but_start = self:Add("DButton")
	self.but_start:SetText("Принять ставки")
	self.but_start:SetColor(Color(169, 169, 169))
	self.but_start:SetFont("DescCharFont1")
	self.but_start:SetTextColor(color_white)
	function self.but_start:Paint( w, h )
		if self:IsDown() then 
			local material = Material("carts/but_3k.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		elseif self:IsHovered() then 
			local material = Material("carts/but_2k.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		else
			local material = Material("carts/but_1k.png")
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		end
	end
	self.but_start:SetSize(but_startWyes, but_startHyes)	
	self.but_start:SetPos(but_startXyes, but_startYyes)	
	self.but_start.DoClick = function(client)
		if (self.total > 0 and LocalPlayer():getChar():getMoney() > self.total) then
			netstream.Start("take_my_money", self.total)
			self.but_start:Remove()
			self.but_min:Remove()
			self.but_plus:Remove()
			self.but_exit:SetDisabled( true )
			self:addContinue()
		else
			return false
		end
	end
	-- ниже панельки не видят self.lefscroe и self.enemyvalue, но должны отображаться без косяков, есоли это будет пофикшено
	--[[local urWyes, urHyes = self.scrW * 0.003, self.scrH * 0.1
	local urXyes, urYyes = (self.scrW * 0.005) - (urWyes * 0.5), self.scrH * 0.01

	local lefscroeWyes, lefscroeHyes = self.scrW * 0.035, self.scrH * 0.035
	local lefscroeXyes, lefscroeYyes = (self.scrW * 0.0475) - (lefscroeWyes * 0.5), self.scrH * 0.405

	self.lefscroe = self:Add("DLabel")
	self.lefscroe:SetPos( lefscroeXyes, lefscroeYyes )
	self.lefscroe:SetSize( lefscroeWyes, lefscroeHyes )
	self.lefscroe:SetText("")
	self.lefscroe.urvalue = 0
	function self.lefscroe:Paint( w, h )
		surface.SetFont( "DescTipFont" )
		surface.SetTextColor(color_white)
		surface.SetTextPos( urXyes, urYyes )
		surface.DrawText( "Вы: "..self.lefscroe.urvalue)
	end

	local enWyes, enHyes = self.scrW * 0.003, self.scrH * 0.1
	local enXyes, enYyes = (self.scrW * 0.005) - (enWyes * 0.5), self.scrH * 0.01

	local rightcroeWyes, rightscroeHyes = self.scrW * 0.035, self.scrH * 0.035
	local rightscroeXyes, rightscroeYyes = (self.scrW * 0.305) - (rightcroeWyes * 0.5), self.scrH * 0.405

	self.rightscroe = self:Add("DLabel")
	self.rightscroe:SetPos( rightscroeXyes, rightscroeYyes )
	self.rightscroe:SetSize( rightcroeWyes, rightscroeHyes )
	self.rightscroe:SetText("")
	function self.rightscroe:Paint( w, h )
		surface.SetFont( "DescTipFont" )
		surface.SetTextColor(color_white)
		surface.SetTextPos( enXyes, enYyes )
		surface.DrawText( "Враг: "..self.enemyvalue)
	end]]

end

function PANEL:addContinue()
	local picran = {
	"carts/6ch.png",
	"carts/6k.png",
	"carts/6p.png",
	"carts/6r.png",
	"carts/7ch.png",
	"carts/7k.png",
	"carts/7p.png",
	"carts/7r.png",
	"carts/8ch.png",
	"carts/8k.png",
	"carts/8p.png",
	"carts/8r.png",
	"carts/9ch.png",
	"carts/9k.png",
	"carts/9p.png",
	"carts/9r.png",
	"carts/10ch.png",
	"carts/10k.png",
	"carts/10p.png",
	"carts/10r.png",
	"carts/ach.png",
	"carts/ak.png",
	"carts/ap.png",
	"carts/ar.png",
	"carts/jch.png",
	"carts/jk.png",
	"carts/jp.png",
	"carts/jr.png",
	"carts/qch.png",
	"carts/qk.png",
	"carts/qp.png",
	"carts/qr.png",
	"carts/kch.png",
	"carts/kk.png",
	"carts/kp.png",
	"carts/kr.png"
	}

	self.scrW, self.scrH = ScrW(), ScrH()

	local but_startWyes, but_startHyes = self.scrW * 0.075, self.scrH * 0.036
	local but_startXyes, but_startYyes = (self.scrW * 0.05) - (but_startWyes * 0.5), self.scrH * 0.505

	self.but_starttwo = self:Add("DButton")
	self.but_starttwo:SetText("Начать игру")
	self.but_starttwo:SetColor(Color(169, 169, 169))
	self.but_starttwo:SetFont("DescCharFont1")
	self.but_starttwo:SetTextColor(color_white)
	self.but_starttwo.DoClick = function(client)
		self.vzat:SetDisabled( false )	
		self.perh:SetDisabled( false )	
		self.but_starttwo:SetDisabled( true )	
		if self.nextcard == 0 then
		self.picwan:SetImage(table.Random(picran))

		self.checkurpicwancart = self.picwan:GetImage()
		if self.checkurpicwancart == "carts/6ch.png" or self.checkurpicwancart == "carts/6k.png" or self.checkurpicwancart == "carts/6p.png" or self.checkurpicwancart == "carts/6r.png" then
			self.urvalue = self.urvalue + 6
		elseif self.checkurpicwancart == "carts/7ch.png" or self.checkurpicwancart == "carts/7k.png" or self.checkurpicwancart == "carts/7p.png" or self.checkurpicwancart == "carts/7r.png" then
			self.urvalue = self.urvalue + 7
		elseif self.checkurpicwancart == "carts/8ch.png" or self.checkurpicwancart == "carts/8k.png" or self.checkurpicwancart == "carts/8p.png" or self.checkurpicwancart == "carts/8r.png" then
			self.urvalue = self.urvalue + 8
		elseif self.checkurpicwancart == "carts/9ch.png" or self.checkurpicwancart == "carts/9k.png" or self.checkurpicwancart == "carts/9p.png" or self.checkurpicwancart == "carts/9r.png" then
			self.urvalue = self.urvalue + 9
		elseif self.checkurpicwancart == "carts/10ch.png" or self.checkurpicwancart == "carts/10k.png" or self.checkurpicwancart == "carts/10p.png" or self.checkurpicwancart == "carts/10r.png" then
			self.urvalue = self.urvalue + 10
		elseif self.checkurpicwancart == "carts/ach.png" or self.checkurpicwancart == "carts/ak.png" or self.checkurpicwancart == "carts/ap.png" or self.checkurpicwancart == "carts/ar.png" then
			self.urvalue = self.urvalue + 11
		elseif self.checkurpicwancart == "carts/jch.png" or self.checkurpicwancart == "carts/jk.png" or self.checkurpicwancart == "carts/jp.png" or self.checkurpicwancart == "carts/jr.png" then
			self.urvalue = self.urvalue + 2
		elseif self.checkurpicwancart == "carts/qch.png" or self.checkurpicwancart == "carts/qk.png" or self.checkurpicwancart == "carts/qp.png" or self.checkurpicwancart == "carts/qr.png" then
			self.urvalue = self.urvalue + 3
		elseif self.checkurpicwancart == "carts/kch.png" or self.checkurpicwancart == "carts/kk.png" or self.checkurpicwancart == "carts/kp.png" or self.checkurpicwancart == "carts/kr.png" then
			self.urvalue = self.urvalue + 4
		else
			LocalPlayer():ConCommand("say Тестинг Ты долбаеб что это такое")
		end

		self.pictwo:SetImage(table.Random(picran))
		self.checkurpictwocart = self.pictwo:GetImage()
		if self.checkurpictwocart == "carts/6ch.png" or self.checkurpictwocart == "carts/6k.png" or self.checkurpictwocart == "carts/6p.png" or self.checkurpictwocart == "carts/6r.png" then
			self.urvalue = self.urvalue + 6
		elseif self.checkurpictwocart == "carts/7ch.png" or self.checkurpictwocart == "carts/7k.png" or self.checkurpictwocart == "carts/7p.png" or self.checkurpictwocart == "carts/7r.png" then
			self.urvalue = self.urvalue + 7
		elseif self.checkurpictwocart == "carts/8ch.png" or self.checkurpictwocart == "carts/8k.png" or self.checkurpictwocart == "carts/8p.png" or self.checkurpictwocart == "carts/8r.png" then
			self.urvalue = self.urvalue + 8
		elseif self.checkurpictwocart == "carts/9ch.png" or self.checkurpictwocart == "carts/9k.png" or self.checkurpictwocart == "carts/9p.png" or self.checkurpictwocart == "carts/9r.png" then
			self.urvalue = self.urvalue + 9
		elseif self.checkurpictwocart == "carts/10ch.png" or self.checkurpictwocart == "carts/10k.png" or self.checkurpictwocart == "carts/10p.png" or self.checkurpictwocart == "carts/10r.png" then
			self.urvalue = self.urvalue + 10
		elseif self.checkurpictwocart == "carts/ach.png" or self.checkurpictwocart == "carts/ak.png" or self.checkurpictwocart == "carts/ap.png" or self.checkurpictwocart == "carts/ar.png" then
			self.urvalue = self.urvalue + 11
		elseif self.checkurpictwocart == "carts/jch.png" or self.checkurpictwocart == "carts/jk.png" or self.checkurpictwocart == "carts/jp.png" or self.checkurpictwocart == "carts/jr.png" then
			self.urvalue = self.urvalue + 2
		elseif self.checkurpictwocart == "carts/qch.png" or self.checkurpictwocart == "carts/qk.png" or self.checkurpictwocart == "carts/qp.png" or self.checkurpictwocart == "carts/qr.png" then
			self.urvalue = self.urvalue + 3
		elseif self.checkurpictwocart == "carts/kch.png" or self.checkurpictwocart == "carts/kk.png" or self.checkurpictwocart == "carts/kp.png" or self.checkurpictwocart == "carts/kr.png" then
			self.urvalue = self.urvalue + 4
		else
			LocalPlayer():ConCommand("say Тестинг Ты долбаеб что это такое")
		end
	end
	end
	function self.but_starttwo:Paint( w, h )
		if self:IsDown() then 
			local material = Material("carts/but_3k.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		elseif self:IsHovered() and !self:GetDisabled() then 
			local material = Material("carts/but_2k.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		elseif self:GetDisabled() then 
			local material = Material("carts/but_1k.png")
			surface.SetDrawColor(Color(169, 169, 169)) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		elseif self:GetDisabled() and self:IsHovered() then 
			local material = Material("carts/but_2k.png")
			surface.SetDrawColor(Color(169, 169, 169)) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		else
			local material = Material("carts/but_1k.png")
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		end
	end
	self.but_starttwo:SetSize(but_startWyes, but_startHyes)	
	self.but_starttwo:SetPos(but_startXyes, but_startYyes)	

	local vzatWyes, vzatHyes = self.scrW * 0.075, self.scrH * 0.036
	local vzatXyes, vzatYyes = (self.scrW * 0.135) - (vzatWyes * 0.5), self.scrH * 0.46

	self.vzat = self:Add("DButton")
	self.vzat:SetText("Взять еще")
	self.vzat:SetColor(Color(169, 169, 169))
	self.vzat:SetFont("DescCharFont1")
	self.vzat:SetTextColor(color_white)
	function self.vzat:Paint( w, h )
		if self:IsDown() then 
			local material = Material("carts/but_3k.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		elseif self:IsHovered() and !self:GetDisabled() then 
			local material = Material("carts/but_2k.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		elseif self:GetDisabled() then 
			local material = Material("carts/but_1k.png")
			surface.SetDrawColor(Color(169, 169, 169)) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		elseif self:GetDisabled() and self:IsHovered() then 
			local material = Material("carts/but_2k.png")
			surface.SetDrawColor(Color(169, 169, 169)) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		else
			local material = Material("carts/but_1k.png")
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		end
	end

	self.vzat:SetSize(vzatWyes, vzatHyes)	
	self.vzat:SetPos(vzatXyes, vzatYyes)
	self.vzat:SetDisabled( true )	
	self.vzat.DoClick = function(client)
	if self.nextcard == 0 then
		self.nextcard = self.nextcard + 1
		self.pictree:SetImage(table.Random(picran))
		self.checkurpictreecart = self.pictree:GetImage()
		if self.checkurpictreecart == "carts/6ch.png" or self.checkurpictreecart == "carts/6k.png" or self.checkurpictreecart == "carts/6p.png" or self.checkurpictreecart == "carts/6r.png" then
			self.urvalue = self.urvalue + 6
		elseif self.checkurpictreecart == "carts/7ch.png" or self.checkurpictreecart == "carts/7k.png" or self.checkurpictreecart == "carts/7p.png" or self.checkurpictreecart == "carts/7r.png" then
			self.urvalue = self.urvalue + 7
		elseif self.checkurpictreecart == "carts/8ch.png" or self.checkurpictreecart == "carts/8k.png" or self.checkurpictreecart == "carts/8p.png" or self.checkurpictreecart == "carts/8r.png" then
			self.urvalue = self.urvalue + 8
		elseif self.checkurpictreecart == "carts/9ch.png" or self.checkurpictreecart == "carts/9k.png" or self.checkurpictreecart == "carts/9p.png" or self.checkurpictreecart == "carts/9r.png" then
			self.urvalue = self.urvalue + 9
		elseif self.checkurpictreecart == "carts/10ch.png" or self.checkurpictreecart == "carts/10k.png" or self.checkurpictreecart == "carts/10p.png" or self.checkurpictreecart == "carts/10r.png" then
			self.urvalue = self.urvalue + 10
		elseif self.checkurpictreecart == "carts/ach.png" or self.checkurpictreecart == "carts/ak.png" or self.checkurpictreecart == "carts/ap.png" or self.checkurpictreecart == "carts/ar.png" then
			self.urvalue = self.urvalue + 11
		elseif self.checkurpictreecart == "carts/jch.png" or self.checkurpictreecart == "carts/jk.png" or self.checkurpictreecart == "carts/jp.png" or self.checkurpictreecart == "carts/jr.png" then
			self.urvalue = self.urvalue + 2
		elseif self.checkurpictreecart == "carts/qch.png" or self.checkurpictreecart == "carts/qk.png" or self.checkurpictreecart == "carts/qp.png" or self.checkurpictreecart == "carts/qr.png" then
			self.urvalue = self.urvalue + 3
		elseif self.checkurpictreecart == "carts/kch.png" or self.checkurpictreecart == "carts/kk.png" or self.checkurpictreecart == "carts/kp.png" or self.checkurpictreecart == "carts/kr.png" then
			self.urvalue = self.urvalue + 4
		else
			LocalPlayer():ConCommand("say Тестинг Ты долбаеб что это такое")
		end

		elseif self.nextcard == 1 then 
		self.nextcard = self.nextcard + 1
		self.picfor:SetImage(table.Random(picran))
		self.checkurpicforcart = self.picfor:GetImage()
		if self.checkurpicforcart == "carts/6ch.png" or self.checkurpicforcart == "carts/6k.png" or self.checkurpicforcart == "carts/6p.png" or self.checkurpicforcart == "carts/6r.png" then
			self.urvalue = self.urvalue + 6
		elseif self.checkurpicforcart == "carts/7ch.png" or self.checkurpicforcart == "carts/7k.png" or self.checkurpicforcart == "carts/7p.png" or self.checkurpicforcart == "carts/7r.png" then
			self.urvalue = self.urvalue + 7
		elseif self.checkurpicforcart == "carts/8ch.png" or self.checkurpicforcart == "carts/8k.png" or self.checkurpicforcart == "carts/8p.png" or self.checkurpicforcart == "carts/8r.png" then
			self.urvalue = self.urvalue + 8
		elseif self.checkurpicforcart == "carts/9ch.png" or self.checkurpicforcart == "carts/9k.png" or self.checkurpicforcart == "carts/9p.png" or self.checkurpicforcart == "carts/9r.png" then
			self.urvalue = self.urvalue + 9
		elseif self.checkurpicforcart == "carts/10ch.png" or self.checkurpicforcart == "carts/10k.png" or self.checkurpicforcart == "carts/10p.png" or self.checkurpicforcart == "carts/10r.png" then
			self.urvalue = self.urvalue + 10
		elseif self.checkurpicforcart == "carts/ach.png" or self.checkurpicforcart == "carts/ak.png" or self.checkurpicforcart == "carts/ap.png" or self.checkurpicforcart == "carts/ar.png" then
			self.urvalue = self.urvalue + 11
		elseif self.checkurpicforcart == "carts/jch.png" or self.checkurpicforcart == "carts/jk.png" or self.checkurpicforcart == "carts/jp.png" or self.checkurpicforcart == "carts/jr.png" then
			self.urvalue = self.urvalue + 2
		elseif self.checkurpicforcart == "carts/qch.png" or self.checkurpicforcart == "carts/qk.png" or self.checkurpicforcart == "carts/qp.png" or self.checkurpicforcart == "carts/qr.png" then
			self.urvalue = self.urvalue + 3
		elseif self.checkurpicforcart == "carts/kch.png" or self.checkurpicforcart == "carts/kk.png" or self.checkurpicforcart == "carts/kp.png" or self.checkurpicforcart == "carts/kr.png" then
			self.urvalue = self.urvalue + 4
		else
			LocalPlayer():ConCommand("say Тестинг Ты долбаеб что это такое")
		end

		elseif self.nextcard == 2 then
		self.nextcard = self.nextcard + 1
		self.picfive:SetImage(table.Random(picran))
		self.checkurpicfivecart = self.picfive:GetImage()
		if self.checkurpicfivecart == "carts/6ch.png" or self.checkurpicfivecart == "carts/6k.png" or self.checkurpicfivecart == "carts/6p.png" or self.checkurpicfivecart == "carts/6r.png" then
			self.urvalue = self.urvalue + 6
		elseif self.checkurpicfivecart == "carts/7ch.png" or self.checkurpicfivecart == "carts/7k.png" or self.checkurpicfivecart == "carts/7p.png" or self.checkurpicfivecart == "carts/7r.png" then
			self.urvalue = self.urvalue + 7
		elseif self.checkurpicfivecart == "carts/8ch.png" or self.checkurpicfivecart == "carts/8k.png" or self.checkurpicfivecart == "carts/8p.png" or self.checkurpicfivecart == "carts/8r.png" then
			self.urvalue = self.urvalue + 8
		elseif self.checkurpicfivecart == "carts/9ch.png" or self.checkurpicfivecart == "carts/9k.png" or self.checkurpicfivecart == "carts/9p.png" or self.checkurpicfivecart == "carts/9r.png" then
			self.urvalue = self.urvalue + 9
		elseif self.checkurpicfivecart == "carts/10ch.png" or self.checkurpicfivecart == "carts/10k.png" or self.checkurpicfivecart == "carts/10p.png" or self.checkurpicfivecart == "carts/10r.png" then
			self.urvalue = self.urvalue + 10
		elseif self.checkurpicfivecart == "carts/ach.png" or self.checkurpicfivecart == "carts/ak.png" or self.checkurpicfivecart == "carts/ap.png" or self.checkurpicfivecart == "carts/ar.png" then
			self.urvalue = self.urvalue + 11
		elseif self.checkurpicfivecart == "carts/jch.png" or self.checkurpicfivecart == "carts/jk.png" or self.checkurpicfivecart == "carts/jp.png" or self.checkurpicfivecart == "carts/jr.png" then
			self.urvalue = self.urvalue + 2
		elseif self.checkurpicfivecart == "carts/qch.png" or self.checkurpicfivecart == "carts/qk.png" or self.checkurpicfivecart == "carts/qp.png" or self.checkurpicfivecart == "carts/qr.png" then
			self.urvalue = self.urvalue + 3
		elseif self.checkurpicfivecart == "carts/kch.png" or self.checkurpicfivecart == "carts/kk.png" or self.checkurpicfivecart == "carts/kp.png" or self.checkurpicfivecart == "carts/kr.png" then
			self.urvalue = self.urvalue + 4
		else
			LocalPlayer():ConCommand("say Тестинг Ты долбаеб что это такое")
		end
		
	end

	end

	local perhWyes, perhHyes = self.scrW * 0.075, self.scrH * 0.036
	local perhXyes, perhYyes = (self.scrW * 0.215) - (perhWyes * 0.5), self.scrH * 0.46

	self.perh = self:Add("DButton")
	self.perh:SetText("Передать ход")
	self.perh:SetColor(Color(169, 169, 169))
	self.perh:SetFont("DescCharFont1")
	self.perh:SetTextColor(color_white)
	local enemyWyes, enemyHyes = self.scrW * 0.2, self.scrH * 0.02
	local enemyXyes, enemyYyes = (self.scrW * 0.215) - (enemyWyes * 0.5), self.scrH * 0.42
	function self.perh:Paint( w, h )
		if self:IsDown() then 
			local material = Material("carts/but_3k.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		elseif self:IsHovered() and !self:GetDisabled() then 
			local material = Material("carts/but_2k.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		elseif self:GetDisabled() then 
			local material = Material("carts/but_1k.png")
			surface.SetDrawColor(Color(169, 169, 169)) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		elseif self:GetDisabled() and self:IsHovered() then 
			local material = Material("carts/but_2k.png")
			surface.SetDrawColor(Color(169, 169, 169)) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		else
			local material = Material("carts/but_1k.png")
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		end
	end
	self.nextcardbot = 0
	self.perh:SetSize(perhWyes, perhHyes)	
	self.perh:SetPos(perhXyes, perhYyes)
	self.perh:SetDisabled( true )	
	self.perh.DoClick = function(client)
		self.perh:SetDisabled( true )	
		self.vzat:SetDisabled( true )	
		self.but_starttwo:Remove()
		self:addContinue2()
		if self.nextcardbot == 0 then
		self.nextcardbot = self.nextcardbot + 1
		self.picsix:SetImage(table.Random(picran))
		self.checkurpicsixcart = self.picsix:GetImage()
		if self.checkurpicsixcart == "carts/6ch.png" or self.checkurpicsixcart == "carts/6k.png" or self.checkurpicsixcart == "carts/6p.png" or self.checkurpicsixcart == "carts/6r.png" then
			self.enemyvalue = self.enemyvalue + 6
		elseif self.checkurpicsixcart == "carts/7ch.png" or self.checkurpicsixcart == "carts/7k.png" or self.checkurpicsixcart == "carts/7p.png" or self.checkurpicsixcart == "carts/7r.png" then
			self.enemyvalue = self.enemyvalue + 7
		elseif self.checkurpicsixcart == "carts/8ch.png" or self.checkurpicsixcart == "carts/8k.png" or self.checkurpicsixcart == "carts/8p.png" or self.checkurpicsixcart == "carts/8r.png" then
			self.enemyvalue = self.enemyvalue + 8
		elseif self.checkurpicsixcart == "carts/9ch.png" or self.checkurpicsixcart == "carts/9k.png" or self.checkurpicsixcart == "carts/9p.png" or self.checkurpicsixcart == "carts/9r.png" then
			self.enemyvalue = self.enemyvalue + 9
		elseif self.checkurpicsixcart == "carts/10ch.png" or self.checkurpicsixcart == "carts/10k.png" or self.checkurpicsixcart == "carts/10p.png" or self.checkurpicsixcart == "carts/10r.png" then
			self.enemyvalue = self.enemyvalue + 10
		elseif self.checkurpicsixcart == "carts/ach.png" or self.checkurpicsixcart == "carts/ak.png" or self.checkurpicsixcart == "carts/ap.png" or self.checkurpicsixcart == "carts/ar.png" then
			self.enemyvalue = self.enemyvalue + 11
		elseif self.checkurpicsixcart == "carts/jch.png" or self.checkurpicsixcart == "carts/jk.png" or self.checkurpicsixcart == "carts/jp.png" or self.checkurpicsixcart == "carts/jr.png" then
			self.enemyvalue = self.enemyvalue + 2
		elseif self.checkurpicsixcart == "carts/qch.png" or self.checkurpicsixcart == "carts/qk.png" or self.checkurpicsixcart == "carts/qp.png" or self.checkurpicsixcart == "carts/qr.png" then
			self.enemyvalue = self.enemyvalue + 3
		elseif self.checkurpicsixcart == "carts/kch.png" or self.checkurpicsixcart == "carts/kk.png" or self.checkurpicsixcart == "carts/kp.png" or self.checkurpicsixcart == "carts/kr.png" then
			self.enemyvalue = self.enemyvalue + 4
		else
			LocalPlayer():ConCommand("say Тестинг Ты долбаеб что это такое")
		end

		self.picseven:SetImage(table.Random(picran))
		self.checkurpicsevencart = self.picseven:GetImage()
		if self.checkurpicsevencart == "carts/6ch.png" or self.checkurpicsevencart == "carts/6k.png" or self.checkurpicsevencart == "carts/6p.png" or self.checkurpicsevencart == "carts/6r.png" then
			self.enemyvalue = self.enemyvalue + 6
		elseif self.checkurpicsevencart == "carts/7ch.png" or self.checkurpicsevencart == "carts/7k.png" or self.checkurpicsevencart == "carts/7p.png" or self.checkurpicsevencart == "carts/7r.png" then
			self.enemyvalue = self.enemyvalue + 7
		elseif self.checkurpicsevencart == "carts/8ch.png" or self.checkurpicsevencart == "carts/8k.png" or self.checkurpicsevencart == "carts/8p.png" or self.checkurpicsevencart == "carts/8r.png" then
			self.enemyvalue = self.enemyvalue + 8
		elseif self.checkurpicsevencart == "carts/9ch.png" or self.checkurpicsevencart == "carts/9k.png" or self.checkurpicsevencart == "carts/9p.png" or self.checkurpicsevencart == "carts/9r.png" then
			self.enemyvalue = self.enemyvalue + 9
		elseif self.checkurpicsevencart == "carts/10ch.png" or self.checkurpicsevencart == "carts/10k.png" or self.checkurpicsevencart == "carts/10p.png" or self.checkurpicsevencart == "carts/10r.png" then
			self.enemyvalue = self.enemyvalue + 10
		elseif self.checkurpicsevencart == "carts/ach.png" or self.checkurpicsevencart == "carts/ak.png" or self.checkurpicsevencart == "carts/ap.png" or self.checkurpicsevencart == "carts/ar.png" then
			self.enemyvalue = self.enemyvalue + 11
		elseif self.checkurpicsevencart == "carts/jch.png" or self.checkurpicsevencart == "carts/jk.png" or self.checkurpicsevencart == "carts/jp.png" or self.checkurpicsevencart == "carts/jr.png" then
			self.enemyvalue = self.enemyvalue + 2
		elseif self.checkurpicsevencart == "carts/qch.png" or self.checkurpicsevencart == "carts/qk.png" or self.checkurpicsevencart == "carts/qp.png" or self.checkurpicsevencart == "carts/qr.png" then
			self.enemyvalue = self.enemyvalue + 3
		elseif self.checkurpicsevencart == "carts/kch.png" or self.checkurpicsevencart == "carts/kk.png" or self.checkurpicsevencart == "carts/kp.png" or self.checkurpicsevencart == "carts/kr.png" then
			self.enemyvalue = self.enemyvalue + 4
		else
			LocalPlayer():ConCommand("say Тестинг Ты долбаеб что это такое")
		end

		end

		if self.nextcardbot == 1 and self.enemyvalue < 17 then
			self.nextcardbot = self.nextcardbot + 1

		self.piceght:SetImage(table.Random(picran))
		self.checkurpiceghtcart = self.piceght:GetImage()
		if self.checkurpiceghtcart == "carts/6ch.png" or self.checkurpiceghtcart == "carts/6k.png" or self.checkurpiceghtcart == "carts/6p.png" or self.checkurpiceghtcart == "carts/6r.png" then
			self.enemyvalue = self.enemyvalue + 6
		elseif self.checkurpiceghtcart == "carts/7ch.png" or self.checkurpiceghtcart == "carts/7k.png" or self.checkurpiceghtcart == "carts/7p.png" or self.checkurpiceghtcart == "carts/7r.png" then
			self.enemyvalue = self.enemyvalue + 7
		elseif self.checkurpiceghtcart == "carts/8ch.png" or self.checkurpiceghtcart == "carts/8k.png" or self.checkurpiceghtcart == "carts/8p.png" or self.checkurpiceghtcart == "carts/8r.png" then
			self.enemyvalue = self.enemyvalue + 8
		elseif self.checkurpiceghtcart == "carts/9ch.png" or self.checkurpiceghtcart == "carts/9k.png" or self.checkurpiceghtcart == "carts/9p.png" or self.checkurpiceghtcart == "carts/9r.png" then
			self.enemyvalue = self.enemyvalue + 9
		elseif self.checkurpiceghtcart == "carts/10ch.png" or self.checkurpiceghtcart == "carts/10k.png" or self.checkurpiceghtcart == "carts/10p.png" or self.checkurpiceghtcart == "carts/10r.png" then
			self.enemyvalue = self.enemyvalue + 10
		elseif self.checkurpiceghtcart == "carts/ach.png" or self.checkurpiceghtcart == "carts/ak.png" or self.checkurpiceghtcart == "carts/ap.png" or self.checkurpiceghtcart == "carts/ar.png" then
			self.enemyvalue = self.enemyvalue + 11
		elseif self.checkurpiceghtcart == "carts/jch.png" or self.checkurpiceghtcart == "carts/jk.png" or self.checkurpiceghtcart == "carts/jp.png" or self.checkurpiceghtcart == "carts/jr.png" then
			self.enemyvalue = self.enemyvalue + 2
		elseif self.checkurpiceghtcart == "carts/qch.png" or self.checkurpiceghtcart == "carts/qk.png" or self.checkurpiceghtcart == "carts/qp.png" or self.checkurpiceghtcart == "carts/qr.png" then
			self.enemyvalue = self.enemyvalue + 3
		elseif self.checkurpiceghtcart == "carts/kch.png" or self.checkurpiceghtcart == "carts/kk.png" or self.checkurpiceghtcart == "carts/kp.png" or self.checkurpiceghtcart == "carts/kr.png" then
			self.enemyvalue = self.enemyvalue + 4
		else
			LocalPlayer():ConCommand("say Тестинг Ты долбаеб что это такое")
		end

		end

		local chance1 = math.random(1, 2)

		if (self.nextcardbot == 2 and self.enemyvalue < 19 and self.enemyvalue > 18 and chance1 == 1) or (self.nextcardbot == 2 and self.enemyvalue < 17) then
			self.nextcardbot = self.nextcardbot + 1

		self.picnine:SetImage(table.Random(picran))
		self.checkurpicninetcart = self.picnine:GetImage()
		if self.checkurpicninetcart == "carts/6ch.png" or self.checkurpicninetcart == "carts/6k.png" or self.checkurpicninetcart == "carts/6p.png" or self.checkurpicninetcart == "carts/6r.png" then
			self.enemyvalue = self.enemyvalue + 6
		elseif self.checkurpicninetcart == "carts/7ch.png" or self.checkurpicninetcart == "carts/7k.png" or self.checkurpicninetcart == "carts/7p.png" or self.checkurpicninetcart == "carts/7r.png" then
			self.enemyvalue = self.enemyvalue + 7
		elseif self.checkurpicninetcart == "carts/8ch.png" or self.checkurpicninetcart == "carts/8k.png" or self.checkurpicninetcart == "carts/8p.png" or self.checkurpicninetcart == "carts/8r.png" then
			self.enemyvalue = self.enemyvalue + 8
		elseif self.checkurpicninetcart == "carts/9ch.png" or self.checkurpicninetcart == "carts/9k.png" or self.checkurpicninetcart == "carts/9p.png" or self.checkurpicninetcart == "carts/9r.png" then
			self.enemyvalue = self.enemyvalue + 9
		elseif self.checkurpicninetcart == "carts/10ch.png" or self.checkurpicninetcart == "carts/10k.png" or self.checkurpicninetcart == "carts/10p.png" or self.checkurpicninetcart == "carts/10r.png" then
			self.enemyvalue = self.enemyvalue + 10
		elseif self.checkurpicninetcart == "carts/ach.png" or self.checkurpicninetcart == "carts/ak.png" or self.checkurpicninetcart == "carts/ap.png" or self.checkurpicninetcart == "carts/ar.png" then
			self.enemyvalue = self.enemyvalue + 11
		elseif self.checkurpicninetcart == "carts/jch.png" or self.checkurpicninetcart == "carts/jk.png" or self.checkurpicninetcart == "carts/jp.png" or self.checkurpicninetcart == "carts/jr.png" then
			self.enemyvalue = self.enemyvalue + 2
		elseif self.checkurpicninetcart == "carts/qch.png" or self.checkurpicninetcart == "carts/qk.png" or self.checkurpicninetcart == "carts/qp.png" or self.checkurpicninetcart == "carts/qr.png" then
			self.enemyvalue = self.enemyvalue + 3
		elseif self.checkurpicninetcart == "carts/kch.png" or self.checkurpicninetcart == "carts/kk.png" or self.checkurpicninetcart == "carts/kp.png" or self.checkurpicninetcart == "carts/kr.png" then
			self.enemyvalue = self.enemyvalue + 4
		else
			LocalPlayer():ConCommand("say Тестинг Ты долбаеб что это такое")
		end

		end

		local chance = math.random(1, 2)

		if (self.nextcardbot == 2 and self.enemyvalue < 19 and self.enemyvalue > 18 and chance == 1) or (self.nextcardbot == 2 and self.enemyvalue < 17) then
			self.nextcardbot = self.nextcardbot + 1

		self.picten:SetImage(table.Random(picran))
		self.checkurpicpictentcart = self.picten:GetImage()
		if self.checkurpicpictentcart == "carts/6ch.png" or self.checkurpicpictentcart == "carts/6k.png" or self.checkurpicpictentcart == "carts/6p.png" or self.checkurpicpictentcart == "carts/6r.png" then
			self.enemyvalue = self.enemyvalue + 6
		elseif self.checkurpicpictentcart == "carts/7ch.png" or self.checkurpicpictentcart == "carts/7k.png" or self.checkurpicpictentcart == "carts/7p.png" or self.checkurpicpictentcart == "carts/7r.png" then
			self.enemyvalue = self.enemyvalue + 7
		elseif self.checkurpicpictentcart == "carts/8ch.png" or self.checkurpicpictentcart == "carts/8k.png" or self.checkurpicpictentcart == "carts/8p.png" or self.checkurpicpictentcart == "carts/8r.png" then
			self.enemyvalue = self.enemyvalue + 8
		elseif self.checkurpicpictentcart == "carts/9ch.png" or self.checkurpicpictentcart == "carts/9k.png" or self.checkurpicpictentcart == "carts/9p.png" or self.checkurpicpictentcart == "carts/9r.png" then
			self.enemyvalue = self.enemyvalue + 9
		elseif self.checkurpicpictentcart == "carts/10ch.png" or self.checkurpicpictentcart == "carts/10k.png" or self.checkurpicpictentcart == "carts/10p.png" or self.checkurpicpictentcart == "carts/10r.png" then
			self.enemyvalue = self.enemyvalue + 10
		elseif self.checkurpicpictentcart == "carts/ach.png" or self.checkurpicpictentcart == "carts/ak.png" or self.checkurpicpictentcart == "carts/ap.png" or self.checkurpicpictentcart == "carts/ar.png" then
			self.enemyvalue = self.enemyvalue + 11
		elseif self.checkurpicpictentcart == "carts/jch.png" or self.checkurpicpictentcart == "carts/jk.png" or self.checkurpicpictentcart == "carts/jp.png" or self.checkurpicpictentcart == "carts/jr.png" then
			self.enemyvalue = self.enemyvalue + 2
		elseif self.checkurpicpictentcart == "carts/qch.png" or self.checkurpicpictentcart == "carts/qk.png" or self.checkurpicpictentcart == "carts/qp.png" or self.checkurpicpictentcart == "carts/qr.png" then
			self.enemyvalue = self.enemyvalue + 3
		elseif self.checkurpicpictentcart == "carts/kch.png" or self.checkurpicpictentcart == "carts/kk.png" or self.checkurpicpictentcart == "carts/kp.png" or self.checkurpicpictentcart == "carts/kr.png" then
			self.enemyvalue = self.enemyvalue + 4
		else
			LocalPlayer():ConCommand("say Тестинг Ты долбаеб что это такое")
		end

		end
	end
end


function PANEL:addContinue2()
	self.scrW, self.scrH = ScrW(), ScrH()

	local but_start1Wyes, but_start1Hyes = self.scrW * 0.075, self.scrH * 0.036
	local but_start1Xyes, but_start1Yyes = (self.scrW * 0.05) - (but_start1Wyes * 0.5), self.scrH * 0.505

	self.but_go_next = self:Add("DButton")
	self.but_go_next:SetText("Продолжить")
	self.but_go_next:SetColor(Color(169, 169, 169))
	self.but_go_next:SetFont("DescCharFont1")
	self.but_go_next:SetTextColor(color_white)
	function self.but_go_next:Paint( w, h )
		if self:IsDown() then 
			local material = Material("carts/but_3k.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		elseif self:IsHovered() then 
			local material = Material("carts/but_2k.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		else
			local material = Material("carts/but_1k.png")
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		end
	end
	self.but_go_next:SetSize(but_start1Wyes, but_start1Hyes)	
	self.but_go_next:SetPos(but_start1Xyes, but_start1Yyes)	
	self.but_go_next.DoClick = function(client)
		self.but_exit:SetDisabled( false )

		local gobutnext = vgui.Create("DFrame")
		gobutnext:SetTall(34)
		gobutnext:SetSize(ScrW() * 0.4, ScrH() * 0.25)
		gobutnext:Center()
		gobutnext:MakePopup()
		gobutnext:ShowCloseButton( false )
		gobutnext:SetDraggable( false )
		gobutnext:SetTitle("")

		function gobutnext:Paint( w, h )
			local material = Material("carts/ui_mod_cards322.png") 
			surface.SetDrawColor(color_white) 
			surface.SetMaterial(material) 
			surface.DrawTexturedRect(0, 0, w, h) 
		end

		local wintextWyes, wintextHyes = self.scrW * 0.45, self.scrH * 0.02
		local wintextXyes, wintextYyes = (self.scrW * 0.241) - (wintextWyes * 0.5), self.scrH * 0.09

		local friendtextXyes, friendtextYyes = self.scrW * 0.45, self.scrH * 0.02
		local friendtextWyes, friendtextHyes = (self.scrW * 0.311) - (friendtextXyes * 0.5), self.scrH * 0.09

		blyad_label = gobutnext:Add("DLabel")

		blyad_label.Think = function()
			if self.w_and_lose == 1 then
				blyad_label:SetText("Вы выиграли. Ваш выигрыш составил - "..self.total.." рублей. Сумма очков: вы - "..self.urvalue..", противник - "..self.enemyvalue..".")
				blyad_label:SetPos( wintextXyes, wintextYyes )
				blyad_label:SetSize( wintextWyes, wintextHyes )
			elseif self.w_and_lose == 3 then
				blyad_label:SetText("Вы проиграли. Ваш проигрыш составил - "..self.total.." рублей. Сумма очков: вы - "..self.urvalue..", противник - "..self.enemyvalue..".")
				blyad_label:SetPos( wintextXyes, wintextYyes )
				blyad_label:SetSize( wintextWyes, wintextHyes )
			elseif self.w_and_lose == 2 then
				blyad_label:SetText("Победила друбжа! Сумма очков: вы - "..self.urvalue..", противник - "..self.enemyvalue..".")
				blyad_label:SetPos( friendtextWyes, friendtextHyes )
				blyad_label:SetSize( friendtextXyes, friendtextYyes )
			else
				blyad_label:SetText("Ты долбаеб это что такое")
			end
		end

		blyad_label:SetFont("DescCharFont1")

		local but_exit1Wyes, but_exit1Hyes = self.scrW * 0.075, self.scrH * 0.036
		local but_exit1Xyes, but_exit1Yyes = (self.scrW * 0.198) - (but_exit1Wyes * 0.5), self.scrH * 0.207

		but_exit1 = gobutnext:Add("DButton")
		but_exit1:SetText("ОК")
		but_exit1:SetColor(Color(169, 169, 169))
		but_exit1:SetFont("DescCharFont1")
		but_exit1:SetTextColor(color_white)
		function but_exit1:Paint( w, h )
			if self:IsDown() then 
				local material = Material("carts/but_3k.png") 
				surface.SetDrawColor(color_white) 
				surface.SetMaterial(material) 
				surface.DrawTexturedRect(0, 0, w, h) 
			elseif self:IsHovered() and !self:GetDisabled() then 
				local material = Material("carts/but_2k.png") 
				surface.SetDrawColor(color_white) 
				surface.SetMaterial(material) 
				surface.DrawTexturedRect(0, 0, w, h) 
			else
				local material = Material("carts/but_1k.png")
				surface.SetDrawColor(color_white) 
				surface.SetMaterial(material) 
				surface.DrawTexturedRect(0, 0, w, h) 
			end
		end
		but_exit1:SetSize(but_exit1Wyes, but_exit1Hyes)	
		but_exit1:SetPos(but_exit1Xyes, but_exit1Yyes)	
		but_exit1.DoClick = function(client)
			gobutnext:Close()
			self:Close()
			local restarturpanel = vgui.Create("21o4ko")
		end

    	if (self.urvalue > self.enemyvalue and self.urvalue < 22 and self.enemyvalue < 22) or
    	 (self.urvalue == 21 and !self.enemyvalue == 21) or
    	  (self.urvalue == 22 and self.enemyvalue == 19) or
    	   --(self.urvalue == 23 and self.enemyvalue == 18) or
    	    (self.urvalue == 24 and self.enemyvalue == 17) or
    	     (self.urvalue == 25 and self.enemyvalue == 16) or
    	      (self.urvalue == 26 and self.enemyvalue == 15) or
    	       (self.urvalue == 22 and self.enemyvalue == 23) or
    	        (self.urvalue == 23 and self.enemyvalue == 24) or
    	         (self.urvalue == 24 and self.enemyvalue == 25) or
    	          (self.urvalue == 25 and self.enemyvalue == 26) or
    	           (self.urvalue == 26 and self.enemyvalue == 27) or
    	            (self.urvalue == 27 and self.enemyvalue == 28) or
    	             (self.urvalue == 28 and self.enemyvalue == 29) or
    	              (self.urvalue == 29 and self.enemyvalue == 30) or
    	               (self.urvalue == 30 and self.enemyvalue == 31) or
    	                (self.urvalue == 20 and self.enemyvalue > 22) or
    	                 (self.urvalue == 21 and self.enemyvalue > 21) or
    	                  (self.urvalue == 19 and self.enemyvalue > 22) or
    	                   (self.urvalue == 18 and self.enemyvalue > 23) or
    	                    (self.urvalue == 17 and self.enemyvalue > 24) or
    	                     (self.urvalue == 16 and self.enemyvalue > 25) or
    	                      (self.urvalue == 15 and self.enemyvalue > 26) or
    	                       (self.urvalue == 31 and self.enemyvalue == 32) or
    	                       	(self.urvalue == 22 and self.enemyvalue == 24) or
    	                       	 (self.urvalue == 20 and self.enemyvalue == 22) or
    	                       	  (self.urvalue == 18 and self.enemyvalue == 22) then
    		--LocalPlayer():ConCommand("say Тестинг! ты выиграл")
    		self.w_and_lose = self.w_and_lose + 1 --вин
    		netstream.Start("give_my_money", self.total)
		elseif (self.urvalue == self.enemyvalue) or
		 (self.urvalue == 20 and self.enemyvalue == 22) or
		  (self.urvalue == 19 and self.enemyvalue == 23) or
		   (self.urvalue == 18 and self.enemyvalue == 24) or
		    (self.urvalue == 17 and self.enemyvalue == 25) or
		     (self.urvalue == 16 and self.enemyvalue == 26) or
		       (self.urvalue == 22 and self.enemyvalue == 20) or
		        (self.urvalue == 23 and self.enemyvalue == 19) or
		         (self.urvalue == 24 and self.enemyvalue == 18) or
		          (self.urvalue == 25 and self.enemyvalue == 17) or
		           (self.urvalue == 26 and self.enemyvalue == 16) then
    		--LocalPlayer():ConCommand("say Тестинг! победила дружба")
    		self.w_and_lose = self.w_and_lose + 2 --ничья
    		netstream.Start("win_4_friend", self.total)
		elseif (self.urvalue < self.enemyvalue and self.urvalue < 22 and self.enemyvalue < 22) then
			--LocalPlayer():ConCommand("say Тестинг! ето проеб")
			self.w_and_lose = self.w_and_lose + 3 --луз
    	else
    		--LocalPlayer():ConCommand("say Тестинг! ето проеб")
    		self.w_and_lose = self.w_and_lose + 3 --луз
    	end
	end
end

vgui.Register("21o4ko", PANEL, "DFrame")
netstream.Hook("21o4ko", function()
	two4ko = vgui.Create("21o4ko")
end)
