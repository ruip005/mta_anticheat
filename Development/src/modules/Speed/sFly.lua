addEvent("onAntiFlyBan", true) -- Anti Fly
addEventHandler("onAntiFlyBan", root , function()
    if ac.modules.fly == false then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl))  then
        if isLogado(source) then
		addBan(source, "fly", true) -- Arrumar
        end
	end
end)