Config = {}

Config.LumberjackJob = "lumberjack"  -- Job name for lumberjack

Config.TreeLocations = {  -- Example tree locations
    vector3(123.4, -456.7, 35.0),
    vector3(222.3, -888.5, 42.1),
    vector3(333.6, -234.5, 28.0)
}

Config.Lumberyard = vector3(100.0, -100.0, 28.0) -- Storage facility
Config.PlankConverter = vector3(500.0, -300.0, 43.0) -- Plank conversion point
Config.MileHighClubDelivery = vector3(1200.0, -3200.0, 32.0) -- Delivery location

Config.ChopTime = 180 -- Time to chop a tree in seconds
Config.PlanksPerWood = 2
Config.ChoppedWoodRequiredForPlanks = 20