AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

local drops_t = {"trapk", "tkan", "tinderbox", "nitka_sintetichesk", "brezent", "armbr", "banka_s_xlamom", "rozshig_kit", "perenosnoe_radio",
"swiss", "tie", "cigar", "ctabak", "geigerbrok", "glue", "pils", "swkit1", "swkit3", "kerosin", "bint", "10r", "100r", "1000r", "500r", "50r", 
"5000r", "200r", "bighealth", "tinderboxfuel", "crowboar", "kowelek", "mirror", "scienmediumhealth", "9x18", "9x19", "9x39", "12x70", "45acp",
"545x39", "556x45", "762x54", "vodka", "vodka_def", "water", "konservi", "bread", "kolbasa", "energy"}

local DropCassette = {"cassette_bandits", "cassette_barman", "cassette_firelake", "cassette_freedom", "cassette_merc", "cassette_standart",
"cassette_true", "cassette_wickedrabbit"}

function ENT:setInventory(inventory)
	if (inventory) then
		self:setNetVar("id", inventory:getID())

		inventory.onAuthorizeTransfer = function(inventory, client, oldInventory, item)
			if (IsValid(client) and IsValid(self) and self.receivers[client]) then
				return true
			end
		end
		inventory.getReceiver = function(inventory)
			local receivers = {}

			for k, v in pairs(self.receivers) do
				if (IsValid(k)) then
					receivers[#receivers + 1] = k
				end
			end

			return #receivers > 0 and receivers or nil
		end
	end
end

function ENT:Initialize()
	self:SetModel("models/kek1ch/sumka1.mdl")	
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self.receivers = {}
	self:DropToFloor()
	self:setNetVar("name", "Рюкзак")

	if (IsValid(self:GetPhysicsObject())) then
		self:GetPhysicsObject():EnableMotion(false)
	end

	nut.item.newInv(0, "loot", function(inventory)
		if (IsValid(self)) then
			inventory:setSize(nut.config.get("invW"), nut.config.get("invH"))
			self:setInventory(inventory)
		end
	end)

	for i = 2, 5 do
		self:getInv():add(drops_t[math.random( 1, #drops_t )])
	end

	if math.random(1,1000) == 1000 then
		self:getInv():add(table.Random(DropCassette))
	end
end

local OPEN_TIME = 0.5
function ENT:OpenInv(activator)
	local inventory = self:getInv()

	activator:setAction("@opening", OPEN_TIME)
	activator:doStaredAction(self, function()
		if (activator:GetPos():Distance(self:GetPos()) < 101) then
			self.receivers[activator] = true
			activator.nutBagEntity = self

			inventory:sync(activator)
			netstream.Start(activator, "lootOpen", self, inventory:getID())
			self:EmitSound("interface/inv_open.ogg")
		end
	end, OPEN_TIME, function()
		if (IsValid(activator)) then
			activator:setAction()
		end
	end)
	return
end

function ENT:Use(activator)
	local inventory = self:getInv()

	if (inventory and (activator.nutNextOpen or 0) < CurTime()) then
		if (activator:getChar()) then
			self:OpenInv(activator)
		end

		if not self.start_timer and self then
			self.start_timer = true

			timer.Simple(math.random(1600, 2000), function()
				--self:Remove()

				--local entity = ents.Create("dma_box")
				--entity:SetPos(self:GetPos())
				--entity:Spawn()
				for i = 2, 5 do
					self:getInv():add(drops_t[math.random( 1, #drops_t )])
				end

				if math.random(1,1000) == 1000 then
					self:getInv():add(table.Random(DropCassette))
				end
			end)
		end

		activator.nutNextOpen = CurTime() + OPEN_TIME * 1.5
	end
end

function ENT:OnRemove()
	for k, v in ipairs(player.GetAll()) do
		netstream.Start(v, "closeLootMenuSafe")
	end
end

function ENT:getInv()
	return nut.item.inventories[self:getNetVar("id", 0)]
end

