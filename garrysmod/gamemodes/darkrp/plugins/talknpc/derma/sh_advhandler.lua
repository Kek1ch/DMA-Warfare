local PLUGIN = PLUGIN
nut.plugin = nut.plugin or {}
nut.plugin.list = nut.plugin.list or {}
local questPLUGIN = nut.plugin.list.quests
if not questPLUGIN then
    print( 'quest_honeya example will not work properly without "quest" plugin.' )
end

PLUGIN.SpecialCall =
{
		--[[["quest_mnash"] = {
            sv = function( client, data )
                if client:HasQuest( "quest_mnash" ) then
                	for k, v in pairs(client:GetQuest( "quest_mnash" )) do
						if client:getChar():getInv():hasItem( k ) then
							if client:getChar():getInv():getItemCount( k ) >= v then
								local nagrada = {
                				"pm",
                				"aksu"
                				}
								client:getChar():getInv():add(table.Random(nagrada))
    							for i = 1, v do client:getChar():getInv():remove(client:getChar():getInv():hasItem( k ):getID()) end
								client:RemoveQuest( "quest_mnash" )
								data.done = true
							end
						else
							data.done = false
						end
					end
                else
                    data.gotquest = true
               		local rkek = {
               			kek1 = {
							["pdolg"] = 2
               			},

               			kek2 = {
							["pmerc"] = 2
               			}
              	 	}
                    client:AddQuest( "quest_mnash", table.Random(rkek) )
                    for k, v in pairs(client:GetQuest( "quest_mnash" )) do
						client:ConCommand("say Задание: принести сталкеру предмет - "..nut.item.list[k].name.." в количестве "..v.." шт.")
					end
                end
                return data
            end,
            cl = function( client, panel, data )
               if data.gotquest then
					for k, v in pairs(LocalPlayer():GetQuest( "quest_mnash" )) do
						panel:AddChat( data.name, "Принеси мне предмет "..nut.item.list[k].name.." в количестве "..v.." шт.")
                        panel:AddChat( LocalPlayer():Name(), "Я берусь.")
					end
					panel.talking = false
                    return
                end
                if data.done then
                    panel:AddChat( data.name, "Сегодня видишь, ты мне помог, а завра и я тебе.")
                else
                    for k, v in pairs( LocalPlayer():GetQuest( "quest_mnash" ) ) do
                        panel:AddChat( data.name, "Принес предмет "..nut.item.list[k].name.." в количестве "..v.." шт.?" )
                    end
                end
                panel.talking = false
            end,
        },]]

        ["quest_medicamenti"] = {
            sv = function( client, data )
                if client:HasQuest( "quest_medicamenti" ) then
                    for k, v in pairs(client:GetQuest( "quest_medicamenti" )) do
                        if client:getChar():getInv():hasItem( v ) then
                            local Medicamenti = {
                                [1] = "medkit",
                                [2] = "pm"
                            }
                            client:getChar():getInv():add(Medicamenti[math.random(1,2)])
                            client:getChar():getInv():remove(client:getChar():getInv():hasItem( v ):getID())
                            client:getChar():setData("quest_medicamenti", nil)
                            client:RemoveQuest( "quest_medicamenti" )
                            data.done = true
                            collectgarbage()
                            break
                        else
                            data.done = false
                        end
                    end
                else
                    data.gotquest = true
                    local rkek = {
                        kek1 = {
                            ["в пещере рядом с заправкой"] = "medic_container" --на местоположении находится gathering
                        },
                        --контейнер можно будет вскрыть, но тогда репутация уменьшится и квест провалится
                        kek2 = {
                            ["на сгоревшем хуторе"] = "medic_container"
                        },
                        
                        kek3 = {
                            ["на лесопилке"] = "medic_container"
                        },
                    }
                    client:AddQuest( "quest_medicamenti", table.Random(rkek) )
                    for k, v in pairs(client:GetQuest( "quest_medicamenti" )) do
                        client:ConCommand("say Задание: принести медику "..nut.item.list[v].name..".")
                    end
                end
                return data
            end,
            cl = function( client, panel, data )
               if data.gotquest then --Вы слышите бормотание, а после взгляд медика устремился на вас. - Чего хотел? Дырка какая, или ожог. Может рану зашить? Только ты учти, у меня сейчас туговато с медикаментами.
                    for k, v in pairs(LocalPlayer():GetQuest( "quest_medicamenti" )) do --Может, помочь с чем смогу? 
                        panel:AddChat( data.name, "Тяжело вздохнув, оглядел вас, видимо оценивая ваш опыт, сказал - Ну, я могу дать тебе метку на один тайник мой, "..k..". Если принесешь мне его содержимое, а именно "..nut.item.list[v].name.." - чиста твоя совесть. Просто вспомни, сколько ты жизней загубишь.")
                        panel:AddChat( LocalPlayer():Name(), "Я берусь.")
                    end
                    panel.talking = false
                    return
                end
                if data.done then
                    panel:AddChat( data.name, "Считай, что ты спас несколько жизней. Вот, это тебе.")
                else
                    for k, v in pairs( LocalPlayer():GetQuest( "quest_medicamenti" ) ) do
                        panel:AddChat( data.name, "Как там продвигается наше дело? Напомню, что тайник находится "..k..", где ты найдешь "..nut.item.list[v].name.."." )
                    end
                end
                panel.talking = false
            end,
        },

        ["quest_syltan_sobake"] = {
            sv = function( client, data )
                if client:HasQuest( "quest_syltan_sobake" ) then
                    for k, v in pairs(client:GetQuest( "quest_syltan_sobake" )) do
                        if client:getChar():getInv():hasItem( k ) then
                            if client:getChar():getInv():getItemCount( k ) >= v then
                                local Sobake = {
                                [1] = "12x70",
                                [2] = "pm",
                                [3] = "9x18"
                                }
                                client:getChar():giveMoney(math.random(2000, 4000))
                                client:getChar():getInv():add(Sobake[math.random(1,3)], 3)
                                for i = 1, v do client:getChar():getInv():remove(client:getChar():getInv():hasItem( k ):getID()) end
                                client:RemoveQuest( "quest_syltan_sobake" )
                                data.done = true
                                break
                            end
                        else
                            data.done = false
                        end
                    end
                else
                    data.gotquest = true
                    local kek1 = {
                        ["food_ruchkasamodrochka4"] = math.random(3, 12)
                    },
                    client:AddQuest( "quest_syltan_sobake", kek1 )
                    for k, v in pairs(client:GetQuest( "quest_syltan_sobake" )) do
                        client:ConCommand("say Задание: принести Султану - "..v.." хвоста псевдособаки.")
                    end
                end
                return data
            end,
            cl = function( client, panel, data )
               if data.gotquest then
                    for k, v in pairs(LocalPlayer():GetQuest( "quest_syltan_sobake" )) do
                        panel:AddChat( data.name, "Короче, та маза еще не че не доказала. Ты конечно не лох какой, за слова отвечаешь, но это только начало. Тут недавно разбушевались собаки, загрызли нашего пацанчика. Ты метнись там, постреляй шавок короче и в доказательство мне хвосты принеси в количестве"..v.." шт." )
                        panel:AddChat( LocalPlayer():Name(), "Мля, да ты шо думаешь, я чепушила какой? Ща сделаю все в лучшем виде.")
                    end
                    panel.talking = false
                    return
                end
                if data.done then
                    panel:AddChat( data.name, "Лопни мои глазоньки! Живой! Ну, на. Заработал.")
                else
                    for k, v in pairs( LocalPlayer():GetQuest( "quest_syltan_sobake" ) ) do
                        panel:AddChat( data.name, "Ты шо, забыл? Принеси "..v.." хвоста псевдособаки.")
                    end
                end
                panel.talking = false
            end,
        },

        ["quest_boroda_scaner"] = {
            sv = function( client, data )
                if client:HasQuest( "quest_boroda_scaner" ) then
                    if (client:getChar():getData("quest_boroda_scaner") == client:GetQuest( "quest_boroda_scaner" )) then  
                        local BorodaScaner = {
                        [1] = "tea",
                        [2] = "vodka",
                        [3] = "konservi",
                        [4] = "water",
                        [5] = "gorka_3",
                        [6] = "kolbasa"
                        }
                        client:getChar():getInv():add(BorodaScaner[math.random(1,6)], 1) 
                        client:getChar():giveMoney(math.random(6000, 9000))
                        client:getChar():setData("quest_boroda_scaner", nil)
                        client:RemoveQuest( "quest_boroda_scaner" )
                        data.done = true
                    else
                        data.done = false
                    end
                else
                    data.gotquest = true

                    local anomalies = {
                    "jarka",
                    "kisel_anomaly",
                    "gazirovka_anomaly",
                    "kometa",
                    "electra_anomaly"
                    }

                    client:AddQuest( "quest_boroda_scaner", table.Random(anomalies) )
                    client:ConCommand("say Задание: Установить сканер аномальной активности рядом с аномалией.")
                    client:getChar():getInv():add("skaner_animalies")
                    timer.Simple(1, function()
                        client:ConCommand("say Получен предмет: Сканер аномальной активности")
                    end)
                end
                return data
            end,
            cl = function( client, panel, data )
                if data.gotquest then
                    panel:AddChat( data.name, "Здарова, молодняк. Тут вобщем дельце нарисовалось, а отправить некого. Все бухают. Я вот тебе предлогаю, да заодно опыта наберешься. Там сходить надо, поставить у аномалии «"..L(LocalPlayer():GetQuest( "quest_boroda_scaner" )).."» кое-какой приборчик и обратно. Наградой не обижу." )
                    panel:AddChat( LocalPlayer():Name(), "Ну ладно. Готовь денюжки.")
                    panel:AddChat( data.name, "Вот это подход. Давай, я вечно тут.")
                    panel.talking = false
                    return
                end
                if data.done then
                    panel:AddChat( data.name, "Ух, молодца! Я в тебе не сомневался, ну разве что чуть-чуть. Ладно, держи честно заработанные.")
                else
                    panel:AddChat( data.name, "На аномалию «"..L(LocalPlayer():GetQuest( "quest_boroda_scaner" )).."» надо сходить и постаить сканер аномальной активности, который я тебе дал.")
                end
                panel.talking = false
            end,
        },

        ["quest_killer_rep"] = {
            sv = function( client, data )
                if client:HasQuest( "quest_killer_rep" ) then
                    if client:getChar():getData("repkiller") == client:GetQuest( "quest_killer_rep" ) then
                        local RepKiller = {
                        [1] = "lr300",
                        [2] = "spas",
                        [3] = "sg550",
                        [4] = "fnfs2000",
                        }
                        client:getChar():getInv():add(RepKiller[math.random(1,4)])
                        client:RemoveQuest( "quest_killer_rep" )
                        client:getChar():setData("repkiller", nil)
                        collectgarbage()
                        data.done = true
                    else
                        data.done = false
                    end
                else
                    for k,v in RandomPairs(player.GetAll()) do
                        if (!v:Team() == FACTION_ADMIN) and (!client:Name() == v:Name()) and (v:getChar():getData("rep") < -40) then
                            print(v:getChar():getData("rep"))
                            client:AddQuest( "quest_killer_rep", v:Name() )
                            --[[timer.Simple(1, function()
                                client:ConCommand("say Задание: Найти и уничтожить сталкера: ".. client:HasQuest( "quest_killer_rep" ))
                            end)]]
                            data.gotquest = true
                        else
                            data.gotquest = false
                        end
                    end
                end
                return data
            end,
            cl = function( client, panel, data )
               if data.gotquest == true then
                    panel:AddChat( data.name, "В последнее время появилось слишком много отморозков, решивших, что им кто-то разрешил разрушать баланс Зоны. Имеется целый список таких лиц. Начни с "..LocalPlayer():GetQuest( "quest_killer_rep" )..". Информация о его пребывании отсутствует, так что тебе придется самому узнавать информацию о нет. Оплата соответствующая.")
                    panel:AddChat( LocalPlayer():Name(), "Считайте, что он уже мертв.")
                    panel.talking = false
                    return
                elseif data.gotquest == false then
                    panel:AddChat( data.name, "Ничего нет.")
                    panel.talking = false
                    return
                end
                if data.done then
                    panel:AddChat( data.name, "Отлично, думаю невидимые наблюдатели будут довольны. Твоя награда.")
                else
                    if LocalPlayer():GetQuest( "quest_killer_rep" ) then
                        panel:AddChat( data.name, LocalPlayer():GetQuest( "quest_killer_rep" ).." еще живой?" )
                    end
                end
                panel.talking = false
            end,
        },

        ["quest_medic"] = {
            sv = function( client, data )
                if client:getChar():getMoney() >= 2100 then
                    client:EmitSound( "interface/inv_bandage_2p9.ogg" )
                    client:SetHealth( 105 )
                    client:getChar():takeMoney(2100)
                    data.done = 1
                elseif client:Health() >= 100 then
                    data.done = 2
                else
                    data.done = 0
                end
                return data
            end,
            cl = function( client, panel, data )
                if data.done == 1 then
                    panel:AddChat( data.name, "Так, вот и всё... Можешь идти. Кстати, с тебя 2100." )
                    panel.talking = false
                    return
                elseif data.done == 0 then
                    panel:AddChat( data.name, "Прости, но денег у тебя не хватит." )
                    panel.talking = false
                    return
                elseif data.done == 2 then
                    panel:AddChat( data.name, "Сейчас, только юбочку поправлю. Вот и всё, можешь идти." )
                    panel.talking = false
                    return
                end
            end,
        },

         ["quest_21o4ko"] = {
            sv = function( client, data )
                return data
            end,
            cl = function( client, panel, data )
                vgui.Create("21o4ko")
                panel:AddChat( data.name, "Раздавай." )
                panel.talking = false
            end,
        },

        ["quest_fixarmor"] = {
            sv = function( client, data )
                return data
            end,
            cl = function( client, panel, data )
                vgui.Create("fixmygearplz_tehnik")
                panel:AddChat( data.name, "Давай посмотрим, что у тебя там." )
                panel.talking = false
            end,
        },

		["quest_bandit_informator1"] = {
            sv = function( client, data )
                if client:HasQuest( "bandit_informator1" ) then
                    local pqst_dat = client:GetQuest( "bandit_informator1" )
					if (client:getChar():hasMoney(5000)) then
                    if client:CanCompleteQuest( "bandit_informator1", pqst_dat ) then
                        client:RemoveQuest( "bandit_informator1" )
						client:getChar():takeMoney(5000)
							local faction = nut.faction.indices[FACTION_RAIDERS]
							if (faction) then
								local faction = nut.faction.indices[FACTION_RAIDERS]
							    local character = client:getChar()
							
							    character.vars.faction = faction.uniqueID
							    character:setFaction(faction.index)
							end
							local character = client:getChar() 
							if !character then return end 
							local faction = nut.faction.indices[character:getFaction()] 
							client:ConCommand("say /zfracquestc"..faction.name.."")
							timer.Simple(0.7, function()
							client:ConCommand("say /zlostmoney 5000")
							end)
                        data.done = true
                    else
                        data.done = false
                    end
				end
                else
                    data.gotquest = true 
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator1" )
                    client:AddQuest( "bandit_informator1" ) 
                end
                return data 
            end,
            cl = function( client, panel, data )
                if data.gotquest then
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator1" )
                    local pqst_dat = LocalPlayer():GetQuest( "bandit_informator1" )
                    panel:AddChat( data.name, "Че ж ты сразу к пахану Султану не пошел... ах да, совсем забыл, тебя бы к нему и на метр не подпустили бы, че ж ты забыл у этих клятых гопарей? Ладно, не мое это дело, все сделаем за 5000 деревянных." )
                    panel.talking = false 
                    return
                end
                if data.done then
                    panel:AddChat( data.name, "Отлично, начинаю обновлять твои данные. Такс... Сейчас обновим твой профиль в глобальной сталкерской сети... Старые данные стираем... Все, теперь ты бандит! Удачного тебе гоп-стопа по Зоне, ральный пацан *смеется*! И да, комбез бандитский возьми.")
                else
                    panel:AddChat( data.name, "Не, парень, так не пойдет, у тебя бабла нет, возвращайся когда у тебя будет 5000 деревянных.")
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator1" )
                    local pqst_dat = LocalPlayer():GetQuest( "bandit_informator1" )
                end
                panel.talking = false
            end,
        },

		["quest_bandit_informator3"] = {
            sv = function( client, data )
                if client:HasQuest( "bandit_informator3" ) then
                    local pqst_dat = client:GetQuest( "bandit_informator3" )
					if (client:getChar():hasMoney(200000)) then
                    if client:CanCompleteQuest( "bandit_informator3", pqst_dat ) then
                        client:RemoveQuest( "bandit_informator3" )
						client:getChar():takeMoney(200000)
						client:getChar():getInv():add("military_skat") 
						client:getChar():getInv():add("groza")
                        client:getChar():getInv():add("gorka_3")
							local faction = nut.faction.indices[FACTION_MERCENARIES]
							if (faction) then
								local faction = nut.faction.indices[FACTION_MERCENARIES]
							    local character = client:getChar()
							
							    character.vars.faction = faction.uniqueID
							    character:setFaction(faction.index)
							end
							local character = client:getChar() 
							if !character then return end 
							local faction = nut.faction.indices[character:getFaction()] 
							client:ConCommand("say /zfracquestc"..faction.name.."")
							timer.Simple(0.8, function()
							client:ConCommand("say /zlostmoney 200000")
							end)
							timer.Simple(1.6, function()
							client:ConCommand("say /ztakeitem Бронекостюм «СКАТ-9М»")
							end)
							timer.Simple(2.3, function()
							client:ConCommand("say /ztakeitem ОЦ-14-4А")
							end)
						
                        data.done = true
                    else
                        data.done = false
                    end
				end
                else
                    data.gotquest = true 
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator3" )
                    client:AddQuest( "bandit_informator3" ) 
                end
                return data 
            end,
            cl = function( client, panel, data )
                if data.gotquest then
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator3" )
                    local pqst_dat = LocalPlayer():GetQuest( "bandit_informator3" )
                    panel:AddChat( data.name, "Это запросто... Просто позволь тебе кое-что объяснить. Для начала скажу тебе одно: это будет стоить денег: 40000 деревянных, иначе разговора вообще не будет, вот еще что: если ты уйдешь из группировки в которую вступил, обратной дороги уже не будет, ни за какие деньги назад уже не примут, так что подумай башкой очень хорошо, надо ли тебе это. " )
                    panel.talking = false 
                    return
                end
                if data.done then
                    panel:AddChat( data.name, "Отлично, начинаю обновлять твои данные. Такс... Сейчас обновим твой профиль в глобальной сталкерской сети... Старые данные стираем... Все, теперь ты в Синдикате. Прибыльных контрактов, и да, держи снарягу.")
                else
                    panel:AddChat( data.name, "Не, парень, так не пойдет, у тебя бабла нет, возвращайся когда у тебя будет 40000 деревянных.")
                    local d_qst = questPLUGIN:GetQuest( "bandit_informator3" )
                    local pqst_dat = LocalPlayer():GetQuest( "bandit_informator3" )
                end
                panel.talking = false
            end,
        },

        ["quest_ribak_first"] = {
            sv = function( client, data )
                if client:HasQuest( "quest_ribak_first" ) then
                    local RibakFirst = {
                    [1] = "aksu",
                    [2] = "aks74",
                    [3] = "akms",
                    [4] = "aek",
                    }
                    if client:getChar():getInv():hasItem("gorka_3") then
                        client:getChar():getInv():add(RibakFirst[math.random(1,4)])
                        client:getChar():getInv():remove(client:getChar():getInv():hasItem("gorka_3"):getID())
                        client:RemoveQuest( "quest_ribak_first" )
                        data.done = true
                    else
                        data.done = false
                    end
                else
                    data.gotquest = true
                    client:AddQuest( "quest_ribak_first", "gorka_3" )
                    client:ConCommand("say Задание: принести сталкеру предмет - Костюм Горка - 3")
                end
                return data
            end,
            cl = function( client, panel, data )
               if data.gotquest then
                    panel:AddChat( data.name, "Костюм, а именно Горка. Если по секрету, то я хочу быть как спецназовец. Ну они там крутые, стреляют так пиу-пау, сильные... Ну ты понял. Еще у них реакция быстрая! *Сталкер все окрашивал и окрашивал эпитатми бойцов силовых структур. Вы немного призадумались и пропустили тонны бесмысленной информации, а вернувшись в реальный мир успели услышать только обрывок фразы...* нированные несколько лет!")
                    panel:AddChat( LocalPlayer():Name(), "Посмотрю, что можно сделать.")
                    panel.talking = false
                    return
                end
                if data.done then
                    panel:AddChat( LocalPlayer():Name(), "Принес я тебе костюм. Он немного помятый, но я думаю так только антуражнее. Если честно, то я сомневаюсь что он сделает из тебя сильного, выносливого и меткого спецназовца.")
                    panel:AddChat( data.name, "Потрясающе! А насчет меткого и сильного спецназовца, то это мы еще посмотрим. Вот увидишь, скоро обо мне легенды будут сочинять и баллады петь.")
                else
                    panel:AddChat( data.name, "Ну че? Принес Горку?")
                end
                panel.talking = false
            end,
        },

        ["quest_ribak_second"] = {
            sv = function( client, data )
                local RibakSecond = {
                [1] = "aksu",
                [2] = "blackbox",
                [3] = "chzo",
                [4] = "pkm",
                [5] = "deagle",
                }

                if client:HasQuest( "quest_ribak_second" ) then
                    if client:getChar():getInv():hasItem("6b_armor") then
                        client:getChar():getInv():add(RibakSecond[math.random(1,5)])
                        client:getChar():getInv():remove(client:getChar():getInv():hasItem("6b_armor"):getID())
                        client:RemoveQuest( "quest_ribak_second" )
                        data.done = true
                    else
                        data.done = false
                    end
                else
                    data.gotquest = true
                    client:AddQuest( "quest_ribak_second", "6b_armor" )
                    client:ConCommand("say Задание: принести сталкеру предмет - Бронежилет")
                end
                return data
            end,
            cl = function( client, panel, data )
               if data.gotquest then
                    panel:AddChat( data.name, "О, еще один. Че смотришь, смешно? Ну да, смешно, это ж не ты в таких тряпках ходишь...")
                    panel:AddChat( LocalPlayer():Name(), "Чего злой такой? Я конечно не социальная служба, но помочь смогу. Разумеется, если ты не будешь мне грубить.")
                    panel:AddChat( data.name, " Ну, раз так... Ладно, прости, просто на нервах весь, да еще и костюм этот...  Короче слушай: Захотел я как-то прикупить себе комплект одежды, ну камуфляжный такой, все дела. Выбрал по этим интернетам вашим дурацким, оплатил все через карту и ждал. Ну, приехал костюм, я распаковываю, а там вот это чудище. Времени скандалить у меня не было, поэтому я смирился. Друган с которым ехали в это проклятое место сказал, что засмеивать меня не будут, но у сталкеров весьма специфическое чувство юмора, да и нету уже того другана... Извини, отошел от темы. Сначало все было безобидно, но потом эти шутки приобретали масштабы и в конечном итоге меня теперь вообще кличут Рыбак. Но ведь не все так плохо, да? Я недавно увидел вояк, а на них такие броники модные, 6Б вроде какие-то там. Вот прошу, принеси мне один такой, он большой и почти весь костюм под себя возьмет, а то этим обезьянам лишь бы поржать!")
                    panel.talking = false
                    return
                end
                if data.done then
                    panel:AddChat( LocalPlayer():Name(), "Такой тяжелый этот 6Б. Ты смотри аккуратнее, в лодку с ним садись, а то перевернет!")
                    panel:AddChat( data.name, "Очень смешно. Я так и знал что тебе не составит труда его найти, военные тут как и все остальные гибнут пачками. Но я не суеверный, а тем более не брезгливый. Рыбак свесил со спины рюкзак и согнулся над ним, шурша и переворачивая все внутри. После нащупывания нужного объекта, он все так же на коленях передал вам небольшой, гремящий мешок, полностью состоящий из брезента. Вот, там все за проделанную работу, а теперь позволь мне удалиться для примерки нового аксессуара.")
                else
                    panel:AddChat( data.name, "Ну че? Принес броник?" )
                end
                panel.talking = false
            end,
        },

         ["quest_bartihan4ik"] = {
            sv = function( client, data )
                if client:HasQuest( "quest_bartihan4ik" ) then
                    if client:getChar():getInv():hasItem("bartihan4ik_life") then
                        local Bartihan = {
                        [1] = "6b_armor",
                        [2] = "medic_container",
                        [3] = "chzo",
                        [4] = "pkm",
                        [5] = "psihelem",
                        }
                        client:getChar():getInv():add(Bartihan[math.random(1,5)])
                        client:getChar():getInv():remove(client:getChar():getInv():hasItem("bartihan4ik_life"):getID())
                        client:RemoveQuest( "quest_bartihan4ik" )
                        data.done = true
                    elseif client:getChar():getInv():hasItem("bartihan4ik_dead") then
                        client:getChar():getInv():add("pm")
                        client:RemoveQuest( "quest_bartihan4ik" )
                        data.done = "pizdec"
                    else
                        data.done = false
                    end
                else
                    data.gotquest = true
                    client:AddQuest( "quest_bartihan4ik", "bartihan4ik_life" )
                    client:ConCommand("say Задание: принести сталкеру Бартыханчика")
                end
                return data
            end,
            cl = function( client, panel, data )
               if data.gotquest then
                    panel:AddChat( LocalPlayer():Name(), "Привет, чего грустишь? Помочь чем?")
                    panel:AddChat( data.name, "Да чем ты мне поможешь? Он же маленький был, темный... Чего смотришь? Крыса у меня пропала, Бартыханчик звали... Ты правда готов помочь? Не ожидая вашего ответа, сталкер продолжил. Бартыханчик любил пещеры, там сыро и темно, для него как большая и бесконечная нора. Я оставил его в рюкзаке, на секунду отвернулся и все, нету Бартыханчика... Поищи его в этих норах под сгоревшим хутором, я тебе клетку для переноски дам. Только аккуратнее, не спугни его, у него и так стресс.")
                    panel.talking = false
                    return
                end
                if (LocalPlayer():getChar():getInv():hasItem("bartihan4ik_life")) then
                    panel:AddChat( LocalPlayer():Name(), "Принес я твою крысу, и вправду в пещере была. Как она среди аномалий вообще пробиралась?")
                    panel:AddChat( data.name, "Спасибо, от всей души благодарю! А насчет пещеры, она же маленькая, да и чувство инстинктивной опасности есть. Может, норки где рыла для прохода, может еще чего. Главное, Бартыханчик живой и здоровый, спасибо тебе. Вот, держи, я и не думал что ты поможешь.")
                elseif (LocalPlayer():getChar():getInv():hasItem("bartihan4ik_dead")) then
                    panel:AddChat( LocalPlayer():Name(), "Нашел я твою крысу... Вот только она мертва, уже была в таком состоянии.")
                    panel:AddChat( data.name, "Эх... И на этом спасибо, сталкер, забирай свою награду и уходи.")
                else
                    panel:AddChat( data.name, "Где же Бартыханчик?" )
                end
                panel.talking = false
            end,
        },

        ["quest_zero_rep"] = {
           sv = function( client, data )
                if (client:getChar():hasMoney((-client:getChar():getData("rep") * 1000))) and (client:getChar():getData("rep") < -50) then
                    client:getChar():takeMoney((-client:getChar():getData("rep") * 1000))
                    client:getChar():setData("rep", 1)
                end
                return data 
            end,
            cl = function( client, panel, data )
                if LocalPlayer():getChar():getData("rep") < -50 then
                    panel:AddChat( LocalPlayer():Name(), "Я знаю что у тебя можно подправить кое-что, да? Я перешел дорогу не одному сталкеру, меня теперь везде чуть ли не запинывают! У меня есть деньги, скажи сколько.")
                    panel:AddChat( data.name, "*Присмотревшись к вам, довольно цокнул и расстянулся в улыбке:* А, так это о тебя слухи пошли. Да на тебя уже первые заказы поступают, правда суммы пока не большие. Но время удвоит, и даже утроит количество людей, не навидящих тебя. Я могу подправить архивы, твои фотографии и прочее, но сам пойми, это будет стоить круглую сумму. Это будет расцениваться для тебя "..(-LocalPlayer():getChar():getData("rep") * 1000).."рублей. Ну что, готов начать новую жизнь?" )
                    if LocalPlayer():getChar():hasMoney((-LocalPlayer():getChar():getData("rep") * 1000)) then
                        panel:AddChat( LocalPlayer():Name(), "*Перевел нужную сумму информатору.")
                    else
                        panel:AddChat( LocalPlayer():Name(), "Пока у меня таких денег нет.")
                    end
                    panel.talking = false 
                else
                    panel:AddChat( LocalPlayer():Name(), "Я знаю что у тебя можно подправить кое-что, да? Я перешел дорогу не одному сталкеру, меня теперь везде чуть ли не запинывают! У меня есть деньги, скажи сколько.")
                    panel:AddChat( data.name, "Не чувак, у тебя всё в порядке, скажи спасибо, что не обманул тебя.")
                    panel.talking = false
                end
            end,
        },
}

if SERVER then
    netstream.Hook( "nut_DialogueMessage", function( client, data )
        if string.Left( data.request, 1 ) == "!" then
            data.request = string.sub( data.request, 2 )
            if PLUGIN.SpecialCall[ data.request ] then
                data = PLUGIN.SpecialCall[ data.request ].sv( client, data )
                netstream.Start( client, "nut_DialoguePingpong", data )
            else
                print( Format( "%s( %s ) tried to call invalid dialouge request( %s ) from %s.", client:Name(), client:Nick(), data.request, data.name ) )
                print( "Please check PLUGIN.SpecialCall or NPC's dialouge unique id." )
                client:EmitSound( "HL1/fvox/hev_general_fail.wav" )
            end
        end
    end)
else
    netstream.Hook( "nut_DialoguePingpong", function( data )
        if IsValid( nut.gui.dialogue ) then
            if PLUGIN.SpecialCall[ data.request ] then
                PLUGIN.SpecialCall[ data.request ].cl( client, nut.gui.dialogue, data )
            end
        end
    end)
end

