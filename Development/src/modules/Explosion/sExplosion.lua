function explosao()
    if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl)) then
        addBan(source, "explosion", false)
    end
end
addEvent("onBanirExplosao", true)
addEventHandler("onBanirExplosao", getRootElement(),explosao)
