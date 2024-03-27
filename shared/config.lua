Config = {}

Config.Debugger = true

Config.HeistNPC = {
    ["HeistStarter"] = {
        -- location = vec4(1620.4526, -2283.8933, 106.2856, 179.1451), Coords to use
        location = vec4(132.3132, -762.5416, 45.7521, 162.7738),
        model = 's_m_y_robber_01',
    },

    ["HeistSeller"] = {
        {
            location = vec4(-68.4101, 6829.1128, 1.6323, 154.6393),
            ped_model = `cs_fbisuit_01`,
            reward = math.random(10000, 50000)
        },

        {
            location = vec4(-2805.0562, 1424.4406, 100.9284, 144.3280),
            ped_model = `g_m_m_chemwork_01`,
            reward = math.random(10000, 50000)
        },

        {
            location = vec4(-308.4942, -2048.4783, 29.9463, 174.6223),
            ped_model = `g_m_m_armboss_01`,
            reward = math.random(10000, 50000)
        },

        {
            location = vec4(1725.5969, -1470.1536, 113.9422, 250.7446),
            ped_model = `g_m_y_famdnf_01`,
            reward = math.random(10000, 50000)
        },

        {
            location = vec4(2845.4302, 1441.3882, 32.5985, 256.5590),
            ped_model = `g_m_y_salvagoon_01`,
            reward = math.random(10000, 50000)
        },
    },
}

Config.GeneralTargetDistance = 1.5

Config.Notifies = {
    timer = 7500,
    position = "center-right"
}

Config.HeistInformation = {
    ['Elevator_fadeout_timer'] = 1000
}

Config.HeistItems = {
    ["PrepPhaseItems"] = {
        key_card = {item_name = "fbi_keycard", amount = 1},
        blueprint = {item_name = "human_labs_blueprint", amount = 1}
    },

    ['FinaleItems'] = {
        sample = {item_name = 'human_labs_sample', amount = 1}
    }
}

Config.Translations = {
    ["HeistStart"] = {
        heist_title = "Human Labs Heist",
        heist_occupied = {
            label = "Er is al iemand bezig met de human labs overval, kom later terug om het nog een keer te proberen!",
            timer = 10000
        }
    },

    ["Phases"] = {
        heist_boss_title = "Heist Baas",
        progressbar_timer = 1000,
        progress_label = "Overleggen...",
        ["FirstPreparationPhase"] = {
            fib_building_message = {
                label = "Ga naar het FIB gebouw, gebruik de kaart die ik je heb gegeven en ga dan met de lift omhoog.",
                timer = 10000,
            },

            fib_top_building_message = {
                label = "Oke, ga nu op zoek naar de blueprint, ik weet niet waar die ligt maar je moet er goed naar zoeken!",
                timer = 10000,
            }
        },

        ["SecondPreparationPhase"] = {
            electric_box_target_label = "Hacken",

            blueprint_picked = {
                label = "Keer snel terug naar de lift!",
                timer = 7500,
            },

            go_to_human_labs = {
                label = "Goed werk, ik heb je een GPS route toegestuurd, ga daarheen en hack de elektriciteits kast!",
                timer = 10000,
            },
            
            doors_opened_notify = {
                message = "De garagedeuren van humane labs zijn open, gebruik je blueprint om te zoeken naar het serum binnen in humane labs!",
                timer = 10000,
            }
        },

        ["Finale"] = {
            serum_label = "Pak Serum",
            found_serum = {
                message = "Goed werk, je hebt het serum gevonden, ga nu zo snel mogelijk naar de verkoper. \nIs de politie er? Ga dan met ze onderhandelen.",
                timer = 10000,
            }
        }
    },

    ["Police"] = {
        police_activity = "Er is verdachte activiteit gezien, locatie staat op jullie gps!",
        police_heist = "Het alarm bij Humane Labs is afgegaan. Ga zo snel mogelijk naar de locatie toe, pas op want ze kunnen bewapend zijn!"

    },
}