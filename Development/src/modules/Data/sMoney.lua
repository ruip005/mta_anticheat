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