local QBCore = exports['qb-core']:GetCoreObject()

-- Creating target zones for interacting
Citizen.CreateThread(function()
    -- Lumberyard Storage Facility Target
    exports['qb-target']:AddTargetEntity(Config.Lumberyard, {
        options = {
            {
                type = "client",
                event = "qb-lumberjack:getAxe", 
                icon = "fas fa-axe",
                label = "Get Axe from Storage",
            },
        },
        distance = 3.0
    })

    -- Target for chopping trees
    for _, treeLocation in ipairs(Config.TreeLocations) do
        exports['qb-target']:AddTargetEntity(treeLocation, {
            options = {
                {
                    type = "client",
                    event = "qb-lumberjack:startChoppingTree", 
                    icon = "fas fa-tree",
                    label = "Chop Tree",
                },
            },
            distance = 2.0
        })
    end

    -- Plank Conversion Location Target
    exports['qb-target']:AddTargetEntity(Config.PlankConverter, {
        options = {
            {
                type = "client",
                event = "qb-lumberjack:convertWoodToPlanks", 
                icon = "fas fa-cogs",
                label = "Convert Wood to Planks",
            },
        },
        distance = 3.0
    })

    -- Delivery Point Target (Mile High Club)
    exports['qb-target']:AddTargetEntity(Config.MileHighClubDelivery, {
        options = {
            {
                type = "client",
                event = "qb-lumberjack:deliverPlanks", 
                icon = "fas fa-truck",
                label = "Deliver Planks",
            },
        },
        distance = 3.0
    })
end)

-- Chop tree action (start)
RegisterNetEvent('qb-lumberjack:startChoppingTree', function()
    local playerPed = PlayerPedId()
    local axe = GetItemInPlayerInventory('axe')

    if axe then
        TriggerEvent('QBCore:Notify', "You are starting to chop the tree...")

        -- Start chopping animation (example)
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_HACK_SAW", 0, true)
        Citizen.Wait(Config.ChopTime * 1000)

        -- Add chopped wood
        local player = QBCore.Functions.GetPlayerData()
        player.Functions.AddItem('chopped_wood', 1)
        TriggerEvent('QBCore:Notify', "You chopped wood!")
        ClearPedTasksImmediately(playerPed)
    else
        TriggerEvent('QBCore:Notify', "You need an axe to chop trees!")
    end
end)

-- Help display information
RegisterCommand('lumberjackInfo', function()
    print("Lumberjack job info: Chop trees, convert wood to planks, and deliver planks for cash!")
end)