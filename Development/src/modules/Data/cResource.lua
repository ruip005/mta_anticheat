function stopAntiCheat(res)
    if localPlayer == source then
        local resource = getResourceName(res)
        for i,v in ipairs(ac.resources) do
            if getResourceName(res) == v then
                triggerServerEvent("onAntiDesativarRES", localPlayer)
                cancelEvent()
                break
            end
        end
    end
end
addEventHandler('onClientResourceStop', resourceRoot, stopAntiCheat)