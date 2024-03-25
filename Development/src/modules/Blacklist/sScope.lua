addEvent("onAimbot", true) -- Aimbot
addEventHandler("onAimbot", root , function()
    if ac.modules.aimbot == false then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl))  then
		local punido = source
                local nome = getPlayerName(source) or getSystemLanguage("noinfo")
                local idd = getElementData(source, servidor.id) or getSystemLanguage("noinfo")
                local ip = getPlayerIP(source) or getSystemLanguage("noinfo")
                local serial = getPlayerSerial(source) or getSystemLanguage("noinfo")
                local conta = getAccountName(getPlayerAccount(source)) or getSystemLanguage("noinfo")
                local randomCode = auth.user.."_"..generateString(12)
                tirarFoto(source, randomCode, discord.aimbot)
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