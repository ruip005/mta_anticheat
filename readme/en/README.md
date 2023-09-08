![uW33D Anticheat.](https://cdn.discordapp.com/attachments/1110700176361918545/1137505212903456808/AC.png "Anticheat")

# **Anticheat for MTA (Multi Theft Auto)**

Welcome to the Anticheat project for Multi Theft Auto (MTA). This repository is intended to host the development of an anticheat system to enhance the integrity and fairness of the game in the MTA multiplayer environment.

[Video on how to set up + AntiVPN](https://youtu.be/XuNNihYl7KE)

[All Anticheat versions](https://github.com/ruip005/mta_anticheat/releases)

## Choose Your Language
Please note that only Portuguese is stable and complete; other languages may have severe bugs due to being unfinished. Please wait for a stable version or use it ONLY in Portuguese.
  
 * [Português](https://github.com/ruip005/mta_anticheat/blob/main/readme/pt/README.md)   
 * [Español](https://github.com/ruip005/mta_anticheat/blob/main/readme/es/README.md)  
 * [English](https://github.com/ruip005/mta_anticheat/blob/main/readme/en/README.md)
 * [Türkçe](https://github.com/ruip005/mta_anticheat/blob/main/readme/tr/README.md)  
 * [Deutsch](https://github.com/ruip005/mta_anticheat/blob/main/readme/de/README.md) 

## Auth

### Authentication to Start the Anticheat.

| Var   | Type       | Description                           |
| :---------- | :--------- | :---------------------------------- |
| `user` | `string` | **Required**. User name |
| `key` | `string` | **Required**. User activation key |


### Some Free Authentications.

1.
**user**: `trial01`

**key**: `f8e2a1388546f9313ad7ac965a4e5990061b2d2dfd4a0e5f9b635799986fdd85`

2.
**user**: `trial02`

**key**: `a0b27debfdda2cb2e99f4faf47b8f6b7b758b0c1c36f53d42078d9df9212c252`

3.
**user**: `trial03`

**key**: `656f0a57cb751e8f55779b991ba4ea016e870b68f2d86271dfe0701bfe70f300`

*If your key is private, do not share it with anyone; use it only on your server! Our system detects the original IP and port of the server starting the anticheat!*  

 
## Overview

The goal of this project is to create an efficient and robust anticheat for Multi Theft Auto. The anticheat aims to detect and prevent cheats, hacks, and other fraudulent activities that could negatively impact players' gaming experience.

## Features

- **Screenshot**: Capture a screenshot of the suspicious player's screen and display it on the staff's screen and save it in a folder within the anticheat mod.

- **Discord Webhook**: This anticheat also has logs that are sent to Discord channels through webhooks.

- **No AntiScreenShot**: This feature, when enabled, only allows players to join the server if the "Allow screen captures" option is turned on.

- **Binds**: This feature alerts staff when keys that are normally used to open cheats are pressed.

- **Anti "Backdoor"**: This feature helps discover hidden commands in compiled mods.

- **Path**: This feature helps discover the location of a certain mod on the server.

- **Weapons Blacklist**: This feature detects players with unauthorized weapons on the server and bans them (except staff).

- **Vehicles Blacklist**: This feature detects players with unauthorized vehicles on the server and bans them (except staff).

- **Game Speed**: This feature detects if a player's game speed is above normal.

- **Anti Jetpack**: This feature detects if a player is not part of the staff and is using a jetpack; they will be banned.

- **Anti Fly [BETA]**: This feature is not 100% functional yet, but its purpose is to detect if a player is flying without being part of the server's staff.

- **RPG Fire**: If the weapons blacklist feature does not detect a cheater, this function will be activated. When a player using an RPG fires, a trigger is activated, resulting in a ban.

- **Tank Fire**: It's similar to the function above, but it's triggered if a cheater fires from a tank.

- **Spawn VBR**: This feature is for those using VBR and includes the option to spawn a tank and a hydra. This function analyzes whether a cheater has a tank on the client side and another vehicle on the server side, resulting in a ban.

- **Anti Resource Stop**: This feature prevents the server's mods from being turned off. If a client disables important mods, they will be banned from the server.

- **Anti Aimbot [BETA]**: This feature is not 100% functional yet, but its purpose is to detect if a player is moving their aim too fast, as if they were using an aimbot.

- **Staff Serials**: When activated, this feature only allows registered "staffers" to enter.

- **Staff Wallhack**: This feature is only available for server staff and helps them know the locations of nearby players.

- **Ban and Unban Logs**: This feature sends a log to Discord with information about which staff member banned or unbanned a player.

- **Global Ban**: This feature is exclusive to the anticheat, and when activated, players who have recently used cheats will be banned by the system upon entering the server.

- **Anti Ban**: This feature prevents players with registered serials from being banned.

- **Update**: The anticheat has an update system.

- **Invisible Weapon [BETA]**: This feature is not fully tested yet, but its purpose is to detect if a player has an invisible weapon.

- **Anti Fix [BETA]**: This feature is not fully tested yet, but its purpose is to detect if a player has executed any car repair function and cancel it.

- **Anti Fire-Rate**: This feature is not fully tested yet, but its purpose is to detect if a player has fired multiple shots in seconds, resulting in a ban.

- **Anti VPN**: This feature detects if a player is using a VPN, resulting in a kick.

- **Fake Vehicles**: This feature detects if a player has spawned a car through a mod menu.

- **Warp Veh to me**: This feature detects if a player has teleported an existing car far from their location.

- **Screenshot API**: All screenshots are now stored on a web server via an API, allowing for sending a Discord log with media files.

- **Anti Max Speed**: This feature detects if a player is moving at an absurdly high speed.

- **Screenshare**: This feature pulls a player's screen for staff to view. (Credits to *zJoaoFtw_*, as he made it.)



- **Element Data**: This feature detects unauthorized modifications to player element data.

- **Lua Executor**: This feature detects any LUA code injection on the client side.

- **CMD Blacklist/Block**: This feature punishes players who execute a blacklisted command.
  
## Legal Notice

This project is developed independently and has no official affiliation with the developers of Multi Theft Auto or the Grand Theft Auto series. The use of this anticheat is optional and based on the server administrators' choice.

## Contact

If you have questions, suggestions, or issue reports, please feel free to create an issue in this repository or contact via Discord at uw33d (User ID: 297122391580999692).

## Sharing

If you distribute this resource, please give credit, as this project was quite tiresome and time-consuming to create.
