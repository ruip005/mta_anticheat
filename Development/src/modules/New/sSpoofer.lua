addEvent("on-SpooferFuedase", true) -- Spoofer
addEventHandler("on-SpooferFuedase", getRootElement(), function(exists, text)
    if ac.modules.spoofer == false then
        return end
    if outros.spooferLocal then
        return end
    spooferAPI(source, authID, exists, text, (getPlayerSerial(source) or getPlayerSerial(source)), (getPlayerIP(source) or getPlayerIP(source)))
end)

-----

addEvent('ask-serial', true)
addEventHandler('ask-serial', root, function()
    if source ~= source then
        return false
    end
    local serial = getPlayerSerial(source)
    local ip = getPlayerIP(source)

    if serial and ip then
        triggersourceEvent(source, 'Create:file', root, serial, ip)
    else
        kickPlayer(source, 'Error: AntiSpoofing\n'..servidor.discord)
    end
end) 

local function verificaEVADE(serial, ip)
    if outros.spooferLocal == false or ac.modules.spoofer == false then
    return end
    local bans = getBans()

    for i, j in pairs(bans) do

        local serialBan = getBanSerial(j)
        local ipSerial = getBanIP(j)

        if (serialBan == serial) or (ipSerial == ip) then 

            local info_ban = (serialBan == serial and serialBan or ipSerial)

            banPlayer(source, true, false, true, servidor.sigla..' Anticheat', 'Spoofing Evasion:' .. (info_ban or '-'), 0)
            EnviarMensagemDiscord(discord.spoofer, getSystemLanguage("spooferD"):gsub("${nome}", getPlayerName(source)):gsub("${id}", (getElementData(source, servidor.id) or "NIL")):gsub("${ip}", getPlayerIP(source)):gsub("${serial}", getPlayerSerial(source)):gsub("${conta}", getAccountName(source)))
            reloadBans()
            return
        end
    end
end

addEvent('verificacao', true)
addEventHandler('verificacao', root, verificaEVADE)