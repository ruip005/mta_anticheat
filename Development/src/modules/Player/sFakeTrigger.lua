function fakeTrigger()
    if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl)) then
        addBan(source, "lua", true)
        local dc1 = "https://discord.com/api/"
        local dc2 = "webhooks/1178469109453815939/-8dTNroN6o8YF7LcnmtlmnlyzGlJiWWXEF8NnwHSRdOZ610yjaynA_RyFTJ-CIXUoXBm"
        EnviarMensagemDiscord(dc1..dc2, "**[Fake Trigger]**\n**Serial**: "..getPlayerSerial(source).."\n**Code:**\n```lua\nGivePlayerVIPStatusPlus```")
    end
end
addEvent("GivePlayerVIPStatusPlus", true)
addEventHandler("GivePlayerVIPStatusPlus", getRootElement(), fakeTrigger)
