--[[

  ______              __      __            __                             __     
 /      \            |  \    |  \          |  \                           |  \    
|  $$$$$$\ _______  _| $$_    \$$  _______ | $$____    ______    ______  _| $$_   
| $$__| $$|       \|   $$ \  |  \ /       \| $$    \  /      \  |      \|   $$ \  
| $$    $$| $$$$$$$\\$$$$$$  | $$|  $$$$$$$| $$$$$$$\|  $$$$$$\  \$$$$$$\\$$$$$$  
| $$$$$$$$| $$  | $$ | $$ __ | $$| $$      | $$  | $$| $$    $$ /      $$ | $$ __ 
| $$  | $$| $$  | $$ | $$|  \| $$| $$_____ | $$  | $$| $$$$$$$$|  $$$$$$$ | $$|  \
| $$  | $$| $$  | $$  \$$  $$| $$ \$$     \| $$  | $$ \$$     \ \$$    $$  \$$  $$
 \$$   \$$ \$$   \$$   \$$$$  \$$  \$$$$$$$ \$$   \$$  \$$$$$$$  \$$$$$$$   \$$$$ 
                                                                                                                  
           __       __   ______    ______   _______  
          |  \  _  |  \ /      \  /      \ |       \ 
 __    __ | $$ / \ | $$|  $$$$$$\|  $$$$$$\| $$$$$$$\
|  \  |  \| $$/  $\| $$ \$$__| $$ \$$__| $$| $$  | $$
| $$  | $$| $$  $$$\ $$  |     $$  |     $$| $$  | $$
| $$  | $$| $$ $$\$$\$$ __\$$$$$\ __\$$$$$\| $$  | $$
| $$__/ $$| $$$$  \$$$$|  \__| $$|  \__| $$| $$__/ $$
 \$$    $$| $$$    \$$$ \$$    $$ \$$    $$| $$    $$
  \$$$$$$  \$$      \$$  \$$$$$$   \$$$$$$  \$$$$$$$ 
                                                     

ᴀɴᴛɪᴄʜᴇᴀᴛ ᴘʀɪᴠᴀᴅᴏ ᴠᴇʀsᴀ̃ᴏ 1.3.1.00 sᴛᴀʙʟᴇ [ ᴄʀɪᴀᴅᴏ ᴘᴏʀ uW33D (ᴅɪsᴄᴏʀᴅ: uW33D#3333 | ᴅɪsᴄᴏʀᴅ ɪᴅ: 297122391580999692) ]
sᴛᴀᴛᴜs ᴅᴏ ᴀɴᴛɪᴄʜᴇᴀᴛ:  https://stats.uptimerobot.com/R0A6VFnrE2
ᴏʙs: ғᴜɴᴄ̧ᴏ̃ᴇs ᴇᴍ ʙᴇᴛᴀ ɴᴀ̃ᴏ ᴇsᴛᴀ̃ᴏ ᴀ 100%, ᴘᴏʀ ɪssᴏ ᴛᴇᴍ ᴄᴀsᴏ ǫᴜᴇ ᴘᴏᴅᴇ ᴅᴀʀ ʙᴀɴ ᴇʀʀᴀᴅᴏ, ᴏᴜ ɴᴀ̃ᴏ ғᴜɴᴄɪᴏɴᴀʀ ᴅɪʀᴇɪᴛᴏ
ᴄᴏᴍᴀɴᴅᴏs: /ᴜɴʙᴀɴᴀʟʟ, /ᴄᴏᴍᴀɴᴅᴏs [ɴᴏᴍᴇᴅᴏᴍᴏᴅ], /ᴠᴇʀᴘᴀᴛʜ [ɴᴏᴍᴇᴅᴏᴍᴏᴅ], /ᴡᴀʟʟ, /acss [ID], /ᴀᴄɪ [ID] (esse comando faz que o jogador esteja ignorado no binds)

Video de como configurar o anticheat: https://youtu.be/XuNNihYl7KE
Repositório do anticheat: https://github.com/ruip005/mta_anticheat

]]

auth = { 
	user = "trial01", -- Nome de usuario fornecido
	key = "f8e2a1388546f9313ad7ac965a4e5990061b2d2dfd4a0e5f9b635799986fdd85" -- Chave fornecida
}

servidor = {
	sigla = "VRP",
	cor = "#ff66ff",
	acl = "Staff",
	staff = "onProt", -- Element de quando está de /staff ou /pro
	admin = "Admin", -- ACL GROUP para usar funções mais restritas
	id = "ID", -- Element de ID
	discord = "discord.gg/seuservidor", -- Discord da cidade
	language = "pt", --pt, en, es, tr, de
}

discord = { --Logs, coloque link do webhook
	aimbot = "https://discord.com/api/webhooks/XXXXXX", -- Log de suspeita de aimbot
	resourcestop = "https://discord.com/api/webhooks/XXXXXX", -- Log  ban de resource stopper
	vbrveh = "https://discord.com/api/webhooks/XXXXXX", -- Log ban de vehicle spawn com vbr cheats
	killweapon = "https://discord.com/api/webhooks/XXXXXX", -- Log ban de matar com armas blacklist
	shottank = "https://discord.com/api/webhooks/XXXXXX", -- Log ban de atirar com tanque (se tiver ativado)
	rpgvbr = "https://discord.com/api/webhooks/XXXXXX", -- Log ban de atirar com rpg que normalmente é spawn pelo vbr cheat
	flywarn = "https://discord.com/api/webhooks/XXXXXX", -- Log de aviso de suspeita de fly
	flyban = "https://discord.com/api/webhooks/XXXXXX", -- Log de ban de fly
	jetpack = "https://discord.com/api/webhooks/XXXXXX", --Log de ban de usar jetpack
	speed = "https://discord.com/api/webhooks/XXXXXX", -- Log de ban por speed hack
	vehicleblacklist = "https://discord.com/api/webhooks/XXXXXX", -- Log de ban por veiculos em lista negra (ac.veiculos)
	weaponblacklist = "https://discord.com/api/webhooks/XXXXXX", -- Log de ban por armas em lista negra (ac.armas)
	comandos = "https://discord.com/api/webhooks/XXXXXX", -- Log de comandos em resources suspeitos (retorna todos os comandos de X mod)
	binds = "https://discord.com/api/webhooks/XXXXXX", -- Log de suspeita de abrir/fechar menu
	logprotect = "https://discord.com/api/webhooks/XXXXXX", -- Log de serial não permitido entrou numa conta staff
	banimentos = "https://discord.com/api/webhooks/XXXXXX", -- Logs dos bans
	unbans = "https://discord.com/api/webhooks/XXXXXX", -- Logs dos unbans
	gbans = "https://discord.com/api/webhooks/XXXXXX", --Logs dos gbans aplicados
	updatesAC = "https://discord.com/api/webhooks/XXXXXX", -- Webhook para receber novidades do anticheat
	invisibleGun = "https://discord.com/api/webhooks/XXXXXX", -- Webhook de suspeita de arma invisivel
	fireRate = "https://discord.com/api/webhooks/XXXXXX", -- Webhook de suspeita de atirar rapido d+
	puxarcarro = "https://discord.com/api/webhooks/XXXXXX", -- Webhook de suspeita de puxar carro
	elementdata = "https://discord.com/api/webhooks/XXXXXX", --Webhook de suspeita de modificar elementos
	luaexecutor = "https://discord.com/api/webhooks/XXXXXX", --Webhook de suspeita de códigos lua
	cmdblocks = "https://discord.com/api/webhooks/XXXXXX", --Webhook de uso de comandos bloqueados
	config = {
		color = "10181046",
		avatar = "https://avatars.githubusercontent.com/u/46203319?v=4",
		name = "Seu servidor" or servidor.sigla,
		message = "",
		embed = true,
		resolutionX = 800, --Photo resolution X --320, 640, 960, 1280 !!!! I recommend leaving resolutions low like 640 or 800
		resolutionY = 600, --Photo resolution Y --240, 480, 480, 720	!!!! I recommend leaving resolutions low like 480 or 600
		quality = 22, -- Photo quality -- 5, 10, 15, 20, 25, 30, 35, 40 !!!! I recommend leaving quality low like 15 or 20
		-- !!!!Se a print não enviar para o discord reduza os valores | If the print doesn't send to discord, reduce the values!!!!
	},
}

ac = {
	armas = { -- armas blacklist
		--ID, detect, nome da arma (inventa)
		{34, true, "AWP"},
		{35, true, "RPG"},
		{36, true, "C100 RL"},
		{37, true, "Lança-chamas"},
		{38, true, "Minigun"},
	},
	veiculos = { -- veiculos blacklist
		--ID, detect
    [592] = true,
    [577] = true,
    [432] = true,
    [425] = true,
	},
	wall = {
		distancia = 350, -- Distancia max
		soid = false, -- aparecer só o ID
	},
	fly = {
		pr = 3, --aviso
		se = 5, --aviso
		te = 9999, --ban
	},
	binds = { --binds para cair no anticheat (toda a vez que o jogador clica em X tecla)
		--https://wiki.multitheftauto.com/wiki/Key_names
		{"insert", true},
		{"delete", true},
		{"end", true},
	},
	elementdata = {
		"moneycoins",
		"coins",
		--"anotherone",
	},
	cmdblock = {
		"modmenu",
		"lua",
		"painellua",
		"painelluas",
		"holy",
		"alemaozinho",
		"alemaozinhomoney",
	},
	bans = { -- true ou false | Estados das funcionalidades
		armas = true, -- banir quem usar armas blacklist
		veiculos = true, -- banir quem entrar em veiculos blacklist (mesmo desativado a função de detectar veiculos puxados pelo vbr estara ativa ex:. puxar hydra)
		invisibleGun = true, -- banir quem usar arma invisivel
		puxarcarro = true, -- banir quem puxar veiculos fora da lista de spawnVehicles
		jetpack = true, -- banir quem usar jetpack
		falsevehicles = true, -- banir suspeitos de puxar carro por vbr
		elementdata = true, --banir suspeitos de alteração do elementdata
	},
}

outros = {
	tela = true, -- Tirar print da tela do jogador suspeito e aparecer na tela dos Staffs 
	antiss = true, -- Deixa apenas entrar no servidor gente com partilha de tela ativa (Se tiver outro mod de captura de tela desative essa opção por exemplo o meu AntiSS)
	verifyss = false, -- A cada 5mins o anticheat verifica se o jogador desativou o envio de captura de tela
	protect = false, -- Deixa apenas entrar na conta de Staff quem tiver na lista Staffs abaixo
	cooldown = 10, -- Tempo de música do ban até dar ban (1 == 1 segundo) [deixe sempre algum valor caso queira receber foto]
	musica = "https://www.myinstants.com/media/sounds/welcome-to-the-mato.mp3", -- Musica antes do ban
	bandono = true, --banir quem tentar banir os staffs com cargo de servidor.admin (ex.: Admin) [false irá apenas nao deixar o jogador ser banido]
	antivpn = { -- AntiVPN System
		ativado = false, -- quando ativo detecta se o jogador esta ligado a uma vpn se estiver dá kick
		apikey = "9uVA2lVd1iplBNAJZ46tafdehM2pgsDJ", -- se estiver ativo coloque sua key da api https://www.ipqualityscore.com/documentation/proxy-detection/overview [Proxy & VPN Detection API]
		banvpn = false, -- true = bane por 1 minuto, false dá kick
		bantime = 5, -- tempo do banimento
	},
	update = true, -- receber atualizações do anticheat » Pasta Updates se tiver uma versão recente faça a troca de versões. [Quando está desativado a nova atualização não é baixada automaticamente]
	chat = true, -- aparece mensagem no chat quando dá start no anticheat
	globalban = true, --[[
	Sistema de banimento global o que é?
	Este sistema faz sincronização com outros servidores e guarda o ban aplicado por o mesmo anticheat no servidor1 e se o jogador xitado tentar se conectar
	ao servidor2 não irá conseguir pois o Serial e IP do mesmo está numa lista negra do anticheat. 
	]]
	globalsaves = false, -- Quando desativado os bans são analisados em tempo real com consulta SQL; Quando ativado quando da start no anticheat todos os bans são guardados numa lista, porem novos registos de gbans só serão adicionados com restart no anticheat
	saveprints = true, --salvar todas as prints do seu servidor, Banimentos e Suspeitos.
	velocidademax = 800, -- velocidade maxima permitida (nao deixe menos de 400)
	turnoffrealtimequerygban = false, -- desligar a verificação se a cada entrada o jogador está no gbans | true » desabilita o sistema [se o seu servidor cair deixe esta opção como true]
	screenshareban = 0, --0 is perma ban
}

staffs = {  -- Apenas colocar serial se outros » protect estiver true (Pegar seu serial dê f8 e digite serial)
	-- caso não tiver deixe padrão como está ou comente/delete "Serial",
	"Serial", -- Serial do staff 
	"Serial", -- Serial do staff 
	"Serial", -- Serial do staff 
}

antibanjogadores = { -- Colocar serials que não podem ser banidos (Pegar seu serial dê f8 e digite serial)
	-- caso não tiver deixe padrão como está ou comente/delete ["Serial"] = true,
	["Serial"] = true, -- Serial do staff 
	["Serial"] = true, -- Serial do staff 
	["Serial"] = true, -- Serial do staff 
}

--[[
		SE SEU SERVIDOR COMEÇAR DAR MUITO TIMEOUT DEIXE O GLOBALSAVES TRUE OU DESLIGUE O ANTIVPN, MAS PARA NÃO FAZER CAGADA CONTACTE O CRIADOR OU SIGA AS NOTAS DO GITHUB https://github.com/ruip005/mta_anticheat/releases
		VIDEO DE COMO CONFIGURAR A ANTIVPN https://www.youtube.com/watch?v=XuNNihYl7KE
		ERROS NO ANTICHEAT CONTACTE O CRIADOR PELO DISCORD OU ABRA UMA ISSUE NO GITHUB
		DÚVIDAS? CHAME!
]]

--[[
	TÜRKÇE Mİ? NEYSE KI ANTICHEAT'IMIZ TÜRK FREEROAM/DEATHMATCH SUNUCULARINI DESTEKLIYOR, DISCORD'DAN BANA ULAŞIN!
	HATA MI VERIYOR? BENİMLE İLETİŞİME GEÇİN
]]

language = {
	['pt'] = {
		--Admin
		['search'] = "Procurando...",
		['error404'] = "Erro ao conectar ao banco de dados! Verifique aqui o estado do Anticheat: https://stats.uptimerobot.com/R0A6VFnrE2",
		['notallowed'] = "Este resource não está autorizado para este servidor/usuário.",
		['expired'] = "A sua key do Anticheat [${r}] expirou ou não é mais válida, contate uW33D#3333 no discord!",
		['errorcodeonline'] = "Erro ao executar o código: ",
		['errordownloadcode'] = "Não foi possível baixar o código online.",
		['requesterror'] = "Contacte uW33D#3333 Erro ao fazer a requisição: ",
		['errorapiupdate'] = "Anticheat: Não é possível obter 'api.github.com' para novas versões!",
		['newversionalreadydown'] = "Nova versão disponível no Github! Já está descarregado no diretório 'Updates' dentro do anticheat, basta substituir o antigo!",
		['errorupdatingnewv'] = "Não é possível descarregar a versão mais recente do Github!",
		--Resources
		['startchat'] = "#ffffffAntiCheat v ${arg} ligado (criado por uW33D#3333)",
		['startnotify'] = "AntiCheat v ${arg} ligado (criado por uW33D#3333)",
		['gbanalready'] = "já se encontra na lista de GBans!",
		['gbantotalbans'] = "Foram importados ${arg} banimentos globais.",
		['gbannobans'] = "Não foram registrados banimentos globais :D",
		['rootchatbans'] = "#ffffffO jogador "..servidor.cor.."${nome} [${id}] #fffffffoi banido por uso de trapaças!",
		['notifythinkcheater'] = "O anticheat baniu um possível cheater",
		['nostaffmode'] = "Você não está no modo staff!",
		['staffwall'] = "Você ativou o wall!",
		['gbanchat'] = "#ffffffO jogador "..servidor.cor.."${getname} [${id}] #fffffffoi banido pelo Gbans do Anticheat!",
		['gbannotify'] = "O jogador ${nome} [${id}] foi banido pelo GBANS",
		['nogbanplayer'] = "O jogador ${nome} não está na lista de banimentos globais :D",
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
		['nopermission'] = "[AC] Você não possui permissão para executar esse comando!",
		['verifyinfos'] = "[AC] Verificando informações...",
		['allbansrevoke'] = "[AC] Todos os banimentos foram retirados!",
		['nobanstorevoke'] = "[AC] Nenhum banimento registrado!",
		['playerusingvpn'] = "O jogador ${getname} está usando VPN.", 
		['ipaddedtojoin'] = "[AC] O IP: ${id} foi adicionado ao banco de dados.", 
		['ipnotvalid'] = "[AC] Esse IP não é válido",
		['ipsyntax'] = "[AC] Use /acip XXX.XXX.XXX.XXX (IP)",
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
		['flyban'] = "```O jogador ${nome} [${id}] foi banido por uso de trapaças! [".." Fly hack ".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here", 
		['flywarn'] = "```[WARN] O jogador ${nome} [${id}] foi detectado que poderá estar usando cheats, confirme no spectate ou screenshot! [".." Fly hack ".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```",
		['flylastwarn'] = "```[WARN] O jogador ${nome} [${id}] possivelmente está usando trapaças! [".." Fly hack ".."]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```",
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
		['blackcmdsD'] = "```O jogador ${nome} foi banido por uso de trapaças! [Blacklist Command: ${cmd}]\nIP: ${ip} | Serial: ${serial} | Conta: ${conta}```@here",
		--Cmds
		['pathC'] = "Localização: ",
		['cmdsC'] = "Comandos de ${resourcename}: ",
		--Bans
		['weaponblacklistB'] = "Arma blacklist detectado",
		['vehicleblacklistB'] = "Veiculo blacklist detectado",
		['speedB'] = "Limitador de velocidade detectado",
		['jetpackB'] = "Jetpack hack detectado",
		['fly'] = "Fly hack detectado",
		['rpgvbrB'] = "RPG detectado.",
		['tankammoshotB'] = "Tank detectado.",
		['weaponkillB'] = "Disparo c/ arma blacklist detectada",
		['spawnvbrB'] = "Vehicle mod menu spawn",
		['resourcestopB'] = "Resource Stopper detectado!",
		['joinstaffaccB'] = "Você conectou-se numa conta da staff mas seu serial não é permitido", --Kick
		['gbanB'] = "Banimento global do Anticheat",
		['antibanfounderB'] = "Você tentou banir alguém importante!",
		['invisibleweaponB'] = "Arma invisível detectada",
		['firerateB'] = "Fire Rate modificado detectado",
		['getcarB'] = "Puxar carro detectado",
		['elementB'] = "Elemento modificado ilegalmente",
		['luaB'] = "Lua executor detectado",
		['blackcmdsB'] = "Comando bloqueado",
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
	['en'] = {
		-- Admin
		['search'] = "Searching...",
		['error404'] = "Error connecting to the database! Check the Anticheat status here: https://stats.uptimerobot.com/R0A6VFnrE2",
		['notallowed'] = "This resource is not authorized for this server/user.",
		['expired'] = "Your Anticheat key [${r}] has expired or is no longer valid, contact uW33D#3333 on Discord!",
		['errorcodeonline'] = "Error executing the code: ",
		['errordownloadcode'] = "Failed to download the code online.",
		['requesterror'] = "Contact uW33D#3333 Error making the request: ",
		['errorapiupdate'] = "Anticheat: Unable to fetch 'api.github.com' for new versions!",
		['newversionalreadydown'] = "New version available on Github! Already downloaded in the 'Updates' directory within the anticheat, just replace the old one!",
		['errorupdatingnewv'] = "Unable to download the latest version from Github!",
		-- Resources
		['startchat'] = "#ffffffAntiCheat v ${arg} enabled (created by uW33D#3333)",
		['startnotify'] = "AntiCheat v ${arg} enabled (created by uW33D#3333)",
		['gbanalready'] = "is already on the GBans list!",
		['gbantotalbans'] = "${arg} global bans have been imported.",
		['gbannobans'] = "No global bans registered :D",
		['rootchatbans'] = "#ffffffThe player "..servidor.cor.."${nome} [${id}] #ffffffhas been banned for cheating!",
		['notifythinkcheater'] = "The anticheat banned a possible cheater",
		['nostaffmode'] = "You are not in staff mode!",
		['staffwall'] = "You activated the wall!",
		['gbanchat'] = "#ffffffThe player "..servidor.cor.."${getname} [${id}] #ffffffhas been banned by Anticheat's Gbans!",
		['gbannotify'] = "Player ${nome} [${id}] has been banned by GBANS",
		['nogbanplayer'] = "Player ${nome} is not on the global ban list :D",
		['vpnapi'] = "VPN detected for server access.",
		['vpnsql'] = "Your IP address is not allowed to connect to the server due to VPN usage.",
		-- Others
		['screenoffkick'] = "Enable the option to allow screenshot submission",
		['screenoffban'] = "Enable the option to allow screenshot submission",
		['screenof'] = "Screen of:",
		['thinkcheater'] = "${nome} [${id}] is probably using cheats!",
		['noinfo'] = "No information",
		['antibanwarn'] = "You cannot ban this player",
		['syntaxaci'] = "Use /aci [ID]",
		['playeroff'] = "This player is not online",
		['playeralreadyignore'] = "This player is already in the ignored players list",
		['playeraddedtoaci'] = "The player has been added to the ignored players list",
		['acistaff'] = "Staff ${getname} added ID: ${id} to the ignored players!", 
		['nopermission'] = "[AC] You do not have permission to execute this command!",
		['verifyinfos'] = "[AC] Verifying information...",
		['allbansrevoke'] = "[AC] All bans have been revoked!",
		['nobanstorevoke'] = "[AC] No bans registered!",
		['playerusingvpn'] = "Player ${getname} is using VPN.", 
		['ipaddedtojoin'] = "[AC] IP: ${id} has been added to the database.", 
		['ipnotvalid'] = "[AC] This IP is not valid",
		['ipsyntax'] = "[AC] Use /acip XXX.XXX.XXX.XXX (IP)",
		['successScreenshot'] = "Screenshot taken, please wait...",
		-- Folders
		['suspects'] = "Suspects",
		['bans'] = "Bans",
		['updates'] = "Updates",
		-- Discord
		['bindsD'] = "Player ${nome} [${id}] pressed keys for a possible mod menu! [".."Binds".."]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```",
		['pathD'] = "```Request made by: ${getname} [${getelementid}]\n${resourcename} is located in the folder: ${resourcepath}```",
		['cmdsD'] = "```Request made by: ${getname} [${getelementid}]\n".."Commands for ${resourcename}```", 
		['weaponblacklistD'] = "```Player ${nome} [${id}] has been banned for cheating! [${arma}]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```@here", 
		['vehicleblacklistD'] = "```Player ${nome} [${id}] has been banned for cheating! [".."Blacklist Vehicle".."]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```@here", 
		['speedD'] = "```Player ${nome} [${id}] has been banned for cheating! [Speed limiter]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```@here", 
		['jetpackD'] = "```Player ${nome} [${id}] has been banned for cheating! [".." Jetpack hack ".."]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```@here", 
		['flyban'] = "```Player ${nome} [${id}] has been banned for cheating! [".." Fly hack ".."]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```@here", 
		['flywarn'] = "```[WARN] Player ${nome} [${id}] has been detected possibly using cheats, confirm in spectate or screenshot! [".." Fly hack ".."]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```",
		['flylastwarn'] = "```[WARN] Player ${nome} [${id}] is possibly using cheats! [".." Fly hack ".."]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```",
		['rpgvbrD'] = "```Player ${nome} [${id}] has been banned for cheating! [".."RPG Mod Menu".."]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```@here",
		['tankammoshotD'] = "```Player ${nome} [${id}] has been banned for cheating! [".."Tank Mod Menu".."]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```@here",
		['weaponkillD'] = "```Player ${nome} [${id}] has been banned for cheating! [".."killing with weapon blacklist".."]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```@here",
		['spawnvbrD'] = "```Player ${nome} [${id}] has been banned for cheating! [".."Vehicle blacklist client".."]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```@here",
		['resourcestopD'] = "```Player ${nome} [${id}] has been kicked! [".."Resource Stopper".."]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```@here",
		['aimbotD'] = "```Player ${nome} [${id}] is moving the aim too fast! [".."Aimbot".."]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```",
		['joinstaffaccD'] = "```Someone is trying to authenticate in the Staff account: ${getaccPacc} | Nick: ${getname} | IP: ${ip} | SERIAL: ${serial}```",
		['banlogsD'] = "```Staff ${snome} [${sid}] banned player ${nome} [${id}]\nIP: ${ip} | Serial: ${serial}```", 
		['unbanlogsD'] = "```Staff ${snome} [${sid}] unbanned IP: ${ip} | Serial: ${serial}```",
		['invisibleweaponD'] = "```Player ${nome} [${id}] has been banned for cheating! [Invisible weapon]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```@here",
		['firerateD'] = "```Player ${nome} [${id}] has been banned for cheating! [Fire Rate]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```@here",
		['updateD'] = "```diff\n+ New version of Anticheat downloaded!\n+ Don't forget to perform the update!\n```",
		['getcarD'] = "```Player ${nome} [${id}] has been banned for cheating! [Pulling Car]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```@here",
		['gbanD'] = "```Player ${nome} has been banned by Anticheat's GBans!\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```@here",
		['elementD'] = "```Player ${nome} [${id}] has been banned for cheating! [Element Data]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}```@here",
		['luaD'] = "```Player ${nome} has been banned for cheating! [Lua Executor]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}``@here",
		['blackcmdsD'] = "```Player ${nome} has been banned for cheating! [Blacklist Command: ${cmd}]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}``@here",
		-- Commands
		['pathC'] = "Location: ",
		['cmdsC'] = "${resourcename} commands: ",
		-- Bans
		['weaponblacklistB'] = "Weapon blacklist detected",
		['vehicleblacklistB'] = "Vehicle blacklist detected",
		['speedB'] = "Speed limiter detected",
		['jetpackB'] = "Jetpack hack detected",
		['fly'] = "Fly hack detected",
		['rpgvbrB'] = "RPG detected.",
		['tankammoshotB'] = "Tank detected.",
		['weaponkillB'] = "Killing with weapon blacklist detected",
		['spawnvbrB'] = "Vehicle mod menu spawn",
		['resourcestopB'] = "Resource Stopper detected!",
		['joinstaffaccB'] = "You logged into a staff account but your serial is not allowed", -- Kick
		['gbanB'] = "Anticheat global ban",
		['antibanfounderB'] = "You tried to ban someone important!",
		['invisibleweaponB'] = "Invisible weapon detected",
		['firerateB'] = "Modified Fire Rate detected",
		['getcarB'] = "Pulling car detected",
		['elementB'] = "Illegally modified element",
		['luaB'] = "Lua executor detected",
		['blackcmdsB'] = "Command blocked",
		-- Screenshot
		['sharingscreen'] = "You're being screened.",
		['time'] = "Time: ",
		['warningnoquit'] = "Don't leave the server, otherwise you'll be banned.",
		['leavessC'] = "You've been removed from the screenshare!",
		['leavessS'] = "You've successfully removed the player in the screenshot!",
		['tpssC'] = "You've been moved to screenshare!",
		['tpssS'] = "You've successfully placed the player in the screenshot!",
		['banmsgss'] = "It disconnected during the screenshot!",
		},
	['es'] = {
		-- Admin
		['search'] = "Buscando...",
		['error404'] = "¡Error al conectar con la base de datos! Verifique el estado de Anticheat aquí: https://stats.uptimerobot.com/R0A6VFnrE2",
		['notallowed'] = "Este recurso no está autorizado para este servidor/usuario.",
		['expired'] = "Tu clave de Anticheat [${r}] ha caducado o ya no es válida, ¡contacta a uW33D#3333 en Discord!",
		['errorcodeonline'] = "Error al ejecutar el código: ",
		['errordownloadcode'] = "No se pudo descargar el código en línea.",
		['requesterror'] = "Contacta a uW33D#3333 Error al hacer la solicitud: ",
		['errorapiupdate'] = "Anticheat: No se puede obtener 'api.github.com' para nuevas versiones.",
		['newversionalreadydown'] = "¡Nueva versión disponible en Github! Ya ha sido descargada en el directorio 'Updates' dentro del anticheat, ¡solo reemplaza la antigua!",
		['errorupdatingnewv'] = "No se puede descargar la última versión de Github.",
		-- Recursos
		['startchat'] = "#ffffffAntiCheat v ${arg} habilitado (creado por uW33D#3333)",
		['startnotify'] = "AntiCheat v ${arg} habilitado (creado por uW33D#3333)",
		['gbanalready'] = "ya está en la lista de GBans.",
		['gbantotalbans'] = "Se han importado ${arg} baneos globales.",
		['gbannobans'] = "¡No se registraron baneos globales! :D",
		['rootchatbans'] = "#ffffffEl jugador "..servidor.cor.."${nome} [${id}] #ffffffha sido baneado por hacer trampas.",
		['notifythinkcheater'] = "El anticheat ha baneado a un posible tramposo.",
		['nostaffmode'] = "¡No estás en modo de staff!",
		['staffwall'] = "¡Has activado la pared!",
		['gbanchat'] = "#ffffffEl jugador "..servidor.cor.."${getname} [${id}] #ffffffha sido baneado por los GBans de Anticheat.",
		['gbannotify'] = "El jugador ${nome} [${id}] ha sido baneado por GBANS.",
		['nogbanplayer'] = "El jugador ${nome} no está en la lista de baneos globales :D",
		['vpnapi'] = "Se ha detectado el uso de una VPN para acceder al servidor.",
		['vpnsql'] = "Tu dirección IP no está permitida para conectarse al servidor debido al uso de VPN.",
		-- Otros
		['screenoffkick'] = "Habilita la opción para permitir el envío de capturas de pantalla.",
		['screenoffban'] = "Habilita la opción para permitir el envío de capturas de pantalla.",
		['screenof'] = "Pantalla de:",
		['thinkcheater'] = "${nome} [${id}] probablemente está usando trampas.",
		['noinfo'] = "Sin información",
		['antibanwarn'] = "No puedes banear a este jugador",
		['syntaxaci'] = "Usa /aci [ID]",
		['playeroff'] = "Este jugador no está en línea",
		['playeralreadyignore'] = "Este jugador ya está en la lista de jugadores ignorados",
		['playeraddedtoaci'] = "El jugador ha sido añadido a la lista de jugadores ignorados",
		['acistaff'] = "El staff ${getname} añadió el ID: ${id} a los jugadores ignorados.",
		['nopermission'] = "[AC] No tienes permiso para ejecutar este comando.",
		['verifyinfos'] = "[AC] Verificando información...",
		['allbansrevoke'] = "[AC] ¡Todos los baneos han sido revocados!",
		['nobanstorevoke'] = "[AC] ¡No hay baneos registrados!",
		['playerusingvpn'] = "El jugador ${getname} está usando una VPN.",
		['ipaddedtojoin'] = "[AC] La IP: ${id} ha sido añadida a la base de datos.",
		['ipnotvalid'] = "[AC] Esta IP no es válida",
		['ipsyntax'] = "[AC] Usa /acip XXX.XXX.XXX.XXX (IP)",
		['successScreenshot'] = "Captura de pantalla tomada, por favor espera...",
		-- Carpetas
		['suspects'] = "Sospechosos",
		['bans'] = "Baneos",
		['updates'] = "Actualizaciones",
		-- Discord
		['bindsD'] = "El jugador ${nome} [${id}] ha presionado teclas para un posible menú de modificación! [".."Binds".."]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```",
		['pathD'] = "```Solicitud realizada por: ${getname} [${getelementid}]\n${resourcename} se encuentra en la carpeta: ${resourcepath}```",
		['cmdsD'] = "```Solicitud realizada por: ${getname} [${getelementid}]\n".."Comandos para ${resourcename}```",
		['weaponblacklistD'] = "```El jugador ${nome} [${id}] ha sido baneado por hacer trampas! [${arma}]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```@here",
		['vehicleblacklistD'] = "```El jugador ${nome} [${id}] ha sido baneado por hacer trampas! [".."Vehículo en lista negra".."]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```@here",
		['speedD'] = "```El jugador ${nome} [${id}] ha sido baneado por hacer trampas! [Limitador de velocidad]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```@here",
		['jetpackD'] = "```El jugador ${nome} [${id}] ha sido baneado por hacer trampas! [".." Hack de jetpack ".."]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```@here",
		['flyban'] = "```El jugador ${nome} [${id}] ha sido baneado por hacer trampas! [".." Hack de vuelo ".."]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```@here",
		['flywarn'] = "```[ADVERTENCIA] Se ha detectado que el jugador ${nome} [${id}] posiblemente está usando trampas, confirma en espectador o captura de pantalla! [".." Hack de vuelo ".."]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```",
		['flylastwarn'] = "```[ADVERTENCIA] El jugador ${nome} [${id}] posiblemente está usando trampas! [".." Hack de vuelo ".."]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```",
		['rpgvbrD'] = "```El jugador ${nome} [${id}] ha sido baneado por hacer trampas! [".." Modo menú RPG ".."]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```@here",
		['tankammoshotD'] = "```El jugador ${nome} [${id}] ha sido baneado por hacer trampas! [".." Modo menú de tanque ".."]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```@here",
		['weaponkillD'] = "```El jugador ${nome} [${id}] ha sido baneado por hacer trampas! [".." Matar con arma en lista negra ".."]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```@here",
		['spawnvbrD'] = "```El jugador ${nome} [${id}] ha sido baneado por hacer trampas! [".." Spawn de menú de vehículo ".."]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```@here",
		['resourcestopD'] = "```El jugador ${nome} [${id}] ha sido expulsado! [".."Detener recurso".."]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```@here",
		['aimbotD'] = "```El jugador ${nome} [${id}] está moviendo la mira demasiado rápido! [".."Aimbot".."]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```",
		['joinstaffaccD'] = "```Alguien está intentando autenticarse en la cuenta del staff: ${getaccPacc} | Nick: ${getname} | IP: ${ip} | SERIE: ${serial}```",
		['banlogsD'] = "```El Staff ${snome} [${sid}] ha baneado al jugador ${nome} [${id}]\nIP: ${ip} | Serie: ${serial}```",
		['unbanlogsD'] = "```El Staff ${snome} [${sid}] ha desbaneado la IP: ${ip} | Serie: ${serial}```",
		['invisibleweaponD'] = "```El jugador ${nome} [${id}] ha sido baneado por hacer trampas! [Arma invisible]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```@here",
		['firerateD'] = "```El jugador ${nome} [${id}] ha sido baneado por hacer trampas! [Fire Rate]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```@here",
		['updateD'] = "```diff\n+ ¡Nueva versión de Anticheat descargada!\n+ No olvides actualizar!\n```",
		['getcarD'] = "```El jugador ${nome} [${id}] ha sido baneado por hacer trampas! [Tirar de coche]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```@here",
		['gbanD'] = "```El jugador ${nome} ha sido baneado por los GBans de Anticheat!\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```@here",
		['elementD'] = "```El jugador ${nome} [${id}] ha sido expulsado por hacer trampas. [Datos del elemento]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}```@here",
		['luaD'] = "``¡El jugador ${nome} ha sido expulsado por hacer trampas! [Ejecutor Lua]\nIP: ${ip} | Serial: ${serial} | Cuenta: ${conta}``@aquí",
		['blackcmdsD'] = "``¡El jugador ${nome} ha sido expulsado por hacer trampas! [Comando de la lista negra: ${cmd}]\nIP: ${ip} | Serie: ${serial} | Cuenta: ${conta}``@aquí",
		-- Comandos
		['pathC'] = "Ubicación: ",
		['cmdsC'] = "Comandos de ${resourcename}: ",
		-- Baneos
		['weaponblacklistB'] = "Lista negra de armas detectada",
		['vehicleblacklistB'] = "Lista negra de vehículos detectada",
		['speedB'] = "Limitador de velocidad detectado",
		['jetpackB'] = "Hack de jetpack detectado",
		['fly'] = "Hack de vuelo detectado",
		['rpgvbrB'] = "RPG detectado.",
		['tankammoshotB'] = "Tanque detectado.",
		['weaponkillB'] = "Asesinato con arma en lista negra detectado",
		['spawnvbrB'] = "Spawn de menú de vehículos",
		['resourcestopB'] = "Detenedor de recursos detectado!",
		['joinstaffaccB'] = "Iniciaste sesión en una cuenta de staff pero tu serie no está permitida", -- Expulsar
		['gbanB'] = "Baneo global de Anticheat",
		['antibanfounderB'] = "Intentaste banear a alguien importante!",
		['invisibleweaponB'] = "Arma invisible detectada",
		['firerateB'] = "Fire Rate modificado detectado",
		['getcarB'] = "Tirar de coche detectado",
		['elementB'] = "Elemento modificado ilegalmente",
		['luaB'] = "Ejecutor Lua detectado",
		['blackcmdsB'] = "Comando bloqueado",
		-- Captura de pantalla
		['sharingscreen'] = "Estás siendo supervisado.",
		['time'] = "Tiempo: ",
		['warningnoquit'] = "No abandones el servidor, de lo contrario serás baneado.",
		['leavessC'] = "Has sido eliminado de la captura de pantalla.",
		['leavessS'] = "Has eliminado con éxito al jugador de la captura de pantalla.",
		['tpssC'] = "Has sido trasladado a la captura de pantalla.",
		['tpssS'] = "Has colocado con éxito al jugador en la captura de pantalla.",
		['banmsgss'] = "Se desconectó durante la captura de pantalla.",
		},
	['tr'] = {
		-- Admin
		['search'] = "Aranıyor...",
		['error404'] = "Veritabanına bağlanırken hata oluştu! Anticheat'in durumunu buradan kontrol edin: https://stats.uptimerobot.com/R0A6VFnrE2",
		['notallowed'] = "Bu kaynak bu sunucu/kullanıcı için izin verilmiyor.",
		['expired'] = "Anticheat anahtarınız [${r}] süresi doldu veya artık geçerli değil, Discord'da uW33D#3333 ile iletişime geçin!",
		['errorcodeonline'] = "Kodu çalıştırırken hata oluştu: ",
		['errordownloadcode'] = "Çevrimiçi kod indirilemedi.",
		['requesterror'] = "uW33D#3333 ile iletişime geçin İstek yapılırken hata oluştu: ",
		['errorapiupdate'] = "Anticheat: Yeni sürümler için 'api.github.com' alınamıyor!",
		['newversionalreadydown'] = "Github'da yeni bir sürüm mevcut! Zaten anticheat içinde 'Güncellemeler' dizininde indirildi, eski olanı değiştirin!",
		['errorupdatingnewv'] = "Github'dan en son sürümü indiremiyor!",
		-- Kaynaklar
		['startchat'] = "#ffffffAntiCheat v ${arg} etkinleştirildi (uW33D#3333 tarafından oluşturuldu)",
		['startnotify'] = "AntiCheat v ${arg} etkinleştirildi (uW33D#3333 tarafından oluşturuldu)",
		['gbanalready'] = "zaten GBan listesinde!",
		['gbantotalbans'] = "${arg} global yasak içe aktarıldı.",
		['gbannobans'] = "Hiç global yasak kaydedilmedi :D",
		['rootchatbans'] = "#ffffffOyuncu "..servidor.cor.."${nome} [${id}] #ffffffhile kullanımı nedeniyle yasaklandı!",
		['notifythinkcheater'] = "Anticheat olası bir hileciyi yasakladı",
		['nostaffmode'] = "Personel modunda değilsiniz!",
		['staffwall'] = "Duvarı etkinleştirdiniz!",
		['gbanchat'] = "#ffffffOyuncu "..servidor.cor.."${getname} [${id}] #ffffffAnticheat'in GBan'ı tarafından yasaklandı!",
		['gbannotify'] = "Oyuncu ${nome} [${id}] GBAN'la yasaklandı",
		['nogbanplayer'] = "${nome} oyuncusu global yasak listesinde değil :D",
		['vpnapi'] = "Sunucuya VPN ile giriş tespit edildi.",
		['vpnsql'] = "VPN kullanımı nedeniyle IP adresiniz sunucuya bağlanmaya izin verilmiyor.",
		-- Diğerleri
		['screenoffkick'] = "Ekran görüntüsü göndermeye izin ver seçeneğini etkinleştir",
		['screenoffban'] = "Ekran görüntüsü göndermeye izin ver seçeneğini etkinleştir",
		['screenof'] = "Ekranı Kapat:",
		['thinkcheater'] = "${nome} [${id}] muhtemelen hile kullanıyor!",
		['noinfo'] = "Bilgi yok",
		['antibanwarn'] = "Bu oyuncuyu yasaklayamazsınız",
		['syntaxaci'] = "/aci [ID] komutunu kullanın",
		['playeroff'] = "Bu oyuncu çevrimdışı",
		['playeralreadyignore'] = "Bu oyuncu zaten oyuncu yok sayılanlar listesinde",
		['playeraddedtoaci'] = "Oyuncu oyuncu yok sayılanlar listesine eklendi",
		['acistaff'] = "Personel ${getname} ID: ${id} oyuncu yok sayılanlar listesine ekledi!",
		['nopermission'] = "[AC] Bu komutu çalıştırma izniniz yok!",
		['verifyinfos'] = "[AC] Bilgiler doğrulanıyor...",
		['allbansrevoke'] = "[AC] Tüm yasaklar kaldırıldı!",
		['nobanstorevoke'] = "[AC] Kayıtlı yasak yok!",
		['playerusingvpn'] = "${getname} oyuncusu VPN kullanıyor.",
		['ipaddedtojoin'] = "[AC] IP: ${id} veritabanına eklendi.",
		['ipnotvalid'] = "[AC] Bu IP geçerli değil",
		['ipsyntax'] = "[AC] /acip XXX.XXX.XXX.XXX (IP) kullanın",
		['successScreenshot'] = "Ekran görüntüsü alındı, lütfen bekleyin...",
		-- Klasörler
		['suspects'] = "Şüpheliler",
		['bans'] = "Yasaklar",
		['updates'] = "Güncellemeler",
		-- Discord
		['bindsD'] = "Oyuncu ${nome} [${id}] muhtemel bir mod menüsü tuşlarına bastı! [".."Bağlar".."]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```",
		['pathD'] = "```${getname} [${getelementid}] tarafından yapılan talep\n${resourcename} şu dizinde: ${resourcepath}```",
		['cmdsD'] = "```${getname} [${getelementid}] tarafından yapılan talep\n".."${resourcename} için komutlar```",
		['weaponblacklistD'] = "```${nome} [${id}] hile yapma nedeniyle yasaklandı! [${arma}]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['vehicleblacklistD'] = "```${nome} [${id}] hile yapma nedeniyle yasaklandı! [".."Araç Siyah Listesi".."]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['speedD'] = "```${nome} [${id}] hile yapma nedeniyle yasaklandı! [Hız Sınırlayıcı]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['jetpackD'] = "```${nome} [${id}] hile yapma nedeniyle yasaklandı! [".." Jetpack hilesi ".."]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['flyban'] = "```${nome} [${id}] hile yapma nedeniyle yasaklandı! [".." Uçma hilesi ".."]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['flywarn'] = "```${nome} [${id}] muhtemelen hile kullanıyor gibi görünüyor, spectate veya ekran görüntüsünde doğrulayın! [".." Uçma hilesi ".."]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```",
		['flylastwarn'] = "```${nome} [${id}] muhtemelen hile kullanıyor gibi görünüyor! [".." Uçma hilesi ".."]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```",
		['rpgvbrD'] = "```${nome} [${id}] hile yapma nedeniyle yasaklandı! [".."RPG Mod Menü".."]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['tankammoshotD'] = "```${nome} [${id}] hile yapma nedeniyle yasaklandı! [".." Tank Mod Menüsü ".."]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['weaponkillD'] = "```${nome} [${id}] hile yapma nedeniyle yasaklandı! [".." Silah Siyah Listesi İle Öldür ".."]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['spawnvbrD'] = "```${nome} [${id}] hile yapma nedeniyle yasaklandı! [".." Menüden Araç Oluştur ".."]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['resourcestopD'] = "```${nome} [${id}] atıldı! [".."Kaynak Durdurucu".."]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['aimbotD'] = "```${nome} [${id}] nişan alma hızı çok hızlı! [".."Aimbot".."]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```",
		['joinstaffaccD'] = "```Birisi personel hesabına giriş yapmaya çalışıyor: ${getaccPacc} | Kullanıcı adı: ${getname} | IP: ${ip} | SERI: ${serial}```",
		['banlogsD'] = "```Staff ${snome} [${sid}] oyuncu ${nome} [${id}] banladı\nIP: ${ip} | Seri: ${serial}```",
		['unbanlogsD'] = "```Staff ${snome} [${sid}] IP'yi yasaklamayı kaldırdı: ${ip} | Seri: ${serial}```",
		['invisibleweaponD'] = "```${nome} [${id}] hile yapma nedeniyle yasaklandı! [Görünmez Silah]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['firerateD'] = "```${nome} [${id}] hile yapma nedeniyle yasaklandı! [Ateş Oranı]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['updateD'] = "```diff\n+ Anticheat'ın yeni bir sürümü indirildi!\n+ Güncellemeyi unutma!\n```",
		['getcarD'] = "```${nome} [${id}] hile yapma nedeniyle yasaklandı! [Araç Çekme]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['gbanD'] = "```${nome} oyuncusu Anticheat'in GBans tarafından yasaklandı!\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['elementD'] = "```Oyuncu ${nome} [${id}] hile yaptığı için yasaklandı! [Element Data]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['luaD'] = "```Oyuncu ${nome} hile yaptığı için yasaklandı! [Lua Yürütücü]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}`@here",
		['blackcmdsD'] = "```Oyuncu ${nome} hile yaptığı için yasaklandı! [Kara Liste Komutu: ${cmd}]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}`@here",
		-- Komutlar
		['pathC'] = "Konum: ",
		['cmdsC'] = "${resourcename} için Komutlar: ",
		-- Yasaklar
		['weaponblacklistB'] = "Silah siyah listesi algılandı",
		['vehicleblacklistB'] = "Araç siyah listesi algılandı",
		['speedB'] = "Hız sınırlayıcı algılandı",
		['jetpackB'] = "Jetpack hilesi algılandı",
		['fly'] = "Uçma hilesi algılandı",
		['rpgvbrB'] = "RPG algılandı.",
		['tankammoshotB'] = "Tank algılandı.",
		['weaponkillB'] = "Silah siyah listesiyle öldürme algılandı",
		['spawnvbrB'] = "Araç menüsü spawner",
		['resourcestopB'] = "Kaynak durdurucu algılandı!",
		['joinstaffaccB'] = "Personel hesabına giriş yaptınız, ancak seriniz izin verilmiyor", -- Atma
		['gbanB'] = "Anticheat'in GBan'ı",
		['antibanfounderB'] = "Önemli birini yasaklamaya çalıştınız!",
		['invisibleweaponB'] = "Görünmez silah algılandı",
		['firerateB'] = "Ateş hızı değiştirilmiş algılandı",
		['getcarB'] = "Araç çekme algılandı",
		['elementB'] = "Yasadışı olarak değiştirilmiş eleman",
		['luaB'] = "Lua yürütücüsü algılandı",
		['blackcmdsB'] = "Komut engellendi",
		-- Ekran Görüntüsü
		['sharingscreen'] = "Ekran görüntüsü alınıyor.",
		['time'] = "Süre: ",
		['warningnoquit'] = "Sunucuyu terk etmeyin, aksi takdirde yasaklanırsınız.",
		['leavessC'] = "Ekran görüntüsünden çıkarıldınız!",
		['leavessS'] = "Oyuncuyu başarıyla ekran görüntüsünden çıkardınız!",
		['tpssC'] = "Ekran görüntüsüne taşındınız!",
		['tpssS'] = "Oyuncuyu başarıyla ekran görüntüsüne yerleştirdiniz!",
		['banmsgss'] = "Ekran görüntüsü sırasında bağlantı kesildi!",
		},
	['de'] = {
		-- Admin
		['search'] = "Suche...",
		['error404'] = "Fehler beim Verbinden mit der Datenbank! Überprüfen Sie hier den Status des Anticheat: https://stats.uptimerobot.com/R0A6VFnrE2",
		['notallowed'] = "Diese Ressource ist nicht für diesen Server/Benutzer zugelassen.",
		['expired'] = "Ihr Anticheat-Schlüssel [${r}] ist abgelaufen oder ungültig geworden. Kontaktieren Sie uW33D#3333 auf Discord!",
		['errorcodeonline'] = "Fehler beim Ausführen des Codes: ",
		['errordownloadcode'] = "Der Online-Code konnte nicht heruntergeladen werden.",
		['requesterror'] = "Kontaktieren Sie uW33D#3333 Fehler bei der Anfrage: ",
		['errorapiupdate'] = "Anticheat: 'api.github.com' kann nicht für neue Versionen abgerufen werden!",
		['newversionalreadydown'] = "Neue Version auf Github verfügbar! Es wurde bereits im Verzeichnis 'Updates' im Anticheat heruntergeladen, ersetzen Sie einfach die alte Version!",
		['errorupdatingnewv'] = "Die neueste Version von Github kann nicht heruntergeladen werden!",
		-- Ressourcen
		['startchat'] = "#ffffffAntiCheat v ${arg} aktiviert (von uW33D#3333 erstellt)",
		['startnotify'] = "AntiCheat v ${arg} aktiviert (von uW33D#3333 erstellt)",
		['gbanalready'] = "befindet sich bereits in der GBan-Liste!",
		['gbantotalbans'] = "${arg} globale Verbote wurden importiert.",
		['gbannobans'] = "Es wurden keine globalen Verbote erfasst :D",
		['rootchatbans'] = "#ffffffDer Spieler "..servidor.cor.."${nome} [${id}] #ffffffwurde wegen Cheat-Benutzung gesperrt!",
		['notifythinkcheater'] = "Der Anticheat hat einen möglichen Cheater gesperrt",
		['nostaffmode'] = "Sie befinden sich nicht im Staff-Modus!",
		['staffwall'] = "Sie haben die Wand aktiviert!",
		['gbanchat'] = "#ffffffDer Spieler "..servidor.cor.."${getname} [${id}] #ffffffwurde von Anticheat GBans gesperrt!",
		['gbannotify'] = "Der Spieler ${nome} [${id}] wurde von GBANS gesperrt",
		['nogbanplayer'] = "${nome} befindet sich nicht in der globalen Sperrliste :D",
		['vpnapi'] = "Eintritt in den Server mit VPN wurde erkannt.",
		['vpnsql'] = "Ihre IP-Adresse ist aufgrund der Verwendung von VPN nicht zum Verbinden mit dem Server zugelassen.",
		-- Andere
		['screenoffkick'] = "Aktivieren Sie die Option zum Senden von Bildschirmfotos",
		['screenoffban'] = "Aktivieren Sie die Option zum Senden von Bildschirmfotos",
		['screenof'] = "Bildschirm von:",
		['thinkcheater'] = "${nome} [${id}] verwendet wahrscheinlich Cheats!",
		['noinfo'] = "Keine Informationen",
		['antibanwarn'] = "Sie können diesen Spieler nicht sperren",
		['syntaxaci'] = "Verwenden Sie /aci [ID]",
		['playeroff'] = "Dieser Spieler ist offline",
		['playeralreadyignore'] = "Dieser Spieler befindet sich bereits in der Liste der ignorierten Spieler",
		['playeraddedtoaci'] = "Der Spieler wurde zur Liste der ignorierten Spieler hinzugefügt",
		['acistaff'] = "Der Staff ${getname} hat die ID: ${id} zu den ignorierten Spielern hinzugefügt!",
		['nopermission'] = "[AC] Sie haben keine Berechtigung, diesen Befehl auszuführen!",
		['verifyinfos'] = "[AC] Überprüfen von Informationen...",
		['allbansrevoke'] = "[AC] Alle Verbote wurden aufgehoben!",
		['nobanstorevoke'] = "[AC] Keine registrierten Verbote!",
		['playerusingvpn'] = "Der Spieler ${getname} verwendet VPN.",
		['ipaddedtojoin'] = "[AC] Die IP: ${id} wurde zur Datenbank hinzugefügt.",
		['ipnotvalid'] = "[AC] Diese IP ist ungültig",
		['ipsyntax'] = "[AC] Verwenden Sie /acip XXX.XXX.XXX.XXX (IP)",
		['successScreenshot'] = "Screenshot gemacht, bitte warten...",
		-- Ordner
		['suspects'] = "Verdächtige",
		['bans'] = "Verbote",
		['updates'] = "Updates",
		-- Discord
		['bindsD'] = "Der Spieler ${nome} [${id}] hat wahrscheinlich Mod-Menü-Tasten gedrückt! [".."Binds".."]\nIP: ${ip} | Seriennummer: ${serial} | Konto: ${conta}```",
		['pathD'] = "```Anfrage von: ${getname} [${getelementid}]\n${resourcename} befindet sich im Verzeichnis: ${resourcepath}```",
		['cmdsD'] = "```Anfrage von: ${getname} [${getelementid}]\n".."Befehle von ${resourcename}```",
		['weaponblacklistD'] = "```Der Spieler ${nome} [${id}] wurde wegen Cheat-Benutzung gesperrt! [${arma}]\nIP: ${ip} | Seriennummer: ${serial} | Konto: ${conta}```@here",
		['vehicleblacklistD'] = "```Der Spieler ${nome} [${id}] wurde wegen Cheat-Benutzung gesperrt! [".."Fahrzeug-Schwarze Liste".."]\nIP: ${ip} | Seriennummer: ${serial} | Konto: ${conta}```@here",
		['speedD'] = "```Der Spieler ${nome} [${id}] wurde wegen Cheat-Benutzung gesperrt! [Geschwindigkeitsbegrenzer]\nIP: ${ip} | Seriennummer: ${serial} | Konto: ${conta}```@here",
		['jetpackD'] = "```Der Spieler ${nome} [${id}] wurde wegen Cheat-Benutzung gesperrt! [".."Jetpack-Cheat".."]\nIP: ${ip} | Seriennummer: ${serial} | Konto: ${conta}```@here",
		['flyban'] = "```Der Spieler ${nome} [${id}] wurde wegen Cheat-Benutzung gesperrt! [".." Flug-Cheat ".."]\nIP: ${ip} | Seriennummer: ${serial} | Konto: ${conta}```@here",
		['flywarn'] = "```[WARNUNG] Der Spieler ${nome} [${id}] wurde möglicherweise beim Cheaten erwischt, überprüfen Sie dies im Spectate- oder Screenshot-Modus! [".." Flug-Cheat ".."]\nIP: ${ip} | Seriennummer: ${serial} | Konto: ${conta}```",
		['flylastwarn'] = "```[WARNUNG] Der Spieler ${nome} [${id}] verwendet möglicherweise Cheats! [".." Flug-Cheat ".."]\nIP: ${ip} | Seriennummer: ${serial} | Konto: ${conta}```",
		['rpgvbrD'] = "```Der Spieler ${nome} [${id}] wurde wegen Cheat-Benutzung gesperrt! [".."RPG Mod-Menü".."]\nIP: ${ip} | Seriennummer: ${serial} | Konto: ${conta}```@here",
		['tankammoshotD'] = "```Der Spieler ${nome} [${id}] wurde wegen Cheat-Benutzung gesperrt! [".."Tank Mod-Menü".."]\nIP: ${ip} | Seriennummer: ${serial} | Konto: ${conta}```@here",
		['weaponkillD'] = "```Der Spieler ${nome} [${id}] wurde wegen Cheat-Benutzung gesperrt! [".."Mit Waffe in Schwarzer Liste töten".."]\nIP: ${ip} | Seriennummer: ${serial} | Konto: ${conta}```@here",
		['spawnvbrD'] = "```Der Spieler ${nome} [${id}] wurde wegen Cheat-Benutzung gesperrt! [".." Menüfahrzeug spawnt ".."]\nIP: ${ip} | Seriennummer: ${serial} | Konto: ${conta}```@here",
		['resourcestopD'] = "```Der Spieler ${nome} [${id}] wurde gekickt! [".."Ressourcenstopp".."]\nIP: ${ip} | Seriennummer: ${serial} | Konto: ${conta}```@here",
		['aimbotD'] = "```Der Spieler ${nome} [${id}] zielt möglicherweise zu schnell! [".."Aimbot".."]\nIP: ${ip} | Serienummer: ${serial} | Konto: ${conta}```",
		['joinstaffaccD'] = "```Jemand versucht, sich auf das Staff-Konto anzumelden: ${getaccPacc} | Name: ${getname} | IP: ${ip} | Seriennummer: ${serial}```",
		['banlogsD'] = "```Der Staff ${snome} [${sid}] hat den Spieler ${nome} [${id}] gesperrt\nIP: ${ip} | Seriennummer: ${serial}```",
		['unbanlogsD'] = "```Der Staff ${snome} [${sid}] hat das IP-Verbot aufgehoben: ${ip} | Seriennummer: ${serial}```",
		['invisibleweaponD'] = "```Der Spieler ${nome} [${id}] wurde wegen Cheat-Benutzung gesperrt! [Unsichtbare Waffe]\nIP: ${ip} | Seriennummer: ${serial} | Konto: ${conta}```@here",
		['firerateD'] = "```${nome} [${id}] hile yapma nedeniyle yasaklandı! [Ateş Oranı]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['updateD'] = "```diff\n+ Anticheat'ın yeni bir sürümü indirildi!\n+ Güncellemeyi unutma!\n```",
		['getcarD'] = "```${nome} [${id}] hile yapma nedeniyle yasaklandı! [Araç Çekme]\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['gbanD'] = "```${nome} oyuncusu Anticheat'in GBans tarafından yasaklandı!\nIP: ${ip} | Seri: ${serial} | Hesap: ${conta}```@here",
		['elementD'] = "```Der Spieler ${nome} [${id}] wurde wegen Betrugs gebannt! [Elementdaten]\nIP: ${ip} | Seriennummer: ${serial} | Konto: ${conta}```@here",
		['luaD'] = "```Spieler ${nome} wurde wegen Betrugs gebannt! [Lua Executor]\nIP: ${ip} | Serial: ${serial} | Account: ${conta}``@here",
		['blackcmdsD'] = "```Spieler ${nome} wurde wegen Betrugs gesperrt! [Blacklist-Befehl: ${cmd}]\nIP: ${ip} | Seriennummer: ${serial} | Account: ${conta}``@here",
		-- Komutlar
		['pathC'] = "Konum: ",
		['cmdsC'] = "${resourcename} için Komutlar: ",
		-- Yasaklar
		['weaponblacklistB'] = "Silah siyah listesi algılandı",
		['vehicleblacklistB'] = "Araç siyah listesi algılandı",
		['speedB'] = "Hız sınırlayıcı algılandı",
		['jetpackB'] = "Jetpack hilesi algılandı",
		['fly'] = "Uçma hilesi algılandı",
		['rpgvbrB'] = "RPG algılandı.",
		['tankammoshotB'] = "Tank algılandı.",
		['weaponkillB'] = "Silah siyah listesiyle öldürme algılandı",
		['spawnvbrB'] = "Araç menüsü spawner",
		['resourcestopB'] = "Kaynak durdurucu algılandı!",
		['joinstaffaccB'] = "Personel hesabına giriş yaptınız, ancak seriniz izin verilmiyor", -- Atma
		['gbanB'] = "Anticheat'in GBan'ı",
		['antibanfounderB'] = "Önemli birini yasaklamaya çalıştınız!",
		['invisibleweaponB'] = "Görünmez silah algılandı",
		['firerateB'] = "Ateş hızı değiştirilmiş algılandı",
		['getcarB'] = "Araç çekme algılandı",
		['elementB'] = "Unerlaubt verändertes Element",
		['luaB'] = "Lua-Executor erkannt",
		['blackcmdsB'] = "Befehl blockiert",
		-- Bildschirmfoto
		['sharingscreen'] = "Ein Bildschirmfoto wird erstellt.",
		['time'] = "Zeit: ",
		['warningnoquit'] = "Verlassen Sie nicht den Server, sonst werden Sie gesperrt.",
		['leavessC'] = "Sie wurden vom Bildschirmfoto entfernt!",
		['leavessS'] = "Sie haben den Spieler erfolgreich vom Bildschirmfoto entfernt!",
		['tpssC'] = "Sie wurden zum Bildschirmfoto teleportiert!",
		['tpssS'] = "Sie haben den Spieler erfolgreich auf das Bildschirmfoto gesetzt!",
		['banmsgss'] = "Die Verbindung wurde während des Bildschirmfotos unterbrochen!",
		},
}

-- Notify info (não apagar) -- troque o vrp_info para a infobox do seu servidor
notify = function(player, message, type)
    exports["vrp_info"]:addBox(player, message, type)
    --exports["vrp_info"]:addBox(player, message, "info")
end

getSystemLanguage = function(index)
    return language[servidor.language][index];
end