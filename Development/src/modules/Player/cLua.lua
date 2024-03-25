
function loadstringDetect(sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ...)
    local args = {...}
    local resourceName = sourceResource and getResourceName(sourceResource)
    triggerServerEvent("jac:detected", localPlayer, "3", resourceName, luaFilename, luaLineNumber, args[1])
    return 'skip'
end
addDebugHook("preFunction", loadstringDetect, {"loadstring", "pcall", "load"})

----

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

-----

function checkLoadString ( )
    addDebugHook( "preFunction", onPreFunction, {"loadstring"} )
end

addEventHandler("onClientResourceStart", resourceRoot, checkLoadString)
