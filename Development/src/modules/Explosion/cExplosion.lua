function getProjectileBoomTime(creator)
    if localPlayer == creator then
    if getPlayerWeapon(localPlayer) == 0 then
        triggerServerEvent("onBanirERRIPJ", localPlayer)
        destroyElement(source)
    end
end
end
addEventHandler("onClientProjectileCreation", root, getProjectileBoomTime)

----

function onClientExplosion(x, y, z, theType)
    if ac.modules.rpgvbr == false then
        return
    end
    if localPlayer == source then
        for i,v in ipairs(ac.explosion) do
            if theType == v[1] then
                if v[2] == true then
                    triggerServerEvent("onBanirExplosao", localPlayer)
                else
                    outputChatBox("[AC] Nós detectamos que você está usando um mod de explosão, por favor pare de usar cheats :D")
                end
            end
        end
        cancelEvent(true)
    end
end
addEventHandler('onClientExplosion', root, onClientExplosion)