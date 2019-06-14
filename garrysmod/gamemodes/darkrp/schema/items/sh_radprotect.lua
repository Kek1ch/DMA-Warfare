ITEM.name = "Антирад"
ITEM.category = "Медицина"
ITEM.desc = "Препарат радиозащитного действия Мексамин, широко распространенный на территории Зоны. При применении вызывает сужения периферических кровеносных сосудов и кислородное голодание, в данном случае является средством профилактики и лечения лучевой болезни. \n\nХАРАКТЕРИСТИКИП: \n-медикамент \n-быстрое использование (шприц) \n-сильный побочный эффект \n\nРадиация - 34"
ITEM.price = 1560
ITEM.weight = 0.02
ITEM.exRender = false

ITEM.model = "models/kek1ch/dev_antirad.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(55.049072265625, 46.191646575928, 34.036888122559),
  ang = Angle(25, 220, 0),
  fov = 5
}

ITEM.functions.use = {
    name = "использовать",
    onRun = function(item)
       local client = item.player
       client:setNetVar("radioactive", client:getNetVar("radioactive", 0) - 74)
       return true
    end,
    onCanRun = function(item)
        return !IsValid(item.entity)
    end
}


