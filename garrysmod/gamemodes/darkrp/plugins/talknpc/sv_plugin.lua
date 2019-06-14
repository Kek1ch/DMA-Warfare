local PLUGIN = PLUGIN

function PLUGIN:SaveData()
	local data = {}
		for k, v in ipairs(ents.FindByClass("nut_talker")) do
			data[#data + 1] = {
				name = v:getNetVar("name"),
				desc = v:getNetVar("desc"),
				anim = v:getNetVar("anim"),
				sound = v:getNetVar("sound"),
				pos = v:GetPos(),
				angles = v:GetAngles(),
				model = v:GetModel(),
				factions = v:getNetVar("factiondata", {}),
				dialogue = v:getNetVar( "dialogue", self.defaultDialogue ),
				classes = v:getNetVar("classdata", {})
			}
		end
	self:setData(data)
end

function PLUGIN:LoadData()
	for k, v in ipairs(self:getData() or {}) do
		local entity = ents.Create("nut_talker")
		entity:SetPos(v.pos)
		entity:SetAngles(v.angles)
		entity:Spawn()
		entity:SetModel(v.model)
		entity:setNetVar("dialogue", v.dialogue)
		entity:setNetVar("factiondata", v.factions)
		entity:setNetVar("classdata", v.classes)
		entity:setNetVar("name", v.name)
		entity:setNetVar("desc", v.desc)
		entity:setNetVar("anim", v.anim)
		entity:setNetVar("sound", v.sound)
	end
end

