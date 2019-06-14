PLUGIN.name = "Talking NPCs"
PLUGIN.author = "Black Tea (NS 1.0), Neon (NS 1.1)"
PLUGIN.desc = "Adding talking NPCs."
PLUGIN.chatDelay = { min = .5, max = 1 }
PLUGIN.defaultDialogue = {
	npc = {
		["_start"] = "Приветствую, сталкер.",
		["test1"] = "Я че ебу этих ящеров. Да кто такой этот Black Tea? Девочка какая-то, Маслорий сука. Есть такой модератор у нас в чате, Маслорий сука, ну и ник бля, я ебал. Да в принципе и неважно как его зовут. Вообщем, этот черный чай попущенный какой-то и от него сильно воняет гавном.",
	},
	player = {
		["quit"] = "Бывай!",
		["test1"] = "Кто такой Black Tea?",
	},
}

nut.util.include("sv_plugin.lua")

