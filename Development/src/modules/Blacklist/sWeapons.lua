addEventHandler ("onPlayerWeaponFire", getRootElement(),function(weapon, endX, endY, endZ, hitElement, startX, startY, startZ) 
    if ac.modules.rpgvbr == false then
        return end
	local weaponID = getPedWeapon(source)
    if weaponID == 36 or weaponID == 35 or weapon == 36 or weapon == 35 then
        if not isStaff(source)  then
        	addBan(source, "rpgvbr", false)
        end
    end
end)

addEventHandler ( "onPlayerWasted", getRootElement(),function(ammo, attacker, weapon, bodypart)
    if ac.modules.weaponkill == false then
        return end
	if attacker then
        if not isStaff(attacker)  then
            local cheater = false
            local armaid = tonumber(weapon)
            for i,v in ipairs(ac.armas) do
                if ac.armas[i][1] == armaid then
                    cheater = true
                end
            end
    ---
    if cheater == true then
    	addBan(attacker, "weaponkill", false)
    end
	end
	end
end)

addEvent('onFireRateCHEAT', true) -- Fire rate
addEventHandler('onFireRateCHEAT', getRootElement(),function()
    if ac.modules.firerate == false then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl))  then
		addBan(source, "firerate", false)
	end
end)

addEvent('onCHECKWEAPONEXIST', true) -- Invisible weapon Arrumar
addEventHandler('onCHECKWEAPONEXIST', getRootElement(),function(arma, ant)
    if ac.modules.invisibleweapon == false then
        return end
   	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl))  then
   	local maoagora = getPedWeapon(source)
    	if maoagora == arma or maoagora == ant then
            for i,wep in ipairs(getPedWeapons(source)) do
            if wep == arma then
                return
            end
        end
        return end 
   		addBan(source, "invisibleweapon", false)
   	end
   end)


   addEvent('onBANWEAPONCHEATER', true)
addEventHandler('onBANWEAPONCHEATER', getRootElement(),function(arma) -- Weapon Blacklist
    if ac.modules.weaponblacklist == false then
        return end
	if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup(servidor.acl))  then
        for i,v in ipairs(ac.armas) do
            if ac.armas[i][1] == arma then
                iprint("BAN")
                addBan(source, "weaponblacklist", false)
                outputDebugString("BAN:WeaponBlacklist, "..getPlayerName(source).." ["..getElementData(source, servidor.id).."] Arma:"..getWeaponNameFromID(arma).."| ID:"..arma.."")
            end
        end
	end
end)