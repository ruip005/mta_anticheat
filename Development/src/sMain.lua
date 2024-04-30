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
local screenshotsImg = {} -- TO DO - Delete
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
end

-- Anti Overwrite

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
                if data.message then -- TO DO - Test
                    msg(data.message)
                end
            else
                msg(getSystemLanguage("apiidk")) -- TO DO - Create new message
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
            else
                msg(getSystemLanguage("apiidk")) -- TO DO - Test
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
                    local player = getPlayerDetails(getPlayerFromSerial(serial))
					banPlayer(getPlayerFromSerial(serial), true, false, true, servidor.sigla.." Anticheat", getSystemLanguage("gbanB").."\n"..servidor.discord)
                    outputChatBox(" ", root)
                    outputChatBox(" ", root)
                    outputChatBox(servidor.cor.."["..servidor.sigla.."] "..getSystemLanguage("gbanchat"):gsub("${getname}", nome):gsub("${id}",idd), root ,255,255,255,true) -- FIX ME
                    outputChatBox(" ", root)
                    outputChatBox(" ", root)
                    notify(root,"[AC] "..getSystemLanguage("gbannotify"):gsub("${getname}", nome):gsub("${id}",idd), "info") -- FIX ME
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
                    triggersourceEvent(p, "ac>createKey", p , data.hwid) -- testar com source
                    else end
                end
                if data.banned then
                    banPlayer(p, true, false, true, servidor.sigla.." Anticheat", getSystemLanguage("spooferB").."\n"..servidor.discord)
                    EnviarMensagemDiscord(discord.spoofer, getSystemLanguage("spooferD"):gsub("${nome}", getPlayerName(p)):gsub("${id}", (getElementData(p, servidor.id) or 'NIL')):gsub("${ip}", getPlayerIP(p)):gsub("${serial}", getPlayerSerial(p)):gsub("${conta}", getAccountName(p)))
                end -- fim if banned
                if data.suspected then
                    notifyStaff(getSystemLanguage("spooferS"):gsub("${nome}", getPlayerName(p)))
                    -- Enviar mensagem discord com gsub nome id ip serial conta
                    EnviarMensagemDiscord(discord.spoofer, getSystemLanguage("spooferDS"):gsub("${nome}", getPlayerName(p)):gsub("${id}", (getElementData(p, servidor.id) or 'NIL')):gsub("${ip}", getPlayerIP(p)):gsub("${serial}", getPlayerSerial(p)):gsub("${conta}", getAccountName(p)))
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

        local info = getPlayerDetails(source)
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
        if isStaff(receiver) then
            if getElementData(receiver, servidor.staff) then
                outputChatBox(getSystemLanguage("screenof").." "..(getPlayerName(source) or getSystemLanguage("noinfo")).." ["..(getElementData(source, servidor.id) or getSystemLanguage("noinfo")).."]", receiver)
                triggersourceEvent( receiver, "onMysourceScreenShot", getRootElement(),pixels )
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

        if client ~= source then
            return
        end

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
    	triggersourceEvent("onSomBAN", punido , outros.musica) -- FIX ME

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

addCommandHandler("seepath", -- Localizacao resource
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

addCommandHandler("commands", -- Comandos do resource
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
        if isStaff(jogador) then
            if getElementData(jogador, servidor.staff ) == false then return notify(jogador, getSystemLanguage("nostaffmode"), "info")end
            triggersourceEvent ("ativarWall", jogador)
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
                    triggersourceEvent(receiver, "JOAO.stopScreenShare", receiver)
                    notify(player, getSystemLanguage("leavessS"), "success")
                else
                    setElementPosition(receiver, 1544.113, -1353.374, 329.474)
                    setElementFrozen (receiver, true)
                    setElementPosition(player, 1544.113, -1353.374, 329.474)
                    setElementData(receiver, "JOAO.screenShare", {getElementPosition(receiver)})
                    triggersourceEvent(receiver, "JOAO.openScreenShare", receiver, getRealTime().timestamp)
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

addEvent("onLUASUS", true) -- LUA EXEC2 (Arrumar)
addEventHandler("onLUASUS", getRootElement(),function()
    if ac.modules.lua == false then
        return end
        if not getElementType(source) == "player" then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl))  then
        --if isLogado(source) then
            addBan(source, "lua", false)
        --end
	end
end)

-- Funcionalidades Principais do Anticheat

-- Novas funcionalidades

local function onDebugMessageHandler(message, level, file, line) -- Troquei [onDebugMessage] por [onDebugMessageHandler] para modular de forma correta com a depuração 
    if file then -- Adicionei para veirificar se o valor de file e nil/nulo caso for ele executa caso ñ for ele ignora
        local rr = file:match("(.+)\")
        if (level == 1 or level == 2 or level == 3) and rr == getResourceName(getThisResource()) then -- implementei o erro level 3 para trabalhar com todos (opcional)
            errorAC(tostring(line), message)
        end
    end
end
addEventHandler("onDebugMessageHandler", getRootElement(), onDebugMessageHandler) -- Modificação feita por gw.designe


-- Novas funcionalidades

addEvent("onKickTela", true) -- Kick
addEventHandler("onKickTela", getRootElement(),function()
    if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl)) then
    if isLogado(source) then
        if source ~= source then
            return false
        end
    banPlayer(source, true, false, true, servidor.sigla.." Anticheat", getSystemLanguage("screenoffban"), 60)
    end
end
end)

-----

local antiReconnect = {}

function antiReconnect.onPlayerJoin(player)
  antiReconnect[player] = {
    lastDisconnectTime = getTickCount(),
    kicked = false,
  }
end

function antiReconnect.onPlayerDisconnect(player, reason)
  antiReconnect[player].lastDisconnectTime = getTickCount()
end

function antiReconnect.onPlayerRequestJoin(player, reason)
  local lastDisconnectTime = antiReconnect[player].lastDisconnectTime
  local currentTime = getTickCount()
  local reconnectTime = currentTime - lastDisconnectTime

  if reconnectTime < 30000 and not antiReconnect[player].kicked then
    antiReconnect[player].kicked = true
    kickPlayer(player, "Reconexão rápida detectada.")
    return false
  end

  return true
end

addEventHandler("onPlayerJoin", antiReconnect.onPlayerJoin)
addEventHandler("onPlayerDisconnect", antiReconnect.onPlayerDisconnect)
addEventHandler("onPlayerRequestJoin", antiReconnect.onPlayerRequestJoin)

-- // Limite de eventos atingidos

function limitEventHit()

end
addEventHandler("onPlayerTriggerEventThreshold", getRootElement(), limitEventHit)
