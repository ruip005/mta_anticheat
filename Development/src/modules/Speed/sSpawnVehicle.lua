addEvent('onpCarroCHEAT', true) -- Puxar carro (Arrumar adicionar garagens e acl vip)
addEventHandler('onpCarroCHEAT', getRootElement(),function()
    if ac.modules.getcar == false then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl))  then

		local player = getLocalPlayer()
		local playerX, playerY, playerZ = getElementPosition(player)
		
		for _, garagem in ipairs(ac.getcar.garagens) do
        local garagemX, garagemY, garagemZ = garagem[1], garagem[2], garagem[3]
        local distancia = calcularDistancia(playerX, playerY, playerZ, garagemX, garagemY, garagemZ)
        
        if distancia <= 50 then
            return
        end
    	end

		addBan(source, "getcar", false)
	end
end)