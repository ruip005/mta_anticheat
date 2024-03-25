function announceBan(reason)

    if client ~= source then
        return
    end

    local isBan = false
    local setReason = {"lua", "rpg", ""} 
    for(k,v) in ipairs(setReason) do
        if string.find(reason, v) then
            isBan = true
            break
        end
    end

    if not isStaff(source) and isBan then
        addBan(source, reason, false)
    end

    notifyStaff(getPlayerName(source).." foi banido por: "..reason) -- TO DO

    if not isStaff(source) and not isBan then
        -- TO DO - webhook
    end


end
addEvent("uw33d->announcePBan", true) -- FIX ME - i change the function name
addEventHandler("uw33d->announcePBan", getRootElement(), announceBan)