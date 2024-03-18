discord = {
	---- Discord Webhooks
	aimbot = "https://discord.com/api/webhooks/XXXXXXX", -- Log de suspeita de aimbot | Aimbot Suspect Log
	resourcestop = "https://discord.com/api/webhooks/XXXXXXX", -- Log  ban de resource stopper | Resource Stopper Ban Log
	spawnvbr = "https://discord.com/api/webhooks/XXXXXXX", -- Log ban de vehicle spawn com vbr cheats | Vehicle Spawner with Cheat log
	weaponkill = "https://discord.com/api/webhooks/XXXXXXX", -- Log ban de matar com armas blacklist | Weapons Blacklist
	tankammoshot = "https://discord.com/api/webhooks/XXXXXXX", -- Log ban de atirar com tanque (se tiver ativado) | Tank shooting (if activated)
	rpgvbr = "https://discord.com/api/webhooks/XXXXXXX", -- Log ban de atirar com rpg que normalmente é spawn pelo vbr cheat | Shoot with rpg that is usually spawned by vbr cheat
	fly = "https://discord.com/api/webhooks/XXXXXXX", -- Log de ban de fly | Fly log
	jetpack = "https://discord.com/api/webhooks/XXXXXXX", --Log de ban de usar jetpack | Jetpack
	speed = "https://discord.com/api/webhooks/XXXXXXX", -- Log de ban por speed hack | Speed hack
	vehicleblacklist = "https://discord.com/api/webhooks/XXXXXXX", -- Log de ban por veiculos em lista negra (ac.veiculos) | Vehicles Blacklist
	weaponblacklist = "https://discord.com/api/webhooks/XXXXXXX", -- Log de ban por armas em lista negra (ac.armas) | Shooting with any weapon blacklist
	comandos = "https://discord.com/api/webhooks/XXXXXXX", -- Log de comandos em resources suspeitos (retorna todos os comandos de X mod) | commands in suspicious resources (returns all commands from X mod)
	binds = "https://discord.com/api/webhooks/XXXXXXX", -- Log de suspeita de abrir/fechar menu | Binds logs
	logprotect = "https://discord.com/api/webhooks/XXXXXXX", -- Log de serial não permitido entrou numa conta staff | Unauthorised serial log entered in a staff account
	banimentos = "https://discord.com/api/webhooks/XXXXXXX", -- Logs dos bans
	unbans = "https://discord.com/api/webhooks/XXXXXXX", -- Logs dos unbans
	gbans = "https://discord.com/api/webhooks/XXXXXXX", --Logs dos gbans aplicados | Global Bans logs
	updatesAC = "https://discord.com/api/webhooks/XXXXXXX", -- Webhook para receber novidades do anticheat | Updates anticheat
	invisibleweapon = "https://discord.com/api/webhooks/XXXXXXX", -- Webhook de suspeita de arma invisivel | Invisible Weapons
	firerate = "https://discord.com/api/webhooks/XXXXXXX", -- Webhook de suspeita de atirar rapido d+ | Fire Rate log
	getcar = "https://discord.com/api/webhooks/XXXXXXX", -- Webhook de suspeita de puxar carro | Pull Car Log
	element = "https://discord.com/api/webhooks/XXXXXXX", --Webhook de suspeita de modificar elementos | Element data modify log
	lua = "https://discord.com/api/webhooks/XXXXXXX", --Webhook de suspeita de códigos lua | Lua executor log
	tphack = "https://discord.com/api/webhooks/XXXXXXX", --Webhook de suspeita de tphack | Tphack log
	cmdblocks = "https://discord.com/api/webhooks/XXXXXXX", --Webhook de uso de comandos bloqueados | Commands blacklist log
	explosion = "https://discord.com/api/webhooks/XXXXXXX", --Webhook de criar explosoes | Commands explosions logs
	moneycheat = "https://discord.com/api/webhooks/XXXXXXX", --Webhook de suspeita de modificar dinheiro | Money logs
	spoofer = "https://discord.com/api/webhooks/XXXXXXX", --Webhook de bans e suspeitos de usar spoofing | Spoofer logs
	---- Discord Webhooks
	config = {
		color = "10181046", -- Cor da embed (se ativado) Embed color (if enabled)
		avatar = "https://avatars.githubusercontent.com/u/46203319?v=4", -- Foto do bot | Bot pic
		name = "Seu servidor" or servidor.sigla, -- Nome do bot | Bot name
		message = "", -- Mensagem adicional | Additional message
		embed = true, -- Ativar discord embed | Discord embed status
		resolutionX = 800, -- Resolução X 
		resolutionY = 600, -- Resolução Y
		quality = 13, -- Qualidade da imagem, não deixe muito alto 10~30 | Image quality
	},
}