--[[

        _       ____________ ____ 
  __  _| |     / /__  /__  // __ \
 / / / / | /| / / /_ < /_ </ / / /
/ /_/ /| |/ |/ /___/ /__/ / /_/ / 
\__,_/ |__/|__//____/____/_____/  
                                 

https://github.com/ruip005/mta_anticheat
https://stats.uptimerobot.com/R0A6VFnrE2

!!!!!WARNING!!!!!

Este anticheat não é compativel com servidores VRP (que usam mysql) por exemplo servidores turcos!
Porquê? Porque o sistema está feito para usar ACL's e não compatibilidade com funções ainda de MySQL (Por exemplo como é via mysql o adminLevel é setado por setElementData e o anticheat verifica a ACL de staff então nao consegue saber se o jogador é staff ou não)
Futuramente irei desenvolver uma versão do anticheat adaptada para esses servidores!

This anticheat is not compatible with VRP servers (which use mysql), for example Turkish servers!
Why? Because the system is designed to use ACLs and not compatibility with MySQL functions (for example, since it's via mysql, the adminLevel is set by setElementData and anticheat checks the staff ACL so it can't know if the player is staff or not).
In the future I will develop a version of anticheat adapted for these servers!

Bu anticheat VRP sunucuları (mysql kullanan), örneğin Türk sunucuları ile uyumlu değildir!
Neden mi? Çünkü sistem ACL'leri kullanmak için tasarlanmıştır ve MySQL fonksiyonları ile uyumlu değildir (örneğin, mysql üzerinden olduğu için, adminLevel setElementData tarafından ayarlanır ve anticheat personel ACL'sini kontrol eder, böylece oyuncunun personel olup olmadığını bilemez).
Gelecekte anticheat'in bu sunucular için uyarlanmış bir versiyonunu geliştireceğim!

/wallac - Wallhack de staff
/aci ID - Ignorar jogador
/acip IP - Deixar entrar ip especifico
/acimg - Desativar print do staff
/seepath RESOURCE - Ver o caminho do resource
/commands RESOURCE - Ver os comandos de um resource
/unbanall - Desbanir todos 
/screen ID - Telar jogador

]]

server = {
	abbreviation  = "VRP", --  Server initials
	color = "#ff66ff", --  Server color
	staff = {
		onlyelementdata = false, -- You server use only element data for staff? (no using acl)
		element = "onProt", -- Staff Element Data
		staffAcl = "Staff", -- Staff ACL
		adminAcl = "Admin", -- Admin ACL
	},
	id = {
		active = true, -- If your server uses ID as element data, activate this option
		element = "ID"
	}
	discord = "discord.gg/seuservidor", -- Your official server discord
	language = "pt", -- Anticheat Language (pt, custom)
	anticheatmta = { -- https://wiki.multitheftauto.com/wiki/Anti-cheat_guide
	14, 15, 28, 31, 32 -- https://github.com/ruip005/mta_anticheat/discussions/9
	},
	minversion = "1.6.0-9.22268.0", -- Minimum version of player needed to enter the server |  https://nightly.multitheftauto.com/ver/
}

ac = {
	weapons = { -- Blacklist Weapons | https://wiki.multitheftauto.com/wiki/Weapons
	--  {Weapon ID, isBAN (true or false), "Weapon name"},
		{34, true, "AWP"},
		{35, true, "RPG"},
		{36, true, "C100 RL"},
		{37, true, "Lança-chamas"},
		{38, true, "Minigun"},
	},
	vehicle = { -- Blacklist Vehicles | https://wiki.multitheftauto.com/wiki/Vehicle_IDs
		--  [Vehicle ID] = isBAN? (true or false),
    		[592] = true,
    		[577] = true,
    		[432] = true,
    		[425] = true,
	},
	wall = { -- Staff wallhack system
		distance = 350, -- Maximum Distance
		onlyname = false, -- Show only player name -- FIX ME
	},
	binds = { -- Supervised keyboards/binds | https://wiki.multitheftauto.com/wiki/Key_names
	--  {"KEY", isActive? (true or false)},
		{"insert", true}, -- INSERT|INS Button
		{"delete", true}, -- DELETE|DEL Button
		{"end", true}, -- END Button
		{"F12", true}, -- F12 Button
		{"arrow_l", true}, -- Left arrow
		{"arrow_u", true}, -- Up arrow
		{"arrow_r", true}, -- Right arrow
		{"arrow_d", true}, -- Down arrow
	},
	elementdata = { -- ElementsDates that cannot be modified on the Client-Side
		"moneycoins",
		"coins",
	},
	cmdblock = { -- Blocked commands
		on = true, -- Leaving the system on?
		ban = false, -- true = ban | false = kick
		seconds = 0, -- 0 = permanent ban, 60*10 = 10 minutes 
		cmds = { -- Commands executed client-side
		"modmenu",
		"lua",
		"painellua",
		"painelluas",
		"holy",
		"alemaozinho",
		"alemaozinhomoney",
		},
	},
	resources = { -- Resources that cannot be switched off
		"vrp_savesystem", -- Your 'sensitive' resource
		"bank_account", -- Your 'sensitive' resource
		getResourceName(getThisResource()), -- Anticheat Name
	},
	explosion = { -- Explosions | https://wiki.multitheftauto.com/wiki/Explosion_types
		{0, true},
		{10, true},
	},
	money = {
		value = 5000000, -- If within x minutes it is detected that the player has modified the money
		banvalue = 6000000, -- Ban for x amount of money, 0 is unlimited -- FIX ME
	},
	modules = { -- Features
		weaponblacklist = true,
		vehicleblacklist = true,
		speed = true,
		jetpack = true,
		fly = true,
		rpgvbr = true,
		tankammoshot = true,
		weaponkill = true,
		spawnvbr = true,
		resourcestop = true,
		aimbot = true,
		invisibleweapon = false,
		firerate = true,
		getcar = false,
		element = false,
		lua = false,
		tphack = true,
		explosion = true,
		moneycheat = true,
		spoofer = true,
		antiesp = true,
	},
	bans = { -- Activate function bans
		weaponblacklist = true,
		vehicleblacklist = true,
		speed = true,
		jetpack = true,
		fly = false,
		rpgvbr = true,
		tankammoshot = true,
		weaponkill = true,
		spawnvbr = true,
		resourcestop = true,
		invisibleweapon = false,
		firerate = true,
		getcar = false,
		element = false,
		lua = true,
		tphack = true,
		explosion = true,
		moneycheat = true,
	},
	getcar = { -- System that tries to detect vehicles that have been pulled over
		garagens = { -- Garage coordinates -> If any player pulls a vehicle anywhere other than these coordinates, they will be banned.
		--   {x, y, z},
		},
	},
	vips = {
		functionsOff = { -- Functions that will be skipped if the player is vip
			"weaponblacklist",
			"jetpack",
			"getcar",
		},
		acl = { -- your server's vip acl's
			"Omega",
			"Sigma",
			"Cosma",
			"Alpha",
		},
	},
}

others = {
	maxSpeed = 800, -- Max speed (don't set it too low)
	screenshareban = 0, -- Ban time if the player leaves in the middle of a ShareScreen (0 = Perma)
	saveprints = true, -- Save prints?
	protect = false, -- Only let in staff with authorized serial (Only for Staffs with acl)
	banowner = false, -- Banning staff/players who try to ban someone with a higher permission (if the player is on anti-ban, they won't be banned)
	update = true, -- Automatically download new versions of anticheat -- FIX ME
	startchat = true, -- AC activation message appears
	cooldown = 5, -- Waiting time before the ban (seconds)
	music = "https://www.myinstants.com/media/sounds/cr7-vou-ao-u-ao-messi.mp3", -- Play music when the player is about to be banned -- FIX ME
	antiss = false, -- Login to the server only with active screenshot
	window = false, -- Only allow the player to enter the server full screen
	printstaff = true, -- Show the player's printout on the Staff screen -- FIX ME
	gbans = true, -- Leave global bans active
	gbansrealcheck = true, -- Check the player who has entered the server for a global ban in real time (false when you start anticheat it saves the bans in a local db)
	spooferLocal = true, -- Local spoofing system (If disabled, the system will search via Global API) [true = Search only on your server | false = Search via Global API]
	antivpn = { -- VPN system
		on = false, -- Leave the system active?
		api = "MY_KEY", -- API KEY -> https://www.ipqualityscore.com/documentation/proxy-detection-api/overview | https://www.youtube.com/watch?v=XuNNihYl7KE
		applyBan = false, -- Ban anyone who uses a VPN (API)
		bantime = 5, -- Time of ban if active
		banvpn = true, -- Ban anyone who uses a VPN for X minutes (LocalDB)
	},
	country = { -- Country system (If the player is from a country that is not allowed, he will be banned)
		on = false, -- Deixar sistema ativo?
		flags = { -- Allowed flags | https://lp.espacenet.com/help?locale=pt_LP&method=handleHelpTopic&topic=countrycodes
			"PT",
			"US",
		},
	},
}

staffs = { -- Add serial if staff protect is active (Only allow staff with serials registered here to enter the server)
	"Serial", -- You serial
	"Serial", -- You friend serial
}

antibanplayers = { -- Add serial if you don't want to be banned for serializing your server -- FIX ME
	["Serial"] = true, -- Your serial
	["Serial"] = true, -- Serial
}

language = {
	['pt'] = {
		--Admin
		['misspermission'] = "O anticheat não tem permissão para iniciar",
		['search'] = "Procurando...",
		['notallowed'] = "Este resource não está autorizado para este servidor/usuário.",
		['expired'] = "A sua key do Anticheat [${r}] expirou ou não é mais válida, contate uW33D#3333 no discord!",
		['errorcodeonline'] = "Erro ao executar o código: ",
		['errordownloadcode'] = "Não foi possível baixar o código online.",
		['requesterror'] = "Contacte uW33D#3333 Erro ao fazer a requisição: ",
		['errorapiupdate'] = "Anticheat: Não é possível obter 'api.github.com' para novas versões!",
		['newversionalreadydown'] = "Nova versão disponível no Github! Já está descarregado no diretório 'Updates' dentro do anticheat, basta substituir o antigo!",
		['errorupdatingnewv'] = "Não é possível descarregar a versão mais recente do Github!",
		['apiinvalid'] = "Chave API inválida",
		['apierrorinternal'] = "Erro interno API",
		['apilackdata'] = "Falta introduzir alguns dados",
		['apiidk'] = "Erro desconhecido de API ou offline",
		--Resources
		['startchat'] = "#ffffffAntiCheat v ${arg} ligado (criado por uW33D#3333)",
		['startnotify'] = "AntiCheat v ${arg} ligado (criado por uW33D#3333)",
		['rootchatbans'] = "#ffffffO jogador "..servidor.cor.."${nome} [${id}] #fffffffoi banido por uso de trapaças!",
		['notifythinkcheater'] = "O anticheat baniu um possível cheater",
		['nostaffmode'] = "Você não está no modo staff!",
		['staffwall'] = "Você ativou o wall!",
		['gbanchat'] = "#ffffffO jogador "..servidor.cor.."${getname} [${id}] #fffffffoi banido pelo Gbans do Anticheat!",
		['gbannotify'] = "O jogador ${nome} [${id}] foi banido pelo GBANS",
		['vpnapi'] = "Foi detectada a entrada no servidor com VPN.",
		['vpnsql'] = "Seu endereço IP não está permitido para conectar no servidor devido ao uso de VPN.",
		--Others
		['screenoffkick'] = "Ative a opção de permitir o envio de capturas de tela",
		['screenoffban'] = "Ative a opção de permitir o envio de capturas de tela ou deixe tela cheia",
		['screenof'] = "Tela de:",
		['thinkcheater'] = "${nome} [${id}] está provavelmente usando cheats!",
		['noinfo'] = "Sem informações",
		['antibanwarn'] = "Você não pode banir esse jogador",
		['syntaxaci'] = "Use /aci [ID]",
		['playeroff'] = "Esse jogador não está online",
		['playeralreadyignore'] = "Esse jogador já se encontra na lista de jogadores ignorados",
		['playeraddedtoaci'] = "O jogador foi adicionado à lista de jogadores ignorados",
		['acistaff'] = "O staff ${getname} adicionou o ID: ${id} aos jogadores ignorados!", 
		['nopermission'] = "Você não possui permissão para executar esse comando!",
		['verifyinfos'] = "Verificando informações...",
		['allbansrevoke'] = "Todos os banimentos foram retirados!",
		['nobanstorevoke'] = "Nenhum banimento registrado!",
		['playerusingvpn'] = "O jogador ${getname} está usando VPN.", 
		['ipaddedtojoin'] = "O IP: ${id} foi adicionado ao banco de dados.", 
		['ipnotvalid'] = "Esse IP não é válido",
		['ipsyntax'] = "Use /acip XXX.XXX.XXX.XXX (IP)",
		['successScreenshot'] = "Foto tirada, aguarde...",
		--Folders
		['suspects'] = "Suspeitos",
		['bans'] = "Banimentos",
		['updates'] = "Updates",
		--Discord
		['bindsD'] = "O jogador ${nome} [${id}] pressionou teclas de possivel mod menu! [".."Binds".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```",
		['pathD'] = "```Request feito por: ${getname} [${getelementid}]\n${resourcename} encontra-se na pasta: ${resourcepath}```",
		['cmdsD'] = "```Request feito por: ${getname} [${getelementid}]\n".."Comandos de ${resourcename}```", 
		['weaponblacklistD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [${arma}]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here", 
		['vehicleblacklistD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".."Blacklist Vehicle".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here", 
		['speedD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [Limitador de velocidade]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here", 
		['jetpackD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".." Jetpack hack ".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here", 
		['flyD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".." Fly hack ".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here", 
		['rpgvbrD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".."RPG Mod Menu".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['tankammoshotD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".."Tank Mod Menu".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['weaponkillD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".."matar com arma blacklist".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['spawnvbrD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".."Vehicle blacklist client".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['resourcestopD'] = "```O jogador ${nome} [${id}] foi kickado! [".."Resource Stopper".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['aimbotD'] = "```O jogador ${nome} [${id}] está mexendo a mira rápido demais! [".."Aimbot".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```",
		['joinstaffaccD'] = "```Tem alguém querendo autenticar-se na conta do Staff: ${getaccPacc} | Nick: ${getname} | IP: ${ip} | SERIAL: ${serial}```",
		['banlogsD'] = "```O Staff ${snome} [${sid}] baniu o jogador ${nome} [${id}]\n\nIP: ${ip} | Serial: ${serial}\nTempo: ${tempo}\nMotivo: ${motivo}\n```", 
		['unbanlogsD'] = "```O Staff ${snome} [${sid}] desbaniu o jogador ${nome} [${id}]\n\nIP: ${ip} | Serial: ${serial}```",
		['invisibleweaponD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [Arma invisível]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['firerateD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [Fire Rate]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['updateD'] = "```diff\n+ Nova versão do Anticheat baixada!\n+ Não esqueça de fazer a troca!\n```",
		['getcarD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [Puxar Carro]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['gbanD'] = "```O jogador ${nome} foi banido pelo Gbans do Anticheat!\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['elementD'] = "```O jogador ${nome} foi banido por uso de trapaças! [Element Data]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['luaD'] = "```O jogador ${nome} foi banido por uso de trapaças! [Lua Executor]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['tphackD'] = "```O jogador ${nome} foi banido por uso de trapaças! [TP HACK]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['blackcmdsD'] = "```O jogador ${nome} foi banido por uso de trapaças! [Blacklist Command: ${cmd}]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['explosionD'] = "```O jogador ${nome} foi banido por uso de trapaças! [Explosion]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['moneycheatD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [Puxar dinheiro]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		--Cmds
		['pathC'] = "Localização: ",
		['cmdsC'] = "Comandos de ${resourcename}: ",
		--Bans
		['weaponblacklistB'] = "Arma blacklist detectado",
		['vehicleblacklistB'] = "Veiculo blacklist detectado",
		['speedB'] = "Limitador de velocidade detectado",
		['jetpackB'] = "Jetpack hack detectado",
		['flyB'] = "Fly hack detectado",
		['rpgvbrB'] = "RPG detectado.",
		['tankammoshotB'] = "Tank detectado.",
		['weaponkillB'] = "Disparo c/ arma blacklist detectada",
		['spawnvbrB'] = "Vehicle mod menu spawn",
		['resourcestopB'] = "Resource Stopper detectado!",
		['joinstaffaccB'] = "Você conectou-se numa conta da staff mas seu serial não é permitido",
		['gbanB'] = "Banimento global do Anticheat",
		['antibanfounderB'] = "Você tentou banir alguém importante!",
		['invisibleweaponB'] = "Arma invisível detectada",
		['firerateB'] = "Fire Rate modificado detectado",
		['getcarB'] = "Puxar carro detectado",
		['elementB'] = "Elemento modificado ilegalmente",
		['luaB'] = "Lua executor detectado",
		['blackcmdsB'] = "Comando bloqueado",
		['tphackB'] = "Teleport Hack detectado",
		['explosionB'] = "Explosão detectada",
		['moneycheatB'] = "Puxar dinheiro detectado",
		-- Screenshot
		['sharingscreen'] = "Você está sendo telado.",
		['time'] = "Tempo: ",
		['warningnoquit'] = "Não saia do servidor, se não você irá ser banido.",
		['leavessC'] = "Você foi retirado da screenshare!",
		['leavessS'] = "Você retirou o jogador na screenshare com sucesso!",
		['tpssC'] = "Você foi movido para screenshare!",
		['tpssS'] = "Você colocou o jogador na screenshare com sucesso!",
		['banmsgss'] = "Desconectou durante a screenshare!",
		['fullscreen'] = "Você está usando modo janela, por favor deixe tela cheia!",
		-- New
		['moneycheat'] = "está possivelmente usando cheat de puxar dinheiro!",
		['moneycheatD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [Puxar dinheiro]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['moneycheatC'] = "Puxar dinheiro detectado",
		['countrynotallowed'] = "Your country is not allowed",
		['spooferB'] = "Spoofer detectado!",
		['spooferD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [Spoofer]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['spooferDS'] = "```O jogador ${nome} [${id}] é suspeito de usar Spoofing! [Spoofer]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['spooferS'] = "O jogador ${nome} é suspeito de usar spoofing."
	},
	['custom'] = { -- Sua linguagem personalizada | Your personalised language ( !Por favor não apague os ${} )
		-- Copie, cole e edite!
	},
	['es'] = {
		-- Su lengua
	},
	['ge'] = {
		-- Meine sprache
	},
}

notify = function(player, message, type) -- Function exported from your Info
    exports["bml_info"]:addBox(player, message, type) -- Post your info/infobox here
end

getSystemLanguage = function(index) -- Don't change it!
    return language[servidor.language][index];
end