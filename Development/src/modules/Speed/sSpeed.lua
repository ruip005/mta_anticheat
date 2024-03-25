addEvent("onSpeedSUS", true)
addEventHandler("onSpeedSUS", root , function()-- Speed Hack
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl))  then
		addBan(source, "speed", false)
	end
end)