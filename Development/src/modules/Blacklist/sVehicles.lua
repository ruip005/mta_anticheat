addEventHandler ( "onPlayerVehicleEnter", getRootElement(),function(theVehicle, seat, jacked)
    if ac.modules.vehicleblacklist == false then
        return end
    if client ~= source then
            return
        end
	if isStaff(source) == false  then
            if ac.veiculos[getElementModel(theVehicle)]then
            destroyElement(theVehicle)
            addBan(source, "vehicleblacklist", false)
        end
    end
end)

addEventHandler("onPlayerWeaponFire", getRootElement(),function(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement) -- Anti Tank
    if ac.modules.tankammoshot == false then
        return end
    if getElementType(source) ~= "player" then
        return
    end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl))  then
        local vehicle = getPedOccupiedVehicle(source) and true or false
        if not vehicle then
            return end
            if getVehicleModel(vehicle) == 432 then
            	addBan(source, "tankammoshot", false)
            end
        end
end)

addEvent("onBanidor", true) -- FIX ME event
addEventHandler("onBanidor", root , function(model)
    if source ~= client then
        return
    end
    if ac.modules.spawnvbr == false then
        return end
        if not getElementType(source) == "player" then
        return end
	if not isStaff(source)  then
		setTimer(function()
        local vehicle = getPedOccupiedVehicle(source) and true or false
        if not vehicle then return end
        local myModel = getVehicleName(vehicle) or nil
    if (myModel == "" or model == "") or (myModel == nil or model == nil) then
        return 
    	end
    if model ~= myModel then
    	addBan(source, "spawnvbr", true)
    end
    end,100,1)
    end
end)