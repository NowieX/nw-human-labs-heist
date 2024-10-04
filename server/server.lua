local heistPlayers = {}
local heist_started = false
local timer_running = false

local function sendDiscordMessage(message, webhookUrl)
    local source = source
    local script_name = GetCurrentResourceName()
    local identifiers = GetPlayerIdentifiers(source)
    local steamName = GetPlayerName(source)
    local steamid = identifiers[1]
    local discordID = identifiers[2]
    local embedData = {{
        ['title'] = script_name,
        ['color'] = 0,
        ['footer'] = {
            ['icon_url'] = ""
        },
        ['description'] = message,
        ['fields'] = {
            {
                name = "",
                value = "",
            },

            {
                name = "ID",
                value = "SpelerID: "..source,
            },

            {
                name = "",
                value = "",
            },


            {
                name = "Steam Identifier",
                value = "Steam"..steamid,
                inline = true
            },

            {
                name = "",
                value = "",
            },

            {
                name = "Steam Naam",
                value = "Steamnaam: "..steamName,
            },

            {
                name = "",
                value = "",
            },

            {
                name = "Discord Identifier",
                value = discordID,
            },
        },
    }}

    PerformHttpRequest(webhookUrl, nil, 'POST', json.encode({
        username = script_name..' logs',
        embeds = embedData
    }), {
        ['Content-Type'] = 'application/json'
    })
end

local function DebugPrinter(message)
    if Config.Debugger then
        print("^1[DEBUGGER "..GetCurrentResourceName().."] ^5"..message)
    end
end

local function StartHeistCooldownTimer()
    cooldown_timer = Config.HeistInformation['HeistCooldownTimer']* 60

    timer_running = true
    while cooldown_timer > 0 do
        Citizen.Wait(1000)
        cooldown_timer = cooldown_timer - 1
    end

    timer_running = false
end

local function CheckIfPlayerHasWeapon(xPlayer)
    for weapon=1, #Config.RequiredWeapons do
        local get_weapon_player = xPlayer.getInventoryItem(Config.RequiredWeapons[weapon])

        if get_weapon_player.count >= 1 then
            return true
        end
    end
    return false
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

RegisterNetEvent('nw-human-labs:server:CheckIfHeistOccupied', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local PolicePlayers = ESX.GetExtendedPlayers('job', 'police')

    if not CheckIfPlayerHasWeapon(xPlayer) then
        TriggerClientEvent('ox_lib:notify', source, {title = Config.Translations['HeistStart'].heist_title, description = Config.Translations["HeistStart"].not_a_threat.label, duration = Config.Translations["HeistStart"].not_a_threat.timer, position = Config.Notifies.position, type = 'error'})
        return
    end

    if timer_running then
        TriggerClientEvent('ox_lib:notify', source, {title = Config.Translations['HeistStart'].heist_title, description = Config.Translations["HeistStart"].heist_recently_done.label:format(cooldown_timer), duration = Config.Translations["HeistStart"].heist_recently_done.timer, position = Config.Notifies.position, type = 'error'})
        return
    end

    if #PolicePlayers < Config.HeistInformation['PoliceNumberRequired'] then
        TriggerClientEvent('ox_lib:notify', source, {title = Config.Translations['HeistStart'].heist_title, description = Config.Translations["HeistStart"].not_enough_police.label:format(Config.HeistInformation['PoliceNumberRequired']), duration = Config.Translations["HeistStart"].not_enough_police.timer, position = Config.Notifies.position, type = 'error'})
        return
    end

    if not heist_started then
        heist_started = true
        heistPlayers[src] = xPlayer.getName()
        TriggerClientEvent("nw-human-labs:client:StartFirstPrep", src)
        Citizen.Wait(Config.Translations["Phases"]["FirstPreparationPhase"].progressbar_timer)
        xPlayer.addInventoryItem(Config.HeistItems["PrepPhaseItems"].key_card.item_name, Config.HeistItems["PrepPhaseItems"].key_card.amount)
    else
        TriggerClientEvent('ox_lib:notify', source, {title = Config.Translations['HeistStart'].heist_title, description = Config.Translations['HeistStart'].heist_occupied.label, duration = Config.Translations['HeistStart'].heist_occupied.timer, position = Config.Notifies.position, type = 'warning'})
    end
end)

RegisterNetEvent('nw-human-labs:server:CheckForSamePlayer', function ()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    for player_id, player_name in pairs(heistPlayers) do
        if player_id ~= src and player_name ~= xPlayer.getName() then
            xPlayer.kick("Trigger Protectie, groetjes AquaCity 📸")
            sendDiscordMessage("***Speler met informatie hieronder is gekickt vanwege een trigger protectie.***", Config.Webhook.hacker_log)
        else
            TriggerClientEvent('nw-human-labs:client:CreateZoneForElevator', src, 136.710, -763.387, 45.835, "WarpPlayerToTopFBIbuilding", 'fa fa-up-long', 'Ga omhoog')
        end
    end
end)

RegisterServerEvent('nw-human-labs:server:CreatePoliceNotification', function()
    local source = source
    local PolicePlayers = ESX.GetExtendedPlayers('job', 'police')

    for i = 1, #(PolicePlayers) do
        local policePlayer = PolicePlayers[i]
        TriggerClientEvent('ox_lib:notify', source, {title = Config.Translations["Police"].humane_labs_alarm.message_title, description = Config.Translations["Police"].message_title, duration = Config.Translations["Police"].timer, position = Config.Notifies.position, type = 'warning', icon = 'fa fa-bell'})
        TriggerClientEvent('nw-human-labs:client:CreatePoliceBlip:PoliceBlip', policePlayer.source)
    end
end)

RegisterNetEvent('nw-human-labs:server:GivePlayerItem', function (coords, item, amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not coords or not item or not amount then
        xPlayer.kick("Trigger Protectie, groetjes AquaCity 📸")
        sendDiscordMessage("***Speler met informatie hieronder is gekickt vanwege een trigger protectie.***", Config.Webhook.hacker_log)
        return
    end
    
    local playerCoords = xPlayer.getCoords(true)
    local distance = #(playerCoords - coords)

    if distance > Config.GeneralTargetDistance + 1.5 then
        xPlayer.kick("Trigger Protectie, groetjes AquaCity 📸")
        sendDiscordMessage("***Speler met informatie hieronder is gekickt vanwege een trigger protectie.***", Config.Webhook.hacker_log)
        return
    end

    sendDiscordMessage("Speler heeft het volgende item gekregen: "..item.." met het volgende aantal: "..amount, Config.Webhook.item_log)
    xPlayer.addInventoryItem(item, amount)
    TriggerClientEvent('nw-human-labs:client:CreateZoneForElevator', src, 136.719, -763.428, 234.212, "WarpPlayerDownFBIbuilding", 'fa fa-down-long', 'Ga omlaag')
end)

RegisterNetEvent('nw-human-labs:server:RemoveItem', function (item_name, count)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    xPlayer.removeInventoryItem(item_name, count)
end)

RegisterNetEvent("nw-human-labs:server:RemoveActivePlayersFromTable", function ()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    for player_id, player_name in pairs(heistPlayers) do
        if player_name ~= xPlayer.getName() or player_id ~= src then
            xPlayer.kick("Trigger Protectie, groetjes AquaCity 📸")
            sendDiscordMessage("***Speler met informatie hieronder is gekickt vanwege een trigger protectie.***", Config.Webhook.hacker_log)
            return
        else
            break
        end
    end
    
    heistPlayers = {}
    StartHeistCooldownTimer()
end)