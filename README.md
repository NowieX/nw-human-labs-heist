# 🧬 Human Labs Heist – FiveM (QB/ESX compatible)

Een volledig custom heist waarbij spelers via meerdere stappen het Human Labs Serum moeten bemachtigen. De heist bevat NPC-interacties, item-progressie, hacking, blueprint mechanics, HTML UI en politie-interventie.

## 🚀 Heist Flow (kort & duidelijk)

### 1️⃣ Starten bij de Heist NPC
De speler moet gewapend zijn met één van de items uit Config.RequiredWeapons.
Interactie binnen Config.GeneralTargetDistance meter.
Als hij voldoet -> krijgt een keycard item en gaat door.

### 2️⃣ FIB Building – Blueprint fase
Met de keycard kan hij via de lift omhoog.
Boven moet de speler zelf de blueprint zoeken.
Als gevonden -> terug naar de lift, dan Human Labs waypoint verschijnt.

### 3️⃣ Human Labs – Hacking & Infiltratie
De speler hacked het electric box panel (progressbar + alert).
Politie krijgt automatisch melding na hack.
De deuren gaan open → met blueprint kan hij binnen het serum zoeken.

### 4️⃣ Finale – Serum pakken & ontsnappen
Speler pakt het serum item.
Heist is geslaagd, hoe het eindigt hangt af van server RP (vluchten, ruilen, dealen, etc.).

## 🔧 Configuration Guide
Alle instellingen staan in config.lua. Hieronder even wat uitleg zodat niemand hoeft te vragen wat iets doet.

## 🧩 Algemene instellingen
Naam	Wat het doet
Config.Debugger	Logging in console aan/uit
Config.GeneralTargetDistance	Afstand voor interacties (in meters)
📡 Webhooks

Kan je leeg laten als je er geen gebruikt.

Key	Functie
hacker_log	Logt hack attempt informatie
item_log	Logt item ontvangsten/verliezen
🧍 Heist NPC

NPC model + locatie waar de heist begint.

Config.HeistNPC = {
    {
        location = vec4(132.3132, -762.5416, 45.7521, 162.7738),
        model = 's_m_y_robber_01'
    },
}


Meerdere NPC’s toevoegen = gewoon een nieuwe entry onder elkaar zetten.

## 🔔 Meldingen (Notifications)
- Instelling - Betekenis
- timer - Hoelang bericht zichtbaar blijft
- position - Waar de melding wordt weergegeven

## ⏱️ Heist voorwaarden
- Naam - Betekenis
- Elevator_fadeout_timer - Time voor lift animatie
- HeistCooldownTimer - Cooldown in minuten
- PoliceNumberRequired - Hoeveel politie minimaal online

## 🎒 Items
Alle items moeten in je framework bestaan!
- Fase - Items
- Preparation - fbi_keycard, human_labs_blueprint
- Finale - human_labs_sample

##🔫 Weapons Check
Speler moet gewapend zijn met een van deze items:
```
Config.RequiredWeapons = {
    'weapon_pistol',
    'weapon_pistol_mk2',
}
```

## 🌍 Translation / UI / Messages
Alle meldingen, progressbars en alerts staan netjes in:

- Config.Translations

Je kan alles daarin aanpassen zonder scripts aan te raken. Messages zijn volledig NL geschreven.

## 👮‍♂️ Politie Systeem
- Wordt getriggered na het hacken
- Stuurt een melding naar elke online agent
- Agents krijgen tijd en locatie + waarschuwing dat dader bewapend kan zijn

📦 Requirements

✔ Target-systeem (bijv. ox_target)
✔ Inventory die items ondersteunt
✔ Notify / Progressbar resource
✔ Script moet toegang hebben tot desc/HTML UI voor Blueprint Preview

🗣 Contact
Voor vragen, bugs, uitbreidingen of paid custom work:
**Discord: nowiex**
DM mag altijd, maar alleen als het écht niet in de README staat 😄
