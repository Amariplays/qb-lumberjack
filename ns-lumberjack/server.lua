local QBCore = exports['qb-core']:GetCoreObject()

-- Current version of the script
local currentVersion = '1.0.0'

-- GitHub repository URL to check the latest release
local githubRepo = ''

-- Function to check for updates
function checkForUpdates()
    PerformHttpRequest(githubRepo, function(statusCode, response)
        if statusCode == 200 then
            local latestRelease = json.decode(response)
            local latestVersion = latestRelease.tag_name  -- Tag name corresponds to the version (e.g., "v1.0.1")
            
            -- Compare the versions
            if latestVersion ~= currentVersion then
                print("New version available: " .. latestVersion)
                TriggerEvent('QBCore:Notify', 'A new version of the Lumberjack script is available! Please update.', 'error')
            else
                print("The script is up to date!")
            end
        else
            print("Error checking for updates: " .. statusCode)
        end
    end, 'GET', '', {['Content-Type'] = 'application/json'})
end

-- Call the checkForUpdates function when the script starts
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        print('Checking for updates...')
        checkForUpdates()
    end
end)

-- Give player an axe when they join the job
RegisterServerEvent('qb-lumberjack:getAxe', function()
    local player = QBCore.Functions.GetPlayer(source)
    if player and player.PlayerData.job.name == Config.LumberjackJob then
        player.Functions.AddItem('axe', 1)
    end
end)

-- Convert chopped wood to planks
RegisterServerEvent('qb-lumberjack:convertWoodToPlanks', function()
    local player = QBCore.Functions.GetPlayer(source)
    if player and player.PlayerData.job.name == Config.LumberjackJob then
        local choppedWoodCount = player.Functions.GetItemByName('chopped_wood') and player.Functions.GetItemByName('chopped_wood').amount or 0
        if choppedWoodCount >= Config.ChoppedWoodRequiredForPlanks then
            local planksToGive = math.floor(choppedWoodCount / Config.PlanksPerWood)
            player.Functions.RemoveItem('chopped_wood', Config.ChoppedWoodRequiredForPlanks)
            player.Functions.AddItem('planks', planksToGive)
            TriggerClientEvent('QBCore:Notify', source, "Wood has been converted to planks!")
        else
            TriggerClientEvent('QBCore:Notify', source, "Not enough chopped wood to make planks.")
        end
    end
end)

-- Deliver planks for money
RegisterServerEvent('qb-lumberjack:deliverPlanks', function()
    local player = QBCore.Functions.GetPlayer(source)
    if player and player.PlayerData.job.name == Config.LumberjackJob then
        local plankCount = player.Functions.GetItemByName('planks') and player.Functions.GetItemByName('planks').amount or 0
        if plankCount > 0 then
            local pay = plankCount * math.random(40, 60)  -- $40 to $60 per plank
            player.Functions.RemoveItem('planks', plankCount)
            player.Functions.AddMoney('cash', pay)
            TriggerClientEvent('QBCore:Notify', source, "You delivered planks and earned $"..pay)
        else
            TriggerClientEvent('QBCore:Notify', source, "No planks to deliver.")
        end
    end
end)