local function loadModel(model)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do Citizen.Wait(0) end
end

RegisterNetEvent('ac-human-labs-heist:client:StartCardSwipe', function (card_swipe_coords)
    TriggerServerEvent("ac-human-labs-heist:server:RemoveItem", Config.HeistItems["PrepPhaseItems"].key_card.item_name, Config.HeistItems["PrepPhaseItems"].key_card.amount)
    local playerPed = PlayerPedId()
    local rotation = vec3(0.0, 0.0, -30.0)
    local animDict = "anim_heist@hs3f@ig3_cardswipe@male@"
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end

    local animation_timer = GetAnimDuration(animDict, "success_var01")
    
    loadModel('ch_prop_swipe_card_01d')
    loadModel('tr_prop_tr_fp_scanner_01a')
    
    local security_card = CreateObject(`ch_prop_swipe_card_01d`, card_swipe_coords.x, card_swipe_coords.y, card_swipe_coords.z, true, true, false)
    
    local swipe_card_scene = NetworkCreateSynchronisedScene(card_swipe_coords.x, card_swipe_coords.y, card_swipe_coords.z, rotation.x, rotation.y, rotation.z, 2, true, true, 1065353216, 0, 1065353216)
    
    NetworkAddPedToSynchronisedScene(playerPed, swipe_card_scene, animDict, "success_var01", 1.5, -4.0, 2, 16, 1148846080, 0) 
    NetworkAddSynchronisedSceneCamera(swipe_card_scene, animDict, "success_var01_camera")
    NetworkAddEntityToSynchronisedScene(security_card, swipe_card_scene, animDict, "success_var01_card", 1.0, 1.0, 1)
    
    NetworkStartSynchronisedScene(swipe_card_scene)
    
    Citizen.Wait(animation_timer * 1000)

    NetworkStopSynchronisedScene(swipe_card_scene)

    lib.notify({
        title = Config.Translations["Phases"].heist_boss_title,
        description = Config.Translations["Phases"]["FirstPreparationPhase"].fib_swipe_card_done.label,
        duration = Config.Translations["Phases"]["FirstPreparationPhase"].fib_swipe_card_done.timer, 
        position = Config.Notifies.position, 
        type = 'info'
    })
    
    DeleteEntity(security_card)
    TriggerServerEvent("ac-human-labs-heist:server:CheckForSamePlayer")

    DoorSystemSetDoorState(`fbi_elevator_left`, 0)
    DoorSystemSetDoorState(`fbi_elevator_right`, 0)
end)

RegisterNetEvent('ac-human-labs-heist:client:StartPickingSerum', function (data)
    local serum_prop = data[2]
    SetEntityVisible(serum_prop, false, false)

    local playerPed = PlayerPedId()
    local animDict = 'missfbi5ig_22'
    local scenePos = vector3(3558.898, 3677.85, 27.125)
    while not HasAnimDictLoaded(animDict) do RequestAnimDict(animDict) Citizen.Wait(50) end

    local chemical_scene = {
        ['objects'] = {
            'prop_cs_vial_01',
            'p_chem_vial_02b_s',
        },
        ['animations'] = {
            {'take_chemical_player0', 'take_chemical_tube', 'take_chemical_vial'}
        },
        ['scenes'] = {},
        ['sceneObjects'] = {}
    }

    SetEntityCoords(playerPed, scenePos.x, scenePos.y, scenePos.z)
    SetEntityHeading(playerPed, 170.0)

    local ped_coords, pedRotation = GetEntityCoords(playerPed), GetEntityRotation(playerPed)
    for i = 1, #chemical_scene['objects'] do
        loadModel(chemical_scene['objects'][i])
        chemical_scene['sceneObjects'][i] = CreateObject(GetHashKey(chemical_scene['objects'][i]), scenePos, 1, 1, 0)
    end

    for i = 1, #chemical_scene['animations'] do
        chemical_scene['scenes'][i] = NetworkCreateSynchronisedScene(ped_coords.x,ped_coords.y, ped_coords.z - 1.0, pedRotation.x, pedRotation.y, pedRotation.z, 2, true, false, 1065353216, 0, 1.1)
        NetworkAddPedToSynchronisedScene(playerPed, chemical_scene['scenes'][i], animDict, chemical_scene['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(chemical_scene['sceneObjects'][1], chemical_scene['scenes'][i], animDict, chemical_scene['animations'][i][2], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(chemical_scene['sceneObjects'][2], chemical_scene['scenes'][i], animDict, chemical_scene['animations'][i][3], 1.0, -1.0, 1148846080)
    end

    -- NetworkAddSynchronisedSceneCamera(chemical_scene['scenes'][1], animDict, "take_chemical_cam")
    NetworkStartSynchronisedScene(chemical_scene['scenes'][1])

    local camera = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
    SetCamActive(camera, true)
    RenderScriptCams(true, 1, 1000, true, false)
    PlayCamAnim(camera, 'take_chemical_cam', animDict, ped_coords.x, ped_coords.y, ped_coords.z - 1.0, pedRotation.x, pedRotation.y, pedRotation.z, false, 2)

    Citizen.Wait(GetAnimDuration(animDict, 'take_chemical_player0') * 1000)

    NetworkStopSynchronisedScene(chemical_scene['scenes'][1])

    RenderScriptCams(false, true, 1000, true, false)
    DestroyCam(camera, false)

    SetEntityVisible(serum_prop, true, false)

    lib.notify({
        title = Config.Translations["Phases"].heist_boss_title,
        description = Config.Translations["Phases"]["Finale"].found_serum.message,
        duration = Config.Translations["Phases"]["Finale"].found_serum.timer, 
        position = Config.Notifies.position, 
        type = 'warning'
    })

    TriggerServerEvent('ac-human-labs-heist:server:GivePlayerItem', data[1], Config.HeistItems['FinaleItems'].sample.item_name, Config.HeistItems['FinaleItems'].sample.amount)
    TriggerServerEvent('ac-human-labs-heist:server:RemoveItem', Config.HeistItems["PrepPhaseItems"].blueprint.item_name, Config.HeistItems["PrepPhaseItems"].blueprint.amount)

    for i = 1, #chemical_scene['sceneObjects'] do
        DeleteEntity(chemical_scene['sceneObjects'][i])
    end

    Citizen.Wait(25000)
    DeleteEntity(serum_prop)

end)

RegisterNetEvent('ac-human-labs-heist:client:StartHackElectricBox', function(data)
    DeleteEntity(card_swipe)
    local playerPed = PlayerPedId()
    local scene_coords = data[1]
    local electric_box = data[2]
    local rotation = vec3(0.0, 0.0, -10.731)
    local animDict = "anim@scripted@heist@ig9_control_tower@male@"
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end

    local opening_scene_timer = GetAnimDuration(animDict, "enter") * 1000
    
    local openBoxScene = NetworkCreateSynchronisedScene(scene_coords.x, scene_coords.y, scene_coords.z - 1, rotation.x, rotation.y, rotation.z, 2, true, false, 1065353216, 0, 1065353216)
    
    NetworkAddPedToSynchronisedScene(playerPed, openBoxScene, animDict, "enter", 1.5, -4.0, 2, 16, 1148846080, 0)    
    NetworkAddEntityToSynchronisedScene(electric_box, openBoxScene, animDict, "enter_electric_box", 1.0, 1.0, 1)
    NetworkStartSynchronisedScene(openBoxScene)

    NetworkStartSynchronisedScene(openBoxScene)

    Citizen.Wait(opening_scene_timer)
    
    local loopingScene = NetworkCreateSynchronisedScene(scene_coords.x, scene_coords.y, scene_coords.z - 1, rotation.x, rotation.y, rotation.z, 2, true, true, 1065353216, 0, 1065353216)
    
    NetworkAddPedToSynchronisedScene(playerPed, loopingScene, animDict, "loop", 1.5, -4.0, 2, 0, 1148846080, 0)  
    NetworkAddEntityToSynchronisedScene(electric_box, loopingScene, animDict, "loop_electric_box", 1.0, 1.0, 1)
    
    NetworkStartSynchronisedScene(loopingScene)
    
    local looping_scene_timer = GetAnimDuration(animDict, "loop") * 1000
    Citizen.Wait(looping_scene_timer)
    
    local closingScene =  NetworkCreateSynchronisedScene(scene_coords.x, scene_coords.y, scene_coords.z - 1, rotation.x, rotation.y, rotation.z, 2, false, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(playerPed, closingScene, animDict, "exit", 1.5, -4.0, 2, 16, 1148846080, 0)    
    NetworkAddEntityToSynchronisedScene(electric_box, closingScene, animDict, "exit_electric_box", 1.0, 1.0, 1)

    NetworkStartSynchronisedScene(closingScene)
    
    local closing_scene = GetAnimDuration(animDict, "exit") * 1000
    Citizen.Wait(closing_scene)
    
    PlayEntityAnim(electric_box, "exit_electric_box", animDict, 0, true, false, true, 0, false)

    NetworkStopSynchronisedScene(closingScene)

    lib.notify({
        title = Config.Translations["Phases"].heist_boss_title,
        description = Config.Translations["Phases"]["SecondPreparationPhase"].doors_opened_notify.message,
        duration = Config.Translations["Phases"]["SecondPreparationPhase"].doors_opened_notify.timer, 
        position = Config.Notifies.position, 
        type = 'info'
    })

    CreatePoliceReport(playerPed, Config.Translations["Police"].humane_labs_alarm.message, Config.Translations["Police"].humane_labs_alarm.message_title)

    RemoveBlip(prop_blip)
    CreateProp(vec3(3560.526, 3672.674, 28.1219), `p_chem_vial_02b_s`, 'StartPickingSerum', -10.795, 'syringe', Config.Translations["Phases"]["Finale"].serum_label, false, nil)
    DoorSystemSetDoorState(`human_labs_door_left`, 0)
    DoorSystemSetDoorState(`human_labs_door_right`, 0)

    Citizen.Wait(50000)
    DeleteEntity(electric_box)
end)