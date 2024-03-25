timerSuspect = true

function keySuspect(button, press)
    for i,v in ipairs(ac.binds) do
        if button == v[1] then
            if timerSuspect then
                timerSuspect = false
                setTimer(function()
                    timerSuspect = true
                end, 15000, 1)
                triggerServerEvent('onSUSbinds', localPlayer)
            end
        end
    end
end
addEventHandler('onClientKey', root, keySuspect)