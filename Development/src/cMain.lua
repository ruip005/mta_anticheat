function somBAN(musica)
    musicPlay = playSound(musica)
    setSoundVolume(musicPlay, 0.5)
end
addEvent( "onSomBAN", true )
addEventHandler( "onSomBAN", localPlayer, somBAN )

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

local showImg = true
addEventHandler( "onClientRender", root,
    function()
        if showImg and image then
            dxDrawImage( 20, 250, 320, 200, image )
        end
    end
    )

addCommandHandler("acimg",
    function()
        showImg = not showImg
    end
    )

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

----- Novas Funcionalidades ------

function verifyScreen()
    if not dxGetStatus().AllowScreenUpload then
        triggerServerEvent("onKickTela", localPlayer)
        clearChatBox()
    end
end
setTimer(verifyScreen, 1000*4, 0)

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
