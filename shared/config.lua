Config = {}

Config.Debugger = true  -- Enables or disables debugging (True means it's enabled)

Config.Webhook = {
    hacker_log = "",  -- Webhook URL for hacker logs (Leave empty to disable)
    item_log = "",    -- Webhook URL for item logs (Leave empty to disable)
}

Config.HeistNPC = {
    {
        location = vec4(132.3132, -762.5416, 45.7521, 162.7738),  -- Vec4 coordinates for NPC spawn
        model = 's_m_y_robber_01',  -- NPC model to use for the heist
    },
}

Config.GeneralTargetDistance = 1.5  -- Defines the target distance for interaction (in meters)

Config.Notifies = {
    timer = 7500,  -- The duration (in milliseconds) of the notification display
    position = "center-right"  -- Position of the notification on screen (options: 'center-right', 'top-left', etc.)
}

Config.HeistInformation = {
    ['Elevator_fadeout_timer'] = 2500,  -- Duration for elevator fade out (in milliseconds)
    ['HeistCooldownTimer'] = 30,  -- Cooldown for the heist in minutes
    ['PoliceNumberRequired'] = 1  -- The minimum number of police officers required for the heist
}

Config.HeistItems = {
    ["PrepPhaseItems"] = {  -- Items required for the preparation phase
        key_card = {item_name = "fbi_keycard", amount = 1},  -- Keycard item for the heist
        blueprint = {item_name = "human_labs_blueprint", amount = 1}  -- Blueprint for the heist
    },

    ['FinaleItems'] = {  -- Items required for the final phase
        sample = {item_name = 'human_labs_sample', amount = 1}  -- Serum sample to be retrieved during the finale
    }
}

Config.RequiredWeapons = {
    'weapon_pistol',  -- Required weapons for the heist (pistol)
    'weapon_pistol_mk2',  -- Another version of the pistol required for the heist
}

Config.Translations = {
    ["HeistStart"] = {
        heist_title = "Human Labs Heist",  -- Title of the heist
        heist_occupied = {
            label = "Er is al iemand bezig met de human labs overval, kom later terug om het nog een keer te proberen!",  -- Message when the heist is occupied by someone else
            timer = 10000  -- How long the message is displayed
        },

        heist_recently_done = {
            label = "Iemand heeft te recentelijk al een heist gedaan. Wacht nog %s seconden!",  -- Message for recently completed heists
            timer = 10000  -- Time until the message disappears
        },
        
        not_enough_police = {
            label = "Er is niet genoeg politie in dienst, er moet minimaal %s politie in dienst zijn.",  -- Message when not enough police are online
            timer = 10000  -- Time until the message disappears
        },

        not_a_threat = {
            label = "Je vormt geen bedreiging om deze heist te kunnen starten.",  -- Message when the player is not considered a threat
            timer = 10000  -- Time until the message disappears
        },
    },

    ["Phases"] = {
        heist_boss_title = "Heist Baas",  -- Title for the heist boss (the main character overseeing the heist)
        progressbar_timer = 5000,  -- Duration of the progress bar (in milliseconds)
        
        ["FirstPreparationPhase"] = {
            fib_building_message = {
                label = "Ga naar het FIB gebouw, gebruik de keycard die ik je heb gegeven en ga dan met de lift omhoog.",  -- Instructions for the first preparation phase
                timer = 10000,  -- Time to display this message
            },

            fib_swipe_card_done = {
                label = "Stap in de lift en ga omhoog door op de knop te drukken.",  -- Instructions after swiping the keycard
                timer = 10000,  -- Time to display this message
            },

            fib_top_building_message = {
                label = "Oke, ga nu op zoek naar de blueprint, ik weet niet waar die ligt maar je moet er goed naar zoeken!",  -- Message instructing the player to find the blueprint
                timer = 10000,  -- Time to display this message
            }
        },

        ["SecondPreparationPhase"] = {
            electric_box_target_label = "Hacken",  -- Label for hacking the electric box

            blueprint_picked = {
                label = "Keer snel terug naar de lift!",  -- Message when the blueprint is picked up
                timer = 7500,  -- Time to display this message
            },

            go_to_human_labs = {
                label = "Goed werk, ik heb je een GPS route toegestuurd, ga daarheen en hack de elektriciteits kast!",  -- Message directing to the next step
                timer = 10000,  -- Time to display this message
            },
            
            doors_opened_notify = {
                message = "Nu komt de blueprint heel goed van pas! Ga via de garage deuren naar binnen en zoek het serum doormiddel van de blueprint.",  -- Message when doors are opened and the blueprint is useful
                timer = 10000,  -- Time to display this message
            }
        },

        ["Finale"] = {
            serum_label = "Pak Serum",  -- Label for picking up the serum
            found_serum = {
                message = "Goed werk, je hebt het serum gevonden, ga nu zo snel mogelijk naar buiten.",  -- Message when the serum is found
                timer = 10000,  -- Time to display this message
            }
        }
    },

    ["Police"] = {
        message_title = "Overval Humane Labs",  -- Title of the police message
        message = "Het alarm bij Humane Labs is afgegaan. Ga zo snel mogelijk naar de locatie toe, pas op want ze kunnen bewapend zijn!",  -- Message notifying the police about the heist
        timer = 10000  -- Time to display this message
    },
}
