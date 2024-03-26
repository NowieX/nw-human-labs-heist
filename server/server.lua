local heistStarted = {}

local function DebugPrinter(message)
    if Config.Debugger then
        print("^1[DEBUGGER "..GetCurrentResourceName().."] ^5"..message)
    end
end

RegisterNetEvent('ac-yachtheist:server:HeistOccupied', function()
    DebugPrinter("ac-yachtheist:server:HeistOccupied is getriggered.")
    local src = source

    if next(heistStarted) == nil then
        heistStarted[src] = true
        TriggerClientEvent("ac-yachtheist:client:StartFirstPrep", src)
    else
        TriggerClientEvent('ox_lib:notify', source, {title = Config.Translations['Heist'].heistTitle, description = Config.Translations['Heist'].heistFull, duration = Config.Notifies.timer, position = Config.Notifies.position, type = 'warning'})
    end

    DebugPrinter('Server event: ac-yachtheist:server:HeistOccupied zou nu klaar moeten zijn en ook werken.')
end)