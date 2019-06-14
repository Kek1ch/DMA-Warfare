local Themes = {}
Themes["Black"] = {Body = Color(0,0,0,225), Text = Color(255,255,255,255), URL = Color(68, 0, 255,255), Reconnect = Color(123, 102, 217,255)}
Themes["Red"] = {Body = Color(255,80,80,225), Text = Color(255,255,255,255), URL = Color(150,255,150,255), Reconnect = Color(255,200,200,255)}
Themes["Blue"] = {Body = Color(150,150,255,225), Text = Color(255,255,255,255), URL = Color(150,255,150,255), Reconnect = Color(255,150,150,255)}
Themes["Green"] = {Body = Color(80,255,80,225), Text = Color(50,50,50,255), URL = Color(50,100,50,255), Reconnect = Color(200,20,20,255)}
Themes["Orange"] = {Body = Color(229,126,22,225), Text = Color(255,255,255,255), URL = Color(150,255,150,255), Reconnect = Color(255,150,150,255)}
Themes["Purple"] = {Body = Color(143,22,229,225), Text = Color(255,255,255,255), URL = Color(150,255,150,255), Reconnect = Color(255,150,150,255)}


local Logo = ""
local LogoWidth = 400
local LogoHeight = 150
local WebsiteURL = ""
local Theme = "Black"

local pingFrequency = 5
local timeout = 5
local reconnectDelay = 60

local requestSent = -1
local lastPing = 0

local function sendPing()
	net.Start("Ele_TimeoutPing")
		net.WriteBit(true)
	net.SendToServer()

	requestSent = CurTime()
end

net.Receive("Ele_TimeoutPing", function(len)
	requestSent = -1
end)

local matBlurScreen = Material( "pp/blurscreen" )
local function RenderBlur()
	local Fraction = 1

	local x, y = 0, 0

	DisableClipping( true )
	
	surface.SetMaterial( matBlurScreen )	
	surface.SetDrawColor( 255, 255, 255, 0 )
		
	for i=0.33, 1, 0.33 do
		matBlurScreen:SetFloat( "$blur", Fraction * 5 * i )
		matBlurScreen:Recompute()
		if ( render ) then render.UpdateScreenEffectTexture() end
		surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )
	end
	
	surface.SetDrawColor( 15, 15, 15, 200 * Fraction )
	surface.DrawRect( x * -1, y * -1, ScrW(), ScrH() )
	
	DisableClipping( false )
end

hook.Add("PostRenderVGUI", "ServerTimeout_HUDPaint", function()
	if (requestSent == -1) then 

		if (CurTime() - lastPing > pingFrequency) then
			
			lastPing = CurTime()
			sendPing()
		end

		return
	end
	if (CurTime() - requestSent < timeout) then return end

	RenderBlur()

	local untilReconnect = reconnectDelay - math.Round(CurTime() - requestSent) + timeout
	surface.SetDrawColor(Themes[Theme].Body.r, Themes[Theme].Body.g, Themes[Theme].Body.b, Themes[Theme].Body.a)
	surface.DrawRect(0,0,ScrW(),ScrH())

	if Logo != "" then
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial(LogoTexture)
		surface.DrawTexturedRect(ScrW()/2-LogoWidth/2, 20,LogoWidth,LogoHeight)
	end

	draw.SimpleText("Потеряно соединение с сервером.", "dobi4ikxyecoc", ScrW()/2, ScrH()/2 - 25, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText("Потеряно соединение с сервером.", "dobi4ikxyecoc", ScrW()/2, ScrH()/2 - 25, Color(211, 211, 211), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	if (untilReconnect > 0) then
		draw.SimpleText("Переподключение произойдет через " .. untilReconnect .. " секунд(ы).", "dobi4ikxyecoc", ScrW()/2, ScrH()/2 + 25, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("Переподключение произойдет через " .. untilReconnect .. " секунд(ы).", "dobi4ikxyecoc", ScrW()/2, ScrH()/2 + 25, Color(62, 95, 138, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	else
		RunConsoleCommand("retry")
	end

	draw.SimpleText(WebsiteURL, "dobi4ikxyecoc", ScrW()/2, ScrH()/2 + 75, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText(WebsiteURL, "dobi4ikxyecoc", ScrW()/2, ScrH()/2 + 75, Themes[Theme].URL, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)

timer.Create("ServerTimeout_AutoPing", pingFrequency, 0, sendPing)