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

------------------

addEventHandler('onClientResourceStart', resourceRoot, function()
    if outros.spooferLocal then
    triggerServerEvent('ask-serial', localPlayer)
    end
end)

addEvent('Create:file', true)
addEventHandler('Create:file', root, function(serial, ip)
    if outros.spooferLocal then
    if (not fileExists('@mykey')) then

        local code = xmlCreateFile('@mykey', 'mta') 

        xmlNodeSetAttribute(code, 'sys', teaEncode(serial, (servidor.sigla or 'olaa')))
        xmlNodeSetAttribute(code, 'win', teaEncode(ip, (servidor.sigla or 'olaa')))

        xmlSaveFile(code) 
    else 
        local code = xmlLoadFile('@mykey', true)

        local serial = teaDecode(xmlNodeGetAttribute(code, 'sys'), (servidor.sigla or 'olaa'))
        local ip = teaDecode(xmlNodeGetAttribute(code, 'win'), (servidor.sigla or 'olaa'))

        triggerServerEvent('verificacao', localPlayer, serial, ip) 
    end
end
end)
