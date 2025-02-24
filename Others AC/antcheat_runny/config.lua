KEY_AC = "NQlm2KcnIk6n5ZSrjvXHtH1aXWnwhJ" -- Key para a liberação do anti-cheat.

webhook_ban = "https://discord.com/api/webhooks/1269735298242449518/iomtjsXiTXaH5oQ-MEWwyxk97GSzqxdAc9yV-E4bOq2s_DAOmZmvDEwAAJfan-_qzhlH"
webhook_logs = "https://discord.com/api/webhooks/1269735468984172605/xIvytR4qFzkN2u_2OX6GsD_zLOJ-0vdVAKYvOmxJLpdcCAs3Kjr9Une4VWfcXwHnZd0d"
webhook_lua = "https://discord.com/api/webhooks/1269735380484362323/DkLliuwvBkvt9SEMz00XIGcgVEdLaYgjRqF74W-PmS208iO30jMqyH2xfkhJ6h1CuVtW"

HEADSHOT_FILE_NAME = "" -- Nome do seu headhsot. (resource name)

ADMIN_LEVEL_LOCK = true -- Se desativado não irá verificar quem esta pegando admin.
DISABLE_GET_BONE_POSITION = true -- Desativar a função de recuperar a posição da cabeça de um player
CHECK_TRIGGER_SERVER_EVENT = true -- Checarse o source e o client são iguais.

SERIAL_STAFF = { -- Serial's dos STAFF's (Impede ser banido caso der falso positivo em alguma das funções)
    "48412123EDB77F46E785D735183EF8B4",
    "A29A833EE85E249D0A5F29489A683CB4",
}

CARGOS_STAFF = { --ACL's da staff. (Errar o nome de alguma ACL pode resultar em ban de um staff.)
    "Console",
    "Admin",
    "Staff",
}

ARMAS_PERMITIDAS = {
    {0, "Fist"},
    {46, "Parachute"},
    {30, "AK-47"},
    {31, "M4"},
    {51, "explosion(rocket/blowVehicle)"},
    {37, "fogo"},
    {50, "atropelado"},
    {53, "agua"},
    {49, "bater"},
    {54, "cair"},
    {63, "Soprado"},
    {55, "desconhecido"},
}

-- Velocidade máxima permitida para todos os jogadores em km/h (Não deixar baixo)
VELOCIDADE_MAXIMA_VEICULOS = 800
VELOCIDADE_MAXIMA_PLAYERS = 200

BAN_SPEED_DETECTED = false
BAN_FLY_DETECTED = false

-- Verificar explosões
explosion = {
    {0, true},    
    {10, true}, -- Tank pode ser adicionado; no código é verificado se o player esta em um veículo ou não. (Retirar essa verificação)
    {1, true}
}
    --[[
0: Grenade
1: Molotov
2: Rocket
3: Rocket Weak
4: Car
5: Car Quick
6: Boat
7: Heli
8: Mine
9: Object
10: Tank Grenade
11: Small
12: Tiny
    --]]

COMANDOS_PERMITIDOS = { -- Pode remover essa lista, apenas procurar pela função no lado server (blockCommands)
    "check",
	"info",
	"list",
	"refresh",
	"refreshall",
	"restart",
	"start",
	"stop",
	"stopall",
	"upgrade",
    "aclrequest",
	"reloadacl",
    "aexec",
	"addaccount",
	"chgpass",
	"delaccount",
	"reloadbans",
	"authserial",
	"ase",
	"debugdb",
	"debugjoinflood",
	"debuguptime",
	"help",
	"loadmodule",
	"unloadmodule",
	"reloadmodule",
	"openports",
	"sfakelag",
	"shutdown",
	"sver",
	"say",
	"whois",
	"ver",
	"chgmypass",
	"debugscript",
	"login",
	"logout",
	"me",
	"msg",
	"nick",
    "help",
    "exit",
    "quit",
    "ver",
    "time",
    "showhud",
    "binds",
    "serial",
    "connect",
	"reconnect",
	"bind",
	"unbind",
	"copygtacontrols",
	"screenshot",
	"saveconfig",
    "fakelag",
    "sinfo",
    "disconnect",
    "shownametags",
    "showchat",
    "shownetstat",
    "showmemstat",
    "showframegraph",
    "chatbox",
	"textscale",
	"showcol",
	"showsound",
    "cleardebug",
    "chatscrollup",
    "chatscrolldown",
    "debugscrollup",
    "debugscrolldown",
    "voiceptt",
    "enter_passenger",
    "radio_next",
    "radio_previous",
    "radar",
    "radar_zoom_in",
    "radar_zoom_out",
    "radar_move_north",
    "radar_move_south",
    "radar_move_east",
    "radar_move_west",
    "radar_attach",
    "msg_target",
    "vehicle_next_weapon",
    "vehicle_previous_weapon",
    "radio_next",
    "kill",
    "mortar",
    "setmedic",
    "Abrir",
    "Open",
    "admin",
    "Toggle",
    "parachuteat",
    "parachuteal",
    "help_me",
    "setpassword",
    "teamsay",
    "Reload",
    "reload",
    "Painel",
    "patriotal",
    "clearchat",
    "debug",
    "setradio",
    "fps_limit",
    "banAC",
    "medic",
    "quickspeed",
    "ping_debug",
    "debug_ccL.externalslide",
    "backwards_drawn",
    "forwards_drawn ",
    "protect",
    "kick",
    "fix",
    "banir",
    "blacklist",
    "spec",
    "screenshare",
    "enviarCaptura",
}

COMANDOS_BLOQUEADOS = {
    "fuckac",
    "puxarx",
    "bazuca",
    "chuvarpg",
    "killall",
    "loadvazelin",
    "p4nel",
    "xvehicle",
    "MaktTR",
    "maktTR",
    "makttr",
    "bazuka",
    --"fire",
    "vsploit",
}