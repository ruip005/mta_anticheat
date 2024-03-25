function checkSpeed()
    local speed = getGameSpeed()
    if speed > 2 then
        triggerServerEvent('onSpeedSUS', localPlayer)
    end
end
setTimer(checkSpeed, 2000, 0)