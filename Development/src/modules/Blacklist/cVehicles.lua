addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer, seat)
            if thePlayer == getLocalPlayer() then
                local modelo = getPedOccupiedVehicle ( thePlayer )
                modelo = getVehicleName(modelo) or nil
            if modelo == "" or modelo == nil then
                return
            end
            triggerServerEvent("onBanidor", localPlayer, modelo)
        end
    end
    )

    -------

    local puxarVeiculoV = false
    function puxVeiculo() -- Arrumar
    local x,y,z = getElementPosition( localPlayer ) 
    local veiculosProx = getElementsWithinRange(x, y, z, 26, "vehicle")
    if #veiculosProx == 0 then
        puxarVeiculoV = true
    else
        puxarVeiculoV = false
    end
    end
    
    setTimer(puxVeiculo , 800, 0)
    
    function puxVeiculo1(player, seat, door)
        if puxarVeiculoV then 
            if player == localPlayer and seat == 0 then
                if isElement(player) and getElementType(player) == "player" then
                    local x, y, z = getElementPosition(player)
                    local coordinates = {x = x, y = y, z = z}
                    triggerServerEvent("onpCarroCHEAT", localPlayer, coordinates)
                end
            end
        end
    end
    addEventHandler("onClientVehicleStartEnter", root, puxVeiculo1)


    -----
    
function veloc()
    if isPedInVehicle(localPlayer) and isElement(getPedOccupiedVehicle(localPlayer)) then 
        local vehicle = getPedOccupiedVehicle(localPlayer)
        local kmh = getElementSpeed(vehicle, 1) or 0
        if kmh >= outros.velocidademax then
            triggerServerEvent('onSpeedSUS', localPlayer)
        else

        end
    end
end
addEventHandler('onClientRender', root, veloc)