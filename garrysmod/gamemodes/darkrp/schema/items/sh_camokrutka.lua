ITEM.name = "Косяк конопли"
ITEM.desc = "Косяк успокоит нервы и поможет расслабиться на некоторое время. Благорадя ярко выраженному седативному эффекту, ненадолго отключит и перезапустит мозг, позволив ему остаться в порядке и избежать необратимых негативных последствий. \n\nХАРАКТЕРИСТИКИ: \n-стимулятор \n-сильное облегчение последствий псио-облучения"
ITEM.price = 360
ITEM.exRender = false
ITEM.weight = 0.01

ITEM.model = "models/kek1ch/drink_joint.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-140.80000305176, -114, 94.400001525879),
	ang = Angle(27.515924453735, 38.980892181396, -11.464967727661),
	fov = 1.3
}

ITEM.functions.Use = {
	name = "закурить",
	onRun = function(item)
		local client = item.player
		if (IsValid(item.player) && item.player:Alive()) then
			if not item.player:getChar():getInv():hasItem("tinderbox") then
				item.player:notify("У вас нет зажигалки!")
				return false
			end
			
			local s = EffectData();
			s:SetOrigin(item.player:EyePos());
			util.Effect("cw_effect_smoke_cig", s);

			item.player:EmitSound("interface/inv_smoke.ogg", 50, 100)
			client:ScreenFade(1, Color(255, 255, 255, 255), 3, 0)
		end
	end,

	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

ITEM:hook("_use", function(item)
	item.player:ScreenFade(1, Color(255, 255, 255, 255), 3, 0)
end)

local weedestColor = Color(27, 150, 0)
local weedMat = Material("modernrp/dankweed.png")

function ITEM:drawEntity(entity, item)
	entity:SetColor(weedestColor)
	entity:DrawModel()
	entity.emitter = entity.emitter or ParticleEmitter(entity:GetPos())

	if (entity.emitter) then
		if (!entity.nextEmit or entity.nextEmit < CurTime()) then
			local smoke = entity.emitter:Add(weedMat, entity:GetPos() + entity:OBBCenter())
			smoke:SetVelocity(VectorRand()*20)
			smoke:SetDieTime(math.Rand(0.5,1.3))
			smoke:SetStartAlpha(255)
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(2,4))
			smoke:SetEndSize(math.random(8,12))
			smoke:SetRoll(math.Rand(0, 420))
			smoke:SetRollDelta(math.Rand(-3,3))
			smoke:SetGravity(Vector( 0, 0, 15))
			smoke:SetAirResistance(120)

			entity.nextEmit = CurTime() + .4
		end
	end
end