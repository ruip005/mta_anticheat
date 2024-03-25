
function getPlayerFromID(id)
    if (id) then
        for i, v in ipairs(getElementsByType("player")) do
            if not isGuestAccount(getPlayerAccount(v)) then
                if tonumber((getElementData(v, servidor.id)) == tonumber(id)) then
                    return v
                end
            end
        end
    end
    return false
end

function notifyStaff(message)
    for i, receiver in ipairs(getElementsByType('player')) do
        if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(receiver)), aclGetGroup(servidor.acl)) then
            if getElementData(receiver, servidor.staff) then
                notify(receiver, "[AC] "..message, "info")
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

function ipAllowed(ip) -- FIX ME - I changed the name of the function
    local existeIP = dbPoll(dbQuery(vpnSys, 'select * from ipAllowByADM where ip = ?', ip), - 1)
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

setTimer(function() -- Anti Bypass
	screenshotsImg = {}
    if isAutorizado == false then
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
	local query = dbQuery(bans, 'select * from bans where serial = ? or ip = ?', serial, ip)
	local res = dbPoll(query, -1)
	if #res ~= 0 then
		return true
	else
		return false
	end 
end