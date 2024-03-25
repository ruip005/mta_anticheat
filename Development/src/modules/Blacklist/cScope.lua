Cache = {}

function verifyAim(attacker, weapon, bodypart, loss)
    if attacker == getLocalPlayer() then
        if bodypart == 9 then
            local vehicle = getPedOccupiedVehicle(source)
            if vehicle then
            end
            --local Desmaiado = getElementData(source, 'Desmaiado') or false 
            local Staff = getElementData(source, servidor.staff) or false
            --if not Desmaiado then
            if not Staff then
                if not Cache.Numbers then
                    Cache = {Numbers = 0}
                end
                if Cache then
                    Cache = {Numbers = Cache.Numbers + 1}
                    setTimer(function()
                        Cache = {Numbers = 0}
                    end, 3000, 1)
                    if Cache.Numbers == 5 then
                        triggerServerEvent('onAimbot', localPlayer)
                    end
                end
            end
            --end
        end
    end
end
addEventHandler('onClientPedDamage', getRootElement(), verifyAim)
addEventHandler('onClientPlayerDamage', getRootElement(), verifyAim)