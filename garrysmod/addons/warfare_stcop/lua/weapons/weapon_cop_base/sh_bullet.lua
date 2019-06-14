local bul, td = {}, {}
local bul2 = {}
local spread  = Vector(0, 0, 0)

local NoRicochet = {
	[MAT_FLESH]       = true,
	[MAT_ANTLION]     = true,
	[MAT_BLOODYFLESH] = true,
	[MAT_DIRT]        = true,
	[MAT_SAND]        = true,
	[MAT_GLASS]       = true,
	[MAT_ALIENFLESH]  = true
}

local NoPenetration = {
	[MAT_SLOSH] = true
}

local PenMod = {
	[MAT_SAND] = 0.5,
	[MAT_DIRT] = 0.8,
	[MAT_METAL] = 1.1,
	[MAT_TILE] = 0.9,
	[MAT_WOOD] = 1.2
}

local PenDamage = {
	[MAT_CONCRETE] = 0.4,
	[MAT_WOOD] = 0.8,
	[MAT_PLASTIC] = 0.85,
	[MAT_GLASS] = 0.75,
	[MAT_SAND] = 0.3,
	[MAT_FLESH] = 0.9,
	[MAT_ALIENFLESH] = 0.85
}

local function BulletPenetration(attacker, tr, dmginfo)
	local wep = attacker:GetActiveWeapon()
	if IsValid(wep) and not NoPenetration[tr.MatType] then
		local force = dmginfo:GetDamageForce():Length() / 256 * wep.Primary.PenMul * (PenMod[tr.MatType] or 1)
		local ent = tr.Entity

		if force > 0 then
			local td = {}
			td.start = tr.HitPos + tr.Normal * force
			td.endpos = tr.HitPos
			td.filter = attacker
			td.mask = MASK_SHOT

			local tr2 = util.TraceLine(td)
			if not (tr2.StartSolid or tr2.Fraction >= 1.0 or tr2.Fraction <= 0.0) then
				bul.Src = tr2.HitPos
				bul.Damage = bul.Damage * (PenDamage[tr.MatType] or 0.5)
				bul.Force = bul.Force * 0.2
				bul.Tracer = 0

				bul2.Num = 1
				bul2.Src = tr2.HitPos + tr.Normal
				bul2.Dir = -tr.Normal
				bul2.Tracer = 0
				bul2.Force = 0
				bul2.Damage = 0

				if IsFirstTimePredicted() then
					attacker:FireBullets(bul)
					attacker:FireBullets(bul2)
				end
			end
		end
	end
end

local RicochetSound = {
	"weapons/stalker_cop/whine1.wav",
	"weapons/stalker_cop/whine2.wav",
	"weapons/stalker_cop/whine3.wav",
	"weapons/stalker_cop/whine4.wav"
}

local function BulletCallback(attacker, _tr, dmginfo)
	local wep = attacker:GetActiveWeapon()
	if IsValid(wep) then
		if wep.BulletCallback then
			wep:BulletCallback(_tr, dmginfo)
		end
	end

	if _tr.HitSky then return end
	if BulletPenetration(attacker, _tr, dmginfo) then return end

	if not wep.Primary.Ricochet then
		return
	end

	if bul.RicNum >= 3 then
		return
	end

 	local dot = -_tr.HitNormal:Dot(_tr.Normal)
	if dot >= 0.2 then return end

	bul.Src = _tr.HitPos
	bul.Dir = (2 * _tr.HitNormal * dot) + _tr.Normal
	bul.Force = bul.Force * 0.3
	bul.Damage = bul.Damage * 0.6
	bul.Tracer = 0
	bul.RicNum = bul.RicNum + 1

	if IsFirstTimePredicted() then
		sound.Play(RicochetSound[math.random(1, #RicochetSound)], bul.Src, 60, 100, 1)
		attacker:FireBullets(bul)
	end
end

function SWEP:FireBullet()
	math.randomseed(CurTime())

	local bulletAccuracy = self:GetAccuracy() * 10
	local bulletDamage   = math.floor(self.Damage / self.Primary.BulletNum)

	local shootPos = self.Owner:GetShootPos()
	local shootDir = self.Owner:GetAimVector():Angle()

	shootDir.p = shootDir.p + math.Rand(-0.5, 0.5) * bulletAccuracy
	shootDir.y = shootDir.y + math.Rand(-0.5, 0.5) * bulletAccuracy

	for i = 1, self.Primary.BulletNum do
		local shootDir2 = shootDir:Forward()

		if self.Primary.Spread > 0 then
			shootDir2 = shootDir2 + VectorRand() * self.Primary.Spread
		end

		bul.Num = 1
		bul.Src = shootPos
		bul.Dir = shootDir2
		bul.Force = bulletDamage * 0.12
		bul.Damage = bulletDamage
		bul.Callback = BulletCallback
		bul.Tracer = 1
		bul.AmmoType = self.Primary.Ammo
		bul.RicNum = 0
		bul.PenMul = 0

		if IsFirstTimePredicted() then
			self.Owner:FireBullets(bul)
		end
	end
end