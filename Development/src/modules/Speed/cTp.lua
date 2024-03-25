
local lastCoordinate = {x = 0, y = 0, z = 0}

setTimer(function()
    local inVehicle = getPedOccupiedVehicle(localPlayer)
    if inVehicle then
        local x, y, z = getElementPosition(localPlayer)
        if x == lastCoordinate.x and y == lastCoordinate.y and z == lastCoordinate.z then
        else
            local distance = getDistanceBetweenPoints3D(x, y, z, lastCoordinate.x, lastCoordinate.y, lastCoordinate.z)
            if distance > 100 then
                local jogadoresProx = getElementsWithinRange(x, y, z, 10, "player")
                if #jogadoresProx > 1 then
                    if (lastCoordinate.x == nil or lastCoordinate.y == nil or lastCoordinate.z == nil) then
                        return end
                        triggerServerEvent("onTPHack", localPlayer)
                    end
                end
            end
            lastCoordinate.x, lastCoordinate.y, lastCoordinate.z = x, y, z
        end
    end,5000, 0)