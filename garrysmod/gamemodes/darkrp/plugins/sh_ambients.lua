local PLUGIN = PLUGIN
PLUGIN.name = "Ambient Sounds"
PLUGIN.author = "Kek1ch"
PLUGIN.desc = "Ambient Sounds"

PLUGIN.config = {}
PLUGIN.config.activated = true

PLUGIN.MainAmbient = {}
PLUGIN.MainAmbient['ambient/zaton/zat_bkg_day.ogg'] = {dur = 25}
PLUGIN.MainAmbient['ambient/zaton/zat_bkg_evening.ogg'] = {dur = 25}
PLUGIN.MainAmbient['ambient/zaton/zat_bkg_morning.ogg'] = {dur = 25}
PLUGIN.MainAmbient['ambient/zaton/zat_bkg_night.ogg'] = {dur = 25}
PLUGIN.MainAmbient['ambient/zaton/zat_bkg_tuman.ogg'] = {dur = 22}
PLUGIN.MainAmbient['ambient/zaton/wind_bkg_1.ogg'] = {dur = 20}
PLUGIN.MainAmbient['ambient/zaton/urban_wind_bak.ogg'] = {dur = 15}
PLUGIN.MainAmbient['ambient/zaton/pri_bkg_tuman.ogg'] = {dur = 49}
PLUGIN.MainAmbient['ambient/zaton/pri_bkg_morning.ogg'] = {dur = 25}
PLUGIN.MainAmbient['ambient/zaton/pri_bkg_evening.ogg'] = {dur = 25}
PLUGIN.MainAmbient['ambient/zaton/pri_bkg_day.ogg'] = {dur = 15}
PLUGIN.MainAmbient['ambient/zaton/marsh_bkg_1.ogg'] = {dur = 10}
PLUGIN.MainAmbient['ambient/zaton/jup_bkg_tuman.ogg'] = {dur = 49}
PLUGIN.MainAmbient['ambient/zaton/jup_bkg_night.ogg'] = {dur = 25}
PLUGIN.MainAmbient['ambient/zaton/jup_bkg_morning.ogg'] = {dur = 26}
PLUGIN.MainAmbient['ambient/zaton/jup_bkg_evening.ogg'] = {dur = 26}
PLUGIN.MainAmbient['ambient/zaton/jup_bkg_day.ogg'] = {dur = 25}
PLUGIN.MainAmbient['ambient/zaton/bkg_tuman.ogg'] = {dur = 30}
PLUGIN.MainAmbient['ambient/zaton/bkg_day.ogg'] = {dur = 69}
PLUGIN.MainAmbient['ambient/zaton/bkg_01.ogg'] = {dur = 36}

PLUGIN.RandomMain = {}
for k, v in pairs(PLUGIN.MainAmbient) do
	PLUGIN.RandomMain[#PLUGIN.RandomMain + 1] = k
end

if (CLIENT) then
	function PLUGIN:Think()
		if (!LocalPlayer().TimeMainAmbient or LocalPlayer().TimeMainAmbient < CurTime()) then
			local TimeValueMn = Format(table.Random(PLUGIN.RandomMain))
			self.MainAmbientSound = CreateSound(LocalPlayer(), TimeValueMn)
			self.MainAmbientSound:Play()
			self.MainAmbientSound:ChangeVolume(1, 1)
			LocalPlayer().TimeMainAmbient = CurTime() + self.MainAmbient[TimeValueMn].dur
		end

		if (!LocalPlayer().TimeRandomAmbient or LocalPlayer().TimeRandomAmbient < CurTime()) then
			self.RandomAmbient = CreateSound(LocalPlayer(), Format("ambient/random/audio"..math.random(1, 25)..".ogg"))
			self.RandomAmbient:Play()
			self.RandomAmbient:ChangeVolume(1, 1)
			LocalPlayer().TimeRandomAmbient = CurTime() + math.random(5, 9)
		end

		local data = {}
			data.start = LocalPlayer():GetShootPos()
			data.endpos = data.start + Vector(0, 0, 10000)
			data.filter = LocalPlayer()
		local trace = util.TraceLine(data)

		if (trace.HitSky) then
			self.MainAmbientSound:ChangeVolume(1, 1)
			self.RandomAmbient:ChangeVolume(1, 1)
		else
			self.MainAmbientSound:ChangeVolume(0.3, 0.3)
			self.RandomAmbient:ChangeVolume(0.3, 0.3)
		end
	end
end
