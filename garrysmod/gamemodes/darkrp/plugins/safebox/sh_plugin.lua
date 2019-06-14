PLUGIN.name = "Safebox"
PLUGIN.author = "La Corporativa, hikka"
PLUGIN.desc = "A plugin that allows players to have a safe place to store their items."

nut.config.add("BankInvW", 5, "How many slots in a row there is in a bank inventory.", nil, {
	data = {min = 0, max = 20},
	category = "characters"
})
nut.config.add("BankInvH", 5, "How many slots in a row there is in a bank inventory.", nil, {
	data = {min = 0, max = 20},
	category = "characters"
})

nut.util.include("sv_plugin.lua")

local CHAR = nut.meta.character

function CHAR:getReserve()
	return self:getData("bankmoney", 0)
end

function CHAR:addReserve(amt)
	self:setData("bankmoney", self:getReserve() + amt)
end

function CHAR:takeReserve(amt)
	self:addReserve(-amt)
end

function CHAR:hasReserve(amt)
	return (amt > 0 and self:getReserve() >= amt)
end

