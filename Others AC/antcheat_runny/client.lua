local localPlayer = getLocalPlayer()

--Protect server---------------------------------------------------------------------------------------------------------

function skipDebugHook(sourceResource,fun, _ARG_2_, _ARG_3_, _ARG_4_, ...)
    if sourceResource == getThisResource() then return end
    return "skip"
end
addDebugHook("preFunction", skipDebugHook, {"addDebugHook"})

function checkResourceStop(_ARG_0_)
    if string.lower(getResourceName(_ARG_0_)) == string.lower(getResourceName(getThisResource())) then
        local serialPlayer = getPlayerSerial(localPlayer)
        for _, serial in ipairs(SERIAL_STAFF) do
            if serial == serialPlayer then
                return
            end
        end
        triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried to stop Anti-Cheat and was banned.")
    end
end
addEventHandler("onClientResourceStop", resourceRoot, checkResourceStop)

function CheckLuaFile(FileName)
    if type(FileName:find(".lua")) == "nil" and FileName ~= "[string \"...\"]" and FileName ~= "[string \"?\"]" then
        triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried lua executor and was banned.")
      return true
    end
    return false
end

DebugHook = addDebugHook("preFunction",
function(_ARG_0_,_ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, ...)
    if CheckLuaFile(_ARG_3_) then
      return "skip"
    end
end,{"addDebugHook","removeDebugHook","triggerServerEvent"})

if not DebugHook then
    triggerServerEvent("acKick", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried to bypass debugHook. (Kicked)")
end

--------------------------------------------------------------end
--Important functions----------------------------------------------------------------------------------------------------

local playerShooting, getFireAll = 0, 0

function math.round(number)
    return number - number % 1
end

function clientFire(weapon)
    if weapon and weapon == 31 or weapon == 30 then
        playerShooting = playerShooting + 1
        getFireAll = getFireAll + 1
    end
end
addEventHandler("onClientPlayerWeaponFire", localPlayer, clientFire)

function stopFire()
    playerShooting = 0
end
bindKey("fire", "up", stopFire)

function rmvBugFire(prevSlot, curSlot)
    if playerShooting == 0 then
        return
    end
    if getPedWeapon(localPlayer, prevSlot) == 31 or getPedWeapon(localPlayer, curSlot) == 30 then
        if getPedWeapon(localPlayer, curSlot) == 0 then
            playerShooting = 0
        end
    end
end
addEventHandler("onClientPlayerWeaponSwitch", localPlayer, rmvBugFire)

function isElementMoving(theElement)
    local keys = getBoundKeys("fire")
    if isElement(theElement) then
        if getElementType(theElement) == "player" or getElementType(theElement) == "ped" then
            if getPedTask(theElement, "secondary", 0) == "TASK_SIMPLE_USE_GUN" or isPedDoingGangDriveby(theElement) then
                return true
            end
        end
        if keys then
            for keyName, state in pairs(keys) do
                if getKeyState(keyName) then
                    return true
                end
            end
        end
        return Vector3(getElementVelocity(theElement)).length ~= 0
    end
    return false
end

--------------------------------------------------------------end
--Inject code------------------------------------------------------------------------------------------------------------

triggerEvent = triggerServerEvent("checarPlayer", localPlayer)
if not triggerEvent then
    triggerServerEvent("acKick", localPlayer, "[Draven-AC] Suspicious activity detected for ".. getPlayerName(localPlayer) .. "(Kicked)")
end

local blockedFunctions = {
    'outputChatBox',
    'getAllElementData',
    'function',
    'triggerEvent',
    'triggerClientEvent',
    'triggerServerEvent',
    'setElementData',
    'addEvent',
    'addEventHandler',
    'addDebugHook',
    'createExplosion',
    'createProjectile',
    'setElementPosition',
    'setElementHealth',
    'setPedArmor',
    'onServerHeadshot',
    'setElementHealth',
    'blowVehicle',
}

function cheatInjector(element)
    
    local serialPlayer = getPlayerSerial(localPlayer)
    for _, serial in ipairs(SERIAL_STAFF) do
        if serial == serialPlayer then
            return
        end
    end

    local text = guiGetText(element)
    local injecting = false
    for _, v in ipairs(blockedFunctions) do
      if (string.find(text,v)) then 
        injecting = true
      end
    end
    if (injecting == true ) then
        triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried lua executor and was banned.")
    end
end
addEventHandler("onClientGUIChanged", root, cheatInjector)

function pasteCheat(text)
    local serialPlayer = getPlayerSerial(localPlayer)
    for _, serial in ipairs(SERIAL_STAFF) do
        if serial == serialPlayer then
            return
        end
    end

    local injecting = false
    for _, v in ipairs(blockedFunctions) do
      if (string.find(text,v)) then 
        injecting = true
      end
    end
    if (injecting == true ) then
        triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried lua executor and was banned.")
    end
end
addEventHandler("onClientPaste", root, pasteCheat)

function checkDebugMessageClient(message, level, arquivo, line)
    if level == 1 or level == 2 then
        if arquivo == nil and line == nil then
            triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried lua executor and was banned.")
        end
    end
end
addEventHandler("onClientDebugMessage", root, checkDebugMessageClient)

function antiCodePaste()
    local serialPlayer = getPlayerSerial(localPlayer)
    for _, serial in ipairs(SERIAL_STAFF) do
        if serial == serialPlayer then
            return
        end
    end
    setClipboard("Draven-AC (Anti-Code paste)")
end
setTimer(antiCodePaste, 200, 0)

function onPreFunction( sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ... )
    
    local serialPlayer = getPlayerSerial(localPlayer)
    for _, serial in ipairs(SERIAL_STAFF) do
        if serial == serialPlayer then
            return
        end
    end

    if CheckLuaFile(luaFilename) then return end
    
    local resourceName = sourceResource and getResourceName(sourceResource)
    local arg = {...}

    --triggerServerEvent("restartResource", localPlayer, resourceName)
    triggerServerEvent("jac:detected", localPlayer, "3", resourceName, luaFilename, luaLineNumber, tostring(arg[1]))
    triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried lua executor and was banned.")
    return "skip"
end
addDebugHook( "preFunction", onPreFunction, {"loadstring", "pcall", "load"} )
  
function cancel(sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ...)
    local serialPlayer = getPlayerSerial(localPlayer)
    for _, serial in ipairs(SERIAL_STAFF) do
        if serial == serialPlayer then
            return
        end
    end

    local resourceName = sourceResource and getResourceName(sourceResource)
    local arg = {...}
    if functionName =="setElementHealth" then
        if tostring(arg[2]) == "100" then
            local px, py, pz = getElementPosition(localPlayer)
            local ax, ay, az = getElementPosition(arg[1])
            local distance = getDistanceBetweenPoints3D(px, py, pz, ax, ay, az) -- Relação da distância entre o player e o alvo.
            if distance > 300 then
                --triggerServerEvent("restartResource", localPlayer, resourceName)
                triggerServerEvent("jac:detected", localPlayer, "3", resourceName, luaFilename, luaLineNumber, tostring(arg[2]))
                triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried lua executor and was banned.")
                return "skip"
            end
            return
        end
    elseif functionName == "createProjectile" then
        if tostring(getElementType(arg[1])) == "vehicle" then -- Esse tipo de verificação pode ser removida caso não tenha veiculos como tanks no seu servidor.
            if isPedInVehicle(localPlayer) and isElement(getPedOccupiedVehicle(localPlayer)) then 
                local vehicleName = getVehicleName(getPedOccupiedVehicle(localPlayer))
                if vehicleName ~= "S.W.A.T." and vehicleName ~= "Rhino" and vehicleName ~= "Hydra" then
                    --triggerServerEvent("restartResource", localPlayer, resourceName)
                    triggerServerEvent("jac:detected", localPlayer, "3", resourceName, luaFilename, luaLineNumber, tostring(arg[1]))
                    triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried lua executor and was banned.")
                    return "skip"
                end
                return
            end
        end
    elseif functionName == "createExplosion" then
        if arg[4] == 8 then
            if isPedInVehicle(localPlayer) and isElement(getPedOccupiedVehicle(localPlayer)) then
                local vehicleName = getVehicleName(getPedOccupiedVehicle(localPlayer))
                if vehicleName ~= "S.W.A.T." and vehicleName ~= "Rhino" then
                    --triggerServerEvent("restartResource", localPlayer, resourceName)
                    triggerServerEvent("jac:detected", localPlayer, "3", resourceName, luaFilename, luaLineNumber, tostring(arg[1]))
                    triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried lua executor and was banned.")
                    return "skip"
                end
                return
            end
        end
    end

    --triggerServerEvent("restartResource", localPlayer, resourceName)
    triggerServerEvent("jac:detected", localPlayer, "3", resourceName, luaFilename, luaLineNumber, tostring(arg[1]))
    triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried lua executor and was banned.")
    return "skip"
end
addDebugHook("preFunction", cancel, {"setPedOnFire", "createProjectile", "blowVehicle", "createExplosion", "killPed", "setElementHealth"})

function checkTriggerServer(sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ...)
    if ADMIN_LEVEL_LOCK == false then return end

    local resourceName = sourceResource and getResourceName(sourceResource)
    local arg = {...}
    local serialPlayer = getPlayerSerial(localPlayer)
    for _, serial in ipairs(SERIAL_STAFF) do
        if serial == serialPlayer then
            return
        end
    end
    --print(resourceName, functionName, arg[1])
    if arg[1] == "onServerHeadshot" then
        if resourceName ~= HEADSHOT_FILE_NAME then
            --triggerServerEvent("restartResource", localPlayer, resourceName)
            triggerServerEvent("jac:detected", localPlayer, "3", resourceName, luaFilename, luaLineNumber, tostring(arg[1]))
            triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried lua executor and was banned.")
            return "skip"
        end

        if tostring(getElementType(arg[3])) == "player" then
            if arg[5] ~= 31 and arg[5] ~= 30 then
                --triggerServerEvent("restartResource", localPlayer, resourceName)
                triggerServerEvent("jac:detected", localPlayer, "3", resourceName, luaFilename, luaLineNumber, tostring(arg[1]))
                triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried lua executor and was banned.")
                return "skip"
            end

            local px, py, pz = getElementPosition(localPlayer)
            local ax, ay, az = getElementPosition(arg[3])
            local distance = getDistanceBetweenPoints3D(px, py, pz, ax, ay, az) -- Relação da distância entre o player e o alvo.

            if distance > 300 then
                --triggerServerEvent("restartResource", localPlayer, resourceName)
                triggerServerEvent("jac:detected", localPlayer, "3", resourceName, luaFilename, luaLineNumber, tostring(arg[1]))
                triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried lua executor and was banned.")
                return "skip"
            end
            
            if getPlayerTeam(arg[3]) == getPlayerTeam(localPlayer) then
                --triggerServerEvent("restartResource", localPlayer, resourceName)
                triggerServerEvent("jac:detected", localPlayer, "3", resourceName, luaFilename, luaLineNumber, tostring(arg[1]))
                triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried lua executor and was banned.")
                return "skip"
            end
        end
    end
    if arg[1] == "trigger:weapon:select" then
        if tostring(arg[3]) ~= "31" and tostring(arg[3]) ~= "30" then
            --triggerServerEvent("restartResource", localPlayer, resourceName)
            triggerServerEvent("jac:detected", localPlayer, "3", resourceName, luaFilename, luaLineNumber, tostring(arg[1]))
            triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried lua executor and was banned.")
            return "skip"
        end
    end

    local palavrasAdmin = {"aAdmin", "Admin", "Console", "SuperModerator", "Moderator", "guerra:juiz", "STAFF", "JUIZ-CHF"}
    local savePalavra = nil

    local todasAsPalavrasPresentes = false
    for _, palavra in ipairs(palavrasAdmin) do
        for _, argElement in ipairs(arg) do
            if tostring(argElement) == palavra then
                palavraPresente = true
                savePalavra = palavra
                break
            end
        end
    end
    if palavraPresente == true then 
        triggerServerEvent("jac:detected", localPlayer, "3", resourceName, luaFilename, luaLineNumber, tostring(arg[1]))
        triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried lua executor and was banned.")
        return "skip"
    end
end
addDebugHook("preFunction", checkTriggerServer, {"triggerServerEvent"})

function getBonePosition( sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ... )

    if localPlayer ~= source then return end 

    if DISABLE_GET_BONE_POSITION == true then

        local arg = {...}
        local resname = getResourceName(sourceResource)
        if resname == getResourceName(getThisResource()) then return end
        triggerServerEvent("jac:detected", localPlayer, "3", resourceName, luaFilename, luaLineNumber, tostring(arg[1]))
        return "skip"
    end
end
addDebugHook( "preFunction", getBonePosition, {"getPedBonePosition"})

--------------------------------------------------------------end
--locomotion-------------------------------------------------------------------------------------------------------------

local apertouX = false
local apertouJ = false

function blockFlySpeed ()
    if apertouX == false then
        apertouX = true
    else
        apertouX = false
    end
end
bindKey("x", "down", blockFlySpeed)

function getElementSpeed(theElement, unit)
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function veloc()
    local speed = getGameSpeed( )
    local name = getPlayerName(localPlayer)
    if speed > 2 then
        triggerServerEvent('onSpeedCheck', localPlayer, "[Draven-AC] "..name.." was caught by the speed camera. :)", math.round(speed), apertouX)
    elseif isPedInVehicle(localPlayer) and isElement(getPedOccupiedVehicle(localPlayer)) then 
        local vehicle = getPedOccupiedVehicle(localPlayer)
        local kmh_v = getElementSpeed(vehicle, 1) or 0
        if kmh_v >= VELOCIDADE_MAXIMA_VEICULOS then
            local name = getPlayerName(localPlayer)
            triggerServerEvent("onSpeedCheck", localPlayer, "[Draven-AC] "..name.." was caught by the speed camera. :)", math.round(km_v), apertouX)
        end
    elseif not isPedInVehicle(localPlayer) and isElement(localPlayer) then
        if isPedOnGround(localPlayer) and not doesPedHaveJetPack( localPlayer ) then
            local kmh_p = getElementSpeed(localPlayer, 1) or 0
            if kmh_p >= VELOCIDADE_MAXIMA_PLAYERS then
                triggerServerEvent('onSpeedCheck', localPlayer, "[Draven-AC] "..name.." was caught by the speed camera. :)", math.round(km_p), apertouX)
            end
        end
    end
end
addEventHandler('onClientRender', root, veloc)

setTimer(
    function ()
            if not getCameraTarget() or getCameraTarget() ~= localPlayer then return end 
            if getElementDimension( localPlayer ) ~= 0 or getElementInterior( localPlayer ) ~= 0 then return end  
            local playerPos = Vector3(getElementPosition( localPlayer ))
            local gameType = getPedMoveState( localPlayer )
            local actualInterior = getElementInterior(localPlayer)
            local actualDimension = getElementDimension(localPlayer)
            if gameType ~= "fall" or (not lastPos or math.floor(playerPos.z) <= math.floor(lastPos.z)) or (not lastInterior or lastInterior ~= actualInterior) or (not lastDimension or lastDimension ~= actualDimension) then 
                lastPos = playerPos
                lastInterior = actualInterior
                lastDimension = actualDimension
            elseif gameType == "fall" and not isPedOnGround(localPlayer) and not isElementInWater( localPlayer ) and not isPedInVehicle( localPlayer ) and not isTimer(timerEntrering) and not doesPedHaveJetPack( localPlayer ) then 
                local groundPos = getGroundPosition( playerPos )
                local dist = (playerPos.z - groundPos)
                local distT = #(playerPos - lastPos)
                local pingPlayer = getPlayerPing(localPlayer)
                if dist > 10 and dist <= 1000 and distT <= 200 and pingPlayer <= 200 then 
                    local x, y, z = playerPos.x, playerPos.y, playerPos.z
                    local searchRadius = 2
                    for i = 0, 360, 15 do
                        local vx = x + math.cos(math.rad(i)) * searchRadius
                        local vy = y + math.sin(math.rad(i)) * searchRadius
                        local hit, hitX, hitY, hitZ, hitElement = processLineOfSight(x, y, z + 2, vx, vy, z - 2, true, false, false, true, false, true, false)

                        if hit then
                            return false
                        end
                    end
                    if not getPedAnimation(localPlayer) then
                        local name = getPlayerName(localPlayer)
                        triggerServerEvent("onFlyCheck", localPlayer, "[Draven-AC] "..name.." It turned into a bird and flapped its wings towards the sky. (Anti-Fly)", apertouX)
                    end
                end 
            end 
    end, 1000, 0
)


--------------------------------------------------------------end
--Explosion--------------------------------------------------------------------------------------------------------------

function notWeapon()
    local armapermitida = false
    weaponType = getPedWeapon ( localPlayer )
    for _, weapon in ipairs(ARMAS_PERMITIDAS) do
        if weaponType == weapon[1] then
            armapermitida = true
            break
        end
    end

    if not armapermitida then
        triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..getPlayerName(localPlayer).." tried to pull a prohibited weapon and was banned.")
    end
end
addEventHandler('onClientRender', root, notWeapon)

function projectileCreation( creator )

    if getElementType(creator) == "player" then
        local projectileType = getProjectileType(source)
        if projectileType == 16 then
            local name = getPlayerName(creator)
            triggerServerEvent("acBanned", localPlayer, "[Draven-AC] "..name.." tried to play explosive and was banned.")
        end
    end
end
addEventHandler( "onClientProjectileCreation", root, projectileCreation )

--------------------------------------------------------------end
--Single aimbot----------------------------------------------------------------------------------------------------------

local errouTiro, pegouNoCorpo, activeRemoveProjectiles = false, false, false
local Cache, saveSingleKill, countHeadshot = 0, 0, 0
local ultimoTargetAim = nil

function checkAimCollision(attacker, weapon, bodypart, loss)
    local alvo = getPedTarget(localPlayer)
    if isElement(alvo) and getElementType(alvo) == "player" then
        if attacker == getLocalPlayer() and playerShooting == 0 then
            if bodypart == 9 then
                if weapon == 31 or weapon == 30 then
                    if isElementMoving(alvo) then
                        if Cache then
                            if ultimoTargetAim == alvo then
                                return
                            end
                            Cache = Cache + 1 -- +1 headshot
                            if errouTiro == true then
                                Cache = 0 -- Errou tiro antes
                                errouTiro = false
                            end
                            if pegouNoCorpo == true then
                                Cache = 0 -- Tiro no corpo antes
                                pegouNoCorpo = false
                            end
                            if getFireAll >= 2 then
                                Cache = 0 -- errou tiro antes (Anti-reset-fires)
                                getFireAll = 0
                            end
                            if Cache == 1 then
                                saveSingleKill = saveSingleKill + 1
                                triggerServerEvent("outputAimbotSingle", localPlayer, saveSingleKill)
                                Cache = 0
                            end
                            activeRemoveProjectiles = true
                            ultimoTargetAim = alvo
                        end
                    end
                end
            else
                pegouNoCorpo = true
                Cache = 0 -- Pegou no corpo
            end
        else
            if playerShooting >= 2 then -- errou tiro
                errouTiro = true
                Cache = 0
            end
        end
        setTimer(function() -- Limpar munições após matar o alvo.
            if activeRemoveProjectiles == true then
                getFireAll = 0
                activeRemoveProjectiles = false
            end
            ultimoTargetAim = nil
        end, 200, 1)
    end
end
addEventHandler('onClientPlayerDamage', getRootElement(), checkAimCollision)

--------------------------------------------------------------end
--Flick-Aimbot-----------------------------------------------------------------------------------------------------------

local saveCheatDetected = 0
local saveDisp1, diference = 0, 0
local ultimoTarget, enterThis = nil, false

function playersAlinhados(x1, y1, z1, x2, y2, z2)

    local xMe, yMe, zMe = getElementPosition(localPlayer)

    -- Vetor direcional do jogador 1 para o jogador 2
    local vec1 = {x2 - x1, y2 - y1, z2 - z1}

    -- Vetor direcional do jogador 1 para player
    local vec2 = {xMe - x1, yMe - y1, zMe - z1}

    -- Verificar se os vetores são paralelos (produto cruzado igual a zero)
    local crossProduct = vec1[1] * vec2[2] - vec1[2] * vec2[1]

    if math.abs(crossProduct) <= 20 then
        return true -- Se a angulação é menor ou igual a 20
    else
        return false -- Se a angulação é maior que 20
    end
end

function distanceGet(x1, y1, z1, x2, y2, z2)

    local distance = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
    local proximityThreshold = 3 -- Distancia permitida do 1º player para o 2º player morto.
    if distance > proximityThreshold then
        return true -- Maior que 5
    else
        return false -- Menor ou igual a 5
    end
end

function puxadaCheater(attacker, weapon, bodypart, loss)

    local playersOnlines = getElementsByType("player")
    if #playersOnlines <= 2 then
        return
    end

    local alvo = getPedTarget(localPlayer)
    if isElement(alvo) and getElementType(alvo) == "player" then
        if attacker == localPlayer then
            if bodypart == 9 then
                if weapon == 31 or weapon == 30 then
                    if ultimoTarget == nil then
                        countHeadshots = 1
                        setTimer(function()
                            countHeadshots = 0 
                            enterThis = false
                            ultimoTarget = nil
                            falseHeadshot = false
                            diference = 0
                            saveDisp1 = 0
                        end, 700, 1)
                        ultimoTarget = alvo
                        enterThis = true
                        saveDisp1 = playerShooting
                    elseif enterThis == true then
                        if ultimoTarget == alvo then
                            return
                        end
                        countHeadshots = countHeadshots + 1
                        if countHeadshots >= 2 then
                            if playerShooting > saveDisp1 then
                                diference = playerShooting - saveDisp1
                            end
                            local x1, y1, z1 = getElementPosition(alvo)
                            local x2, y2, z2 = getElementPosition(ultimoTarget)
                            if playersAlinhados(x1, y1, z1, x2, y2, z2) == false then -- Verificar se não estão alinhados
                                if distanceGet(x1, y1, z1, x2, y2, z2) == true then -- Verificar se não estão próximos
                                    saveCheatDetected = saveCheatDetected + 1
                                    triggerServerEvent("outputAimbotFlick", localPlayer, saveCheatDetected, diference)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
addEventHandler('onClientPlayerDamage', getRootElement(), puxadaCheater)

--------------------------------------------------------------end
--Spiked Aimbot---------------------------------------------------------------------------------------------------------

local contadorSuspect, countDetectCravar = 0, 0
local resetSuspect = false

function isPedAiming(thePedToCheck)
    if isElement(thePedToCheck) then
        if getElementType(thePedToCheck) == "player" then
            if getPedTask(thePedToCheck, "secondary", 0) == "TASK_SIMPLE_USE_GUN" or isPedDoingGangDriveby(thePedToCheck) then
                return true
            end
        end
    end
    return false
end

function cravouMira()
    local alvo = getPedTarget(localPlayer)

    if alvo == false then
        return
    end

    if not isPedAiming(localPlayer) then
        return
    end

    if isElement(alvo) and getElementType(alvo) == "player" then

        if getPlayerTeam(localPlayer) == getPlayerTeam(alvo) then
            return
        end

        local px, py, pz = getElementPosition(localPlayer)
        local ax, ay, az = getElementPosition(alvo)
        local distance = getDistanceBetweenPoints3D(px, py, pz, ax, ay, az) -- Relação da distância entre o player e o alvo.

        local x1, y1, z1 = getPedBonePosition(alvo, 7)
        local x2, y2, z2 = getPedTargetCollision(localPlayer)
        local distanceToHead = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2) -- Relação da distância entre a mira do player e a cabeça do alvo.

        local headRadius = 0.185 -- Posição head
        if Vector3(getElementVelocity(alvo)).length ~= 0 then  -- Verifica se o alvo esta correndo.
            if distanceToHead <= headRadius then -- Mirando na cabeça do alvo.
                if resetSuspect == true then
                    contadorSuspect = 0
                    resetSuspect = false
                end
                contadorSuspect = contadorSuspect + 1
                if contadorSuspect == 8 and distance <= 40 then
                    countDetectCravar = countDetectCravar + 1
                    triggerServerEvent("outputAimbotSpiked", localPlayer, countDetectCravar, math.round(distance))
                    resetSuspect = true
                elseif contadorSuspect == 5 and distance > 40 then
                    countDetectCravar = countDetectCravar + 1
                    triggerServerEvent("outputAimbotSpiked", localPlayer, countDetectCravar, math.round(distance))
                    resetSuspect = true
                end
            else
                resetSuspect = true -- Não está mirando na cabeça do alvo.
            end
        end
    else
        resetSuspect = true -- Não está mirando em nenhum alvo.
    end
end
setTimer(cravouMira, 100, 0)

--------------------------------------------------------------end
--Silent aimbot-----------------------------------------------------------------------------------------------------------

local countSilent = 0
local jogadorMaisProximo = nil
local savePlayerHeadshot = nil

function getPlayerMaisProximoSemColShape()
    local x, y, z = getElementPosition(localPlayer)

    local distanciaMinima = math.huge

    for _, player in ipairs(getElementsByType("player")) do
        if player ~= localPlayer then
            if getPlayerTeam(player) ~= getPlayerTeam(localPlayer) then
                if not isPedDead (player) then
                    local x2, y2, z2 = getElementPosition(player)
                    local screenX, screenY = getScreenFromWorldPosition(x2, y2, z2)
                    if screenX and screenY then
                        local distancia = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
                        if distancia < distanciaMinima then
                            distanciaMinima = distancia
                            jogadorMaisProximo = player
                        end
                    end
                end
            end
        end
    end
end
addEventHandler('onClientPlayerWeaponFire', getRootElement(), getPlayerMaisProximoSemColShape)

function siletAim(attacker, weapon, bodypart, loss)

    local alvo = getPedTarget(localPlayer)

    if not isPedAiming(localPlayer) then
        return
    end
    
    if attacker == localPlayer then
        if bodypart == 9 then
            local x1, y1, z1 = getPedBonePosition(jogadorMaisProximo, 7)
            local x2, y2, z2 = getPedTargetCollision(localPlayer)
            local distanceToHead = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
            local headRadius = 3
            if weapon == 31 or weapon == 30 then
                if savePlayerHeadshot ~= jogadorMaisProximo then
                    if distanceToHead > headRadius and alvo == false then
                        countSilent = countSilent + 1
                        triggerServerEvent("outputAimbotSilent", localPlayer, countSilent)
                    end
                    savePlayerHeadshot = jogadorMaisProximo
                end
            end
        end
    end
end
addEventHandler('onClientPlayerDamage', getRootElement(), siletAim)

--------------------------------------------------------------end
--Not Look---------------------------------------------------------------------------------------------------------------

local pedBodyAttachments = {}

local function createHeadAttachment(player)
    if not pedBodyAttachments[player] then
        pedBodyAttachments[player] = {}
        pedBodyAttachments[player]['head'] = createColSphere(0, 0, 0.9, 0.1)
        local x, y, z = getElementPosition(pedBodyAttachments[player]['head'])
        attachElements(pedBodyAttachments[player]['head'], player, x, y, z)
    end
end

local function removeHeadAttachment(player)
    if pedBodyAttachments[player] then
        for i, v in pairs(pedBodyAttachments[player]) do
            if isElement(v) then destroyElement(v) end
        end
        pedBodyAttachments[player] = {}
    end
end

addEventHandler("onClientResourceStart", resourceRoot, function()
    for i, v in pairs(getElementsByType("player")) do
        if v ~= localPlayer then
            createHeadAttachment(v)
        end
    end
end)

addEventHandler("onClientPlayerJoin", root, function()
    createHeadAttachment(source)
end)

addEventHandler("onClientPlayerQuit", root, function()
    removeHeadAttachment(source)
end)

local saveKillsEstranhas = 0

function notLook(player)
    local x, y, z = getCameraMatrix()
    local bodyParts = pedBodyAttachments[player] or {[1] = player}
    local isSafeKill = false

	for i,v in pairs(bodyParts) do
        local x1, y1, z1 = getElementPosition(v)
        if isLineOfSightClear(x, y, z, x1, y1, z1, true, false, false, true, false, true, true, player) then
            isSafeKill = true
        end
    end

    if isSafeKill == false then
        saveKillsEstranhas = saveKillsEstranhas + 1
        triggerServerEvent("notifyKiller", localPlayer, saveKillsEstranhas)
    end
end
addEvent("checkVision", true)
addEventHandler("checkVision", root, notLook)

--------------------------------------------------------------end
--Spectate---------------------------------------------------------------------------------------------------------------

local playerLookingDirection = { x = 0, y = 0, z = 0, lx = 0, ly = 0, lz = 0 }
local timer = nil

function chamarTimer(bool)
    if bool == true then
        timer = setTimer(cameraGet, 20, 0)
    else
        killTimer(timer)
    end
end
addEvent("contarTeste", true)
addEventHandler("contarTeste", root, chamarTimer)

function cameraGet()
    local w, h = guiGetScreenSize ()
    local x, y, z = getCameraMatrix()
    local lx, ly, lz = getWorldFromScreenPosition ( w/2, h/2, 300 )
    playerLookingDirection = { x = x, y = y, z = z, lx = lx, ly = ly, lz = lz }
    triggerServerEvent("updateLookingDirection", localPlayer, playerLookingDirection)
end

function chamarTimer2(bool, x, y, z, spectado)
    if bool == true then
        setCameraTarget ( x, y, z )
    end
end
addEvent("contarTesteStaff", true)
addEventHandler("contarTesteStaff", root, chamarTimer2)

--------------------------------------------------------------end
--Verify timer-----------------------------------------------------------------------------------------------------------

local saveHours = {
    hours = -1,
    minutes = -1,
}

function checarHora()
    local time = getRealTime()
    local hour = time.hour
    local minute = time.minute

    if saveHours.hours ~= -1 then
        if hour < saveHours.hours or minute < saveHours.minutes then
            triggerServerEvent("sendBypass", localPlayer, saveHours.hours, saveHours.minutes, hour, minute)
            return
        end
    end
    saveHours.hours = hour
    saveHours.minutes = minute
end
addEvent("verificarHora", true)
addEventHandler("verificarHora", root, checarHora)