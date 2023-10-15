--[[

        _       ____________ ____ 
  __  _| |     / /__  /__  // __ \
 / / / / | /| / / /_ < /_ </ / / /
/ /_/ /| |/ |/ /___/ /__/ / /_/ / 
\__,_/ |__/|__//____/____/_____/  
                                 

https://github.com/ruip005/mta_anticheat
https://stats.uptimerobot.com/R0A6VFnrE2

]]

auth = { -- Autenticação | Authentication
	user = "", --http://request-uw33dac.duckdns.org:3000/demo
	key = "" --http://request-uw33dac.duckdns.org:3000/demo
}

servidor = {
	sigla = "VRP", -- Sigla do servidor | Server initials
	cor = "#ff66ff", -- Cor do servidor | Server color
	acl = "Staff", -- ACL de Staff | Staff ACL (Normal)
	staff = "onProt", -- Element Data para entrar no modo staff (/pro ou /staff) | Element Data to enter staff mode (/pro or /staff)
	admin = "Admin",  -- ACL de Staff superior | Staff ACL (Admin+)
	id = "ID", -- Element Data do ID | ID Element Data
	discord = "discord.gg/seuservidor", -- Discord do seu servidor | Ur official server discord
	language = "pt", -- Lingua do anticheat | Anticheat Language (pt, custom)
}

discord = {
	---- Discord Webhooks
	aimbot = "https://discord.com/api/webhooks/XXXXXX", -- Log de suspeita de aimbot | Aimbot Suspect Log
	resourcestop = "https://discord.com/api/webhooks/XXXXXX", -- Log  ban de resource stopper | Resource Stopper Ban Log
	spawnvbr = "https://discord.com/api/webhooks/XXXXXX", -- Log ban de vehicle spawn com vbr cheats | Vehicle Spawner with Cheat log
	weaponkill = "https://discord.com/api/webhooks/XXXXXX", -- Log ban de matar com armas blacklist | Weapons Blacklist
	tankammoshot = "https://discord.com/api/webhooks/XXXXXX", -- Log ban de atirar com tanque (se tiver ativado) | Tank shooting (if activated)
	rpgvbr = "https://discord.com/api/webhooks/XXXXXX", -- Log ban de atirar com rpg que normalmente é spawn pelo vbr cheat | Shoot with rpg that is usually spawned by vbr cheat
	fly = "https://discord.com/api/webhooks/XXXXXX", -- Log de ban de fly | Fly log
	jetpack = "https://discord.com/api/webhooks/XXXXXX", --Log de ban de usar jetpack | Jetpack
	speed = "https://discord.com/api/webhooks/XXXXXX", -- Log de ban por speed hack | Speed hack
	vehicleblacklist = "https://discord.com/api/webhooks/XXXXXX", -- Log de ban por veiculos em lista negra (ac.veiculos) | Vehicles Blacklist
	weaponblacklist = "https://discord.com/api/webhooks/XXXXXX", -- Log de ban por armas em lista negra (ac.armas) | Shooting with any weapon blacklist
	comandos = "https://discord.com/api/webhooks/XXXXXX", -- Log de comandos em resources suspeitos (retorna todos os comandos de X mod) | commands in suspicious resources (returns all commands from X mod)
	binds = "https://discord.com/api/webhooks/XXXXXX", -- Log de suspeita de abrir/fechar menu | Binds logs
	logprotect = "https://discord.com/api/webhooks/XXXXXX", -- Log de serial não permitido entrou numa conta staff | Unauthorised serial log entered in a staff account
	banimentos = "https://discord.com/api/webhooks/XXXXXX", -- Logs dos bans
	unbans = "https://discord.com/api/webhooks/XXXXXX", -- Logs dos unbans
	gbans = "https://discord.com/api/webhooks/XXXXXX", --Logs dos gbans aplicados | Global Bans logs
	updatesAC = "https://discord.com/api/webhooks/XXXXXX", -- Webhook para receber novidades do anticheat | Updates anticheat
	invisibleweapon = "https://discord.com/api/webhooks/XXXXXX", -- Webhook de suspeita de arma invisivel | Invisible Weapons
	firerate = "https://discord.com/api/webhooks/XXXXXX", -- Webhook de suspeita de atirar rapido d+ | Fire Rate log
	getcar = "https://discord.com/api/webhooks/XXXXXX", -- Webhook de suspeita de puxar carro | Pull Car Log
	element = "https://discord.com/api/webhooks/XXXXXX", --Webhook de suspeita de modificar elementos | Element data modify log
	lua = "https://discord.com/api/webhooks/XXXXXX", --Webhook de suspeita de códigos lua | Lua executor log
	tphack = "https://discord.com/api/webhooks/XXXXXX", --Webhook de suspeita de tphack | Tphack log
	cmdblocks = "https://discord.com/api/webhooks/XXXXXX", --Webhook de uso de comandos bloqueados | Commands blacklist log
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

ac = {
	armas = { -- Armas blacklist https://wiki.multitheftauto.com/wiki/Weapons
		{34, true, "AWP"},
		{35, true, "RPG"},
		{36, true, "C100 RL"},
		{37, true, "Lança-chamas"},
		{38, true, "Minigun"},
	},
	veiculos = { -- Veiculos blacklist https://wiki.multitheftauto.com/wiki/Vehicle_IDs
    [592] = true,
    [577] = true,
    [432] = true,
    [425] = true,
	},
	wall = { -- Sistema de wall de staff
		distancia = 350, -- Distancia Maxima
		soid = false, -- Aparecer apenas o ID
	},
	binds = { -- Binds supervisionadas https://wiki.multitheftauto.com/wiki/Key_names
		{"insert", true},
		{"delete", true},
		{"end", true},
	},
	elementdata = { -- ElementsDatas que não podem ser modificados do lado do Client-Side
		"moneycoins",
		"coins",
	},
	cmdblock = { -- Comandos bloqueados
		"modmenu",
		"lua",
		"painellua",
		"painelluas",
		"holy",
		"alemaozinho",
		"alemaozinhomoney",
	},
	resources = { -- Resources que não podem ser desligados
		"vrp_savesystem",
		"bank_account",
		"weed_anticheat"
	},
	bans = { -- Ativar banimentos das funções
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
		element = true,
		lua = true,
		tphack = true,
	},
	getcar = {
		vips = { -- ACL Vips
			"Omega",
			"Sigma",
			"Cosma",
			"Alpha",
		},
		garagens = { -- Coordenadas das garagens
			{12,12,12}
		}
	}
}

outros = {
	velocidademax = 700, -- Velocidade max (nao coloque muito baixa)
	screenshareban = 0, -- Tempo de banimento se o jogador sair a meio de um ShareScreen (0 = Perma)
	saveprints = true, -- Salvar todas as prints numa pasta no seu servidor
	protect = false, -- Deixar apenas entrar pessoal com serial autorizado (Apenas para Staffs com acl)
	bandono = false, -- Banir staffs/players que tentarem banir alguém com permissão mais alta (se o jogador estiver no antibanjogadores ele não irá ser banido)
	update = true, -- Baixar automaticamente novas versões do anticheat
	startchat = true, -- Aparecer mensagem de ativação do AC
	cooldown = 5, -- Tempo de espera antes do banimento
	musica = "https://mediastream.com/music.mp3", -- Tocar música quando o jogador estiver para ser banido
	antiss = true, -- Entrar no servidor apenas com captura de tela ativa
	verifyAllTimeSS = false, -- Ficar analisando jogadores se ainda tem captura de tela ativa
	telastaff = true, -- Mostrar a print do jogador na tela do Staff
	gbans = true, -- Deixar os banimentos globais ativos
	gbansrealcheck = false, -- Verificar o jogador que entrou no servidor se possui banimento global em tempo real (false ao iniciar o anticheat ele guarda os banimentos numa local db)
	antivpn = {
		on = true, -- Deixar o sistema ativo
		api = "API-SECRET-KEY", -- Chave de API -> https://www.ipqualityscore.com/documentation/proxy-detection-api/overview
		applyBan = false, -- Banir quem usar VPN por X minutos (API)
		bantime = 5, -- Tempo do banimento se estiver ativo
		banvpn = true -- Banir quem usar VPN por X minutos (LocalDB)
	}
}

staffs = { -- Adicionar serial caso o protect de staff esteja ativo (Deixa apenas entrar no servidor staffs com seriais aqui registados)
	"Serial", -- Seu serial
	"Serial", -- Outro serial
}

antibanjogadores = { -- Adicionar serial caso queira não tomar ban por serial do seu servidor
	["Serial"] = true, -- Seu serial
	["Serial"] = true, -- Outro serial
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
		['apiidk'] = "Erro desconhecido de API",
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
		['screenoffban'] = "Ative a opção de permitir o envio de capturas de tela",
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
		['flybanD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".." Fly hack ".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here", 
		['rpgvbrD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".."RPG Mod Menu".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['tankammoshotD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".."Tank Mod Menu".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['weaponkillD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".."matar com arma blacklist".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['spawnvbrD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".."Vehicle blacklist client".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['resourcestopD'] = "```O jogador ${nome} [${id}] foi kickado! [".."Resource Stopper".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['aimbotD'] = "```O jogador ${nome} [${id}] está mexendo a mira rápido demais! [".."Aimbot".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```",
		['joinstaffaccD'] = "```Tem alguém querendo autenticar-se na conta do Staff: ${getaccPacc} | Nick: ${getname} | IP: ${ip} | SERIAL: ${serial}```",
		['banlogsD'] = "```O Staff ${snome} [${sid}] baniu o jogador ${nome} [${id}]\nIP: ${ip} | Serial: ${serial}```", 
		['unbanlogsD'] = "```O Staff ${snome} [${sid}] desbaniu o IP: ${ip} | Serial: ${serial}```",
		['invisibleweaponD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [Arma invisível]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['firerateD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [Fire Rate]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['updateD'] = "```diff\n+ Nova versão do Anticheat baixada!\n+ Não esqueça de fazer a troca!\n```",
		['getcarD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [Puxar Carro]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['gbanD'] = "```O jogador ${nome} foi banido pelo Gbans do Anticheat!\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['elementD'] = "```O jogador ${nome} foi banido por uso de trapaças! [Element Data]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['luaD'] = "```O jogador ${nome} foi banido por uso de trapaças! [Lua Executor]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['~tphackD'] = "```O jogador ${nome} foi banido por uso de trapaças! [TP HACK]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['blackcmdsD'] = "```O jogador ${nome} foi banido por uso de trapaças! [Blacklist Command: ${cmd}]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
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
		-- Screenshot
		['sharingscreen'] = "Você está sendo telado.",
		['time'] = "Tempo: ",
		['warningnoquit'] = "Não saia do servidor, se não você irá ser banido.",
		['leavessC'] = "Você foi retirado da screenshare!",
		['leavessS'] = "Você retirou o jogador na screenshare com sucesso!",
		['tpssC'] = "Você foi movido para screenshare!",
		['tpssS'] = "Você colocou o jogador na screenshare com sucesso!",
		['banmsgss'] = "Desconectou durante a screenshare!",
	},
	['custom'] = { -- Sua linguagem personalizada | Your personalised language ( !Por favor não apague os ${} )
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
		['apiidk'] = "Erro desconhecido de API",
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
		['screenoffban'] = "Ative a opção de permitir o envio de capturas de tela",
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
		['flybanD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".." Fly hack ".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here", 
		['rpgvbrD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".."RPG Mod Menu".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['tankammoshotD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".."Tank Mod Menu".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['weaponkillD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".."matar com arma blacklist".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['spawnvbrD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".."Vehicle blacklist client".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['resourcestopD'] = "```O jogador ${nome} [${id}] foi kickado! [".."Resource Stopper".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['aimbotD'] = "```O jogador ${nome} [${id}] está mexendo a mira rápido demais! [".."Aimbot".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```",
		['joinstaffaccD'] = "```Tem alguém querendo autenticar-se na conta do Staff: ${getaccPacc} | Nick: ${getname} | IP: ${ip} | SERIAL: ${serial}```",
		['banlogsD'] = "```O Staff ${snome} [${sid}] baniu o jogador ${nome} [${id}]\nIP: ${ip} | Serial: ${serial}```", 
		['unbanlogsD'] = "```O Staff ${snome} [${sid}] desbaniu o IP: ${ip} | Serial: ${serial}```",
		['invisibleweaponD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [Arma invisível]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['firerateD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [Fire Rate]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['updateD'] = "```diff\n+ Nova versão do Anticheat baixada!\n+ Não esqueça de fazer a troca!\n```",
		['getcarD'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [Puxar Carro]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['gbanD'] = "```O jogador ${nome} foi banido pelo Gbans do Anticheat!\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['elementD'] = "```O jogador ${nome} foi banido por uso de trapaças! [Element Data]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['luaD'] = "```O jogador ${nome} foi banido por uso de trapaças! [Lua Executor]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['~tphackD'] = "```O jogador ${nome} foi banido por uso de trapaças! [TP HACK]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		['blackcmdsD'] = "```O jogador ${nome} foi banido por uso de trapaças! [Blacklist Command: ${cmd}]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
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
		-- Screenshot
		['sharingscreen'] = "Você está sendo telado.",
		['time'] = "Tempo: ",
		['warningnoquit'] = "Não saia do servidor, se não você irá ser banido.",
		['leavessC'] = "Você foi retirado da screenshare!",
		['leavessS'] = "Você retirou o jogador na screenshare com sucesso!",
		['tpssC'] = "Você foi movido para screenshare!",
		['tpssS'] = "Você colocou o jogador na screenshare com sucesso!",
		['banmsgss'] = "Desconectou durante a screenshare!",
	},
}

notify = function(player, message, type) -- Função exportada da sua Info
    exports["vrp_info"]:addBox(player, message, type)
end

getSystemLanguage = function(index) -- Não altere!
    return language[servidor.language][index];
end