function bindsSUS() -- Binds
    local nome = getPlayerName(source) or getSystemLanguage("noinfo")
    local idd = getElementData(source, servidor.id) or getSystemLanguage("noinfo")
    local ip = getPlayerIP(source) or getSystemLanguage("noinfo")
    local serial = getPlayerSerial(source) or getSystemLanguage("noinfo")
    local conta = getAccountName(getPlayerAccount(source)) or getSystemLanguage("noinfo")
    local randomCode = auth.user.."_"..generateString(12)
    tirarFoto(source, randomCode, discord.binds)
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