Config = {}

Config.Debugger = true

Config.Webhook = {
    hacker_log = "",
    item_log = "",
}

Config.HeistNPC = {
    {
        location = vec4(132.3132, -762.5416, 45.7521, 162.7738), -- Vec4 coords to use
        model = 's_m_y_robber_01',
    },
}

Config.GeneralTargetDistance = 1.5

Config.Notifies = {
    timer = 7500,
    position = "center-right"
}

Config.HeistInformation = {
    ['Elevator_fadeout_timer'] = 2500,
    ['HeistCooldownTimer'] = 30, -- Minuten
    ['PoliceNumberRequired'] = 1
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

Config.RequiredWeapons = {
    'weapon_pistol',
    'weapon_pistol_mk2',
}

Config.Translations = {
    ["HeistStart"] = {
        heist_title = "Human Labs Heist",
        heist_occupied = {
            label = "Er is al iemand bezig met de human labs overval, kom later terug om het nog een keer te proberen!",
            timer = 10000
        },

        heist_recently_done = {
            label = "Iemand heeft te recentelijk al een heist gedaan. Wacht nog %s seconden!", -- %s erin laten, deze formateerd het aantal seconden dat iemand moet wachten voor een nieuwe heist
            timer = 10000
        },
        
        not_enough_police = {
            label = "Er is niet genoeg politie in dienst, er moet minimaal %s politie in dienst zijn.", -- %s erin laten, deze formateerd het aantal seconden dat iemand moet wachten voor een nieuwe heist
            timer = 10000
        },

        not_a_threat = {
            label = "Je vormt geen bedreiging om deze heist te kunnen starten.",
            timer = 10000
        },
    },

    ["Phases"] = {
        heist_boss_title = "Heist Baas",
        progressbar_timer = 5000,
        -- progress_label = "Overleggen...",
        ["FirstPreparationPhase"] = {
            fib_building_message = {
                label = "Ga naar het FIB gebouw, gebruik de keycard die ik je heb gegeven en ga dan met de lift omhoog.",
                timer = 10000,
            },

            fib_swipe_card_done = {
                label = "Stap in de lift en ga omhoog door op de knop te drukken.",
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
                message = "Nu komt de blueprint heel goed van pas! Ga via de garage deuren naar binnen en zoek het serum doormiddel van de blueprint.",
                timer = 10000,
            }
        },

        ["Finale"] = {
            serum_label = "Pak Serum",
            found_serum = {
                message = "Goed werk, je hebt het serum gevonden, ga nu zo snel mogelijk naar buiten.",
                timer = 10000,
            }
        }
    },

    ["Police"] = {
        message_title = "Overval Humane Labs",
        message = "Het alarm bij Humane Labs is afgegaan. Ga zo snel mogelijk naar de locatie toe, pas op want ze kunnen bewapend zijn!",
        timer = 10000
    },
}