Config = {}

Config.Debugger = false

Config.HeistNPC = {
    {
        -- location = vec4(1620.4526, -2283.8933, 106.2856, 179.1451), Coords to use
        location = vec4(-994.5438, 6243.1562, 2.6329, 216.1641),
        model = 's_m_y_dealer_01',
    },
}

Config.Notifies = {
    timer = 7500,
    position = "center-right"
}

Config.Translations = {
    ["Heist"] = {
        heistTitle = "Jacht Heist",
        heistFull = "Er is al iemand bezig met de jacht overval, kom later terug om het nog een keer te proberen!"
    },

    ["Police"] = {
        policeMessage = "Er is een verdachte activiteit gezien, locatie staat op jullie gps!"
    },
}