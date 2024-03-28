local heistPlayers = {}
local heist_started = false

local function DebugPrinter(message)
    if Config.Debugger then
        print("^1[DEBUGGER "..GetCurrentResourceName().."] ^5"..message)
    end
end

RegisterNetEvent('esx:playerDropped', function(playerId, reason)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    
    for player_id in pairs(heistPlayers) do
        if xPlayer == player_id then
            heistPlayers[player_id] = nil
            heist_started = false
        end
    end

    if next(heistPlayers) == nil then
        DebugPrinter("Er is iemand geleaved uit de server wat betekent dat de heist weer beschikbaar is voor andere spelers.")
    else
        DebugPrinter("Er is iemand bezig met de heist.")
    end
end)

RegisterNetEvent('ac-human-labs-heist:server:CheckIfHeistOccupied', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not heist_started then
        heist_started = true
        heistPlayers[src] = xPlayer.getName()
        TriggerClientEvent("ac-human-labs-heist:client:StartFirstPrep", src)
        Citizen.Wait(Config.Translations["Phases"]["FirstPreparationPhase"].progressbar_timer)
        xPlayer.addInventoryItem(Config.HeistItems["PrepPhaseItems"].key_card.item_name, Config.HeistItems["PrepPhaseItems"].key_card.amount)
    else
        TriggerClientEvent('ox_lib:notify', source, {title = Config.Translations['HeistStart'].heist_title, description = Config.Translations['HeistStart'].heist_occupied.label, duration = Config.Translations['HeistStart'].heist_occupied.timer, position = Config.Notifies.position, type = 'warning'})
    end
end)

RegisterNetEvent('ac-human-labs-heist:server:CheckForSamePlayer', function ()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    for player_id, player_name in pairs(heistPlayers) do
        if player_id ~= src and player_name ~= xPlayer.getName() then
            xPlayer.kick("Trigger Protectie, groetjes AquaCity 📸")
        else
            TriggerClientEvent('ac-human-labs-heist:client:CreateZoneForElevator', src, 136.710, -763.387, 45.835, "WarpPlayerToTopFBIbuilding", 'fa fa-up-long', 'Ga omhoog')
        end
    end
end)

RegisterNetEvent('ac-human-labs-heist:server:GivePlayerItem', function (coords, item, amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not coords or not item or not amount then
        xPlayer.kick("Trigger Protectie, groetjes AquaCity 📸")
        return        
    end
    
    local playerCoords = xPlayer.getCoords(true)
    local distance = #(playerCoords - coords)

    if distance > Config.GeneralTargetDistance + 1.5 then
        xPlayer.kick("Trigger Protectie, groetjes AquaCity 📸")
        return
    end

    xPlayer.addInventoryItem(item, amount)
    TriggerClientEvent('ac-human-labs-heist:client:CreateZoneForElevator', src, 136.719, -763.428, 234.212, "WarpPlayerDownFBIbuilding", 'fa fa-down-long', 'Ga omlaag')
end)

RegisterNetEvent("ac-human-labs-heist:server:PayoutFromHeist", function ()
    print("Het werkt, de speler heeft uitgecashed")
end)

RegisterNetEvent('ac-human-labs-heist:server:RemoveItem', function (item_name, count)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    xPlayer.removeInventoryItem(item_name, count)
end)