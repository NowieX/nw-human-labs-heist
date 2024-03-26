local function loadModel(model)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do Citizen.Wait(0) end
end

local function CreateCameraAndRender(posx, posy, posz, heading, fov)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", posx, posy, posz, 0.0 ,0.0, heading, fov, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, true, true)
end

local function StopCameraRender()
    RenderScriptCams(false, true, 1000, true, true)
    SetCamActive(cam, false)
end

RegisterCommand('scene', function()
    local playerPed = PlayerPedId()
    local rotation = vec3(0.0, 0.0, -30.0)
    local sceneLocation = vec3(3616.2537, 5022.2480, 11.3409)
    local animDict = "anim_heist@hs3f@ig3_cardswipe@male@"
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
    
    loadModel('ch_prop_swipe_card_01d')
    loadModel('ch_prop_fingerprint_scanner_01e')
    
    local card_swipe_coords = vec3(137.022, -763.968, 45.9)
    
    local card_swipe = CreateObject(`ch_prop_fingerprint_scanner_01e`, card_swipe_coords.x, card_swipe_coords.y, card_swipe_coords.z, true, true, false)
    SetEntityHeading(card_swipe, 337.5087)
    local card_swipe_coords = GetOffsetFromEntityInWorldCoords(card_swipe, 0.0, 0.0, 0.0)
    
    local security_card = CreateObject(`ch_prop_swipe_card_01d`, card_swipe_coords, true, true, false)
    
    local swipe_card_scene = NetworkCreateSynchronisedScene(card_swipe_coords.x, card_swipe_coords.y, card_swipe_coords.z, rotation.x, rotation.y, rotation.z, 2, false, false, 1065353216, 0, 1065353216)
    
    NetworkAddPedToSynchronisedScene(playerPed, swipe_card_scene, animDict, "success_var03", 1.5, -4.0, 2, 16, 1148846080, 0) 
    
    NetworkAddEntityToSynchronisedScene(security_card, swipe_card_scene, animDict, "success_var03_card", 1.0, 1.0, 1)
    
    NetworkStartSynchronisedScene(swipe_card_scene)
    
    Citizen.Wait(5400)
    
    DeleteEntity(security_card)
    DeleteEntity(card_swipe)
end, false)