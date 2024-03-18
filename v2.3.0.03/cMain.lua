function somBAN(musica)
    musicPlay = playSound(musica)
    setSoundVolume(musicPlay, 0.5)
end
addEvent( "onSomBAN", true )
addEventHandler( "onSomBAN", localPlayer, somBAN )

---

function checkJetpackUsage()
    -- Obtém o jogador local
    local player = localPlayer
    -- Verifica se o jogador está usando um jetpack
    if doesPedHaveJetPack ( player ) then
        triggerServerEvent("onJetpackhack", localPlayer)
    end
end
setTimer(checkJetpackUsage, 3000, 0)

-------
-- Anti Fly
--[[
setTimer(
function()
    local gameType = getPedMoveState( localPlayer )
    local playerPos = Vector3(getElementPosition( localPlayer )).z
    if gameType ~= "fall" or (not lastPos or playerPos <= lastPos) then 
        lastPos = playerPos
    elseif gameType == "fall" and not isPedOnGround(localPlayer) and not isElementInWater( localPlayer ) and not isPedInVehicle( localPlayer ) and not isTimer(timerEntrering) and not doesPedHaveJetPack( localPlayer ) then 
        local groundPos = getGroundPosition( Vector3(getElementPosition( localPlayer )) )
        local dist = (playerPos - groundPos)
        if dist > 10 then 
            triggerServerEvent("onAntiFlyBan", localPlayer)
        end 
    end
end
, 1000, 0)]]
---

--------------------------------------------------
-- NOVO
addEvent("onMyClientScreenShot",true)
addEventHandler( "onMyClientScreenShot", root,
    function( pixels )
        if image then
            destroyElement(image)
        end
        image = dxCreateTexture( pixels )
        setTimer(function()
            image = nil
            --destroyElement(image)
        end, 15000, 1)
    end
    )

--------------------------------------------------
-- Show image
addEventHandler( "onClientRender", root,
    function()
        if image then
            dxDrawImage( 20, 250, 320, 200, image )
        end
    end
    )

addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer, seat)
        setTimer(function()
            if thePlayer == getLocalPlayer() then
                local modelo = getPedOccupiedVehicle ( thePlayer )
                modelo = getVehicleName(modelo) or nil
            --outputChatBox(modelo)
            if modelo == "" or modelo == nil then
                return
            end
            triggerServerEvent("onBanidor", localPlayer, modelo)
        end
    end, 8000, 1)
    end
    )

---New2

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

--- WALL HACK STAFF

mostrar = false
function ativarDesativar ()
    if source == localPlayer then
        mostrar = not mostrar
    end
end
addEvent ("ativarWall", true)
addEventHandler ("ativarWall", getRootElement(), ativarDesativar)

function renderizar ()
    if mostrar == true then
        local renderizados = getElementsByType ("player")
        if renderizados and #renderizados > 0 then
            for i=1, #renderizados do
                local boneco = renderizados[i]
                if isElement (boneco) then
                    local x,y,z = getElementPosition (localPlayer)
                    local px,py,pz = getElementPosition (boneco)
                    local dist = math.round(getDistanceBetweenPoints3D (x,y,z,px,py,pz))
                    if ac.wall.distance and dist > ac.wall.distance then

                    else
                        local nome = getPlayerName (boneco)
                        local id = getElementData(boneco, servidor.id) or ""
                        local vida = math.round(getElementHealth (boneco)) or 100
                        local colete = math.round(getPedArmor (boneco)) or 0
                        dxDrawLine3D (x,y,z,px,py,pz)
                        dxDrawTextOnElement(boneco, "["..dist.."m]".." "..removeHex(nome).." ".."["..id.."]", 1.2, distanciaMaxima, 255, 255, 255, 255, 1.6, "default", false, false, false, false, true)
                    end
                else
                    table.remove (renderizados, i)
                end
            end
        end
    end
end
addEventHandler ("onClientRender", root, renderizar)

function math.round(number)
    return number - number % 1
end

function dxDrawBorderedText (outline, text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    for oX = (outline * -1), outline do
        for oY = (outline * -1), outline do
            dxDrawText (text, left + oX, top + oY, right + oX, bottom + oY, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
        end
    end
    dxDrawText (text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end

function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
    local x, y, z = getElementPosition(TheElement)
    local x2, y2, z2 = getCameraMatrix()
    local distance = distance or 20
    local height = height or 1

    if (isLineOfSightClear(x, y, z+2, x2, y2, z2, ...)) then
        local sx, sy = getScreenFromWorldPosition(x, y, z+height)
        if(sx) and (sy) then
            local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
            if(distanceBetweenPoints < distance) then
                dxDrawBorderedText(2,text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center", false, false)
            end
        end
    end
end

function removeHex(str)
    local nString = str

    while string.find(nString, "#%x%x%x%x%x%x") do
        nString = string.gsub(nString, "#%x%x%x%x%x%x", "")
    end

    return nString
end

--- new 5
function checkSpeed()
    local speed = getGameSpeed()
    if speed > 2 then
        triggerServerEvent('onSpeedSUS', localPlayer)
    end
end
setTimer(checkSpeed, 15000, 0)

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

--new 6 (new git 1)

local antispamINVWEAPON = false

function disableMinigunOnSwitch(prevSlot, curSlot)
    for i,v in ipairs(ac.armas) do
        if getPedWeapon(localPlayer, curSlot) == ac.armas[i][1] then
            triggerServerEvent('onBANWEAPONCHEATER', localPlayer, ac.armas[i][1])
        end
    end
---- git new 2 (anti arma invisivel)
local arma = getPedWeapon(localPlayer, curSlot)
local ant = getPedWeapon(localPlayer, prevSlot)
    --exports.vrp_info:addBox(arma, "info")
    if antispamINVWEAPON then
        return end
        triggerServerEvent('onCHECKWEAPONEXIST', localPlayer, arma, ant)
        antispamINVWEAPON = true 
    end
    addEventHandler("onClientPlayerWeaponSwitch", localPlayer, disableMinigunOnSwitch)

----- git new 3 (Noclip, fire rate)
local tiross = 0
local banirT = false
function contarTiros(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
    if weapon == 38 or weapon == 37 or weapon == 28 or weapon == 32 then
        return end
        tiross = tiross + 1
        if tiross > 27 then
            if banirT then
                return end
                triggerServerEvent("onFireRateCHEAT", localPlayer)
            end
        end
        addEventHandler ( "onClientPlayerWeaponFire", localPlayer, contarTiros )

        setTimer(function()
            tiross = 0
        end, 2000, 0)

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


----new 1.3
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

function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

-----

local font = dxCreateFont("files/fonts/medium.ttf", 8)

function dx()
    local alphaCount = interpolateBetween(255, 0, 0, 200, 0, 0, ((getTickCount() - tickPisck) / 4000), 'SineCurve')
    local timer = giveCounter(((getRealTime().timestamp-timestamp)*1000))
    dxDrawImage(20, 644, 196, 104, "files/imgs/base.png")
    dxDrawImage(199, 656, 5, 5, "files/imgs/ellipse.png", 0, 0, 0, tocolor(255, 255, 255, alphaCount))
    dxDrawText(getSystemLanguage("sharingscreen"), 60, 656, 135, 16, tocolor(255, 255, 255, 60), 1.00, font, "left", "center", false, false, false, false, false)
    dxDrawText(getSystemLanguage("time")..timer, 73, 671, 88, 16, tocolor(255, 255, 255, 35), 1.00, font, "left", "center", false, false, false, false, false)
    dxDrawText(getSystemLanguage("warningnoquit"), 33, 703, 173, 32, tocolor(255, 255, 255, 25), 1.00, font, "left", "top", false, true, false, false, false)
end

addEvent("JOAO.openScreenShare", true)
addEventHandler("JOAO.openScreenShare", root,
    function(timestamp_)
        if not isEventHandlerAdded("onClientRender", root, dx) then
            timestamp = timestamp_
            tickPisck = getTickCount()
            addEventHandler("onClientRender", root, dx)
        end
    end)

addEventHandler("onClientClick", root,
    function(_, state)
        if state == "up" then
            if isEventHandlerAdded("onClientRender", root, dx) then
            end
        end
    end)

function closeMenu()
    if isEventHandlerAdded("onClientRender", root, dx) then
        removeEventHandler("onClientRender", root, dx)
    end
end
addEvent("JOAO.stopScreenShare", true)
addEventHandler("JOAO.stopScreenShare", root, closeMenu)

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == "string" and isElement( pElementAttachedTo ) and type( func ) == "function" then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == "table" and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

---- Casper things Arrumar

function loadstringDetect(sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ...)
    local args = {...}
    local resourceName = sourceResource and getResourceName(sourceResource)
    triggerServerEvent("jac:detected", localPlayer, "3", resourceName, luaFilename, luaLineNumber, args[1])
    return 'skip'
end
addDebugHook("preFunction", loadstringDetect, {"loadstring", "pcall", "load"})

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

----- Novas Funcionalidades ------

local function caractereAleatorio()
    local caracteres = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*"
    local rand = math.random(1, #caracteres)
    return caracteres:sub(rand, rand)
end

local function textoAleatorio(comprimento)
    local texto = ""
    for i = 1, comprimento do
        texto = texto .. caractereAleatorio()
    end
    return texto
end

function verifyScreen()
    if not dxGetStatus().AllowScreenUpload then
        triggerServerEvent("onKickTela", localPlayer)
        clearChatBox()
    end
end
setTimer(verifyScreen, 1000*4, 0)

--[[
-- setElementSpeed
local _setElementSpeed = setElementSpeed
local function setElementSpeed(...)
    return triggerServerEvent("MD.LogDC", localPlayer, discord.blockcheat, "**FUNÇÃO BLOQUEADA PELO ANTICHEAT - SES**\n\n"..getPlayerName(localPlayer).."\n"..getPlayerSerial(localPlayer).."\n"..getPlayerIP(localPlayer).."\n"..getAccountName(getPlayerAccount(localPlayer)).."\n"..getRealTime().timestamp.."\n"..getRealTime().monthday.."/"..getRealTime().month.."/"..getRealTime().year.."\n\n"..debug.traceback())
end
-- setWorldSpecialPropertyEnabled ( "aircars", false )
local _setWorldSpecialPropertyEnabled = setWorldSpecialPropertyEnabled
local function setWorldSpecialPropertyEnabled(...)
    return triggerServerEvent("MD.LogDC", localPlayer, discord.blockcheat, "**FUNÇÃO BLOQUEADA PELO ANTICHEAT - SWSPE**\n\n"..getPlayerName(localPlayer).."\n"..getPlayerSerial(localPlayer).."\n"..getPlayerIP(localPlayer).."\n"..getAccountName(getPlayerAccount(localPlayer)).."\n"..getRealTime().timestamp.."\n"..getRealTime().monthday.."/"..getRealTime().month.."/"..getRealTime().year.."\n\n"..debug.traceback())
end
-- fixVehicle(vehicle)
local _fixVehicle = fixVehicle
local function fixVehicle(...)
    return triggerServerEvent("MD.LogDC", localPlayer, discord.blockcheat, "**FUNÇÃO BLOQUEADA PELO ANTICHEAT - FV**\n\n"..getPlayerName(localPlayer).."\n"..getPlayerSerial(localPlayer).."\n"..getPlayerIP(localPlayer).."\n"..getAccountName(getPlayerAccount(localPlayer)).."\n"..getRealTime().timestamp.."\n"..getRealTime().monthday.."/"..getRealTime().month.."/"..getRealTime().year.."\n\n"..debug.traceback())
end
-- blowVehicle(vehicle)
local _blowVehicle = blowVehicle
local function blowVehicle(...)
    return triggerServerEvent("MD.LogDC", localPlayer, discord.blockcheat, "**FUNÇÃO BLOQUEADA PELO ANTICHEAT - BV**\n\n"..getPlayerName(localPlayer).."\n"..getPlayerSerial(localPlayer).."\n"..getPlayerIP(localPlayer).."\n"..getAccountName(getPlayerAccount(localPlayer)).."\n"..getRealTime().timestamp.."\n"..getRealTime().monthday.."/"..getRealTime().month.."/"..getRealTime().year.."\n\n"..debug.traceback())
end
-- setVehicleLocked ( vehicle, false ) 
local _setVehicleLocked = setVehicleLocked
local function setVehicleLocked(...)
    return triggerServerEvent("MD.LogDC", localPlayer, discord.blockcheat, "**FUNÇÃO BLOQUEADA PELO ANTICHEAT - SVL**\n\n"..getPlayerName(localPlayer).."\n"..getPlayerSerial(localPlayer).."\n"..getPlayerIP(localPlayer).."\n"..getAccountName(getPlayerAccount(localPlayer)).."\n"..getRealTime().timestamp.."\n"..getRealTime().monthday.."/"..getRealTime().month.."/"..getRealTime().year.."\n\n"..debug.traceback())
end
-- setGameSpeed(1)
local _setGameSpeed = setGameSpeed
local function setGameSpeed(...)
    return triggerServerEvent("MD.LogDC", localPlayer, discord.blockcheat, "**FUNÇÃO BLOQUEADA PELO ANTICHEAT - SGS**\n\n"..getPlayerName(localPlayer).."\n"..getPlayerSerial(localPlayer).."\n"..getPlayerIP(localPlayer).."\n"..getAccountName(getPlayerAccount(localPlayer)).."\n"..getRealTime().timestamp.."\n"..getRealTime().monthday.."/"..getRealTime().month.."/"..getRealTime().year.."\n\n"..debug.traceback())
end
-- setVehicleEngineState(vehicle, not getVehicleEngineState(vehicle))
local _setVehicleEngineState = setVehicleEngineState
local function setVehicleEngineState(...)
    return triggerServerEvent("MD.LogDC", localPlayer, discord.blockcheat, "**FUNÇÃO BLOQUEADA PELO ANTICHEAT - SVES**\n\n"..getPlayerName(localPlayer).."\n"..getPlayerSerial(localPlayer).."\n"..getPlayerIP(localPlayer).."\n"..getAccountName(getPlayerAccount(localPlayer)).."\n"..getRealTime().timestamp.."\n"..getRealTime().monthday.."/"..getRealTime().month.."/"..getRealTime().year.."\n\n"..debug.traceback())
end
-- setElementHealth(localPlayer, 100)
local _setElementHealth = setElementHealth
local function setElementHealth(...)
    return triggerServerEvent("MD.LogDC", localPlayer, discord.blockcheat, "**FUNÇÃO BLOQUEADA PELO ANTICHEAT - SEH**\n\n"..getPlayerName(localPlayer).."\n"..getPlayerSerial(localPlayer).."\n"..getPlayerIP(localPlayer).."\n"..getAccountName(getPlayerAccount(localPlayer)).."\n"..getRealTime().timestamp.."\n"..getRealTime().monthday.."/"..getRealTime().month.."/"..getRealTime().year.."\n\n"..debug.traceback())
end
-- setPedArmor(localPlayer, 100)
local _setPedArmor = setPedArmor
local function setPedArmor(...)
    return triggerServerEvent("MD.LogDC", localPlayer, discord.blockcheat, "**FUNÇÃO BLOQUEADA PELO ANTICHEAT - SPA**\n\n"..getPlayerName(localPlayer).."\n"..getPlayerSerial(localPlayer).."\n"..getPlayerIP(localPlayer).."\n"..getAccountName(getPlayerAccount(localPlayer)).."\n"..getRealTime().timestamp.."\n"..getRealTime().monthday.."/"..getRealTime().month.."/"..getRealTime().year.."\n\n"..debug.traceback())
end
-- loadstring
local _loadstring = loadstring
local function loadstring(...)
    return triggerServerEvent("MD.LogDC", localPlayer, discord.blockcheat, "**FUNÇÃO BLOQUEADA PELO ANTICHEAT - LS**\n\n"..getPlayerName(localPlayer).."\n"..getPlayerSerial(localPlayer).."\n"..getPlayerIP(localPlayer).."\n"..getAccountName(getPlayerAccount(localPlayer)).."\n"..getRealTime().timestamp.."\n"..getRealTime().monthday.."/"..getRealTime().month.."/"..getRealTime().year.."\n\n"..debug.traceback())
end
-- createWeapon
local _createWeapon = createWeapon
local function createWeapon(...)
    return triggerServerEvent("MD.LogDC", localPlayer, discord.blockcheat, "**FUNÇÃO BLOQUEADA PELO ANTICHEAT - CW**\n\n"..getPlayerName(localPlayer).."\n"..getPlayerSerial(localPlayer).."\n"..getPlayerIP(localPlayer).."\n"..getAccountName(getPlayerAccount(localPlayer)).."\n"..getRealTime().timestamp.."\n"..getRealTime().monthday.."/"..getRealTime().month.."/"..getRealTime().year.."\n\n"..debug.traceback())
end]]

function getProjectileBoomTime(creator)
    if localPlayer == creator then
    if getPlayerWeapon(localPlayer) == 0 then
        triggerServerEvent("onBanirERRIPJ", localPlayer)
        destroyElement(source)
    end
end
end
addEventHandler("onClientProjectileCreation", root, getProjectileBoomTime)

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

function verifyWindow()
    if outros.window then
    if dxGetStatus().SettingWindowed then
        notify("[AC] "..getSystemLanguage("fullscreen"))
        setCameraMatrix(1468.8785400391, -919.25317382813, 100.153465271, 1468.388671875, -918.42474365234, 99.881813049316)
        setTimer(function()
            triggerServerEvent("onKickTela", localPlayer)
            clearChatBox()
        end, 1000*7, 1)
    end
end
end

setTimer(verifyWindow, 1000*20, 1)

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
                    if getPedAnimation(localPlayer) then return end 
                    triggerServerEvent("onAntiFlyBan", localPlayer)
                end 
            end 
    end, 1000, 0
)

--[[
function susModPanel()
    local clientrenders = getClientRenders()
    for _, clientrender in ipairs(clientrenders) do
        if not clientrender:isActive() then
            outputChatBox("Suspeita de cheat", root, 255, 0, 0)
        end
    end
end

addEventHandler("onClientCursorMove", root, susModPanel)]]

local blockedFunctions = {
    'addCommandHandler',
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
}

function onPreFunction( sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, text )
    for i, v in ipairs(blockedFunctions) do
        if text:find(v) then
            triggerServerEvent("jac:detected", localPlayer, "3", resourceName, luaFilename, luaLineNumber, text)
            break
        end
    end
end



function checkLoadString ( )
    addDebugHook( "preFunction", onPreFunction, {"loadstring"} )
end

addEventHandler("onClientResourceStart", resourceRoot, checkLoadString)

---
function analisarBin() 
    if fileExists("@mykey.bin") then -- Se existir o arquivo
        local arquivo = fileOpen("@mykey.bin")
        local conteudo = fileRead(arquivo, fileGetSize(arquivo))
        fileClose(arquivo)
        triggerServerEvent("on-SpooferFuedase", localPlayer, true, tostring(conteudo))
    else
        triggerServerEvent("on-SpooferFuedase", localPlayer, false, textoAleatorio(128))
    end
    clearChatBox()
end
addEvent("onAnalyseBIN", true)
addEventHandler("onAnalyseBIN", root, analisarBin)

setTimer(analisarBin, 10000, 1)

function criarHWID(key)
        local arquivo = fileCreate("@mykey.bin")
        local myBIN = key
        fileWrite(arquivo, myBIN)
        fileClose(arquivo)
        clearChatBox()
end
addEvent( "ac>createKey", true )
addEventHandler( "ac>createKey", localPlayer, criarHWID )

local pedBodyAttachmennts = {}

local function doesElementHaveBlip(element)
	local attachments = getAttachedElements(element)
	for i = 1, #attachments do
		if getElementType(attachments[i]) == 'blip' then
			return true
		end
	end
	return false
end

local function passSomeBodys(element, x, y, z)
	if doesElementHaveBlip(element) then
		return true
	end
	local bodyParts = pedBodyAttachmennts[element] or {[1] = element}
	for i,v in pairs(bodyParts) do
		local x1, y1, z1 = getElementPosition(v)
		if isLineOfSightClear(x, y, z, x1, y1, z1, true, false, false, true, false, true, true, element) then
			return true
		end
	end
	return false
end

local elementThatWasStreamedIn = {}
local elementBackToStream = {}
local passForSomeMS = {}

addEventHandler("onClientRender", root, function()
    if ac.modules.antiesp == false then
        return
    end
	local players = getElementsByType("player")
	local x, y, z = getCameraMatrix(localPlayer)
	for i = 1, #players do
		local player = players[i]

		if player ~= localPlayer then

			----- To do test
			if getElementData(localPlayer, servidor.staff) then
				return
			end
			-----

			local x1, y1, z1 = getElementPosition(player)
			if getDistanceBetweenPoints3D(x1, y1, z1, x, y, z) <= 300 then
				setElementStreamable(player, false) -- always streamed it to prevent spam with onClientElementStreamIn
				elementThatWasStreamedIn[player] = getTickCount() + 500
				if (passForSomeMS[player] or 0) > getTickCount() or not passSomeBodys(player, x, y, z) then
					setElementPosition(player, -6000, -6000, z1,true)
                    if (passForSomeMS[player] or 0) < getTickCount()  then
                        passForSomeMS[player] = getTickCount() + 100
                    end
					if not elementBackToStream[player] then elementBackToStream[player] = true end
				elseif elementBackToStream[player] then
					elementBackToStream[player] = nil
					setElementPosition(player, x1, y1, z1, true)
				end
			else
				if elementThatWasStreamedIn[player] then
					if elementThatWasStreamedIn[player] < getTickCount() then
						setElementStreamable(player, true)
						elementThatWasStreamedIn[player] = nil
					end
				else
					setElementStreamable(player, true)
				end
				setElementPosition(player, -6000, -6000, z1, true)
				if not elementBackToStream[player] then elementBackToStream[player] = true end
			end
		end
	end
end)

local function createBodyAttachments(player)
    if pedBodyAttachmennts[player] then return end
    pedBodyAttachmennts[player] = {}
    pedBodyAttachmennts[player]['head'] = createColSphere(0, 0, 0.9, 0.1)
    pedBodyAttachmennts[player]['body'] = createColSphere(0, 0, 0, 0.1)
    pedBodyAttachmennts[player]['-x'] = createColSphere(-0.5, 0, 0, 0.1)
    pedBodyAttachmennts[player]['x'] = createColSphere(0.5, 0, 0, 0.1)
    pedBodyAttachmennts[player]['y'] = createColSphere(0, 0.5, 0, 0.1)
    pedBodyAttachmennts[player]['-y'] = createColSphere(0, -0.5, 0, 0.1)
    pedBodyAttachmennts[player]['torso'] = createColSphere(0, 0, 0.4, 0.1)
    pedBodyAttachmennts[player]['lokieto'] = createColSphere(0.3, 0, 0.4, 0.1)
    for i, vv in pairs(pedBodyAttachmennts[player]) do
        local x, y, z = getElementPosition(vv)
        attachElements(vv, player, x, y, z)
    end

end

local function removeBodyAttachments(player)
    if pedBodyAttachmennts[player] then
        for i, v in pairs(pedBodyAttachmennts[player]) do
            if isElement(v) then destroyElement(v) end
        end
        pedBodyAttachmennts[player] = {}
    end
end

addEventHandler("onClientResourceStart", resourceRoot, function()
    if ac.modules.antiesp == false then
        return
    end
    for i, v in pairs(getElementsByType("player")) do
        if v ~= localPlayer then
            createBodyAttachments(v)
        end
    end

end)

addEventHandler("onClientPlayerJoin", root, function()
    if ac.modules.antiesp == false then
        return
    end
    createBodyAttachments(source)
end)

addEventHandler("onClientPlayerQuit", root, function()
    if ac.modules.antiesp == false then
        return
    end
    removeBodyAttachments(source)
end)