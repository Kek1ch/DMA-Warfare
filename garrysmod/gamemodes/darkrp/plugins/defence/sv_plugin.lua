---------------------------------------------
--Автоматическая очистка предметов
---------------------------------------------
timer.Create( "itemcleanup", 8, 0, function()
	if table.Count(ents.FindByClass( "nut_item" )) > 40 then
		for k, v in ipairs(ents.FindByClass("nut_item")) do
			v:Remove()
		end
	end
	if table.Count(ents.FindByClass( "nut_money" )) > 40 then
		for k, v in ipairs(ents.FindByClass("nut_money")) do
			v:Remove()
		end
	end
end)

nut.command.add("itemclean", {
	adminOnly = true,
	onRun = function (client, arguments)
		if (!client:getChar():hasFlags("M")) then return end
		for k, v in pairs( ents.FindByClass( "nut_item" ) ) do
			v:Remove()
		end
		for k, v in pairs( ents.FindByClass( "nut_money" ) ) do
			v:Remove()
		end
		for k, v in pairs( ents.FindByClass( "nut_item_death" ) ) do
			v:Remove()
		end
		client:notify("Очистка карты завершена")
	end
})


