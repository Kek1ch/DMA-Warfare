ITEM.name = "Таблетки Пси-блокада"
ITEM.category = "Медицина"
ITEM.desc = "Наркотический препарат, блокирующий лавинообразные нервные импульсы. Интересен побочный эффект: после приёма препарата наблюдается кратковременное исчезновение каких-либо эмоций. В Зоне используется для противодействия аномальным полям повышенной пси-активности; за её пределами применения не нашёл. Обладает продолжительным действием."
ITEM.price = 1550
ITEM.weight = 0.02

ITEM.model = "models/kek1ch/drug_psy_blockade.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(87.162963867188, 73.138404846191, 53.306564331055),
  ang = Angle(25, 220, 0),
  fov = 5
}

ITEM.functions.use = {
    name = "использовать",
    onRun = function(item)
       local client = item.player
       client:setNetVar("psy", client:getNetVar("psy", 0) - 25)
       return true
    end,
    onCanRun = function(item)
        return !IsValid(item.entity)
    end
}
