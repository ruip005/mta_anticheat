# **Anticheat for MTA (Multi Theft Auto)**

Welcome to the Anticheat project for Multi Theft Auto (MTA). This repository is intended to host the development of an anticheat system aimed at improving the integrity and fairness of the game in the MTA's multiplayer environment.

[Video on how to set up + AntiVPN](https://youtu.be/XuNNihYl7KE)

## Authentication

### Authentication to start the anticheat.

| Variable | Type     | Description                             |
| :------- | :------- | :-------------------------------------- |
| `user`   | `string` | **Required**. Username                  |
| `key`    | `string` | **Required**. User activation key       |

### Some free authentications.

1.
**user**: `trial01`

**key**: `f8e2a1388546f9313ad7ac965a4e5990061b2d2dfd4a0e5f9b635799986fdd85`

2.
**user**: `trial02`

**key**: `a0b27debfdda2cb2e99f4faf47b8f6b7b758b0c1c36f53d42078d9df9212c252`

3.
**user**: `trial03`

**key**: `656f0a57cb751e8f55779b991ba4ea016e870b68f2d86271dfe0701bfe70f300`

## Overview

The aim of this project is to create an efficient and robust anticheat for Multi Theft Auto. The anticheat is designed to detect and prevent cheats, hacks, and other fraudulent activities that may negatively impact players' gaming experience.

## Features

- **Screenshot**: Take a screenshot of the suspected player's screen and display it on the staff's screen and save it in a folder within the anticheat mod.

- **Discord Webhook**: This anticheat also includes logs that will be sent to Discord channels via webhooks.

- **No AntiScreenShot**: When activated, this feature only allows players to join the server if they have the "Allow screen captures" option enabled.

- **Binds**: This feature alerts the staff when keys typically used to open cheats are pressed.

- **Anti "Backdoor"**: This feature helps discover hidden commands in compiled mods.

- **Path**: This feature helps discover the location of a specific mod on the server.

- **Weapons Blacklist**: This feature detects players with unauthorized weapons on the server and then bans them (except staff).

- **Vehicles Blacklist**: This feature detects players with unauthorized vehicles on the server and then bans them (except staff).

- **Game Speed**: This feature detects if a player has the game speed set above normal.

- **Anti Jetpack**: This feature detects if a player is not part of the staff and is using a Jetpack, resulting in a ban.

- **Anti Fly [BETA]**: This feature is not 100% complete yet, but its purpose is to detect if a player is flying without being part of the server's staff.

- **RPG Fire**: If the weapons blacklist feature doesn't detect anything, this RPG Fire feature activates. It triggers a ban when a player using an RPG fires it.

- **Tank Fire**: Similar to the above feature, but for when a cheater fires from a tank.

- **Spawn VBR**: This feature is for those who use VBR and includes the option to spawn a tank and a hydra. It checks if the cheater has a tank on the client side and another vehicle on the server side, resulting in a ban.

- **Anti Resource Stop**: This feature prevents important server mods from being turned off if the client deactivates them; in such cases, the player is banned.

- **Anti Aimbot [BETA]**: This feature is not 100% complete yet, but its purpose is to detect if a player is moving their crosshair too quickly, as if using a real aimbot.

- **Staff Serials**: When this feature is active, only staffers with registered serials are allowed to enter.

- **Staff Wallhack**: This feature is only available to server staff and helps locate nearby players.

- **Ban and Unban Logs**: This feature sends a log to Discord with information about which staff member banned or unbanned a player.

- **Global Ban**: This feature is exclusive to the anticheat, and when activated, players who have recently used cheats when entering the server will be banned by the system.

- **Anti-Ban**: This feature prevents players with registered serials from being banned.

- **Update**: The anticheat includes an update system.

- **Invisible Weapon [BETA]**: This feature is not 100% TESTED yet, but its purpose is to detect if a player has an invisible weapon.

- **Anti Fix [BETA]**: This feature is not 100% TESTED yet, but its purpose is to detect if a player has executed any car repair function and cancel it.

- **Anti Fire-Rate**: This feature is not 100% TESTED yet, but its purpose is to detect if a player has fired multiple shots in seconds, resulting in a ban.

- **Anti VPN**: This feature detects if a player is using a VPN, resulting in a Kick.

- **Fake Vehicles**: This feature detects if a player has spawned a car through a mod menu.

- **Warp Vehicle to Me**: This feature detects if a player has teleported an existing vehicle far from themselves.

- **Screenshot API**: All screenshots are now stored on a web server via an API, allowing you to send a Discord log with media files.

- **Anti Max Speed**: This feature detects if a player is moving at an absurd speed.

- **Screenshare**: This feature pulls a player to share their screen. (Credits to *zJoaoFtw_*, as he created it).

- **Element Data**: This feature detects modifications that shouldn't occur in player element data.

- **Lua Executor**: This feature detects any LUA code injection on the client side.

- **CMD Blacklist/Block**: This feature punishes the player who executes a blacklisted command.

## Legal Disclaimer

This project is developed independently and has no official affiliation with the developers of Multi Theft Auto or the Grand Theft Auto series. The use of this anticheat is optional and is based on the server administrators' choice.

## Contact

If you have questions, suggestions, or issue reports, feel free to create an issue in this repository or contact us via email at [ruirr31@gmail.com](mailto:ruirr31@gmail.com).

## Sharing

If you decide to use this resource, please give proper credit, as this project was quite tiring and time-consuming to create.