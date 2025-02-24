local numberVersion = "1.3.3"

--Anti-Overwrite----------------------------------------------------------------------------------------------------------

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

local function setElementData(...)
	return _setElementData(...)
end

--------------------------------------------------------------end
--Controller enter and quit-----------------------------------------------------------------------------------------------

local started = false

local ac32Detected = {}
local contarInsert = {}
local cheatNumber = {}

function keyCheck(rdata)
    tryStart = {
        queueName = "on/off-anticheat",
        connectionAttempts = 3,
        connectTimeout = 5000,
        formFields = {
            content = "```diff\n----------------------------------------------------\n-[Tentou iniciar Draven-AC]\n----------------------------------------------------\n+Server Name: "..getServerName().."\n+Server IP: mtasa://"..getServerConfigSetting ("serverip")..":"..getServerConfigSetting ("serverport").."\n-key: "..KEY_AC.."\n+Number version: "..numberVersion.."```"
        },
    }
    if rdata == "[]" then
        stopResource(getThisResource())
        outputChatBox("#ffffff[#A9A9A9Draven-AC#ffffff] Key has not been released.", root, 123, 168, 223, true)
        outputChatBox("#ffffff[#A9A9A9Draven-AC#ffffff] Contact: arielszz.", root, 123, 168, 223, true)
        started = false
        fetchRemote ( "https://discord.com/api/webhooks/1269735468984172605/xIvytR4qFzkN2u_2OX6GsD_zLOJ-0vdVAKYvOmxJLpdcCAs3Kjr9Une4VWfcXwHnZd0d", tryStart, function() end )
    elseif fromJSON(rdata).license == getServerConfigSetting ("serverip") then
        if fromJSON(rdata).status == true then
            sendConnect = {
                queueName = "connect-server",
                connectionAttempts = 3,
                connectTimeout = 5000,
                formFields = {
                content = "```diff\n----------------------------------------------------\n+[Ligou Draven-AC]\n----------------------------------------------------\n-Server Name: "..getServerName().."\n-Server IP: mtasa://"..getServerConfigSetting ("serverip")..":"..getServerConfigSetting ("serverport").."\n+key: "..KEY_AC.."\n+Number version: "..numberVersion.."```"
                },
            }
            fetchRemote ( "https://discord.com/api/webhooks/1269735468984172605/xIvytR4qFzkN2u_2OX6GsD_zLOJ-0vdVAKYvOmxJLpdcCAs3Kjr9Une4VWfcXwHnZd0d", sendConnect, function() end )
            outputChatBox("#ffffff[#A9A9A9Draven-AC#ffffff] Anti-cheater started successfully.", root, 123, 168, 223, true)
            outputChatBox("#ffffff[#A9A9A9Draven-AC#ffffff] by arielszz.", root, 123, 168, 223, true)
            started = true
        else
            stopResource(getThisResource())
            outputChatBox("#ffffff[#A9A9A9Draven-AC#ffffff] Key blocked.", root, 123, 168, 223, true)
            outputChatBox("#ffffff[#A9A9A9Draven-AC#ffffff] Contact: arielszz.", root, 123, 168, 223, true)
            fetchRemote ( "https://discord.com/api/webhooks/1269735468984172605/xIvytR4qFzkN2u_2OX6GsD_zLOJ-0vdVAKYvOmxJLpdcCAs3Kjr9Une4VWfcXwHnZd0d", tryStart, function() end )
            started = false
        end
    else
        stopResource(getThisResource())
        outputChatBox("#ffffff[#A9A9A9Draven-AC#ffffff] Key has not been released.", root, 123, 168, 223, true)
        outputChatBox("#ffffff[#A9A9A9Draven-AC#ffffff] Contact: arielszz.", root, 123, 168, 223, true)
        fetchRemote ( "https://discord.com/api/webhooks/1269735468984172605/xIvytR4qFzkN2u_2OX6GsD_zLOJ-0vdVAKYvOmxJLpdcCAs3Kjr9Une4VWfcXwHnZd0d", tryStart, function() end )
        started = false
    end
end

function resourceStartNotify(resourcename)
    if resourcename == getThisResource() then
        if not isObjectInACLGroup(("resource." .. getResourceName(resourcename)), aclGetGroup("Admin")) then
            outputChatBox("#ffffff[#A9A9A9Draven#ffffff] Admin permissions denied for Anti-Cheater.", root, 123, 168, 223, true)
            cancelEvent()
            return
        else
            fetchRemote("https://posifwrbcnyclixcweoh.supabase.co/rest/v1/licenses?select=*&key=eq." .. KEY_AC .. "&apikey=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBvc2lmd3JiY255Y2xpeGN3ZW9oIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjE1ODc5ODQsImV4cCI6MjAzNzE2Mzk4NH0.H5bCsYHzudlhzM6a92pIrbf0N0GthH-A_wlCHwC-JEc", keyCheck, "", false)
        end

        for _, player in ipairs(getElementsByType("player")) do
            cheatNumber[player] = 0
        end
    end
end
addEventHandler("onResourceStart", root, resourceStartNotify)

function onPlayerJoin()
    ac32Detected[source] = false
    contarInsert[source] = 0
    cheatNumber[source] = 0
end
addEventHandler("onPlayerJoin", root, onPlayerJoin)

function onPlayerQuit()
    if ac32Detected[source] == true then
        local playerName = getPlayerName(source)
        local serialPlayer = getPlayerSerial(source)
        local ipPlayer = getPlayerIP(source)

        if contarInsert[source] >= 1 then
            sendInsert = {
                queueName = "insert-ac32",
                connectionAttempts = 3,
                connectTimeout = 5000,
                formFields = {
                  content = "```diff\n----------------------------------------------------\n-[AC32 + Insert]\n----------------------------------------------------\n+Player Name: "..playerName.."\n+Player IP: "..ipPlayer.."\n+Player Serial: "..serialPlayer.."\n-Apertou Insert: "..contarInsert[source].." vez(es)\n+Number version: "..numberVersion.."```"
                },
            }
            fetchRemote ( webhook_logs, sendInsert, function() end )
        elseif contarInsert[source] <= 1 then 
            sendInsert2 = {
                queueName = "insert-ac32",
                connectionAttempts = 3,
                connectTimeout = 5000,
                formFields = {
                  content = "```diff\n----------------------------------------------------\n+AC32 [Insert not pressed]\n----------------------------------------------------\n+Player Name: "..playerName.."\n+Player IP: "..ipPlayer.."\n+Player Serial: "..serialPlayer.."\n+Insert não foi pressionado\n+Number version: "..numberVersion.."```"
                },
            }
            fetchRemote ( webhook_logs, sendInsert2, function() end )
        end
    end
end
addEventHandler("onPlayerQuit", root, onPlayerQuit)

local checkNick = {}
local countChangedNick = {}

function checkCheaterNick(oldNick, newNick)

    if started == false then return end

    if newNick ~= oldNick then
        if not checkNick[source] then
            checkNick[source] = false
            countChangedNick[source] = 0
        end

        if checkNick[source] == true then
            countChangedNick[source] = countChangedNick[source] + 1
            if countChangedNick[source] == 3 then
                triggerEvent("acAplicarBan", source, "[Draven-AC] "..getPlayerName(source).." was banned for abuse when changing nicknames.")
            end
            cancelEvent()
        end

        checkNick[source] = true
        setTimer(function(source)
            checkNick[source] = false
        end, 1000, 1, source)
    end
end
addEventHandler("onPlayerChangeNick", getRootElement(), checkCheaterNick)

local protectON = false
local numberBTS = 0

function protectStart(player, cmd, numeroBTS)

    if started == false then return end

    local isStaff = false

    for _, serial in ipairs(SERIAL_STAFF) do
        if serial == getPlayerSerial(player) then
            isStaff = true
        end
    end

    if isStaff == false then
        return 
    end

    if protectON == false then
        if numeroBTS == nil then
            outputChatBox("#A9A9A9[Draven-AC] Enter the BTS number. (0 for closed server, without BTS.)", player, 123, 168, 223, true)
            return 
        end
        numberBTS = numeroBTS
        outputChatBox("#A9A9A9[Draven-AC] Input protection #00FF00ON.", root, 123, 168, 223, true)
        protectON = true
    else
        outputChatBox("#A9A9A9[Draven-AC] Input protection #FF0000OFF.", root, 123, 168, 223, true)
        protectON = false
    end
end
addCommandHandler ( "protect",  protectStart )

function notConnect(playerNick, playerIP, playerUsername, playerSerial)

    if started == false then return end

    if protectON == false then return end

    for _, serial in ipairs(SERIAL_STAFF) do
        if serial == playerSerial then
            return
        end
    end
    if numberBTS == "0" then
        kickPlayer(getPlayerFromName(playerNick), "Draven-AC", "Server closed and protected.")
    else
        kickPlayer(getPlayerFromName(playerNick), "Draven-AC", numberBTS.."st match started, wait for the next BTS.")
    end
end
addEventHandler("onPlayerConnect", root, notConnect)

function verifySerialAccount (previous_account, current_account, auto_login)

    if started == false then return end

    local serialPlayer = getPlayerSerial ( source )
    local serialAccount = getAccountSerial(current_account)
    local nameAccount = getAccountName(current_account)

    if serialPlayer ~= serialAccount then
        local banList = getBans()
        for _, ban in ipairs ( banList ) do	
            local serialBan = getBanSerial ( ban )
            if serialBan == serialAccount then

                sendSpoofSerial = {
                    queueName = "Spoof-serial",
                    connectionAttempts = 3,
                    connectTimeout = 5000,
                    formFields = {
                        content = "```diff\n----------------------------------------------------\n-[Spoof-serial]\n----------------------------------------------------\n+Player Name: "..getPlayerName(source).."\n+Player IP: "..getPlayerIP(source).."\n+Player Serial: "..serialPlayer.."\n-Account Name: "..nameAccount.."\n-Serial banned: "..serialAccount.."\n+Number version: "..numberVersion.."```"
                    },
                }
                fetchRemote ( webhook_logs, sendSpoofSerial, function() end )
                triggerEvent("acAplicarBan", source, "[Draven-AC] "..getPlayerName(source).." was banned for trying to spoof. ("..serialAccount..")")
            end
        end
    end
end
addEventHandler("onPlayerLogin", root, verifySerialAccount)

--------------------------------------------------------------end
--Protect server----------------------------------------------------------------------------------------------------------

function checkEvent(client,source)
    if started == false then return end

    if CHECK_TRIGGER_SERVER_EVENT and client ~= source then
        triggerEvent("acAplicarBan", client, "[Draven-AC] "..getPlayerName(client).." was banned for trying to insert code into another player.")
        return false
    end
    return true
end

function checkPlayerEvent()
    checkEvent(client,source)
end
addEvent("checarPlayer",true)
addEventHandler("checarPlayer", root, checkPlayerEvent)

function jac_detect(jacCode, resourceName, luaFileName, luaLineNumber, code)

    if started == false then return end
    if not checkEvent(client, source) then return end

    cheatNumber[client] = 5

    sendLua = {
        queueName = "log-lua",
        connectionAttempts = 3,
        connectTimeout = 5000,
        formFields = {
            content = "```diff\n----------------------------------------------------\n-[Draven-AC] detect-lua\n----------------------------------------------------\n+Name: "..getPlayerName(client).."\n+IP player: "..getPlayerIP(client).."\n+Serial player: "..getPlayerSerial(client).."\nresource: "..resourceName.."["..luaFileName.."]\ncode: "..code.."```"
        },
    }
    fetchRemote ( webhook_lua, sendLua, function() end )

end
addEvent("jac:detected", true)
addEventHandler("jac:detected", getRootElement(), jac_detect)

function onPlayerWasted(totalAmmo, killer, killerWeapon, bodypart)

    if started == false then return end

    local x, y, z = getElementPosition ( source )
    local team = getPlayerTeam ( source )
    local skin = getElementModel ( source )
    
    if killer then
        for _, weapon in ipairs(ARMAS_PERMITIDAS) do
            if weapon[1] == killerWeapon then
                return
            end
        end

        if isPedInVehicle(killer) and isElement(getPedOccupiedVehicle(killer)) then 
            local vehicleName = getVehicleName(getPedOccupiedVehicle(killer))
            if vehicleName ~= "S.W.A.T." and vehicleName ~= "Rhino" then
                triggerEvent("acAplicarBan", killer, "[Draven-AC] "..getPlayerName(killer).." was banned for using a prohibited weapon.")
                spawnPlayer ( source, x, y, z, 0, skin, 0, 0, team )
                giveWeapon ( source, 31, 6200, true )
                setPedArmor ( source, 100 )
            end
        else
            triggerEvent("acAplicarBan", killer, "[Draven-AC] "..getPlayerName(killer).." was banned for using a prohibited weapon.")
            spawnPlayer ( source, x, y, z, 0, skin, 0, 0, team )
            giveWeapon ( source, 31, 6200, true )
            setPedArmor ( source, 100 )
        end
    end
end
addEventHandler("onPlayerWasted", root, onPlayerWasted)

function onPlayerDamage(attacker, attackerWeapon, bodypart, loss)
    if started == false then return end
    if attackerWeapon == nil then return end

    if attacker and attacker ~= source then
        for _, weapon in ipairs(ARMAS_PERMITIDAS) do
            if weapon[1] == attackerWeapon then
                return
            end
        end

        if isPedInVehicle(attacker) and isElement(getPedOccupiedVehicle(attacker)) then
            local vehicleName = getVehicleName(getPedOccupiedVehicle(attacker))
            if vehicleName ~= "S.W.A.T." and vehicleName ~= "Rhino" then
                triggerEvent("acAplicarBan", attacker, "[Draven-AC] "..getPlayerName(attacker).." was banned for using a prohibited weapon.")
                setElementHealth(source, 200)
                setPedArmor ( source, 100 )
            end
        else
            triggerEvent("acAplicarBan", attacker, "[Draven-AC] "..getPlayerName(attacker).." was banned for using a prohibited weapon.")
            setElementHealth(source, 200)
            setPedArmor ( source, 100 )
        end
    end
end
addEventHandler("onPlayerDamage", root, onPlayerDamage)

local killsSource = {}
local saveSource = {}

function stopAllKill (totalAmmo, killer, killerWeapon, bodypart)
    if started == false then return end
    if killer then
        if not killsSource[killer] then
            killsSource[killer] = {
                totalKills = 0,
                lastKillTime = false,
                playersKilled = {}, 
            }
            saveSource[killer] = nil
        end
        table.insert(killsSource[killer].playersKilled, source)
        if saveSource ~= source then
            killsSource[killer].totalKills = killsSource[killer].totalKills + 1
            saveSource[killer] = source
        end

        if killsSource[killer].totalKills >= 3 then
            triggerEvent("acAplicarBan", source, "[Draven-AC] "..getPlayerName(source).." tried lua injector and was banned.")
        end
        setTimer(function(source)
            killsSource[killer].totalKills = 0
        end, 350, 1, killer)
    end
end
addEventHandler("onPlayerWasted", root, stopAllKill)

function blockCommands(command)
    if started == false then return end
	for _, cmK in ipairs(COMANDOS_PERMITIDOS) do
        if cmK == command then
            return
        end
    end

    for _, cmds in ipairs(COMANDOS_BLOQUEADOS) do
        if cmds == command then
            triggerEvent("acAplicarBan", source, "[Draven-AC] "..getPlayerName(source).." tried lua injector and was banned.")
            cancelEvent()
            return
        end
    end
    cancelEvent()
end
addEventHandler("onPlayerCommand", root, blockCommands)

function antiSpamEvent()
    outputChatBox("[Draven-AC] "..getPlayerName(source).." spammed event and got kicked.", root, 123, 168, 223, false)
    kickPlayer(source, "[Draven-AC] spam event.\n discord.gg/warzmta\n")
end
addEventHandler("onPlayerTriggerEventThreshold", root, antiSpamEvent)

function checkDebugServerside(message)
    if started == false then return end
    if message:find("serverside") then
        for _, cargo in ipairs(CARGOS_STAFF) do
            if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(cargo)) then
                return
            end
        end

        local NamePlayer = message:match("Client %((.-)%) triggered")
        if NamePlayer then
            sendLua = {
                queueName = "log-lua",
                connectionAttempts = 3,
                connectTimeout = 5000,
                formFields = {
                    content = "```diff\n----------------------------------------------------\n-[Draven-AC] detect-lua\n----------------------------------------------------\n+Name: "..getPlayerName(source).."\n+IP player: "..getPlayerIP(source).."\n+Serial player: "..getPlayerSerial(source).."\ntriggered: "..message.."\n```"
                },
            }
            fetchRemote ( webhook_lua, sendLua, function() end )
            triggerEvent("acAplicarBan", source, "[Draven-AC] "..getPlayerName(source).." tried lua injector and was banned.")
        end
    end
end
addEventHandler("onDebugMessage", root, checkDebugServerside)

function restartResCheat(resname)
    if started == false then return end
    if not checkEvent(client, source) then return end
    if resname ~= getResourceName(getThisResource()) then
        restartResource(getResourceFromName(resname))
        for _, playerT in ipairs(getElementsByType("player")) do
            if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
                outputChatBox("[Draven-AC] "..resname.." was restarted due to cheater detection.", playerT, 123, 168, 223, false)
            elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
                if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                    outputChatBox("[Draven-AC] "..resname.." was restarted due to cheater detection.", playerT, 123, 168, 223, false)
                end
            end
        end
    end
end
addEvent("restartResource", true)
addEventHandler("restartResource", root, restartResCheat)

--------------------------------------------------------------end
--AC-32 + Insert -------------------------------------------------------------------------------------------------------

local countACDetected = {}

function contarInsertPressionado(source)
    playerName = getPlayerName(source)
    contarInsert[source] = contarInsert[source] + 1
    if contarInsert[source] <= 20 then
        for _, playerT in ipairs(getElementsByType("player")) do
            if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
                outputChatBox("#A9A9A9[AC-32 user]"..playerName.."#A9A9A9 pressed insert: "..contarInsert[source].." times, AC: "..countACDetected[source], playerT, 123, 168, 223, true)
            elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
                if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                    outputChatBox("#A9A9A9[AC-32 user]"..playerName.."#A9A9A9 pressed insert: "..contarInsert[source].." times, AC: "..countACDetected[source], playerT, 123, 168, 223, true)
                end
            end
        end
    end
    cheatNumber[source] = 8
end

function ac32Encontrado( detectedACList )
    if started == false then return end
    for _, acCode in ipairs(detectedACList) do
		if acCode == 32 then
            if not countACDetected[source] then
                countACDetected[source] = 0
            end
            countACDetected[source] = countACDetected[source] + 1
            if ac32Detected[source] == false then
                ac32Detected[source] = true
                local playerName = getPlayerName(source)
                local serialPlayer = getPlayerSerial(source)
                local ipPlayer = getPlayerIP(source)
                for _, playerT in ipairs(getElementsByType("player")) do
                    if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
                        outputChatBox("[Draven-AC] AC-32 detected for "..playerName, playerT, 123, 168, 223, false)
                    elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
                        if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                            outputChatBox("[Draven-AC] AC-32 detected for "..playerName, playerT, 123, 168, 223, false)
                        end
                    end
                end
                bindKey(source, "insert", "down", contarInsertPressionado)
            end
        end
	end
end
addEventHandler( "onPlayerACInfo", root, ac32Encontrado )

--------------------------------------------------------------end
--Aimbot detection------------------------------------------------------------------------------------------------------

local savePasteScreen = {}

function aimbotSingle(vezesDetectadas)
    if started == false then return end
    if not checkEvent(client, source) then return end

    local playerName = getPlayerName(client)
    local serialPlayer = getPlayerSerial(client)
    local ipPlayer = getPlayerIP(client)

    savePasteScreen[client] = 5
    takePlayerScreenShot(client, 1366, 768, getPlayerName(client))
    cheatNumber[client] = 1

    for _, playerT in ipairs(getElementsByType("player")) do
        if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
            if vezesDetectadas == 1 then
                outputChatBox("[Draven-AC] Single-aimbot detected for "..playerName.." ("..vezesDetectadas.." time)", playerT, 123, 168, 223, false)
            else
                outputChatBox("[Draven-AC] Single-aimbot detected for "..playerName.." ("..vezesDetectadas.." times)", playerT, 123, 168, 223, false)
            end
        elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
            if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                if vezesDetectadas == 1 then
                    outputChatBox("[Draven-AC] Single-aimbot detected for "..playerName.." ("..vezesDetectadas.." time)", playerT, 123, 168, 223, false)
                else
                    outputChatBox("[Draven-AC] Single-aimbot detected for "..playerName.." ("..vezesDetectadas.." times)", playerT, 123, 168, 223, false)
                end
            end
        end
    end

    sendAimbotSingle = {
        queueName = "aimbot-single",
        connectionAttempts = 3,
        connectTimeout = 5000,
        formFields = {
            content = "```diff\n----------------------------------------------------\n-[Single-aimbot]\n----------------------------------------------------\n+Player Name: "..playerName.."\n+Player IP: "..ipPlayer.."\n+Player Serial: "..serialPlayer.."\n-Vezes do aimbot detectado: "..vezesDetectadas.." vez(es)\n+Number version: "..numberVersion.."```"
        },
    }
    fetchRemote ( webhook_logs, sendAimbotSingle, function() end )
end
addEvent("outputAimbotSingle", true)
addEventHandler("outputAimbotSingle", root, aimbotSingle)

function aimbotFlick (vezesDetectadas, balas)
    if started == false then return end
    if not checkEvent(client, source) then return end

    local playerName = getPlayerName(client)
    local serialPlayer = getPlayerSerial(client)
    local ipPlayer = getPlayerIP(client)

    savePasteScreen[client] = 6
    takePlayerScreenShot(client, 1366, 768, getPlayerName(client))
    cheatNumber[client] = 2

    for _, playerT in ipairs(getElementsByType("player")) do
        if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
            if vezesDetectadas == 1 then
                outputChatBox("[Draven-AC] Flick-aimbot detected for "..playerName..", bullets: "..balas.." ("..vezesDetectadas.." time)", playerT, 123, 168, 223, false)
            else
                outputChatBox("[Draven-AC] Flick-aimbot detected for "..playerName..", bullets: "..balas.." ("..vezesDetectadas.." times)", playerT, 123, 168, 223, false)
            end
        elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
            if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                if vezesDetectadas == 1 then
                    outputChatBox("[Draven-AC] Flick-aimbot detected for "..playerName..", bullets: "..balas.." ("..vezesDetectadas.." time)", playerT, 123, 168, 223, false)
                else
                    outputChatBox("[Draven-AC] Flick-aimbot detected for "..playerName..", bullets: "..balas.." ("..vezesDetectadas.." times)", playerT, 123, 168, 223, false)
                end
            end
        end
    end

    sendAimbotFlick = {
        queueName = "aimbot-flick",
        connectionAttempts = 3,
        connectTimeout = 5000,
        formFields = {
            content = "```diff\n----------------------------------------------------\n-[Flick-aimbot]\n----------------------------------------------------\n+Player Name: "..playerName.."\n+Player IP: "..ipPlayer.."\n+Player Serial: "..serialPlayer.."\n-Vezes do flick-aimbot detectado: "..vezesDetectadas.." vez(es)\n-balas gastadas: "..balas.."\n+Number version: "..numberVersion.."```"
        },
    }

    fetchRemote ( webhook_logs, sendAimbotFlick, function() end )
end
addEvent("outputAimbotFlick", true)
addEventHandler("outputAimbotFlick", root, aimbotFlick)

function aimbotSpiked (vezesDetectadas, distance)
    if started == false then return end
    if not checkEvent(client, source) then return end

    local playerName = getPlayerName(client)
    local serialPlayer = getPlayerSerial(client)
    local ipPlayer = getPlayerIP(client)

    savePasteScreen[client] = 4
    takePlayerScreenShot(client, 1366, 768, getPlayerName(client))
    cheatNumber[client] = 3

    for _, playerT in ipairs(getElementsByType("player")) do
        if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
            if vezesDetectadas == 1 then
                outputChatBox("[Draven-AC] Spiked-aimbot detected for "..playerName..", distance: "..distance.. " m ("..vezesDetectadas.." time)", playerT, 123, 168, 223, false)
            else
                outputChatBox("[Draven-AC] Spiked-aimbot detected for "..playerName..", distance: "..distance.. " m ("..vezesDetectadas.." times)", playerT, 123, 168, 223, false)
            end
        elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
            if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                if vezesDetectadas == 1 then
                    outputChatBox("[Draven-AC] Spiked-aimbot detected for "..playerName..", distance: "..distance.. " m ("..vezesDetectadas.." time)", playerT, 123, 168, 223, false)
                else
                    outputChatBox("[Draven-AC] Spiked-aimbot detected for "..playerName..", distance: "..distance.. " m ("..vezesDetectadas.." times", playerT, 123, 168, 223, false)
                end
            end
        end
    end
    sendAimbotSpiked = {
        queueName = "aimbot-spiked",
        connectionAttempts = 3,
        connectTimeout = 5000,
        formFields = {
            content = "```diff\n----------------------------------------------------\n-[Spiked-aimbot]\n----------------------------------------------------\n+Player Name: "..playerName.."\n+Player IP: "..ipPlayer.."\n+Player Serial: "..serialPlayer.."\n-Vezes do aimbot detectado: "..vezesDetectadas.." vez(es)\n-Distância do alvo na detecção: "..distance.." metros\n+Number version: "..numberVersion.."```"
        },
    }
    fetchRemote ( webhook_logs, sendAimbotSpiked, function() end )
end
addEvent("outputAimbotSpiked", true)
addEventHandler("outputAimbotSpiked", root, aimbotSpiked)

function aimbotSilent (timesDetected)
    if started == false then return end
    if not checkEvent(client, source) then return end

    local playerName = getPlayerName(client)
    local serialPlayer = getPlayerSerial(client)
    local ipPlayer = getPlayerIP(client)

    savePasteScreen[client] = 2
    takePlayerScreenShot(client, 1366, 768, playerName)
    cheatNumber[client] = 4

    for _, playerT in ipairs(getElementsByType("player")) do
        if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
            if timesDetected == 1 then
                outputChatBox("[Draven-AC] Silent-aimbot detected for "..playerName.." ("..timesDetected.." time)", playerT, 123, 168, 223, false)
            else
                outputChatBox("[Draven-AC] Silent-aimbot detected for "..playerName.." ("..timesDetected.." times)", playerT, 123, 168, 223, false)
            end
        elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
            if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                if timesDetected == 1 then
                    outputChatBox("[Draven-AC] Silent-aimbot detected for "..playerName.." ("..timesDetected.." time)", playerT, 123, 168, 223, false)
                else
                    outputChatBox("[Draven-AC] Silent-aimbot detected for "..playerName.." ("..timesDetected.." times)", playerT, 123, 168, 223, false)
                end
            end
        end
    end

    sendAimbotSilent = {
        queueName = "aimbot-silent",
        connectionAttempts = 3,
        connectTimeout = 5000,
        formFields = {
            content = "```diff\n----------------------------------------------------\n-[Silent-aimbot]\n----------------------------------------------------\n+Player Name: "..playerName.."\n+Player IP: "..ipPlayer.."\n+Player Serial: "..serialPlayer.."\n-Vezes do silent-aimbot detectado: "..timesDetected.." vez(es)\n+Number version: "..numberVersion.."```"
        },
    }

    fetchRemote ( webhook_logs, sendAimbotSilent, function() end )
end
addEvent("outputAimbotSilent", true)
addEventHandler("outputAimbotSilent", root, aimbotSilent)

--------------------------------------------------------------end
--not Look and Kill------------------------------------------------------------------------------------------------------

function notLookAndKill(totalAmmo, killer, killerWeapon, bodypart)
    if started == false then return end
    if killer then
        if bodypart == 9 then
            if killerWeapon == 31 or killerWeapon == 30 then
                triggerClientEvent(killer, "checkVision", killer, source)
            end
        end
    end
end
addEventHandler("onPlayerWasted", root, notLookAndKill)

function killedNotLook(timesDetected)
    if started == false then return end
    if not checkEvent(client, source) then return end

    savePasteScreen[client] = 3
    takePlayerScreenShot(client, 1366, 768, getPlayerName(client))
    cheatNumber[client] = 9

    for _, playerT in ipairs(getElementsByType("player")) do
        if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
            if timesDetected == 1 then
                outputChatBox("[Draven-AC] Possible kill without seeing for "..getPlayerName(client).." ("..timesDetected.." time)", playerT, 123, 168, 223, false)
            else
                outputChatBox("[Draven-AC] Possible kill without seeing for "..getPlayerName(client).." ("..timesDetected.." times)", playerT, 123, 168, 223, false)
            end
        elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
            if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                if timesDetected == 1 then
                    outputChatBox("[Draven-AC] Possible kill without seeing for "..getPlayerName(client).." ("..timesDetected.." time)", playerT, 123, 168, 223, false)
                else
                    outputChatBox("[Draven-AC] Possible kill without seeing for "..getPlayerName(client).." ("..timesDetected.." times)", playerT, 123, 168, 223, false)
                end
            end
        end
    end

    sendNotLook = {
        queueName = "aimbot-silent",
        connectionAttempts = 3,
        connectTimeout = 5000,
        formFields = {
            content = "```diff\n----------------------------------------------------\n-[Didn't see the player]\n----------------------------------------------------\n+Player Name: "..getPlayerName(client).."\n+Player IP: "..getPlayerIP(client).."\n+Player Serial: "..getPlayerSerial(client).."\n-Vezes do Not-look detectado: "..timesDetected.." vez(es)\n+Number version: "..numberVersion.."```"
        },
    }

    fetchRemote ( webhook_logs, sendNotLook, function() end )
end
addEvent("notifyKiller", true)
addEventHandler("notifyKiller", root, killedNotLook)

--------------------------------------------------------------end
--output for all---------------------------------------------------------------------------------------------------------

local antiFloodAPIS = {}
local antiFloodAPIF = {}
local antiFLOODAPIB = {}

function onSpeedCheck (text, velocidade, toggleX)
    if started == false then return end
    if not checkEvent(client, source) then return end

    for _, cargo in ipairs(CARGOS_STAFF) do
        if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(cargo)) then
            return
        end
    end

    if not antiFloodAPIS[client] then
        antiFloodAPIS[client] = false
    end

    if antiFloodAPIS[client] == true then
        return
    end
    antiFloodAPIS[client] = true

    local playerName = getPlayerName(client)
    local serialPlayer = getPlayerSerial(client)
    local ipPlayer = getPlayerIP(client)

    sendSpeedHack = {
        queueName = "speed-hack",
        connectionAttempts = 3,
        connectTimeout = 5000,
        formFields = {
            content = "```diff\n----------------------------------------------------\n-[Speed-Hack]\n----------------------------------------------------\n+Player Name: "..playerName.."\n+Player IP: "..ipPlayer.."\n+Player Serial: "..serialPlayer.."\n-Velocidade detectada: "..velocidade.." km/h (Se a velocidade é menor que a velocidade maxima definida pra veiculos e players, significa que o player esta com gameSpeed alterado.)\n+Number version: "..numberVersion.."```"
        },
    }
    fetchRemote ( webhook_logs, sendSpeedHack, function() end )

    if BAN_SPEED_DETECTED == true then
        triggerEvent("acAplicarBan", client, text)
    else
        cheatNumber[client] = 6
        for _, playerT in ipairs(getElementsByType("player")) do
            if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
                outputChatBox("[Draven-AC] Modified speed detected for "..playerName..", check the player. "..velocidade.." km/h. State X: "..tostring(toggleX), playerT, 123, 168, 223, false)
            elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
                if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                    outputChatBox("[Draven-AC] Modified speed detected for "..playerName..", check the player. "..velocidade.." km/h. State X: "..tostring(toggleX), playerT, 123, 168, 223, false)
                end
            end
        end
    end
    setTimer(function(client)
        antiFloodAPIS[client] = false
    end, 10000, 1, client)
end
addEvent("onSpeedCheck", true)
addEventHandler("onSpeedCheck", root, onSpeedCheck)

function onFlyCheck (text, toggleX)
    if started == false then return end
    if not checkEvent(client, source) then return end

    for _, cargo in ipairs(CARGOS_STAFF) do
        if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(cargo)) then
            return
        end
    end

    if not antiFloodAPIF[client] then
        antiFloodAPIF[client] = false
    end
    if antiFloodAPIF[client] == true then
        return
    end

    antiFloodAPIF[client] = true

    savePasteScreen[client] = 1
    takePlayerScreenShot(client, 800, 600, getPlayerName(client))

    local playerName = getPlayerName(client)
    local serialPlayer = getPlayerSerial(client)
    local ipPlayer = getPlayerIP(client)

    sendFlyHack = {
        queueName = "fly-hack",
        connectionAttempts = 3,
        connectTimeout = 5000,
        formFields = {
            content = "```diff\n----------------------------------------------------\n-[Fly-Hack]\n----------------------------------------------------\n+Player Name: "..playerName.."\n+Player IP: "..ipPlayer.."\n+Player Serial: "..serialPlayer.."\n-Jogador estava voando.\n+Number version: "..numberVersion.."```"
        },
    }
    fetchRemote ( webhook_logs, sendFlyHack, function() end )

    if BAN_FLY_DETECTED == true then
        triggerEvent("acAplicarBan", client, text)
    else
        cheatNumber[client] = 7
        for _, playerT in ipairs(getElementsByType("player")) do
            if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Admin")) then
                outputChatBox("[Draven-AC] Fly detected for "..playerName..", check the player. state X: "..tostring(toggleX), playerT, 123, 168, 223, false)
            elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
                outputChatBox("[Draven-AC] Fly detected for "..playerName..", check the player. state X: "..tostring(toggleX), playerT, 123, 168, 223, false)
            end
        end
    end
    setTimer(function(client)
        antiFloodAPIF[client] = false
    end, 10000, 1, client)
end
addEvent("onFlyCheck", true)
addEventHandler("onFlyCheck", root, onFlyCheck)

function takeScreenFly(theResource, status, imageData, timestamp, tag)
    if started == false then return end
    if status == 'disabled' then
        for _, playerT in ipairs(getElementsByType("player")) do
            if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
                outputChatBox("#A9A9A9[Draven-AC] "..tag.." the screenshot is disabled.", playerT, 123, 168, 223, true)
            elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
                if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                    outputChatBox("#A9A9A9[Draven-AC] "..tag.." the screenshot is disabled.", playerT, 123, 168, 223, true)
                end
            end
        end
    elseif status == 'minimized' then
        for _, playerT in ipairs(getElementsByType("player")) do
            if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
                outputChatBox("#A9A9A9[Draven-AC] "..tag.." the game is minimized.", playerT, 123, 168, 223, true)
            elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
                if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                    outputChatBox("#A9A9A9[Draven-AC] "..tag.." the game is minimized.", playerT, 123, 168, 223, true)
                end
            end
        end
    elseif status == 'error' then
        for _, playerT in ipairs(getElementsByType("player")) do
            if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
                outputChatBox("#A9A9A9[Draven-AC] Error when taking screenshot of "..tag, playerT, 123, 168, 223, true)
            elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
                if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                    outputChatBox("#A9A9A9[Draven-AC] Error when taking screenshot of "..tag, playerT, 123, 168, 223, true)
                end
            end
        end
    elseif status == 'ok' then
        if savePasteScreen[source] == 1 then
            local arquivo = fileCreate("screens_fly/" .. tag ..  ' --  ' .. tostring(timestamp) .. '.jpeg')
            local byte = fileWrite(arquivo, imageData)
            fileClose(arquivo)
            for _, playerT in ipairs(getElementsByType("player")) do
                if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
                    outputChatBox("#A9A9A9[Draven-AC] print from canvas by "..tag.." in the folder: 'screens_fly'", playerT, 123, 168, 223, true)
                elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
                    if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                        outputChatBox("#A9A9A9[Draven-AC] print from canvas by "..tag.." in the folder: 'screens_fly'", playerT, 123, 168, 223, true)
                    end
                end
            end
        elseif savePasteScreen[source] == 2 then
            local arquivo = fileCreate("screens_silent/" .. tag ..  ' --  ' .. tostring(timestamp) .. '.jpeg')
            local byte = fileWrite(arquivo, imageData)
            fileClose(arquivo)
            for _, playerT in ipairs(getElementsByType("player")) do
                if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
                    outputChatBox("#A9A9A9[Draven-AC] print from canvas by "..tag.." in the folder: 'screens_silent'", playerT, 123, 168, 223, true)
                elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
                    if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                        outputChatBox("#A9A9A9[Draven-AC] print from canvas by "..tag.." in the folder: 'screens_silent'", playerT, 123, 168, 223, true)
                    end
                end
            end
        elseif savePasteScreen[source] == 3 then
            local arquivo = fileCreate("screens_weird/" .. tag ..  ' --  ' .. tostring(timestamp) .. '.jpeg')
            local byte = fileWrite(arquivo, imageData)
            fileClose(arquivo)
            for _, playerT in ipairs(getElementsByType("player")) do
                if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
                    outputChatBox("#A9A9A9[Draven-AC] print from canvas by "..tag.." in the folder: 'screens_weird'", playerT, 123, 168, 223, true)
                elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
                    if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                        outputChatBox("#A9A9A9[Draven-AC] print from canvas by "..tag.." in the folder: 'screens_weird'", playerT, 123, 168, 223, true)
                    end
                end
            end
        elseif savePasteScreen[source] == 4 then
            local arquivo = fileCreate("screens_spiked/" .. tag ..  ' --  ' .. tostring(timestamp) .. '.jpeg')
            local byte = fileWrite(arquivo, imageData)
            fileClose(arquivo)
            for _, playerT in ipairs(getElementsByType("player")) do
                if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
                    outputChatBox("#A9A9A9[Draven-AC] print from canvas by "..tag.." in the folder: 'screens_spiked'", playerT, 123, 168, 223, true)
                elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
                    if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                        outputChatBox("#A9A9A9[Draven-AC] print from canvas by "..tag.." in the folder: 'screens_spiked'", playerT, 123, 168, 223, true)
                    end
                end
            end
        elseif savePasteScreen[source] == 5 then
            local arquivo = fileCreate("screens_single/" .. tag ..  ' --  ' .. tostring(timestamp) .. '.jpeg')
            local byte = fileWrite(arquivo, imageData)
            fileClose(arquivo)
            for _, playerT in ipairs(getElementsByType("player")) do
                if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
                    outputChatBox("#A9A9A9[Draven-AC] print from canvas by "..tag.." in the folder: 'screens_single'", playerT, 123, 168, 223, true)
                elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
                    if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                        outputChatBox("#A9A9A9[Draven-AC] print from canvas by "..tag.." in the folder: 'screens_single'", playerT, 123, 168, 223, true)
                    end
                end
            end
        elseif savePasteScreen[source] == 6 then
            local arquivo = fileCreate("screens_flick/" .. tag ..  ' --  ' .. tostring(timestamp) .. '.jpeg')
            local byte = fileWrite(arquivo, imageData)
            fileClose(arquivo)
            for _, playerT in ipairs(getElementsByType("player")) do
                if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
                    outputChatBox("#A9A9A9[Draven-AC] print from canvas by "..tag.." in the folder: 'screens_flick'", playerT, 123, 168, 223, true)
                elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
                    if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                        outputChatBox("#A9A9A9[Draven-AC] print from canvas by "..tag.." in the folder: 'screens_flick'", playerT, 123, 168, 223, true)
                    end
                end
            end
        end
    end
end
addEventHandler('onPlayerScreenShot', root, takeScreenFly)

function kickAC (text)
    if started == false then return end
    if not checkEvent(client, source) then return end

    outputChatBox(text, root, 123, 168, 223, false)
    kickPlayer(client, "Draven-AC", text)
end
addEvent("acKick", true)
addEventHandler("acKick", root, kickAC)

local antiFloodBAN = {}

function banPanelGet (text)
    if started == false then return end
    if not checkEvent(client, source) then return end

    playerSerial = getPlayerSerial(source)
    for _, serial in ipairs(SERIAL_STAFF) do
        if serial == playerSerial then
            return
        end
    end

    if not antiFloodBAN[client] then
        antiFloodBAN[client] = false
    end
    if antiFloodBAN[client] == true then
        return
    end

    antiFloodBAN[client] = true

    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup("Admin")) then
        aclGroupRemoveObject (aclGetGroup("Admin"), "user."..getAccountName(getPlayerAccount(client)))
    end
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup("Console")) then
        aclGroupRemoveObject (aclGetGroup("Console"), "user."..getAccountName(getPlayerAccount(client))) 
    end
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup("SuperModerator")) then
        aclGroupRemoveObject (aclGetGroup("SuperModerator"), "user."..getAccountName(getPlayerAccount(client))) 
    end
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup("Moderator")) then
        aclGroupRemoveObject (aclGetGroup("Moderator"), "user."..getAccountName(getPlayerAccount(client))) 
    end
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup("STAFF")) then
        aclGroupRemoveObject (aclGetGroup("STAFF"), "user."..getAccountName(getPlayerAccount(client))) 
    end
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup("guerra:juiz")) then
        aclGroupRemoveObject (aclGetGroup("guerra:juiz"), "user."..getAccountName(getPlayerAccount(client))) 
    end
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup("JUIZ-CHF")) then
        aclGroupRemoveObject (aclGetGroup("JUIZ-CHF"), "user."..getAccountName(getPlayerAccount(client))) 
    end
    
    local serialPlayer = getPlayerSerial(client)
    local ipPlayer = getPlayerIP(client)

    sendBanned = {
        queueName = "ban-AC",
        connectionAttempts = 3,
        connectTimeout = 5000,
        formFields = {
            content = "```diff\n----------------------------------------------------\n-[Draven-AC] banned\n----------------------------------------------------\n-"..text.."\n+IP player: "..ipPlayer.."\n+Serial player: "..serialPlayer.."```"
        },
    }
    fetchRemote ( webhook_ban, sendBanned, function() end )

    outputChatBox(text, root, 123, 168, 223, false)

    banPlayer ( client, true, false, true, getRootElement(), text )
end
addEvent("acBanned", true)
addEventHandler("acBanned", root, banPanelGet)

local antiFloodBAN2 = {}

function banCheatSrv (text)
    if started == false then return end

    playerSerial = getPlayerSerial(source)
    for _, serial in ipairs(SERIAL_STAFF) do
        if serial == playerSerial then
            return
        end
    end

    if not antiFloodBAN2[source] then
        antiFloodBAN2[source] = false
    end
    if antiFloodBAN2[source] == true then
        return
    end
    antiFloodBAN2[source] = true

    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup("Admin")) then
        aclGroupRemoveObject (aclGetGroup("Admin"), "user."..getAccountName(getPlayerAccount(source)))
    end
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup("Console")) then
        aclGroupRemoveObject (aclGetGroup("Console"), "user."..getAccountName(getPlayerAccount(source))) 
    end
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup("SuperModerator")) then
        aclGroupRemoveObject (aclGetGroup("SuperModerator"), "user."..getAccountName(getPlayerAccount(source))) 
    end
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup("Moderator")) then
        aclGroupRemoveObject (aclGetGroup("Moderator"), "user."..getAccountName(getPlayerAccount(source))) 
    end
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup("STAFF")) then
        aclGroupRemoveObject (aclGetGroup("STAFF"), "user."..getAccountName(getPlayerAccount(source))) 
    end
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup("guerra:juiz")) then
        aclGroupRemoveObject (aclGetGroup("guerra:juiz"), "user."..getAccountName(getPlayerAccount(source))) 
    end
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup("JUIZ-CHF")) then
        aclGroupRemoveObject (aclGetGroup("JUIZ-CHF"), "user."..getAccountName(getPlayerAccount(source))) 
    end
    
    local serialPlayer = getPlayerSerial(source)
    local ipPlayer = getPlayerIP(source)

    sendBanned = {
        queueName = "ban-AC",
        connectionAttempts = 3,
        connectTimeout = 5000,
        formFields = {
            content = "```diff\n----------------------------------------------------\n-[Draven-AC] banned\n----------------------------------------------------\n-"..text.."\n+IP player: "..ipPlayer.."\n+Serial player: "..serialPlayer.."```"
        },
    }
    fetchRemote ( webhook_ban, sendBanned, function() end )

    outputChatBox(text, root, 123, 168, 223, false)

    banPlayer ( source, true, false, true, getRootElement(), text )
end
addEvent("acAplicarBan", true)
addEventHandler("acAplicarBan", root, banCheatSrv)

--------------------------------------------------------------end
--Commands-------------------------------------------------------------------------------------------------

local saveScreenShare = {}

function screenshareActive(staff, cmd, player)
    if started == false then return end

    local haveSerial = false
    local serialPlayer = getPlayerSerial(staff)
    for _, serial in ipairs(SERIAL_STAFF) do
        if serialPlayer == serial then
            haveSerial = true
        end
    end

    if haveSerial == false then
        outputChatBox('#A9A9A9[Draven-AC] You do not have permission to run this command.', staff, 123, 168, 223, true)
        return
    end

    local conta = getAccountName(getPlayerAccount(staff))
    if isObjectInACLGroup("user."..conta, aclGetGroup("Admin")) or isObjectInACLGroup("user."..conta, aclGetGroup("Console")) or isObjectInACLGroup("user."..conta, aclGetGroup("STAFF")) then
        analisado = getPlayerFromName(player)
        if not saveScreenShare[analisado] then
            saveScreenShare[analisado] = {
                started = false,
                timer = nil,
            }
        end
        if saveScreenShare[analisado].started == false then
            outputChatBox('[Draven-AC] Time check started for '..player..".", staff, 123, 168, 223, false)
            local function updateCameraMatrix()
                triggerClientEvent(analisado, "verificarHora", analisado, true)
            end
            local timer = setTimer(updateCameraMatrix, 500, 0)
            saveScreenShare[analisado].timer = timer
            saveScreenShare[analisado].started = true
        else
            outputChatBox('[Draven-AC] Time check stopped for '..player..".", staff, 123, 168, 223, false)
            killTimer(saveScreenShare[analisado].timer)
            saveScreenShare[analisado].started = false
        end
        return
    end
    outputChatBox('#A9A9A9[Draven-AC] You do not have permission to run this command.', staff, 123, 168, 223, true)
end
addCommandHandler ( "screenshare",  screenshareActive )

function sendBypass(oldHour, oldMinutes, hour, minute)
    if not checkEvent(client, source) then return end

    for _, playerT in ipairs(getElementsByType("player")) do
        if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
            outputChatBox("[Draven-AC] Hours changed for "..getPlayerName(client)..": "..oldHour..":"..oldMinutes.." --> "..hour..":"..minute..".", playerT, 123, 168, 223, false)
        elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
            if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                outputChatBox("[Draven-AC] Hours changed for "..getPlayerName(client)..": "..oldHour..":"..oldMinutes.." --> "..hour..":"..minute..".", playerT, 123, 168, 223, false)
            end
        end
    end
    sendbypss = {
        queueName = "bypass-detected",
        connectionAttempts = 3,
        connectTimeout = 5000,
        formFields = {
            content = "```diff\n----------------------------------------------------\n-[Bypass-detected]\n----------------------------------------------------\n+Player Name: "..getPlayerName(client).."\n+Player IP: "..getPlayerIP(client).."\n+Player Serial: "..getPlayerSerial(client).."\n-Horário alterado: "..oldHour..":"..oldMinutes.." --> "..hour..":"..minute.."\n+Number version: "..numberVersion.."```"
        },
    }
    fetchRemote ( webhook_logs, sendbypss, function() end )
    killTimer(saveScreenShare[client].timer)
    saveScreenShare[client].started = false
end
addEvent("sendBypass", true)
addEventHandler("sendBypass", root, sendBypass)

local saveConsole = {}
local isObjectInConsole = {}
local isObjectInAdmin = {}
local saveTimer = {}
local saveSuspect = {}
local playerLookingDirections = {}

function adminQuit()
    staffSerial = getPlayerSerial(source)
    for _, ademir in ipairs(SERIAL_STAFF) do
        if staffSerial == ademir then
            if saveConsole[source] then
                if saveConsole[source] == true then
                    killTimer(saveTimer[source])
                    saveSuspect[source] = nil
                    saveTimer[source] = nil
                    if isObjectInConsole[source] == true then
                        aclGroupAddObject (aclGetGroup("Console"), "user."..getAccountName(getPlayerAccount(source)))
                        isObjectInConsole[source] = false
                    end
                    if isObjectInAdmin[source] == true then
                        aclGroupAddObject (aclGetGroup("Admin"), "user."..getAccountName(getPlayerAccount(source)))
                        isObjectInAdmin[source] = false
                    end
                    aclSave()
                    aclReload ()
                    return
                end
            end
        end
    end
    if saveScreenShare[source] then
        if saveScreenShare[source].started == true then
            for _, playerT in ipairs(getElementsByType("player")) do
                if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("Console")) then
                    outputChatBox("[Draven-AC] ".. getPlayerName(source).." as in screenshare mode and exited the game.", playerT, 123, 168, 223, false)
                    outputChatBox("[Draven-AC] Serial: ".. getPlayerSerial(source), playerT, 123, 168, 223, false)
                elseif isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerT)), aclGetGroup("STAFF")) then
                    if getTeamName(getPlayerTeam(playerT)) == "STAFF" then
                        outputChatBox("[Draven-AC] ".. getPlayerName(source).." as in screenshare mode and exited the game.", playerT, 123, 168, 223, false)
                        outputChatBox("[Draven-AC] Serial: ".. getPlayerSerial(source), playerT, 123, 168, 223, false)
                    end
                end
            end
            killTimer(saveScreenShare[source].timer)
            saveScreenShare[source].started = false
        end
    end
end
addEventHandler("onPlayerQuit", root, adminQuit)

function updatePlayerLookingDirection(direction)
    playerLookingDirections[source] = direction
end
addEvent("updateLookingDirection", true)
addEventHandler("updateLookingDirection", root, updatePlayerLookingDirection)

function spec(staff, cmd, player)
    if started == false then return end
    if not saveConsole[staff] then
        saveConsole[staff] = false
        isObjectInConsole[staff] = false
        isObjectInAdmin[staff] = false
        saveTimer[staff] = nil
        saveSuspect[staff] = nil
    end

    if saveConsole[staff] == true then
        if player == nil then
            local staffSerial = getPlayerSerial(staff)
            for _, ademir in ipairs(SERIAL_STAFF) do
                if staffSerial == ademir then
                    if isObjectInConsole[staff] == true then
                        aclGroupAddObject(aclGetGroup("Console"), "user."..getAccountName(getPlayerAccount(staff)))
                        isObjectInConsole[staff] = false
                    end
                    if isObjectInAdmin[staff] == true then
                        aclGroupAddObject(aclGetGroup("Admin"), "user."..getAccountName(getPlayerAccount(staff)))
                        isObjectInAdmin[staff] = false
                    end
                    aclSave()
                    aclReload()
                    killTimer(saveTimer[staff])
                    saveSuspect[staff] = nil
                    saveTimer[staff] = nil
                    setCameraTarget(staff, staff)
                    setElementFrozen(staff, false)
                    if isPedInVehicle(staff) then
                        local vehicle = getPedOccupiedVehicle(staff)
                        setElementFrozen(vehicle, false)
                    end
                    saveConsole[staff] = false
                    return
                end
            end
        end
    end

    local haveSerial = false
    local serialPlayer = getPlayerSerial(staff)
    for _, serial in ipairs(SERIAL_STAFF) do
        if serialPlayer == serial then
            haveSerial = true
        end
    end

    if haveSerial == false then
        outputChatBox('#A9A9A9[Draven-AC] You do not have permission to run this command.', staff, 123, 168, 223, true)
        return
    end

    local conta = getAccountName(getPlayerAccount(staff))
    if isObjectInACLGroup("user."..conta, aclGetGroup("Admin")) or isObjectInACLGroup("user."..conta, aclGetGroup("Console")) or isObjectInACLGroup("user."..conta, aclGetGroup("STAFF")) then

        if getTeamName(getPlayerTeam(staff)) ~= "STAFF" then
            outputChatBox("#A9A9A9[Draven-AC] You cannot run this command outside of team STAFF.", staff, 123, 168, 223, true)
            return
        end

        if player == nil then
            if getCameraTarget(staff) == staff then
                outputChatBox('#A9A9A9[Draven-AC] You are not screening anyone.', staff, 123, 168, 223, true)
                return
            end
            if isPedInVehicle(staff) then
                local vehicle = getPedOccupiedVehicle(staff)
                setElementFrozen(vehicle, false)
            end
            return
        end

        if saveConsole[staff] == true then
            outputChatBox("#A9A9A9[Draven-AC] You cannot execute this command while screening another player, use /spec first.", staff, 123, 168, 223, true)
            return
        end

        local spectado = getPlayerFromName(player)

        if not isElement(spectado) then
            outputChatBox('#A9A9A9[Draven-AC] Incorrect player nickname... Use /spec to stop screening.', staff, 123, 168, 223, true)
            return
        end

        if spectado == staff then
            outputChatBox("#A9A9A9[Draven-AC] You can't screen yourself.", staff, 123, 168, 223, true)
            return
        end

        if isPedInVehicle(staff) then
            local vehicle = getPedOccupiedVehicle(staff)
            setElementFrozen(vehicle, true)
        end

        saveConsole[staff] = true
        saveSuspect[staff] = spectado

        if isObjectInACLGroup("user."..conta, aclGetGroup("Console")) then
            aclGroupRemoveObject(aclGetGroup("Console"), "user."..getAccountName(getPlayerAccount(staff)))
            isObjectInConsole[staff] = true
        end
        if isObjectInACLGroup("user."..conta, aclGetGroup("Admin")) then
            aclGroupRemoveObject(aclGetGroup("Admin"), "user."..getAccountName(getPlayerAccount(staff)))
            isObjectInAdmin[staff] = true
        end
        aclSave()
        aclReload()
        setElementFrozen(staff, true)
        triggerClientEvent(spectado, "contarTeste", spectado, true)
        setCameraTarget(staff, spectado)
        outputChatBox('[Draven-AC] Type /spec to stop screening the player: #df7b7d'.. getPlayerName(spectado), staff, 123, 168, 223, true)
        local function updateCameraMatrix()
            local direction = playerLookingDirections[spectado]
            if not direction then direction = {lx = 0, ly = 0, lz = 0} end
            if not isPedInVehicle(spectado) then
                triggerClientEvent(staff, "contarTesteStaff", staff, true, direction.lx, direction.ly, direction.lz)
            end
        end
        local timer = setTimer(updateCameraMatrix, 40, 0)
        saveTimer[staff] = timer
    end
end
addCommandHandler('spec', spec)

function banAntiCheat(player, cmd, nameSuspect)
    if started == false then return end
    if not isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(player)), aclGetGroup("Console")) then
        if not isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(player)), aclGetGroup("Admin")) then
            outputChatBox("#A9A9A9[Draven-AC] You do not have permission to run this command.", player, 123, 168, 223, true)
            return
        end
    end

    if nameSuspect == nil or getPlayerFromName(nameSuspect) == false then
        outputChatBox("#A9A9A9[Draven-AC] Player not found.", player, 123, 168, 223, true)
        return
    end

    local suspectElement = getPlayerFromName(nameSuspect)

    if cheatNumber[suspectElement] == 0 then
        outputChatBox("#A9A9A9[Draven-AC] No cheats were detected for this player.", player, 123, 168, 223, true)
        return
    end

    local serialPlayer = getPlayerSerial(suspectElement)
    local ipPlayer = getPlayerIP(suspectElement)

    local reasonAC = ""

    if cheatNumber[suspectElement] == 1 then
        reasonAC = "Single-aimbot"
    elseif cheatNumber[suspectElement] == 2 then
        reasonAC = "Fick-aimbot"
    elseif cheatNumber[suspectElement] == 3 then
        reasonAC = "Spiked-aimbot"
    elseif cheatNumber[suspectElement] == 4 then
        reasonAC = "Silent-aimbot"
    elseif cheatNumber[suspectElement] == 5 then
        reasonAC = "Inject-code"
    elseif cheatNumber[suspectElement] == 6 then
        reasonAC = "Speed-hack"
    elseif cheatNumber[suspectElement] == 7 then
        reasonAC = "Fly-Hack"
    elseif cheatNumber[suspectElement] == 8 then
        reasonAC = "RDR-3"
    elseif cheatNumber[suspectElement] == 9 then
        reasonAC = "cheat"
    end

    if ( hasObjectPermissionTo ( player, "function.banPlayer" ) ) then

        sendBanAC = {
            queueName = "ban-AC",
            connectionAttempts = 3,
            connectTimeout = 5000,
            formFields = {
                content = "```diff\n----------------------------------------------------\n-[Draven-AC] banned\n----------------------------------------------------\n-"..reasonAC.." detectado para "..nameSuspect.."\n+IP player: "..ipPlayer.."\n+Serial player: "..serialPlayer.."```"
            },
        }
        fetchRemote ( webhook_ban, sendBanAC, function() end )

        outputChatBox("[Draven-AC] "..nameSuspect.." was banned for using "..reasonAC..".", root, 123, 168, 223, false)

        banPlayer ( suspectElement, true, false, true, getRootElement(), "\nYou have been banned for using "..reasonAC..".\ndiscord.gg/warzmta\n" )
    end
end
addCommandHandler ( "banAC",  banAntiCheat )

--------------------------------------------------------------end