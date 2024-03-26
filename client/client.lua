Citizen.CreateThread(function()  
    for _, v in ipairs(Config.HeistNPC) do
        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do
            Wait(1)
        end
        
        local npc = CreatePed(2, v.model, v.location.x, v.location.y, v.location.z - 1, v.location.w,  false, true)
        
        SetPedFleeAttributes(npc, 0, 0)
        SetPedDropsWeaponsWhenDead(npc, false)
        SetPedDiesWhenInjured(npc, false)
        SetEntityInvincible(npc , true)
        FreezeEntityPosition(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)

        exports.ox_target:addBoxZone({
            coords = vec3(v.location.x, v.location.y, v.location.z),
            size = vec3(1, 1, 1),
            rotation = 360,
            debug = true,
            options = {
                {
                    serverEvent = 'ac-yachtheist:server:HeistOccupied',
                    distance = 2,
                    icon = 'fa fa-ship',
                    label = 'Jacht Heist',
                },
            }
        })
    end
end)

RegisterNetEvent("ac-yachtheist:client:StartFirstPrep", function ()
    
end)