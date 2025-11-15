# 🧬 Human Labs Heist – FiveM ESX/OX

A fully custom heist where players must obtain the Human Labs serum through multiple stages.  
This heist includes NPC interaction, item progression, hacking, blueprint mechanics, HTML UI and police intervention.

---

## 🚀 Heist Flow (Short & Clear)

### 1️⃣ Starting at the Heist NPC
- The player must be armed with one of the items from **Config.RequiredWeapons**
- Interaction must occur within **Config.GeneralTargetDistance** meters
- If requirements are met → Player receives a **keycard item**

---

### 2️⃣ FIB Building – Blueprint Phase
- Player uses the keycard to access the elevator
- Once upstairs, the player must manually **search for the blueprint**
- When found → Return to elevator → **Human Labs waypoint appears**

---

### 3️⃣ Human Labs – Hacking & Infiltration
- Player hacks the electric box (progressbar + alert)
- Police are automatically alerted after the hack
- Doors open → With blueprint, the player can **search for the serum**

---

### 4️⃣ Finale – Grab Serum & Escape
- Player picks up the serum item
- Heist is completed
- Outcome depends on **server RP** (escape, trade, deal, etc.)

---

## 🔧 Configuration Guide
All settings are located inside **config.lua**

## 🧩 General Settings

| Name                          | Description                                 |
|------------------------------|---------------------------------------------|
| Config.Debugger               | Enables or disables console logging         |
| Config.GeneralTargetDistance  | Interaction distance *(in meters)*          |

---

## 📡 Webhooks

Can be left empty if not used.

| Key         | Function                                |
|-------------|------------------------------------------|
| hacker_log  | Logs hack attempt actions                |
| item_log    | Logs received or lost items              |

## 🧍 Heist NPC
NPC location and model where the heist starts:

```lua
Config.HeistNPC = {
    {
        location = vec4(132.3132, -762.5416, 45.7521, 162.7738),
        model = 's_m_y_robber_01'
    },
}
```
Add more NPCs by copying and pasting a new entry under it.

## 🔔 Notifications

| Setting                          | Description                                 |
|------------------------------|---------------------------------------------|
| timer               | Duration of notification visibility         |
| position  | Screen position of notification          |

## ⏱️ Heist Requirements
| Name                          | Description                                 |
|------------------------------|---------------------------------------------|
| Elevator_fadeout_timer               | Duration of elevator fade animation         |
| HeistCooldownTimer  | Heist cooldown in minutes          |
| PoliceNumberRequired  | Required online police count          |

## 🎒 Items
All items must exist in your framework.
| Phase                          | Items                                 |
|------------------------------|---------------------------------------------|
| Preparation               | fbi_keycard, human_labs_blueprint         |
| Finale  | human_labs_sample          |

##🔫 Weapons Check
Player must be armed with one of the following: (you can change this in the Config.lua to your own likings)

```lua
Config.RequiredWeapons = {
    'weapon_pistol',
    'weapon_pistol_mk2',
}
```

## 🌍 Translation / UI / Messages
All notifications, progressbars and alert messages are stored inside:
```
Config.Translations
```
Everything can be changed there without editing script code.

## 👮‍♂️ Police System
- Triggered automatically after hacking
- Sends alert to every online police officer
- Police receive coordinates and a warning that the suspect may be armed

📦 Requirements

- Target system (e.g. ox_target)
- Inventory system that supports items
- Notification + progressbar system
- HTML support for blueprint preview window

🗣 Contact
For questions, bugs, improvements or paid development work:
**Discord: nowiex**
DM is always welcome, but only if it's really not in the README 😄
