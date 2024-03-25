auth = { -- Autenticação | Authentication
	user = "MY_USER", -- You username
	key = "MY_PASSWORD" -- You password/key
}

discord = {
	---- Discord Webhooks
	aimbot = "https://discord.com/api/webhooks/XXXXXXX", -- Aimbot Suspect Log
	resourcestop = "https://discord.com/api/webhooks/XXXXXXX", -- Resource Stopper Ban Log
	spawnvbr = "https://discord.com/api/webhooks/XXXXXXX", -- Vehicle Spawner with Cheat log
	weaponkill = "https://discord.com/api/webhooks/XXXXXXX", -- Weapons Blacklist
	tankammoshot = "https://discord.com/api/webhooks/XXXXXXX", -- Tank shooting (if activated)
	rpgvbr = "https://discord.com/api/webhooks/XXXXXXX", -- Shoot with rpg that is usually spawned by vbr cheat
	fly = "https://discord.com/api/webhooks/XXXXXXX", -- Fly log
	jetpack = "https://discord.com/api/webhooks/XXXXXXX", -- Jetpack log
	speed = "https://discord.com/api/webhooks/XXXXXXX", --  Speed hack
	vehicleblacklist = "https://discord.com/api/webhooks/XXXXXXX", -- Vehicles Blacklist
	weaponblacklist = "https://discord.com/api/webhooks/XXXXXXX", -- Shooting with any weapon blacklist
	commands = "https://discord.com/api/webhooks/XXXXXXX", -- Commands in suspicious resources (returns all commands from X mod) -- TO DO - Name
	binds = "https://discord.com/api/webhooks/XXXXXXX", -- Binds logs
	logprotect = "https://discord.com/api/webhooks/XXXXXXX", -- Unauthorised serial log entered in a staff account
	bans = "https://discord.com/api/webhooks/XXXXXXX", -- Bans logs -- TO DO - Name
	unbans = "https://discord.com/api/webhooks/XXXXXXX", -- Unbans logs
	gbans = "https://discord.com/api/webhooks/XXXXXXX", -- Global Bans logs
	updatesAC = "https://discord.com/api/webhooks/XXXXXXX", --  Updates anticheat
	invisibleweapon = "https://discord.com/api/webhooks/XXXXXXX", --  Invisible Weapons
	firerate = "https://discord.com/api/webhooks/XXXXXXX", --  Fire Rate log
	getcar = "https://discord.com/api/webhooks/XXXXXXX", -- Pull Car Log
	element = "https://discord.com/api/webhooks/XXXXXXX", -- Element data modify log
	lua = "https://discord.com/api/webhooks/XXXXXXX", -- Lua executor log
	tphack = "https://discord.com/api/webhooks/XXXXXXX", -- Tphack log
	cmdblocks = "https://discord.com/api/webhooks/XXXXXXX", -- Commands blacklist log
	explosion = "https://discord.com/api/webhooks/XXXXXXX", -- Commands explosions logs
	moneycheat = "https://discord.com/api/webhooks/XXXXXXX", -- Money logs
	spoofer = "https://discord.com/api/webhooks/XXXXXXX", -- Spoofer logs
	---- Discord Webhooks
	config = {
		color = "10181046", --  Embed color (if enabled)
		avatar = "https://avatars.githubusercontent.com/u/46203319?v=4", --  Bot pic
		name = "Seu servidor" or servidor.sigla, --  Bot name
		message = "", --  Additional message
		embed = true, -- Discord embed status
		resolutionX = 800, -- Resolution X 
		resolutionY = 600, -- Resolution Y
		quality = 22, -- Image quality
	},
}

externalCode = "https://pastebin.com/raw/dk3EbQcx"