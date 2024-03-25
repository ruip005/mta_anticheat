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