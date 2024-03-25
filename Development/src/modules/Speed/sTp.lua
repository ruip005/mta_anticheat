addEvent("onTPHack", true) -- TP HACK
addEventHandler("onTPHack", getRootElement(),function(jogadoresProx)
    if ac.modules.tphack == false then
        return end
    local toBanned = true
    if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl))  then
        if jogadoresProx == nil or #jogadoresProx == nil then
            return end
        for i,v in ipairs(jogadoresProx) do
            if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(v)), aclGetGroup(servidor.acl)) then
                if getElementInterior(source) ~= 0 then
                    return
                end
                if getElementDimension (source) ~= 0 then
                    return
                end
                toBanned = false
            else
            end
        end
        if toBanned then
            addBan(source, "tphack", false)
        end
    end
end)