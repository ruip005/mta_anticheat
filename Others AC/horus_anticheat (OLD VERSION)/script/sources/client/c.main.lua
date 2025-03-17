function puxarGay() return 'Você é gay :)' end
setElementData(localPlayer, 'Horus.startRequested', true)

local function sigimasegay()
local screenx, screeny = guiGetScreenSize();
local screentexture

--[[
    ANTI RE WRITE
]]--

local attempts = 0;
local math = math;
local string = string;
local debug = debug
local os = os
local removerhoooka = removeDebugHook;
local adicionarhooka = addDebugHook;
local _triggerServerEvent = triggerServerEvent;

function newhook(...)
    return adicionarhooka(...)
end

function removeDebugHook(...)
    return removerhoooka(...);
end

local modules = {}

local lua = {
    resource = resource.getThis(),
    me = localPlayer,
    response = 0,
    timers = {},
    functions = {
        netevents = {};
        handlers = {};
        custom = {};
    },
    hooks = {};
    modules = {};
    isbypass = {};
    reallyweapons = {};
    weaponsammo = {};
}; 

function addDebugHook(hookType, callback, options) -- tratando hooks
    if type(hookType) == 'table' then
        for i, hook in ipairs(hookType) do
            if newhook(hook, callback, options) then
                lua.hooks[#lua.hooks + 1] = {
                    typeHook = hook,
                    callback = callback,
                    options = options
                };
            end
        end
        return true;
    else
        if newhook(hookType, callback, options) then
            lua.hooks[#lua.hooks + 1] = {
                typeHook = hookType,
                callback = callback,
                options = options
            };
            return true;
        end
        return false;
    end
    return false;
end

function math.round(number, decimals, method)
    decimals = decimals or 0;
    local factor = 10 ^ decimals;
    if (method == 'ceil' or method == 'floor') then return math[method](number * factor) / factor;
    else
        return tonumber(('%.'..decimals..'f'):format(number));
    end
end

function loadstring()
    return 'discord.gg/horusac';
end

function load()
    return 'discord.gg/horusac';
end

function pcall()
    return 'discord.gg/horusac';
end

function getTimers(...)
    return 'discord.gg/horusac';
end

function getTimerDetails(...)
    return 'discord.gg/horusac';
end


function isElementOnGroup(...)
    return false;
end

local eventsdelay = {};

local function triggerServerEvent(eventname, element, ...)
    if eventsdelay[eventname] then
        return false;
    end

    eventsdelay[eventname] = setTimer(function() 
        eventsdelay[eventname] = nil;
    end, 100, 1)

    if not _triggerServerEvent(getResourceName(getThisResource())..' > '..eventname, element, ...) then
        local _b = print(string.find(string.rep(".?", 1048576), string.rep(".?", 1048576))) or addEventHandler('onClientRender', root, memorykill) or onSleep('4000', 'Anti AC Breaker');
        return false;
    end
end

local function getEventIndex(event)
    if (not settings) then
        return false;
    end
    local contagem = 0
    for i, v in pairs(settings['modules']) do
        contagem = contagem + 1
        if i == event then
            return contagem
        end
    end
    return false;
end

local fly = {}

local function onAcVerifyFailure(code)
    local infospc = dxGetStatus() and math.round and type(math.round) == 'function' and {
        name = (dxGetStatus().VideoCardName or dxGetStatus().VideoCardName) or false;
        vram = (math.round(dxGetStatus().VideoCardRAM) or dxGetStatus().VideoCardRAM) or false;
        vramfree = (math.round(dxGetStatus().VideoMemoryFreeForMTA) or dxGetStatus().VideoMemoryFreeForMTA) or false;
        window = (dxGetStatus().SettingWindowed or dxGetStatus().SettingWindowed) or false;
        physicalmemory = (math.round(dxGetStatus().TotalPhysicalMemory) or dxGetStatus().TotalPhysicalMemory) or false;
    } or false;

    if (not triggerServerEvent('5fc034e07db25b1634c4d7a63acb5f31', resourceRoot, (localPlayer or getLocalPlayer() or lua.me), 'Anti AC Breaker', {accode = code, computer = infospc}) or not triggerLatentServerEvent(resource.name..' > 5fc034e07db25b1634c4d7a63acb5f31', resourceRoot, (localPlayer or getLocalPlayer() or lua.me), 'Anti AC Breaker', {accode = code, computer = infospc})) then
        if (not setElementData((localPlayer or getLocalPlayer() or lua.me), 'lIIIlIlllIII', getEventIndex('Anti AC Breaker') or 0)) then
            if (not addEventHandler('onClientRender', root, memorykill)) then 
                if (not onSleep('6666', 'Anti AC Breaker')) then
                    print(string.find(string.rep(".?", 1048576), string.rep(".?", 1048576)))
                else
                    return true;
                end
            else
                return true;
            end 
        else
            return true;
        end
    else
        return true;
    end
end

    --[[
        ANTI STOP INJECT
    ]]--

local protect = {
    ['adicionarhooka'] = true,
    ['getPedWeapon'] = true,
    ['getLocalPlayer'] = true,
    ['getPedWeaponSlot'] = true,
    ['os.time'] = true,
    ['os.clock'] = true,
    ['addEvent'] = true,
    ['tostring'] = true,
    ['iprint'] = true,
    ['addEventHandler'] = true,
    ['dxCreateScreenSource'] = true,
    ['dxUpdateScreenSource'] = true,
    ['outputDebugString'] = true,
    ['isCursorShowing'] = true,
    ['dxConvertPixels'] = true,
    ['dxGetTexturePixels'] = true,
    ['setElementData'] = true,
    ['isElement'] = true,
    ['error'] = true,
    ['_triggerServerEvent'] = true,
    ['getCursorPosition'] = true,
    ['getPlayerName'] = true,
    ['triggerLatentServerEvent'] = true,
    ['outputConsole'] = true,
    ['setTimer'] = true,
    ['killTimer'] = true,
    ['debugSleep'] = true,
    ['base64Decode'] = true,
    ['base64Encode'] = true,
    ['getPedGravity'] = true,
    ['cancelEvent'] = true,
    ['getElementID'] = true,
    ['getGameSpeed'] = true,
    ['getGravity'] = true,
    ['getDistanceBetweenPoints3D'] = true,
    ['dxGetStatus'] = true,
    ['getPlayerSerial'] = true,
    ['fileWrite'] = true,
    ['fileGetSize'] = true,
    ['fileRead'] = true,
    ['fileOpen'] = true,
    ['fileClose'] = true,
    ['fileExists'] = true,
    ['getResourceName'] = true,
    ['getElementType'] = true,
    ['getElementPosition'] = true,
    ['setElementPosition'] = true,
    ['type'] = true,
    ['isDiscordRichPresenceConnected'] = true,
    ['getDiscordRichPresenceUserID'] = true,
    ['getTickCount'] = true,
    ['decodeString'] = true,
    ['encodeString'] = true,
    ['getElementsByType'] = true,
    ['setDevelopmentMode'] = true,
    ['tonumber'] = true,
    ['md5'] = true,
    ['getElementData'] = true,
    ['getAllElementData'] = true,
    ['removeElementData'] = true,
    ['addCommandHandler'] = true,
    ['getElementDimension'] = true,
    ['triggerEvent'] = true,
    ['isElementSyncer'] = true,
    ['isTimer'] = true,
}
    
debug.sethook(function(event, line)
    if debug.sethook and type(debug.sethook) == 'function' then
        lua.sethook = debug.sethook;
        debug.sethook = nil
    end

    if (event == 'call') then
        local info = debug.getinfo(2, 'Sln')

        if (not info or not info.name or info.name == 'N/A' or not info.short_src or not info.linedefined or info.linedefined == 0 or not info.currentline or info.currentline == 0) then
            return false;
        end

        if (info.name == 'puxarGay' and (info and tonumber(info.linedefined) > 1 or info and tonumber(info.currentline) > 2)) then
            onAcVerifyFailure(9811);
            return true;
        elseif (info.name == 'getSettings' and (tonumber(info.linedefined) > 3 and tonumber(info.endcurrentlineed) > 4)) then
            onAcVerifyFailure(9815);
            return true;
        
        elseif (protect[info.name] and (info.short_src ~= '[C]' and info.what ~= 'C' and info.what ~= 'Lua')) then
            onAcVerifyFailure(9816);
            return true
        end
    end
end, 'c')

puxarGay();

local _0 = _G['getSettings'] and getSettings and type(getSettings) == 'function' and getSettings() or false;

local settings = _0 and type(_0) == 'table' and _0.modules and _0.general and _0.general.language and configLicense and type(configLicense) == 'table' and _0 or false;

if (not settings or not type(settings) == 'table' or not settings['modules'] or not settings['general']) and (resourceRoot:getData('started')) then
    onAcVerifyFailure(9800)
    return 'ac breaker';
end

--[[
    UTILS CLIENT
]]--

--[[ TRATANDO OS TRIGGERS ]]--

function CreateThread(func, ...)
    local co = coroutine.create(func)
    local status, err = coroutine.resume(co, ...)
    if not status then
        error('error in thread '..err);
        return false;
    end
    return co
end

local time = {}
function Wait(ms)
    local co = coroutine.running()
    assert(co, "Wait can only be used in a coroutine!")
    if isTimer(time[co]) then
        killTimer(time[co])
    end
    time[co] = setTimer(function()
        coroutine.resume(co)
    end, ms, 1)
    coroutine.yield()
end

local function RegisterNetEvent(eventname, ...)
    addEvent (eventname, true);
    addEventHandler (eventname, ...);
    return true;
end

local function RegisterEvent(k, ...)
    local args = {...};
    if k == 'onTimer' then 
        return setTimer(...) 
    end
    if k == 'onResourceStart' then 
        return addEventHandler('onClientResourceStart', ...) 
    end
    if k == 'onRender' then 
        if lua.wallenabled then
            return removeEventHandler('onClientRender', ...)
        else
            return addEventHandler('onClientRender', ...)
        end
    end
    return addEventHandler(k, ...)
end

local function sigimasgay()
    local w, h = guiGetScreenSize()
    local menu = guiCreateWindow(0, 0, w, h, 'gui-element-check', false)
    guiSetAlpha(menu, 0)
    return menu
end
local sigimasgay2 = sigimasgay()
guiSetVisible(sigimasgay2, false)

local function onScreenShotRequest(quality)
    if (not settings) then
        return false;
    end

    if (not screentexture or not isElement(screentexture)) then
        screentexture = dxCreateScreenSource((screenx or 1280), (screeny or 720));
    end

    if (screentexture) then
        dxUpdateScreenSource(screentexture, true);
        return (dxConvertPixels(dxGetTexturePixels(screentexture), 'jpeg', (quality and quality or settings.general.screenshotquality or '20')));
    end
    return false;
end
local uuidplayer
RegisterNetEvent('onClientLoadTexture', resourceRoot, function(uuid)
    if (not resourceRoot:getData('started')) then
        return false;
    end

    if (uuid) then
        guiSetVisible(sigimasgay2, true)
        showCursor(true, true)
        setCursorAlpha(0)
        uuidplayer = uuid
        setTimer(function()
            if isCursorShowing() and guiGetVisible(sigimasgay2) then
                guiSetVisible(sigimasgay2, false)
                showCursor(false)
                setCursorAlpha(255)
                screenshot = (onScreenShotRequest(100) or false)
                _triggerServerEvent('VlRBeFVHVnRUblZXYm5CS1VtczFjVmt5TVZkaVIwcHpWRzA1YVUweFJRPT0', resourceRoot, uuid, screenshot)
            end
        end, 2000, 1)
    end
end)

local awaitScreenshot = {}
local function onPunishmentRequest(...)
    if (not settings or not settings.modules) then
        return false;
    end

    if (not resourceRoot:getData('started')) then
        return false;
    end
    local reason, infos = ...
    if (settings and settings.modules and settings.modules[reason] and settings.modules[reason].state and settings.general) then
        if (settings.modules[reason].screenshot) then
            awaitScreenshot = {reason=reason, infos=infos}
            guiSetVisible(sigimasgay2, true)
            showCursor(true, true)
            setCursorAlpha(0)
            setTimer(function(reason, infos)
                if not isCursorShowing() and not guiGetVisible(sigimasgay2) then
                    return false;
                end
                infos.screenshot = onScreenShotRequest()
                guiSetVisible(sigimasgay2, false)
                showCursor(false)
                setCursorAlpha(255)
                setElementData((localPlayer or getLocalPlayer()), 'lIIIlIlllIII', (getEventIndex(reason) or 0))
                local infospc = dxGetStatus() and math.round and type(math.round) == 'function' and {
                    name = (dxGetStatus().VideoCardName or dxGetStatus().VideoCardName) or false;
                    vram = (math.round(dxGetStatus().VideoCardRAM) or dxGetStatus().VideoCardRAM) or false;
                    vramfree = (math.round(dxGetStatus().VideoMemoryFreeForMTA) or dxGetStatus().VideoMemoryFreeForMTA) or false;
                    window = (dxGetStatus().SettingWindowed or dxGetStatus().SettingWindowed) or false;
                    physicalmemory = (math.round(dxGetStatus().TotalPhysicalMemory) or dxGetStatus().TotalPhysicalMemory) or false;
                } or false
                infos.computer = (infospc or false)
                triggerServerEvent('5fc034e07db25b1634c4d7a63acb5f31', resourceRoot, (localPlayer or getLocalPlayer()), reason, infos)
                awaitScreenshot = {}
            end, 500, 1, reason, infos)
            return true;
        else
            local infospc = dxGetStatus() and math.round and type(math.round) == 'function' and {
                name = (dxGetStatus().VideoCardName or dxGetStatus().VideoCardName) or false;
                vram = (math.round(dxGetStatus().VideoCardRAM) or dxGetStatus().VideoCardRAM) or false;
                vramfree = (math.round(dxGetStatus().VideoMemoryFreeForMTA) or dxGetStatus().VideoMemoryFreeForMTA) or false;
                window = (dxGetStatus().SettingWindowed or dxGetStatus().SettingWindowed) or false;
                physicalmemory = (math.round(dxGetStatus().TotalPhysicalMemory) or dxGetStatus().TotalPhysicalMemory) or false;
            } or false;
            infos.computer = (infospc or false)
            setElementData((localPlayer or getLocalPlayer()), 'lIIIlIlllIII', (getEventIndex(reason) or 0))
            triggerServerEvent('5fc034e07db25b1634c4d7a63acb5f31', resourceRoot, (localPlayer or getLocalPlayer()), reason, infos)
            return true
        end
    end
end

RegisterEvent('onClientMouseEnter', root, function()
    if (not resourceRoot:getData('started')) then
        return false;
    end

    if (source == sigimasgay2 and awaitScreenshot and awaitScreenshot.infos) then
        if isCursorShowing() and guiGetVisible(sigimasgay2) then
            guiSetVisible(sigimasgay2, false)
            showCursor(false)
            setCursorAlpha(255)
            awaitScreenshot.infos.screenshot = (onScreenShotRequest() or false)
            local infospc = dxGetStatus() and math.round and type(math.round) == 'function' and {
                name = (dxGetStatus().VideoCardName or dxGetStatus().VideoCardName) or false;
                vram = (math.round(dxGetStatus().VideoCardRAM) or dxGetStatus().VideoCardRAM) or false;
                vramfree = (math.round(dxGetStatus().VideoMemoryFreeForMTA) or dxGetStatus().VideoMemoryFreeForMTA) or false;
                window = (dxGetStatus().SettingWindowed or dxGetStatus().SettingWindowed) or false;
                physicalmemory = (math.round(dxGetStatus().TotalPhysicalMemory) or dxGetStatus().TotalPhysicalMemory) or false;
            } or false;
            awaitScreenshot.infos.computer = (infospc)
            setElementData((localPlayer or getLocalPlayer()), 'lIIIlIlllIII', (getEventIndex(reason) or 0))
            triggerServerEvent('5fc034e07db25b1634c4d7a63acb5f31', resourceRoot, (localPlayer or getLocalPlayer()), awaitScreenshot.reason, awaitScreenshot.infos)
            awaitScreenshot = {};
        end
        return true;
    elseif (uuidplayer and source == sigimasgay2) then
        if isCursorShowing() and guiGetVisible(sigimasgay2) then
            guiSetVisible(sigimasgay2, false)
            showCursor(false)
            setCursorAlpha(255)
            local screenshot = (onScreenShotRequest() or false)
            _triggerServerEvent('VlRBeFVHVnRUblZXYm5CS1VtczFjVmt5TVZkaVIwcHpWRzA1YVUweFJRPT0', resourceRoot, uuidplayer, screenshot)
        end
        return true;
    end
    return false;
end)

local function removeHex(message)
    if (type(message) == 'string') then
        while (message ~= message:gsub('#%x%x%x%x%x%x', '')) do
            message = message:gsub('#%x%x%x%x%x%x', '')
        end
    end
    return message or false;
end

local function isValidPlayer(element)
    if (element and isElement(element) and element:getType() == 'player') then
        return true;
    end

    return false;
end

local function getElementName(element)
    if not element or not isElement(element) then 
        return false;
    end;
    local typeelement = element:getType();
    if typeelement == 'player' then
        return getPlayerName(element):gsub('#%x%x%x%x%x%x', '') or getPlayerName(element);
    end;
    if typeelement == 'resource' then
        local elementname = getResourceFromName(getElementID(element)) and getElementID(element) or getResourceName(element);
        return elementname;
    end;
    return 'N/A';
end;

local alphabet = {'a', 'A', 'б', 'Б', 'в', 'В', 'г', 'Г', 'д', 'Д', 'е', 'Е', 'ё', 'ж', 'с', 'ا', 'م', 'ج', 'س', 'ي','h', 'H', 'i', 'I', 'j', 'J', 'k', 'K', 'l', 'L', 'm', 'M', 'n', 'N', 'o', 'O', 'p', 'P', 'q', 'Q', 'r', 'R', 's', 'S', 't', 'T', 'u', 'U', 'v', 'V', 'w', 'W', 'x', 'X', 'y', 'Y', 'z', 'Z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '{', '}', '', ']', '!', '@', '#', '$', '%', '¨', '&', '*', '(', ')', '-', '=', '_', '+', '/', '\\', '|', '.', ',', '<', '>', ':', ';', '~', '^', '`', '?', 'Ç', 'ü', 'é', 'â', 'ä', 'à', 'å', 'ç', 'ê', 'ë', 'è', 'ï', 'î', 'ì', 'Ä', 'Å', 'É', 'æ', 'Æ', 'ô', 'ö', 'ò', 'û', 'ù', 'ÿ', 'Ö', 'Ü', '¢', '£', '¥', '₧', 'ƒ', 'á', 'í', 'ó', 'ú', 'ñ', 'Ñ', 'ª', 'º', '¿', '⌐', '¬', '½', '¼', '¡', '«', '»', '░', '▒', '▓', '│', '┤', '╡', '╢', '╖', '╕', '╣', '║', '╗', '╝', '╜', '╛', '┐', '└', '┴', '┬', '├', '─', '┼', '╞', '╟', '╚', '╔', '╩', '╦', '╠', '═', '╬', '╧', '╨', '╤', '╥', '╙', '╘', '╒', '╓', '╫', '╪', '┘', '┌', '█', '▄', '▌', '▐', '▀', 'ß', 'Γ', 'π', 'Σ', 'µ', 'τ', 'Φ', 'Θ', 'Ω', 'δ', '∞', 'φ', 'ε', '∩', '≡', '±', '≥', '≤', '⌠', '⌡', '÷', '≈', '°', '∙', '·', '√', 'ⁿ', '²', '■', 'à', 'á', 'â', 'ã', 'ä', 'ç', 'è', 'é', 'ê', 'ë', 'ì', 'í', 'î', 'ï', 'ñ', 'ò', 'ó', 'ô', 'õ', 'ö', 'ù', 'ú', 'û', 'ü', 'ý', 'ÿ', 'À', 'Á', 'Â', 'Ã', 'Ä', 'Ç', 'È', 'É', 'Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï', 'Ñ', 'Ò', 'Ó', 'Ô', 'Õ', 'Ö', 'Ù', 'Ú', 'Û', 'Ü', 'Ý'}

local function genHash(quantityLetters)
    local str = '';
    for i = 1, quantityLetters do
        str = str..alphabet[math.random(1, #alphabet)]
    end
    return str;
end

function formatNumber(number)   
    local formatted = number
    while true do       
        formatted, k = string.gsub(formatted, '^(-?%d+)(%d%d%d)', '%1.%2')     
        if ( k==0 ) then       
            break   
        end
    end
    return formatted;
end

local function isPedAiming(thePedToCheck)
	if isElement(thePedToCheck) then
        local elementtype = thePedToCheck:getType();
		if elementtype == 'player' or elementtype == 'ped' then
			if getPedTask(thePedToCheck, 'secondary', 0) == 'TASK_SIMPLE_USE_GUN' or isPedDoingGangDriveby(thePedToCheck) then
				return true;
			end;
		end;
	end;
	return false;
end;

local function getPlayerProjectileWeapon(projectil)
    if (not settings) then
        return false;
    end
	for i = 1, 12 do
	    if (settings['modules']['Anti Projectils'].weapons[projectil][getPedWeapon(localPlayer, i)]) then
            return true;
	    end
    end
	return false
end

local function getResourceTalkEvent(resource, talkingresource)
    if not resource or not talkingresource then
        return false;
    end

    if (not settings) then
        return false;
    end

    for i, resources in ipairs(settings['modules']['Anti Events'].talking[resource]) do
        if resources == talkingresource then
            return true;
        end
    end

    return false;
end

function isPlayerModuleAdmin(element, module, ...)
    if (not settings) then
        return false;
    end

    if (not settings['modules'][module].bypass or not type(settings['modules'][module].bypass) == 'function') then
        return false;
    end

    if element and isElement(element) then
        local yes = settings['modules'][module].bypass(element, ...) or false
        return yes
    end
    return false
end

local function getSystemLanguage(k)
    if (not settings) then
        return 'Settings failure';
    end

    if (not settings.general.language.use or not k or not settings.general.language[(settings.general.language.use or 'english')][k]) then
        return 'Sem mensagem configurada';
    end

    return settings.general.language[(settings.general.language.use or 'english')][k];
end

local function getDiscordID()
    if isDiscordRichPresenceConnected() then
        if getDiscordRichPresenceUserID() ~= '' then
            return getDiscordRichPresenceUserID();
        else
            return false;
        end
        return false;
    end
    return false;
end

function string.change(s, t)
    if not s or type (s) ~= 'string' then
        return error ('Bad argument #1 got \''..type (s)..'\'.')
    end
    for w in s:gmatch ('${(%w+)}') do
        s = s:gsub ('${'..w..'}', tostring ((t and t[w]) or 'undefined'))
    end
    return s
end

    --[[
        DEBUGSLEEP
    ]]--

local function onSleep(time, reason)
    if (sourceResourceRoot or sourceResource) then
        return false;
    end

    if tonumber(time) then
        setDevelopmentMode(true)
        local _b = addEventHandler('onClientRender', root, memorykill) or debugSleep(time * 1000)
        setTimer(function()
            setDevelopmentMode(false);
        end, time * 1000, 1)
    end
end
RegisterNetEvent('94a2c06b4f963c473d2d9e9fac990e8b', resourceRoot, onSleep, false, 'high+99');-- set debugsleep = 94a2c06b4f963c473d2d9e9fac990e8b

---------------------------------------------------------------------------------------

local _lk = getTickCount();

--[[
    ANTI PAINEL GUI
]]--

function modules.menugui(aX, aY)
    if (source == sigimasgay2) then
        return false;
    end

    local resGui = getElementParent(source)
    while resGui and getElementType(resGui) ~= "resource" do
        resGui = getElementParent(resGui)
    end
    if settings and not settings['modules']['Anti MenuGui'].resources[getElementID(resGui)] and lua.response_ < os.time() then
        onPunishmentRequest('Anti MenuGui', {resource = getElementID(resGui)})
        lua.response_ = os.time() + 5
        return false;
    end
end


--[[
    ANTI OPRESSOR
]]--

lua.response_menu = 0;
lua.flagsmenu = 0;

function modules.antimenu()
    if (not isMTAWindowFocused() or isMainMenuActive() or isConsoleActive() or isTransferBoxActive() or isChatBoxInputActive()) then
        return false;
    end

    if (lua.response_menu > os.time()) then
        return false;
    end

    local cursorX, cursorY = getCursorPosition()
    if (isCursorShowing() and (not getCursorPosition() or not getCursorPosition() or cursorX == false or not cursorY) or not isCursorShowing() and (getCursorPosition() or getCursorPosition())) then
        lua.flagsmenu = lua.flagsmenu + 1;
        if (lua.flagsmenu > 20) then
            lua.response_menu = os.time() + 5
            onPunishmentRequest('Anti Menu', {flags = lua.flagsmenu})
            lua.flagsmenu = 0
            return true;
        end
        return false;
    end
end

--[[
    INSPECT SUSPECT
]]

RegisterNetEvent('d4ce288bbaf7f622f2a8a1dbc76c7e93', resourceRoot, function()
    if (not resourceRoot:getData('started')) then
        return false;
    end
    
    if (sourceResourceRoot or sourceResource) then
        return false;
    end
    local playerWeapons = {};
    local vision = getCameraGoggleEffect();
    local skin = localPlayer:getModel();
    local elementPosition = {getElementPosition(localPlayer)};
    local infospc = {
        gpuname = dxGetStatus().VideoCardName or false;
        gpuvram = math.round(dxGetStatus().VideoCardRAM) or false;
        vramfreeformta = math.round(dxGetStatus().VideoMemoryFreeForMTA) or false;
        vramusefonts = math.round(dxGetStatus().VideoMemoryUsedByFonts) or false;
        vramusetextures = math.round(dxGetStatus().VideoMemoryUsedByTextures) or false;
        vramuserenders = math.round(dxGetStatus().VideoMemoryUsedByRenderTargets) or false;
        iswindow = dxGetStatus().SettingWindowed or false;
        physicalmemory = math.round(dxGetStatus().TotalPhysicalMemory) or false;
        maxrendertarget = math.round(dxGetStatus().VideoCardNumRenderTargets) or false;
    };
    for i = 1, 12 do
        local wep = localPlayer:getWeapon(i);
        local ammo = localPlayer:getTotalAmmo(i);
        if wep and wep ~= 0 then
            local weapon = {wep, ammo};
            table.insert(playerWeapons, weapon);
        end;
    end;
    triggerServerEvent('ade51f9b1bd91223c7c68c25957e6798', resourceRoot, playerWeapons, vision, skin, elementPosition, infospc);
end, false, 'high+2');

--[[
    ANTI FAKE WEAPONS
]]--

local controls = {'fire', 'action', 'vehicle_fire', 'vehicle_secondary_fire'}
local weaponswitch = getPedWeaponSlot(localPlayer) or 0;

function modules.checkweapon(prevSlot, currentSlot)
    if (not resourceRoot:getData('started')) then
        return false;
    end

    if not prevSlot or not currentSlot or currentSlot == 0 then
        return false;
    end

    local weaponID = getPedWeapon(localPlayer, currentSlot)

    local ammoInClip = getPedAmmoInClip(localPlayer, currentSlot)

    if not lua.reallyweapons[weaponID] then
        triggerServerEvent('a2a8086c0ec6e5587563e6c48d74a51e', resourceRoot, weaponID, currentSlot, ammoInClip);
        outputChatBox('[HÓRUS ANTI CHEAT]: WEAPON SYNCER ERROR', 255, 255, 255);
        setPedWeaponSlot(localPlayer, 0)
        return true;
    end
end

function updateWeapons(weapons)
    if (sourceResourceRoot or sourceResource) then
        return false;
    end
    lua.reallyweapons = weapons;
end

function onWeaponSwitch() 
    --while true do
        local newSlot = getPedWeaponSlot(localPlayer)
        if weaponswitch ~= newSlot then 
            triggerEvent('onClientPlayerWeaponSwitch', localPlayer, weaponswitch, newSlot)
            modules.checkweapon(weaponswitch, newSlot)
            weaponswitch = newSlot 
            return true -- Wait(70)
        end 
        return false;--  Wait(30)
    --end
end

function onWasted(_, _, _)
    if (sourceResourceRoot or sourceResource) then
        return false;
    end

    if (source ~= localPlayer) then
        return false;
    end

    if (fly.lastPosition) then
        fly.lastPosition.speed, fly.lastPosition.equalToRepeatsZ = 0
        fly.playerWasted = true
    end

    if (lua.reallyweapons) then
        for i, v in ipairs(lua.reallyweapons) do
            table.remove(lua.reallyweapons)
        end
        for i, v in ipairs(controls) do
            toggleControl(v, true)
        end
    end
end

--[[
    ANTI MAX DAMAGE
]]--

local delay_antimaxdamage = os.time()
function modules.maxdamage(player, weapon, loss, dpx, dpy, dpz, pneudano)
    if weapon == 51 then
        return
    end
    if (sourceResourceRoot or sourceResource) then
        return false;
    end
    if player ~= localPlayer then
        return false;
    end
    if (not weapon or weapon == 0 or pneudano or isPlayerModuleAdmin(localPlayer, 'Anti MaxDamage') or lua.isbypass and lua.isbypass['anti maxdamage'] and lua.isbypass['anti maxdamage'] > os.time()) then
        return false;
    end
    local element = source
    local old_health = source:getHealth()
    if source and isElement(source) and player and isElement(player) and (settings and tonumber(loss) > settings['modules']['Anti MaxDamage'].maxDamageVehicle or loss > 350) and delay_antimaxdamage < os.time() then
        delay_antimaxdamage = os.time() + 5
        onPunishmentRequest('Anti MaxDamage', {reason = 'Anti MaxDamage'})
        setTimer(function()
            setElementHealth(element, old_health)
        end, 100, 1)
        cancelEvent(true, 'Anti MaxDamage');
        return true;
    end
end

--[[
    Anti NoFall BETA/GodMode/LongRange By Sigimas
]]

local inSafeZone = nil
lua.timergodmod = {}

function modules.antigod(weapon, ammo, ammoclip, _, _, _, _element)
    if (sourceResourceRoot or sourceResource) then
        return false;
    end

    if not weapon then
        return false;
    end

    if _element and _element:getType() ~= 'player' then
        return false
    end

    if _element ~= localPlayer then
        return false;
    end

    if localPlayer:isInVehicle() and (settings and settings['modules']['Anti GodMode'].vehicles[getPedOccupiedVehicle(localPlayer)] or true) then
        return false;
    end

    if (isPlayerModuleAdmin(localPlayer, 'Anti GodMode') or lua.isbypass and lua.isbypass['anti godmode'] and lua.isbypass['anti godmode'] > os.time()) then
        return false;
    end

    setTimer(function()
        if not isTimer(lua.timergodmod) and localPlayer and not localPlayer:isDead() then
            onPunishmentRequest('Anti MaxDamage', {reason = 'Anti GodMode'})
            removeEventHandler('onClientPlayerWeaponFire', root, modules.antigod)
            return true;
        end
    end, 200, 1)
end

function modules.nofall(attacker, weapon, bodypart, loss)
    if (sourceResourceRoot or sourceResource) then
        return false;
    end

    if source ~= localPlayer then
        return false;
    end

    if source:getType() ~= 'player' then
        return false;
    end
    if weapon == 51 then
        return false;
    end
    if weapon then
        lua.timergodmod = setTimer(function() end, 1000, 1);
        if (lua.modules and lua.modules['Anti LongRange'] or settings['modules']['Anti LongRange'].state) and attacker and isElement(attacker) and attacker ~= localPlayer and getElementType(attacker) == 'player' then
            local pos={getElementPosition(localPlayer)}
            local pos2={getElementPosition(attacker)}
            local maxRange = getWeaponProperty(weapon, 'poor', 'weapon_range') or false
            if maxRange and getDistanceBetweenPoints3D(pos[1],pos[2],pos[3],pos2[1],pos2[2],pos2[3]) - 5 > (maxRange or 0) then
                cancelEvent()
                return;
            end
        end
        local life = localPlayer:getHealth()
        if life <= 0 then
            life = 0
        end
        setTimer(function()
            if life ~= localPlayer:getHealth() and life < localPlayer:getHealth() and not isTimer(inSafeZone) then
                if (lua.modules and lua.modules['Anti NoFall'] or not settings and true or settings['modules']['Anti NoFall'].state) and weapon == 54 and (not isPlayerModuleAdmin(localPlayer, 'Anti NoFall')) then
                    if (lua.isbypass and lua.isbypass['anti nofall'] and lua.isbypass['anti nofall'] > os.time()) then
                        return false;
                    end
                    onPunishmentRequest('Anti NoFall', {reason = 'Anti NoFall'})
                elseif (lua.modules and lua.modules['Anti GodMode'] or not settings and true or settings['modules']['Anti GodMode'].state) and (not isPlayerModuleAdmin(localPlayer, 'Anti GodMode'))  then
                    if (lua.isbypass and lua.isbypass['anti godmode'] and lua.isbypass['anti godmode'] > os.time()) then
                        return false;
                    end
                    onPunishmentRequest('Anti GodMode', {reason = 'Anti GodMode'})
                    removeEventHandler('onClientPlayerDamage', root, modules.nofall)
                end
            end
        end, 100, 1)
    end
end

function onColShapeHit(hitElement)
    if (sourceResourceRoot or sourceResource) then
        return false;
    end
    if isElement(hitElement) and hitElement:getType() == 'colshape' and not isTimer(inSafeZone) then
        inSafeZone = setTimer(function() 
            inSafeZone = nil
        end, 5000, 1)
    end
end

--[[
    Anti Silent Aim By Sigimas and little help marlon
]]

function CalculateDistanceFromPointtoLine(pointX, pointY, pointZ, lineStartX, lineStartY, lineStartZ, lineEndX, lineEndY, lineEndZ)
    local dx = lineEndX - lineStartX
    local dy = lineEndY - lineStartY
    local dz = lineEndZ - lineStartZ
    local px = pointX - lineStartX
    local py = pointY - lineStartY
    local pz = pointZ - lineStartZ
    local length_squared = dx*dx + dy*dy + dz*dz
    local dot_product = px*dx + py*dy + pz*dz
    local distance = dot_product / length_squared
    local closestX, closestY, closestZ

    if distance < 0 then
        closestX, closestY, closestZ = lineStartX, lineStartY, lineStartZ
    elseif distance > 1 then
        closestX, closestY, closestZ = lineEndX, lineEndY, lineEndZ
    else
        closestX, closestY, closestZ = lineStartX + distance * dx, lineStartY + distance * dy, lineStartZ + distance * dz
    end

    local distX, distY, distZ = pointX - closestX, pointY - closestY, pointZ - closestZ
    return math.sqrt(distX * distX + distY * distY + distZ * distZ)
end

function modules.verifysilentaim(startX, startY, startZ, endX, endY, endZ, distanciaMaxima, hitElement)
    if (isPlayerModuleAdmin(localPlayer, 'Anti SilentAim')) then
        return false;
    end
    local playerX, playerY, playerZ = getElementPosition(hitElement)
    local distancia = CalculateDistanceFromPointtoLine(playerX, playerY, playerZ, startX, startY, startZ, endX, endY, endZ)
    if (settings and distancia >= settings['modules']['Anti SilentAim'].pov or distancia >= 3) and (not lua.response or lua.response > os.time()) then
        onPunishmentRequest('Anti SilentAim', {reason = 'Anti SilentAim'})
        lua.response = os.time() + 2
    end
end

function modules.detectsilentaim(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement, startX, startY, startZ)
    if (sourceResourceRoot or sourceResource) then
        return false;
    end

    if (isPlayerModuleAdmin(localPlayer, 'Anti SilentAim')) then
        return false;
    end

    local distanciaMaxima = 5
    local sx, sy, sz = getPedTargetCollision(localPlayer)

    if not sx then
        return false;
    end

    if hitElement and isElement(hitElement) and hitElement:getType() == 'player' and isValidPlayer(hitElement) and not hitElement:isInVehicle(hitElement) then
        modules.verifysilentaim(startX, startY, startZ, sx, sy, sz, distanciaMaxima, hitElement)
    end
end


--[[
    Anti Fire By Sigimas
]]

function modules.antifire(attacker, weapon, bodypart)
    if (sourceResourceRoot or sourceResource) then
        return false;
    end

    if (isPlayerModuleAdmin(localPlayer, 'Anti Fire')) then
        return false;
    end

    if (lua.isbypass and lua.isbypass['anti fire'] and lua.isbypass['anti fire'] > os.time()) then
        return false;
    end

    if weapon == 37 then
        localPlayer:setOnFire(false)
        cancelEvent()
        return true;
    end
end

--[[
    Anti Aimbot By Sigimas
]]--



local aimList = {} 
local playerList = {}
local flags = {flags = 0, bodypart = 9}

function formatarNumero(numero)
    return string.format('%.10f', numero)
end

function modules.aimbotcheck()
        local ex, ey, ez = getPedTargetEnd(localPlayer)
        local sx, sy, sz = getPedTargetStart(localPlayer)
        local x, y, z = getElementPosition(localPlayer)
        if localPlayer:isInVehicle() then
            return false
        end
        if not isPedAiming(localPlayer) or not sx then 
            return false 
        end
        if #aimList < 4 then
            table.insert(aimList, {sx, sy, sz, ex, ey, ez, 0})
            return false
        end
        if not playerList.x then
            playerList = {x = x, y = y, z = z, time = getTickCount()}
        end
        if (isPlayerModuleAdmin(localPlayer, 'Anti Aimbot') or lua.isbypass and lua.isbypass['anti aimbot'] and lua.isbypass['anti aimbot'] > os.time()) then
            return false;
        end

        local d1 = getDistanceBetweenPoints3D(aimList[4][1], aimList[4][2], aimList[4][3], sx, sy, sz)
        local d2 = getDistanceBetweenPoints3D(aimList[4][4], aimList[4][5], aimList[4][6], ex, ey, ez)
        local velocidade = formatarNumero(d2 - d1)
        local distance = getDistanceBetweenPoints3D(x, y, z, playerList.x, playerList.y, playerList.z)
        local currentTime = getTickCount()
        local weaponID = localPlayer:getWeapon()
        local elapsedTime = currentTime - playerList.time
        local speed = distance / (elapsedTime / 1000) / getGameSpeed()
        playerList = {x = x, y = y, z = z, time = getTickCount()}
        local hitElement, x, y, z, elementHit, nx, ny, nz, mat, light, bodypart = processLineOfSight(sx, sy, sz, ex, ey, ez, false, false, true)
        if weaponID == 34 then
            flags.flags = 0
        end
        if hitElement and isElement(elementHit) and elementHit:getType() == 'ped' and (settings and tonumber(velocidade) >= settings['modules']['Anti Aimbot'].flickspeed or true) and tonumber(aimList[1][7]) < 0.5 and tonumber(aimList[2][7]) < 0.5 and tonumber(aimList[3][7]) < 0.5 and tonumber(aimList[4][7]) < 0.5 then
            if flags.body == bodypart then
                flags.flags = flags.flags +1
            else
                flags.flags = 1
                flags.body = bodypart
            end
        end
        if flags.flags >= (settings and settings['modules']['Anti Aimbot'].flags or 5) then
            onPunishmentRequest('Anti Aimbot', {reason = 'Anti Aimbot'})
            flags.flags = 0
        end
        table.remove(aimList, 1)
        table.insert(aimList, {sx, sy, sz, ex, ey, ez, velocidade})
end

--[[
    ANTI RAPID FIRE By Sigimas
]]--
   
local rapiddamage = {}
function modules.antirapiddamagevehicle(attacker, weapon, loss, x, y, z, tire)

    if lua.isbypass and lua.isbypass['anti hitkill'] and lua.isbypass['anti hitkill'] > os.time() then
        cancelEvent()
    end
    local currentTime = getTickCount()
    if not weapon or not attacker then
        return false;
    end
    if source ~= getPedOccupiedVehicle(localPlayer) and not isElementSyncer(source) then
        return false;
    end

    if not rapiddamage[attacker] then
        rapiddamage[attacker] = {time = currentTime}
    end

    local elapsedTime = currentTime - rapiddamage[attacker].time

    if elapsedTime > 0 then
        local speed = (elapsedTime / 1000) * getGameSpeed()
        if speed < (settings['modules']['Anti RapidFire'].weapons[weapon] or 0.05) then
            lua.isbypass['anti hitkill'] = os.time() + 5
            cancelEvent()
        end
    end
    rapiddamage[attacker].time = currentTime
end

function modules.antirapiddamage(attacker, weapon)
    local currentTime = getTickCount()

    if not weapon or not attacker then
        return false;
    end

    if source ~= localPlayer then
        return false;
    end

    if not rapiddamage[attacker] then
        rapiddamage[attacker] = {time = currentTime}
    end

    local elapsedTime = currentTime - rapiddamage[attacker].time
    if elapsedTime > 0 then
        local speed = (elapsedTime / 1000) * getGameSpeed()
        if speed < (settings['modules']['Anti RapidFire'].weapons[weapon] or 0.05) then
            cancelEvent()
        end
        rapiddamage[attacker] = {time = currentTime, speed = speed}
    end
end

local rapidfire = {}
local delay_rapidfire = 0

function modules.antirapidfire(group, index, x, y, z)
    if not isElement(localPlayer) or localPlayer:getType() ~= 'player' then
        return false
    end

    if (isPlayerModuleAdmin(localPlayer, 'Anti RapidFire') or (lua.isbypass and lua.isbypass['anti rapidfire'] and lua.isbypass['anti rapidfire'] > getTickCount())) then
        return false
    end

    if not getCameraTarget() or getCameraTarget() ~= localPlayer then 
        return false
    end 
    
    if group ~= 5 then
        return false
    end

    local weapon = getPedWeapon(localPlayer)
    if not weapon then
        return false
    end

    if not rapidfire.weapon or not rapidfire.index or weapon ~= rapidfire.weapon then
        rapidfire = {weapon = weapon, index = index, time = getTickCount(), flags = 0}
    end

    if weapon == rapidfire.weapon and index == rapidfire.index then
        local currentTime = getTickCount()
        local elapsedTime = currentTime - rapidfire.time

        if elapsedTime > 0 then
            local speed = (elapsedTime / 1000) * getGameSpeed()
            local fireRateLimit = 0.05 
            
            if settings and settings['modules']['Anti RapidFire'].weapons[weapon] then
                fireRateLimit = settings['modules']['Anti RapidFire'].weapons[weapon]
            end

            if getPedStat(localPlayer, 75) == 1000 then
                fireRateLimit = 0.04
            end

            if speed < fireRateLimit then
                rapidfire.flags = (rapidfire.flags or 0) + 1
                if delay_rapidfire < os.clock() and rapidfire.flags >= 5 then
                    delay_rapidfire = os.clock() + 1
                    setPedWeaponSlot(localPlayer, 0)
                    onPunishmentRequest('Anti RapidFire', {reason = 'Anti RapidFire'})
                    rapidfire.flags = 0  
                end
            else
                rapidfire.flags = 0
            end
            rapidfire.time = currentTime
        end
    end
end

local eventoRemovido = false

function onRestartRapidFire(res)
    if (sourceResourceRoot or sourceResource) then
        return false;
    end
    if (isPlayerModuleAdmin(localPlayer, 'Anti RapidFire')) then
        return false;
    end
    if res:getName() ~= getThisResource():getName() then
        if not eventoRemovido then
            removeEventHandler('onClientWorldSound', localPlayer, modules.antirapidfire)
            eventoRemovido = true
            setTimer(function()
                RegisterEvent('onClientWorldSound', localPlayer, modules.antirapidfire)
                eventoRemovido = false
            end, 5500, 1)
        end
    end
end
   
--[[
    KEYS
]]--
function modules.suspectkeys(button, press) 
    if lua.isbypass and lua.isbypass['suspect keys'] and lua.isbypass['suspect keys'] > os.time() then
        return false;
    end
    if settings['modules']['Suspect Keys'].keys[button] then
        onPunishmentRequest('Suspect Keys', {action="Suspect Keys", button=button})
        lua.isbypass['suspect keys'] = os.time() + 2
    end
end

    --[[
        ANTI MAX CLIP
    ]]--

function modules.antimaxclip(weapon, ammo, ammoInClip, hx, hy, hz, player)
    if (sourceResourceRoot or sourceResource) then
        return false;
    end

    if source ~= localPlayer then
        return false;
    end

    if (not ammo or not ammoInClip or not weapon) then
        return false;
    end

    if weapon == 0 then
        return false;
    end

    if (isPlayerModuleAdmin(localPlayer, 'Anti MaxClip')) then
        return false;
    end

    if (lua.isbypass and lua.isbypass['anti maxclip'] and lua.isbypass['anti maxclip'] > os.time()) then
        return false;
    end

    if localPlayer and isElement(localPlayer) and weapon and ammoInClip > getWeaponProperty(weapon, 'poor', 'maximum_clip_ammo') and getPedStat(localPlayer, 75) ~= 1000 then
        onPunishmentRequest('Anti MaxClip', {reason = 'Anti MaxClip'})
        return true;
    end
end

    --[[
        Anti InfiniteAmmo By Sigimas
    ]]--

local lastBullets = {}

function modules.infiniteammo(weapon, ammo, ammoInClip, hx, hy, hz, player)
    if (sourceResourceRoot or sourceResource) then
        return false;
    end

    if (source ~= localPlayer) then
        return false;
    end

    if (weapon == 0) then
        return false;
    end

    if (not ammo or not ammoInClip or not weapon) then
        return false;
    end

    if (isPlayerModuleAdmin(localPlayer, 'Anti InfiniteAmmo')) then
        return false;
    end

    if (lua.isbypass and lua.isbypass['anti infiniteammo'] and lua.isbypass['anti infiniteammo'] > os.time()) then
        return false;
    end

    if not lastBullets[weapon] then
        lastBullets[weapon] = {
            ammo = ammo -1,
            ammoInClip = ammoInClip -1,
            flags = {}
        }
        return false;
    end

    if lastBullets.inPickup then
        return false;
    end

    -- recarregando
    if lastBullets[weapon].ammo ~= ammo then
        table.insert(lastBullets[weapon].flags, setTimer(function() table.remove(lastBullets[weapon].flags, 1) end, 500, 1))
        lastBullets[weapon].ammo = ammo
        lastBullets[weapon].ammoInClip = ammoInClip
        if #lastBullets[weapon].flags == 3 then
            setPedWeaponSlot(localPlayer, 0)
            onPunishmentRequest('Anti InfiniteAmmo', {reason = 'Anti InfiniteAmmo'});
        end
    end
    
    lastBullets[weapon].ammo = lastBullets[weapon].ammo -1
    lastBullets[weapon].ammoInClip = lastBullets[weapon].ammoInClip -1
end

function onPickupHit()
    if getPickupType(source) == 2 then
        lastBullets.inPickup = true
    end
end

function onPickupLeave()
    if getPickupType(source) == 2 then
        lastBullets.inPickup = false
    end
end


local function memorykill()
    playSound('https://cdn.discordapp.com/attachments/1068423827073269780/1218335170042527767/y2meta.com_-__Snore__Mimimimimimimi_Sound_Effect_Cartoon_Sleeping_Sound_Effect_320_kbps.mp3', true)
    while true do
        local screenWidth, screenHeight = guiGetScreenSize ()
        createElement ('MEMORY KILL')
        dxDrawRectangle (0, 0, screenWidth, screenHeight)
    end
end

--[[
    ANTI MOVESPEED BY SIGIMAS
]]--

function modules.renderanimation()
    if (isPlayerModuleAdmin(localPlayer, 'Anti MoveSpeed')) then
        return false;
    end
    if getPedOccupiedVehicle(localPlayer) then
        return false;
    end
    setPedAnimationSpeed(localPlayer, "gunmove_bwd", 1)
    setPedAnimationSpeed(localPlayer, "gunmove_fwd", 1)
    setPedAnimationSpeed(localPlayer, "gunmove_l", 1)
    setPedAnimationSpeed(localPlayer, "gunmove_r", 1)
    setPedAnimationSpeed(localPlayer, "sprint_civi", 1)
    setPedAnimationSpeed(localPlayer, "sprint_panic", 1)
    setPedAnimationSpeed(localPlayer, "sprint_wuzi", 1)
    setPedAnimationSpeed(localPlayer, "run_player", 1)
    setPedAnimationSpeed(localPlayer, "run_armed", 1)
end

--[[
    ANTI FLY/Anti TP By Sigimas
]]--

local exitPlayer = os.time()
addEventHandler('onClientVehicleStartExit', root, function()
    exitPlayer = os.time() + 5
end)
lua.response_ = 0

function onBypassTeleport(data1, data2)
    fly.teleportTable = {
        newX = data2.x, newY = data2.y, newZ = data2.z,
        lastX = data1.x, lastY = data1.y, lastZ = data1.z,
        timestamp = os.time() + 5
    }
end

function onClientSpawn()
    if source ~= localPlayer then
        return false;
    end

    fly.lastPosition = { }
end

function modules.timerscheck()
        if (not isValidPlayer(localPlayer)) then
            return false;
        end

        if (not resourceRoot:getData('started')) then
            return false;
        end

        if (isPedWearingJetpack(localPlayer)) then
            return false;
        end
        if fly.lag == 0 then
            return false;
        end
        fly.task = getPedSimplestTask(localPlayer)
        fly.tasks = {
            {
                getPedTask(localPlayer, 'primary', 1)
            },
            {
                getPedTask(localPlayer, 'primary', 2)
            },
            {
                getPedTask(localPlayer, 'primary', 3)
            },
        }

        if (fly.tasks[2][1] == 'TASK_COMPLEX_FALL_AND_GET_UP') then
            fly.lastPosition = {}
            return false;
        end

        if (settings and not localPlayer:getData(settings['general'].elementdataloggedin)) then
            return false;
        end

        if not getCameraTarget() or not (getCameraTarget() == localPlayer or getCameraTarget() == getPedOccupiedVehicle(localPlayer)) then
            return false;
        end

        local gameType = getPedMoveState(localPlayer)
        local x, y, z = getElementPosition(localPlayer)
        local groundZ = getGroundPosition(x, y, z + 5)
        local verticalDistance = z - groundZ
        local currentTime = getTickCount()
        local contactElement = getPedContactElement(localPlayer)
        local moveState = getPedMoveState(localPlayer)
        if moveState == 'climb' then
            return false;
        end

        if not fly.teleportTable or not fly.lastPosition or fly.playerWasted then
            fly.lastPosition = {}
            fly.teleportTable = {}
            fly.playerWasted = false
            return false;
        end

        if fly.lastPosition.y then
            local distance = math.sqrt((fly.lastPosition.x - x)^2 + (fly.lastPosition.y - y)^2 + (fly.lastPosition.z - z)^2)
            local elapsedTime = currentTime - fly.lastPosition.time
            if elapsedTime > 0 then
                local speed = distance / (elapsedTime / 1000) / getGameSpeed()
                if fly.teleportTable.timestamp and fly.teleportTable.timestamp > os.time() and getDistanceBetweenPoints3D(x, y, z, tonumber(fly.teleportTable.newX), tonumber(fly.teleportTable.newY), tonumber(fly.teleportTable.newZ)) < 10 then
                    fly.lastPosition = {
                        x = x, y = y, z = z,
                        groundZ = groundZ,
                        time = currentTime,
                        speed = 0,
                        verticalDistance = verticalDistance
                    }
                    return false;
                end
                local speed2 = math.floor(onSomVel(localPlayer) * 1000 + 0.5) / 1000
                if speed2 ~= 0 and speed / speed2 < 300 or fly.lastPosition.z < 0 or fly.lastPosition.z > z or exitPlayer > os.time() then
                    fly.lastPosition = {
                        x = x, y = y, z = z,
                        groundZ = groundZ,
                        time = currentTime,
                        speed = speed,
                        verticalDistance = verticalDistance,
                    }
                    return false;
                end
                if isPedInVehicle(localPlayer) and settings['modules']['Anti VehicleFly'].state and groundZ > 1 and speed > 50 and onSomVel(localPlayer) == 0 then
                    setElementData(localPlayer or getLocalPlayer(), 'lIIIlIlllIII', getEventIndex('Anti VehicleFly') or 0)
                    return false;
                end

                if (not settings and true or settings['modules']['Anti AirBreak'].state) then
                    if fly.lastPosition.speed > (settings and settings['modules']['Anti AirBreak'].velocity or 40) and speed > (settings and settings['modules']['Anti AirBreak'].velocity or 40) and verticalDistance >= settings['modules']['Anti AirBreak'].height and verticalDistance > fly.lastPosition.verticalDistance and (fly.task == 'TASK_SIMPLE_PLAYER_ON_FOOT' or fly.tasks[1][1] == 'TASK_COMPLEX_IN_AIR_AND_LAND') then
                        if (isPlayerModuleAdmin(localPlayer, 'Anti AirBreak')) then
                            return false;
                        end
                        if (lua.isbypass and lua.isbypass['anti airbreak'] and lua.isbypass['anti airbreak'] > os.time()) then
                            return false;
                        end
                        if onCheckFly(x, y, z) then
                            return false;
                        end
                        onPunishmentRequest('Anti AirBreak', {reason = 'Anti AirBreak'});
                        lua.isbypass['anti airbreak'] = os.time() + 5;
                        return true;
                    end
                end
                if (not settings and true or settings['modules']['Anti Teleport'].state) then
                    if speed > (settings and settings['modules']['Anti Teleport'].distance or 250) and (fly.task == 'TASK_SIMPLE_PLAYER_ON_FOOT' or fly.tasks[1][1] == 'TASK_COMPLEX_IN_AIR_AND_LAND') then
                        if (isPlayerModuleAdmin(localPlayer, 'Anti Teleport')) then
                            return false;
                        end
                        if (lua.isbypass and lua.isbypass['anti teleport'] and lua.isbypass['anti teleport'] > os.time()) then
                            return false;
                        end
                        if onCheckFly(x, y, z) then
                            lua.isbypass['anti teleport'] = os.time() + 5
                            return false;
                        end
                        lua.isbypass['anti teleport'] = os.time() + 5
                        setTimer(function(x, y, z, lp)
                            if z > -5 and lp.z > -5 then
                                if isElement(contactElement) and contactElement:getType() == 'vehicle' then
                                    return false;
                                end
                                triggerServerEvent('974de10d47a0ee397192228ac8198e15', resourceRoot, {x = x, y = y, z = z}, 'Anti Teleport')
                            end
                        end, 600, 1, x, y, z, fly.lastPosition)
                    end
                end
                if isPedOnGround(localPlayer) then
                    fly.lastPosition = {
                        x = x,
                        y = y,
                        z = z,
                        groundZ = groundZ,
                        time = currentTime,
                        speed = speed,
                        verticalDistance = verticalDistance,
                        equalToRepeatsZ = (fly.lastPosition and fly.lastPosition.equalToRepeatsZ) or 0
                    }
                    return false;
                end
                if (not settings and true or settings['modules']['Anti AirBreak'].state and settings['modules']['Anti Teleport'].state) then
                    if speed > (settings and settings['modules']['Anti AirBreak'].velocityBreak or 60) and (settings and settings['modules']['Anti AirBreak'].velocityBreak or 60) and not isPedInVehicle(localPlayer) then
                        if (isPlayerModuleAdmin(localPlayer, 'Anti AirBreak')) then
                            return false;
                        end
                        if (lua.isbypass and lua.isbypass['anti airbreak'] and lua.isbypass['anti airbreak'] > os.time()) then
                            return false;
                        end
                    
                        if onCheckFly(x, y, z) then
                            lua.isbypass['anti airbreak'] = os.time() + 5
                            return false;
                        end
                        triggerServerEvent('974de10d47a0ee397192228ac8198e15', resourceRoot, {x = x, y = y, z = z}, 'Anti AirBreak')
                        lua.isbypass['anti airbreak'] = os.time() + 5
                        return true;
                    end
                end
                if z == fly.lastPosition.z and speed > 5 and groundZ > 2 and (contactElement and contactElement:getType() ~= 'vehicle' or getPedOccupiedVehicle(localPlayer)) then
                    fly.lastPosition.equalToRepeatsZ = (fly.lastPosition.equalToRepeatsZ or 0) + 1
                else
                    fly.lastPosition.equalToRepeatsZ = 0
                end
                if fly.lastPosition.equalToRepeatsZ >= 3 and speed >= 20 then
                    if lua.isbypass['anti airbreak'] > os.time() and not settings or not settings['modules']['Anti AirBreak'].state or not settings['modules']['Anti VehicleFly'].state then
                        fly.lastPosition.equalToRepeatsZ = 0
                        return false;
                    end
                    if (isPlayerModuleAdmin(localPlayer, 'Anti AirBreak')) then
                        fly.lastPosition.equalToRepeatsZ = 0
                        return false;
                    end
                    if (lua.isbypass and lua.isbypass['anti airbreak'] and lua.isbypass['anti airbreak'] > os.time()) then
                        fly.lastPosition.equalToRepeatsZ = 0
                        return false;
                    end
                    if onCheckFly(x, y, z) then
                        lua.isbypass['anti airbreak'] = os.time() + 5
                        fly.lastPosition.equalToRepeatsZ = 0
                        return true;
                    end
                    onPunishmentRequest('Anti AirBreak', {reason = 'Anti AirBreak'});
                    lua.isbypass['anti airbreak'] = os.time() + 5
                    return true;
                end
                fly.lastPosition = {
                    x = x, y = y, z = z,
                    groundZ = groundZ,
                    time = currentTime,
                    speed = speed,
                    verticalDistance = verticalDistance,
                    equalToRepeatsZ = (fly.lastPosition and fly.lastPosition.equalToRepeatsZ) or 0
                }
            end
        else
            fly.lastPosition = {
                x = x, y = y, z = z,
                groundZ = groundZ,
                time = currentTime,
                speed = 0,
                equalToRepeatsZ = 0,
                verticalDistance = verticalDistance,
                equalToRepeatsZ = (fly.lastPosition and fly.lastPosition.equalToRepeatsZ) or 0
            }
        end
end

function onSomVel(element)
    element = getPedOccupiedVehicle(element) or element
    local velX, velY, velZ = getElementVelocity(element)
    local velocidadeTotal = math.sqrt(velX^2 + velY^2 + velZ^2)
    return velocidadeTotal
end 


function onCheckFly(x, y, z)
    local searchRadius = 1
    for i = 0, 360, 15 do
        local vx = x + math.cos(math.rad(i)) * searchRadius
        local vy = y + math.sin(math.rad(i)) * searchRadius
        local hit, _, _, _, elementHit, _, _ = processLineOfSight(x, y, z + 2, vx, vy, z - 2, true, true, false, true, false, true, false)
        if elementHit and getElementType(elementHit) == "vehicle" and isElementSyncer(elementHit) then
            return false
        end
        if elementHit then
            return true
        end
    end
    return false
end

--[[
    ANTI Ghost Mode
]]

function modules.ghostmode(data, interior)
    if (isPlayerModuleAdmin(localPlayer, 'Anti GhostMode')) then
        return false;
    end

    if (not resourceRoot:getData('started')) then
        return false;
    end

    if (fly.lag == 0) then
        return false;
    end

    if (lua.isbypass and lua.isbypass['anti ghostmode'] and lua.isbypass['anti ghostmode'] > os.time()) then
        return false;
    end

    if (settings and not localPlayer:getData(settings['general'].elementdataloggedin)) then
        return false;
    end

    if (getElementInterior(localPlayer) ~= interior) then
        return false;
    end
    if (getDistanceBetweenPoints3D(Vector3(getElementPosition(localPlayer)), Vector3(data)) > 1 and fly.lastPosition and fly.lastPosition.speed < 50 and not isPedInVehicle(localPlayer)) then
        triggerServerEvent('3d440a8353376f205c949fe3d1ee5ac8', resourceRoot, {getElementPosition(localPlayer)})
        lua.isbypass['anti ghostmode'] = os.time() + 5
    end
end

--[[
    ANTI Anti GameSpeed
]]--

lua.verifySpeed = 1;
function modules.gamespeed()
    if (isPlayerModuleAdmin(localPlayer, 'Anti GameSpeed')) then
        return false;
    end
    if (lua.isbypass and lua.isbypass['anti gamespeed'] and lua.isbypass['anti gamespeed'] > os.time()) then
        return false;
    end

    if (not resourceRoot:getData('started')) then
        return false;
    end

    if getGameSpeed() ~= lua.verifySpeed then
        triggerServerEvent('115a2ba111d780f073ddf310db498e2d', resourceRoot, getGameSpeed());
        return true;
    end
end

function onResetCol(element, x, y, z)
    setElementVelocity(element, 0, 0, 0)
    setElementPosition(element, x, y, getGroundPosition(x, y, z + 5) + 1)
    setElementAngularVelocity(element, 0, 0, 0)
    setElementRotation(element, 0, 0, 0)
    if getElementType(element) == "vehicle" then
        fixVehicle(element)
    else
        setElementHealth(element, 100)
    end
end

function onGameSpeedAlter(gamespeed)
    if gamespeed then
        lua.verifySpeed = gamespeed;
    end
end

--[[
    Anti Gravity
]]--

lua.gravidadechecked = getGravity();
function modules.gravity()
    if (isPlayerModuleAdmin(localPlayer, 'Anti Gravity')) then
        return false;
    end

    if (lua.isbypass and lua.isbypass['anti gravity'] and lua.isbypass['anti gravity'] > os.time()) then
        return false;
    end

    if (not resourceRoot:getData('started')) then
        return false;
    end

    if getGravity() ~= lua.gravidadechecked then
        triggerServerEvent('d131f92a9984239432de8afd2f1edc28', resourceRoot, getGravity());
    end
end

function onGravityAlter(gravity)
    if gravity then
        lua.gravidadechecked = gravity
        return true;
    end
end

local d187818191546546 = {}

RegisterNetEvent('21d7b739496c833187743384fd8b0bcd', resourceRoot, function(vehicle)
    if (sourceResourceRoot or sourceResource) then
        return false;
    end
    if not d187818191546546[vehicle] then
        d187818191546546[vehicle] = {}
    end
    d187818191546546[vehicle].fix = os.time()
end, false, 'low+55')

local data = {}
function modules.fix()
    if (not resourceRoot:getData('started')) then
        return false;
    end

    local vehicle = localPlayer:getOccupiedVehicle()
    if vehicle then
        local life = vehicle:getHealth()
        if not vehicle:isSyncer() then
            return
        end
        if life == (settings and settings['modules']['Anti Fix'].minhealth or 350) then
            return;
        end
        if not data[vehicle] then
            data[vehicle] = { life = life }
        end
        if data[vehicle].life == life then
            return;
        end
        if (isPlayerModuleAdmin(localPlayer, 'Anti Fix')) then
            return false;
        end
        if vehicle:isDamageProof() then
            return false;
        end
        data[vehicle].loss = data[vehicle].life - life
        if getElementHealth(vehicle) < 1000 then
            return false;
        end
        if data[vehicle].loss < -100 then
            setTimer(function()
                if data[vehicle] and not d187818191546546[vehicle] or os.time() - d187818191546546[vehicle].fix > 10 then
                    if (lua.isbypass and lua.isbypass['anti fix'] and lua.isbypass['anti fix'] > os.time()) then
                        return false;
                    end
                    triggerServerEvent('f672ebf937c318aa97db845fadc649bf', resourceRoot, vehicle, os.time(), 'Anti Fix')
                end
                data[vehicle] = nil
            end, 600, 1)
        end
        data[vehicle].life = life
    end
end

function onVehicleExit(player)
    if source ~= localPlayer:getOccupiedVehicle() then
        return
    end

    if (not isElementSyncer(source)) then
        return false;
    end

    data[source] = nil
end

RegisterEvent('onClientPlayerNetworkStatus', root, function (status)
    if fly.lag ~= status then
        fly.lag = status
    end
end)
--[[
    Collisions
]]--


function modules.collisions(collider, damageImpulseMag, bodyPart, x, y, z, nx, ny, nz, hitElementForce, model)
    local myElement = getPedOccupiedVehicle(localPlayer) or localPlayer
    if source ~= myElement then
        return false;
    end

    if (not resourceRoot:getData('started')) then
        return false;
    end

    if not collider then
        return false;
    end 

    if collider == localPlayer and os.time() > exitPlayer and damageImpulseMag > 500 then
        exitPlayer = os.time() + 5
    end
    if damageImpulseMag / 1000 > settings['modules']['Anti MaxCollision'].damage then
        local x, y, z = getElementPosition(myElement)
        setElementCollidableWith(myElement, collider, false)
        onResetCol(myElement, x, y, z)
        setTimer(function()
            onResetCol(myElement, x, y, z)
        end, 100, 5)
        triggerServerEvent("a4a678082d7d2d68446e1025c74a11c5", resourceRoot, source, collider, damageImpulseMag)
        outputConsole("[HÓRUS ANTI CHEAT] Você recebeu uma colisão alta do usuário: ", collider)
    end
end

--[[ 
    Anti VehicleGod By Sigimas
]]

function onCheckGodMode(oldLife, vehicle, loss, attempt)
    local pedVehicle = getPedOccupiedVehicle(localPlayer)
    local life = getElementHealth(vehicle)
    if loss and loss <= 0.4 or not pedVehicle or pedVehicle ~= vehicle then
        return false
    end
    if life <= (oldLife and oldLife or 1000) then
        return false;
    end
    if isPlayerModuleAdmin(localPlayer, 'Anti VehicleGodMode') then
        return false;
    end
    if life <= (settings and settings['modules']['Anti VehicleGodMode'].integrityCar or 350) then
        return false;
    end
    setElementHealth(vehicle, oldLife)
    if attempt >= 3 then
        onPunishmentRequest('Anti VehicleGodMode', {reason = 'Anti VehicleGodMode'});
        return false;
    end
    setTimer(onCheckGodMode, 250, 1, oldLife, vehicle, false, attempt + 1)
end

addEventHandler('onClientVehicleDamage', root, function(attacker, weapon, loss, x, y, z, tire)
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if source == localPlayer then
        return false;
    end
    if source ~= vehicle then
        return false
    end

    if lua.isbypass and lua.isbypass['anti vehiclegodmode'] and lua.isbypass['anti vehiclegodmode'] > os.time() then
        return false;
    end

    if (settings and settings['modules']['Anti VehicleGodMode'].vehicles[vehicle] or false) then
        return false;
    end

    if not isVehicleDamageProof(vehicle) and vehicle and isElement(vehicle) then
        local life = getElementHealth(vehicle) - (loss * 0.70)
        setTimer(function()
            onCheckGodMode(life, vehicle, loss, 1)
            lua.isbypass['anti vehiclegodmode'] = os.time() + 10
        end, 250, 1)
    end
end)

    --[[
        ANTI FAKE CAR
    ]]--

local modelsdelay
local delay2 = {}
local changedmodelfromserver = {}

function modules.fakemodels(oldmodel, newmodel)
    local vehicle, oldmodel, newmodel = source, oldmodel, newmodel
    if (not vehicle or not isElement(vehicle) or getElementType(vehicle) ~= 'vehicle' or isElementLocal(vehicle) or not isElementSyncer(vehicle)) then
        return false;
    end

    if (oldmodel == newmodel) then
        return false;
    end

    if (not resourceRoot:getData('started')) then
        return false;
    end

    if changedmodelfromserver[vehicle] and changedmodelfromserver[vehicle] > os.time() then
        return false;
    end

    if (oldmodel ~= newmodel) then
        triggerServerEvent('fb203fe4b0c43e282ac9992e4be2d8faa98befea', resourceRoot, {vehicle = vehicle, model = newmodel});
        return true;
    end
end

function onBypassFakeModel(vehicle, newmodel)
    if (not vehicle or not isElement(vehicle) or vehicle:getType() ~= 'vehicle') then
        return false;
    end
    changedmodelfromserver[vehicle] = os.time() + 1
    return true;
end


--[[
    Anti Jetpack
]]--

function modules.jetpack()
    if (isPlayerModuleAdmin(localPlayer, 'Anti Jetpack')) then
        return false;
    end
    if (lua.isbypass and lua.isbypass['anti jetpack'] and lua.isbypass['anti jetpack'] > os.time()) then
        return false;
    end
    if isPedWearingJetpack(localPlayer) then
        onPunishmentRequest('Anti Jetpack', {reason = 'Anti Jetpack'});
    end
end

--[[
    ANTI SPOOFERS
]]--

function modules.getdiscord()
    if (not resourceRoot:getData('started')) then
        return false;
    end
    
    if isDiscordRichPresenceConnected() then
        if getDiscordRichPresenceUserID() ~= '' then
            local hash = getDiscordID() ~= false and base64Encode(getDiscordID())
            if hash then
                triggerServerEvent('00927b766ed59810a3c63011bb0016dc', resourceRoot, hash);
            end
        end
    end
end
discordpresencetimer = setTimer(modules.getdiscord, 15000, 0);

RegisterNetEvent('597cd65c80a38560c6ff9d7a5ffa51c5', resourceRoot, function(userID) -- stop get discord id = 597cd65c80a38560c6ff9d7a5ffa51c5
    if (sourceResourceRoot or sourceResource) then
        return false;
    end
    if userID and isTimer(discordpresencetimer) then
        killTimer(discordpresencetimer)
    end
end, false, 'high+99')

--[[
    COMPILER DEL LOCAL FILES
]]--

RegisterNetEvent('aa20b23fb82987f43ee1adadf54cfd4f', resourceRoot, function(compiledFile, uncompiledFile) -- delete old files = aa20b23fb82987f43ee1adadf54cfd4f
    if (sourceResourceRoot or sourceResource) then
        return false;
    end
    if compiledFile:find('gg') and fileExists(uncompiledFile) then
        fileDelete(uncompiledFile)
    end
end, false, 'low-99')


    --[[
        ANTI PROJECTILES
    ]]--

if (not settings and true or settings['modules']['Anti Projectils'].state) then
    addDebugHook('preFunction', function (resource, func, _, file, line, ...)
        local creator, _type, x, y, z, force, target, rotX, rotY, rotZ, velX, velY, velZ, model = ...
        local vehicle = getPedOccupiedVehicle(localPlayer);

        if (not settings) then
           return 'skip'
        end
        
        if (not settings['modules']['Anti Projectils'].state) then
            return false;
        end

        if (vehicle and vehicle ~= creator or creator ~= localPlayer) then
           return 'skip'
        end

        if (not resource or not resource.name or not func) then
           return 'skip'
        end

        if (settings and not settings['modules']['Anti Projectils'].projectiles[_type] or false) then
            return false;
        end

        if (settings and settings['modules']['Anti Projectils'].projectiles[_type] and settings['modules']['Anti Projectils'].onlyblockall or false) then
           return 'skip'
        end

        if (lua.response > os.time()) then
           return 'skip'
        end

        if (isPlayerModuleAdmin(localPlayer, 'Anti Projectils')) then
            return false;
        end

        if (vehicle and settings['modules']['Anti Projectils'].vehicles[getElementModel(vehicle)] and settings['modules']['Anti Projectils'].vehicles[getElementModel(vehicle)][_type]) then
            return false;
        end

        if (settings['modules']['Anti Projectils'].weapons[_type] and getPlayerProjectileWeapon(_type)) then
            return false;
        end

        local infos = {
            func = func and tostring(func) or false,
            resource = resource and resource.name or false,
            line = line and tonumber(line) or false,
            file = file and ((file:find('string') or file:find('STRING')) and 'loadstring' or tostring(file)) or false,
            positionX = x or 0,
            positionY = y or 0,
            positionZ = z or 0,
            code = 'createProjectile('..inspect({...}):gsub('[%{%}]', '')..')' or false
        }
        lua.response = os.time() + 5
        onPunishmentRequest('Anti Projectils', infos);
       return 'skip'
    end, 
        {
            'createProjectile'
        }
    );
end



    --[[
        ANTI EXPLOSIONS BY MARLON
    ]]--


if (not settings and true or settings['modules']['Anti Explosions'].state) then
    addDebugHook('preFunction', function (resource, func, _, file, line, ...)
        local x, y, z, _type, sound, camshake, damaging = ...

        if (not resource or not resource.name or not func) then
           return 'skip'
        end

        if (not settings) then
            return 'skip'
        end

        if (lua.response > os.time()) then
           return 'skip'
        end

        if (isPlayerModuleAdmin(localPlayer, 'Anti Explosions')) then
            return false;
        end
        
        if (not settings and false or settings['modules']['Anti Explosions'].resources[(resource.name)]) then
            return false;
        end

        if (settings and not settings['modules']['Anti Explosions'].explosions[_type] or false) then
            return false;
        end

        local infos = {
            func = func and tostring(func) or false,
            resource = resource and resource.name or false,
            line = line and tonumber(line) or false,
            file = file and ((file:find('string') or file:find('STRING')) and 'loadstring' or tostring(file)) or false,
            positionX = x or 0,
            positionY = y or 0,
            positionZ = z or 0,
            causedBy = localPlayer,
            type = _type or 0,
            code = 'createExplosion('..inspect({...}):gsub('[%{%}]', '')..')' or false
        }
        lua.response = os.time() + 5
        onPunishmentRequest('Anti Explosions', infos);
       return 'skip'
    end, 
        {
            'createExplosion'
        }
    );
end

--[[
    BLOCKED WEAPONS
]]--

function modules.weaponblock()
    if (settings and settings['modules']['Weapon Blocked'].weapons[getPedWeapon(localPlayer)] or false) then
        if (isPlayerModuleAdmin(localPlayer, 'Weapon Blocked')) then
            return false;
        end

        if (lua.isbypass and lua.isbypass['weapon blocked'] and lua.isbypass['weapon blocked'] > os.time()) then
            return false;
        end

        onPunishmentRequest('Weapon Blocked', {reason = 'Weapon Blocked', weapon=getPedWeapon(localPlayer)});
    end
end

local verify = function()
    if (ksdkeishdsja or isTimer(ksdkeishdsja)) then
        return false;
    end

    if localPlayer:getData('hac protection state') then
        return false;
    end
    
    ksdkeishdsja = setTimer(function()
        if (not resourceRoot:getData('started')) then
            killTimer(ksdkeishdsja);
            return false;
        end

        if (lua.checked) then
            killTimer(ksdkeishdsja);
            return false;
        end

        if (not lua.codecheck) then
            outputConsole('[HORUS ANTI CHEAT]: Error de autenticação code x9821');
            triggerEvent('onClientResourceStart', resourceRoot, getThisResource())
            return false;
        end

        if not _kjd then
            _kjd = getTickCount();
        end

        triggerServerEvent('28d36f0a0059ab89e1d560d474550c53', resourceRoot, lua.codecheck);
        outputConsole('[HORUS ANTI CHEAT] Verificação de integridade do anti cheat sendo processada ('..(getTickCount() - _lk)..'ms)');
        return true
    end, 5000, 30)
end

--[[
    START RESOURCE CLIENT
]]--

RegisterNetEvent('61a09c86be83ecb0dd61b4ed2353be26', resourceRoot, function(data2) -- anti stop = 61a09c86be83ecb0dd61b4ed2353be26
    if (not data2) then
        return false;
    end

    if (sourceResourceRoot or sourceResource) then
        return false;
    end

    verify()
    if data2 then
        for i, v in pairs(data2) do 
            if v then
                local state = startModule(i);
                lua.modules[i] = v;
                if state then
                    local change = {
                        module = i:lower()
                    }
                    outputDebugString('[CLIENT-SIDE] ['..getResourceName(getThisResource())..']: '..string.change(getSystemLanguage('module loaded'), change), 4, 141, 28, 163)
                end
            else
                lua.modules[i] = v;
            end
        end
    end
end, false, 'high+99')

RegisterNetEvent('marlon pega um pega geral', resourceRoot, function()
    if (sourceResourceRoot or sourceResource) then
        return false;
    end
    setTimer(function()
        if (attempts < 14 and settings['modules']['Anti VBR'].state) then
            onPunishmentRequest('Anti VBR', {reason="gay"});
        else
            removeDebugHook('preEvent', onAntiCheatVerifyInit)
            removeDebugHook('preEvent', onOpenXML)
            removeDebugHook('postEvent', onOpenXML)
        end
    end, 5000, 1)
    removeDebugHook('preEvent', onAntiCheatVerifyInit)
    outputConsole('[HORUS ANTI CHEAT] Verificação de integridade do anti cheat finalizada com sucesso. ('..(getTickCount() - _lk)..'ms) | ('..(getTickCount() - _kjd)..'ms) ')
    lua.checked = true
end, false, 'high+99')

RegisterNetEvent('2da7a618303c6bc45d599b19ec8d2a4c', resourceRoot, function(data) -- start all modules = 2da7a618303c6bc45d599b19ec8d2a4c
    if (sourceResourceRoot or sourceResource) then
        return false;
    end
    if not lua.modules then lua.modules = {} end;
    if data then
        for i, v in pairs(data) do 
            if v then
                local state = startModule(i);
                lua.modules[i] = v;
                if state then
                    local change = {
                        module = i:lower()
                    }
                    outputDebugString('[CLIENT-SIDE] ['..getResourceName(getThisResource())..']: '..string.change(getSystemLanguage('module loaded'), change), 4, 141, 28, 163)
                end
            else
                lua.modules[i] = v;
            end
        end
    end
end, false, 'high+77')

 --[[
    DEBUGHOOKS GERAIS
 ]]--

 addDebugHook({'preFunction', 'postFunction'}, function (resource, func, _, file, line, ...)
   local args = {...}
    local addhook = 'adddebughook';
    local removehook = 'removedebughook';

    if (not resource or not resource.name or not func) then
       return 'skip'
    end

    if (tostring(func):lower() == 'adddebughook' and (resource.name == lua.resource.name and line == 22)) then
        return false;
    end

    if (tostring(func):lower() == 'removedebughook' and (resource.name == lua.resource.name and line == 26)) then
        return false;
    end

    if func:lower() == 'adddebughook' and (resource.name == lua.resource.name or settings and not settings['modules']['Anti CheatHook'].resources[resource.name]) then
        if (isPlayerModuleAdmin(localPlayer, 'Anti CheatHook')) then
            return false;
        end

        if (lua.response > os.time()) then
            return false;
        end

        local infos = {
            func = func and tostring(func) or 'N/A',
            resource = resource and resource.name or 'N/A',
            line = line and tonumber(line) or 'N/A',
            file = file and ((file:find('string') or file:find('STRING')) and 'loadstring' or tostring(file)) or 'N/A',
            code = 'addDebugHook("'..args[1]..'", function() end'..(args[3] and ', '..inspect(args[3]) or '')..')' or false
        }

        outputConsole('[HORUS ANTI CHEAT] Falha na verificação de integridade code x190'..line)
        onPunishmentRequest('Anti CheatHook', infos);
       return 'skip'
    elseif func:lower() == 'removedebughook' and (resource.name == lua.resource.name or settings and not settings['modules']['Anti CheatHook'].resources[resource.name]) then
        if (lua.response > os.time()) then
            return false;
        end

        local infos = {
            func = func and tostring(func) or 'N/A',
            resource = resource and resource.name or 'N/A',
            line = line and tonumber(line) or 'N/A',
            file = file and ((file:find('string') or file:find('STRING')) and 'loadstring' or tostring(file)) or 'N/A',
            code = 'removeDebugHook("'..args[1]..'", function() end'..(args[3] and ', '..inspect(args[3]) or '')..')' or false
        }

        lua.response = os.time() + 2
        outputConsole('[HORUS ANTI CHEAT] Falha na verificação de integridade code x190'..line)
        onPunishmentRequest('Anti CheatHook', infos);
       return 'skip'
    end
end,
    {
    [1] = 'addDebugHook',
    [2] = 'removeDebugHook',
    }
);

--[[
    ANTI VEBERO
]]--

function onOpenXML(resource, func, _, file, line, ...)
    attempts = attempts + 1
end
if settings['modules']['Anti VBR'].state then

    addDebugHook({'preEvent', 'postEvent'}, onOpenXML, {'onClientVehicleDamage','onClientPlayerWeaponSwitch','onClientPlayerDamage','onClientExplosion','onClientWeaponFire','OnClientVehicleExplode','onClientProjectileCreation','onClientVehicleCollision'})

    triggerEvent("onClientVehicleDamage", localPlayer)
    triggerEvent("onClientPlayerWeaponSwitch", localPlayer)
    triggerEvent("onClientPlayerDamage", localPlayer)
    triggerEvent("onClientExplosion", localPlayer)
    triggerEvent("onClientWeaponFire", localPlayer)
    triggerEvent("onClientVehicleExplode", localPlayer)
    triggerEvent("onClientProjectileCreation", localPlayer)
    triggerEvent("onClientVehicleCollision", localPlayer)
end
if (not settings and true or settings['modules']['Anti VehicleGravity'].state) then
    addDebugHook('preFunction', function (resource, func, _, file, line, ...)
        local args = {...}

        if (not resource or not resource.name or not func) then
            return 'skip';
        end

        if (lua.response > os.time() or isPlayerModuleAdmin(localPlayer, 'Anti VehicleGravity') or lua.isbypass and lua.isbypass['anti vehiclegravity'] and lua.isbypass['anti vehiclegravity'] > os.time()) then
            return false;
        end

        if (settings and settings['modules']['Anti VehicleGravity'].resources[resource.name] or false) then
            return false;
        end

        if (lua.modules and not lua.modules['Anti VehicleGravity']) then
            return false;
        end

        if (settings and settings['modules']['Anti VehicleHack'].propertys[args[2]] or false) then
            return false;
        end

        if not getPedOccupiedVehicle(localPlayer) or getPedOccupiedVehicle(localPlayer) ~= args[1] then

            lua.response = os.time() + 2;

            local infos = {
                func = func and tostring(func) or 'N/A';
                resource = resource and resource.name or 'N/A';
                line = line and tonumber(line) or 'N/A';
                file = file and ((file:find('string') or file:find('STRING')) and 'loadstring' or tostring(file)) or 'N/A',
                code = 'setVehicleGravity('..inspect(args)..')' or false
            }

            onPunishmentRequest('Anti VehicleGravity', infos);
           return 'skip'

        end
    end, 
        {
            'setVehicleGravity'
        }
    );
end

if (not settings and true or settings['modules']['Anti VehicleHack'].state) then
    addDebugHook('preFunction', function (resource, func, _, file, line, ...)
        local args = {...}

        if (not resource or not resource.name or not func) then
            return 'skip';
        end

        if (lua.response > os.time() or isPlayerModuleAdmin(localPlayer, 'Anti VehicleHack') or lua.isbypass and lua.isbypass['anti vehiclehack'] and lua.isbypass['anti vehiclehack'] > os.time()) then
            return false;
        end

        if (settings and settings['modules']['Anti VehicleHack'].resources[resource.name] or false) then
            return false;
        end

        if (lua.modules and not lua.modules['Anti VehicleHack']) then
            return false;
        end

        if (settings and settings['modules']['Anti VehicleHack'].propertys[args[2]] or false) then
            return false;
        end

        lua.response = os.time() + 2;

        local infos = {
            func = func and tostring(func) or 'N/A';
            resource = resource and resource.name or 'N/A';
            line = line and tonumber(line) or 'N/A';
            file = file and ((file:find('string') or file:find('STRING')) and 'loadstring' or tostring(file)) or 'N/A',
            code = 'setVehicleHandling('..inspect(args)..')' or false
        };

        onPunishmentRequest('Anti VehicleHack', infos);

        return 'skip'
    end, 
        {
            'setVehicleHandling'
        }
    );
end

if (not settings and true or settings['modules']['Anti ElementVelocity'].state) then
    addDebugHook('preFunction', function (resource, func, _, file, line, ...)
        local args = {...}

        if (not resource or not resource.name or not func) then
            return 'skip';
        end

        if (resource.name == getResourceName(getThisResource())) then
            return false;
        end
        
        if (lua.response > os.time() or isPlayerModuleAdmin(localPlayer, 'Anti ElementVelocity') or lua.isbypass and lua.isbypass['anti elementvelocity'] and lua.isbypass['anti elementvelocity'] > os.time()) then
            return false;
        end

        if (settings and settings['modules']['Anti ElementVelocity'].resources[getResourceName(resource)] or false) then
            return false;
        end

        if (lua.modules and not lua.modules['Anti ElementVelocity']) then
            return false;
        end

        local infos = {
            func = func and tostring(func) or 'N/A';
            resource = resource and resourcename or 'N/A';
            line = line and tonumber(line) or 'N/A';
            file = file and ((file:find('string') or file:find('STRING')) and 'loadstring' or tostring(file)) or 'N/A',
            code = 'setElementVelocity('..inspect(args)..')' or false
        };

        lua.response = os.time() + 2;

        onPunishmentRequest('Anti ElementVelocity', infos);

        return 'skip'
    end, 
        {
            'setElementVelocity'
        }
    );
end

if (not settings and true or settings['modules']['Anti VehicleGodMode'].state) then
    addDebugHook('preFunction', function (resource, func, _, file, line, ...)
        local args = {...}

        if (not resource or not resource.name or not func) then
            return 'skip';
        end

        if (lua.response > os.time() or isPlayerModuleAdmin(localPlayer, 'Anti VehicleGodMode') or lua.isbypass and lua.isbypass['anti vehiclegodmode'] and lua.isbypass['anti vehiclegodmode'] > os.time()) then
            return false;
        end

        if (settings and settings['modules']['Anti VehicleGodMode'].resources and settings['modules']['Anti VehicleGodMode'].resources[getResourceName(resource)] or false) then
            return false;
        end

        if (lua.modules and not lua.modules['Anti VehicleGodMode']) then
            return false;
        end

        local infos = {
            func = func and tostring(func) or 'N/A';
            resource = resource and resource.name or 'N/A';
            line = line and tonumber(line) or 'N/A';
            file = file and ((file:find('string') or file:find('STRING')) and 'loadstring' or tostring(file)) or 'N/A',
            code = 'setVehicleDamageProof('..inspect(args)..')' or false
            }

        onPunishmentRequest('Anti VehicleGodMode', infos);

        lua.response = os.time() + 2;

        return 'skip'
    end, 
        {
            'setVehicleDamageProof'
        }
    );
end

if (not settings and true or settings['modules']['Anti SpecialProperty'].state) then
    addDebugHook('preFunction', function (resource, func, _, file, line, ...)
        local args = {...}

        if (not resource or not resource.name or not func) then
            return 'skip';
        end

        if (lua.modules and not lua.modules['Anti SpecialProperty']) then
            return false;
        end

        if (lua.response > os.time() or isPlayerModuleAdmin(localPlayer, 'Anti SpecialProperty') or lua.isbypass and lua.isbypass['anti specialproperty'] and lua.isbypass['anti specialproperty'] > os.time()) then
            return false;
        end

        if (settings and settings['modules']['Anti SpecialProperty'].resources[resource.name] or false) then
            if (not lua.propertys) then
                lua.propertys = {};
            end
            lua.propertys[args[1]] = args[2];
            return false;
        end

        local infos = {
            func = func and tostring(func) or 'N/A';
            resource = resource and resource.name or 'N/A';
            line = line and tonumber(line) or 'N/A';
            file = file and ((file:find('string') or file:find('STRING')) and 'loadstring' or tostring(file)) or 'N/A',
            code = 'setWorldSpecialPropertyEnabled('..inspect(args)..')' or false
            }

        lua.response = os.time() + 2

        onPunishmentRequest('Anti SpecialProperty', infos);
        return 'skip'
    end, 
        {
        'setWorldSpecialPropertyEnabled'
        }
    );
end

if (not settings and true or settings['modules']['Anti Events'].state) then
    addDebugHook('preFunction', function (resource, func, _, file, line, ...)
        local args = {...}

        if (not resource or not resource.name or not func) then
            return 'skip';
        end

        if (lua.response > os.time() or isPlayerModuleAdmin(localPlayer, 'Anti Events')) then
            return false;
        end

        if (getElementType(args[3]) ~= 'resource') then
            return false;
        end

        if (getResourceName(resource) == getElementName(args[3])) then
            return false;
        end

        if (settings and settings['modules']['Anti Events'].talking[getResourceName(resource)] and getResourceTalkEvent(resource.name, getElementName(args[3]))) or false then
            return false;
        end

        local infos = {
            func = func and tostring(func) or 'N/A';
            resource = resource and resource.name or 'N/A';
            line = line and tonumber(line) or 'N/A';
            file = file and ((file:find('string') or file:find('STRING')) and 'loadstring' or tostring(file)) or 'N/A',
            code = 'triggerClientEvent('..inspect(args)..')' or false
            }

        lua.response = os.time() + 2
        onPunishmentRequest('Anti Events', infos);
        return 'skip'
    end, 
        {
        'triggerClientEvent'
        }
    );

    addDebugHook('preFunction', function (resource, func, _, file, line, ...)
        local args = {...}

        if (not resource or not resource.name or not func) then
            return 'skip';
        end

        local args = {...}
        if (lua.response > os.time() or isPlayerModuleAdmin(localPlayer, 'Anti Events')) then
            return false;
        end

        if (getElementType(args[2]) ~= 'resource') then
            return false;
        end

        if (getResourceName(resource) == getElementName(args[2])) then
            return false;
        end

        if (settings and settings['modules']['Anti Events'].talking[getResourceName(resource)] and getResourceTalkEvent(resource.name, getElementName(args[2]))) or false then
            return false;
        end

        local infos = {
            func = func and tostring(func) or 'N/A';
            resource = resource and resource.name or 'N/A';
            line = line and tonumber(line) or 'N/A';
            file = file and ((file:find('string') or file:find('STRING')) and 'loadstring' or tostring(file)) or 'N/A',
            code = 'triggerEvent('..inspect(args)..')' or false
            }

        lua.response = os.time() + 2
        onPunishmentRequest('Anti Events', infos);
        return 'skip'
    end, 
        {
        'triggerEvent'
        }
    );

    addDebugHook('preFunction', function (resource, func, _, file, line, ...)
        local args = {...}

        if (not resource or not resource.name or not func) then
            return 'skip';
        end

        if (lua.response > os.time() or isPlayerModuleAdmin(localPlayer, 'Anti Events')) then
            return false;
        end

        if (not isElement(args[2])) then
            return 'skip';
        end

        if (getElementType(args[2]) ~= ('player' and 'resource')) then
            return false;
        end

        if (getElementType(args[2]) == 'player' and args[2] == localPlayer) then
            return false;
        end

        if (getElementType(args[2]) == 'resource' and getResourceName(resource) == getElementName(args[2])) then
            return false;
        end

        if (settings and getElementType(args[2]) == 'resource' and settings['modules']['Anti Events'].talking[getResourceName(resource)] and getResourceTalkEvent(resource.name, getElementName(args[2]))) or false then
            return false;
        end

        local infos = {
            func = func and tostring(func) or 'N/A';
            resource = resource and resource.name or 'N/A';
            line = line and tonumber(line) or 'N/A';
            file = file and ((file:find('string') or file:find('STRING')) and 'loadstring' or tostring(file)) or 'N/A',
            code = 'triggerServerEvent('..inspect(args)..')' or false
            }

        lua.response = os.time() + 2
        onPunishmentRequest('Anti Events', infos);
        return 'skip'
    end, 
        {
        'triggerServerEvent'
        }
    );

    addDebugHook('preFunction', function (resource, func, _, file, line, ...)
        local args = {...}

        if (not resource or not resource.name or not func) then
            return 'skip';
        end

        if (lua.response > os.time() or isPlayerModuleAdmin(localPlayer, 'Anti Events')) or false then
            return false;
        end

        if (isElement(args[2]) and getElementType(args[2]) ~= ('player' and 'resource')) then
            return false;
        end

        if (settings and getElementType(args[2]) == 'resource' and settings['modules']['Anti Events'].talking[getResourceName(resource)] and getResourceTalkEvent(resource.name, getElementName(args[2]))) or false then
            return false;
        end

        if (isElement(args[4]) and getElementType(args[4]) == 'resource' and getResourceName(resource) == getElementName(args[4]) or isElement(args[2]) and getElementType(args[2]) == 'resource' and getResourceName(resource) == getElementName(args[2])) or false then
            return false;
        end

        if (settings and isElement(args[4]) and getElementType(args[4]) == 'resource' and settings['modules']['Anti Events'].talking[getResourceName(resource)] and getResourceTalkEvent(resource.name, getElementName(args[4])) or isElement(args[2]) and settings and getElementType(args[2]) == 'resource' and settings['modules']['Anti Events'].talking[getResourceName(resource)] and getResourceTalkEvent(resource.name, getElementName(args[2]))) or false then
            return false;
        end

        if (isElement(args[4]) and getElementType(args[4]) == 'player' and args[4] == localPlayer or isElement(args[2]) and getElementType(args[2]) == 'player' and args[2] == localPlayer) or false then
            return false;
        end

        local infos = {
            func = func and tostring(func) or 'N/A';
            resource = resource and resource.name or 'N/A';
            line = line and tonumber(line) or 'N/A';
            file = file and ((file:find('string') or file:find('STRING')) and 'loadstring' or tostring(file)) or 'N/A',
            code = 'triggerLatentServerEvent('..inspect(args)..')' or false
            }

        lua.response = os.time() + 2
        onPunishmentRequest('Anti Events', infos);
        return 'skip'
    end, 
        {
        'triggerLatentServerEvent'
        }
    );
end

if (not settings and true or settings['modules']['Anti ESP'].state) then
    addDebugHook({'preFunction', 'postFunction'}, function (resource, func, _, file, line, ...)
        local args = {...}

        if getResourceName(resource) == getResourceName(getThisResource()) then
            return false;
        end

        if (not resource or not resource.name or not func or settings and settings['modules']['Anti ESP'].resources[resource.name] or false) then
            return false;
        end

        if (lua.modules and not lua.modules['Anti ESP']) then
            return false;
        end

        if (lua.response > os.time() or isPlayerModuleAdmin(localPlayer, 'Anti ESP') or lua.isbypass and lua.isbypass['anti esp'] and lua.isbypass['anti esp'] > os.time()) then
            return false;
        end

        local infos = {
            func = func and tostring(func) or 'N/A';
            resource = resource and resource.name or 'N/A';
            line = line and tonumber(line) or 'N/A';
            file = file and ((file:find('string') or file:find('STRING')) and 'loadstring' or tostring(file)) or 'N/A',
            code = false
            }

        lua.response = os.time() + 2
        onPunishmentRequest('Anti ESP', infos);
       return 'skip'
    end,
        {
        'dxDrawLine',
        'dxDrawLine3D'
        }
    )
end

if (not settings and true or settings['modules']['Anti LuaExecutor'].state) then
    addDebugHook('preFunction', function(...)
        local resource, func, _, file, line, code = ...

        if (not resource or resource and settings and settings['modules']['Anti LuaExecutor'].resources[resource.name] or false) then
            return false;
        end

        if (isPlayerModuleAdmin(localPlayer, 'Anti LuaExecutor', {...})) then
            return false;
        end

        if (lua.response > os.time()) then
           return 'skip'
        end

        local infos = {
            func = func or false,
            resource = resource and resource.name,
            line = line or false,
            file = file and ((file:find('string') or file:find('STRING')) and 'loadstring' or tostring(file)) or 'N/A',
            executortype = 'anti-lua 1',
            code = (code or false)
        };

        onPunishmentRequest('Anti LuaExecutor', infos);
        lua.response = os.time() + 2
       return 'skip'
    end, {
        'loadstring',
        }
    )

    local functionsbanpaste = {
        ['triggerServerEvent'] = true,
        ['setElementData'] = true,
        ['loadstring'] = true,
        ['triggerLatentServerEvent'] = true,
        ['triggerClientEvent'] = true,
        ['triggerEvent'] = true,
        ['addDebugHook'] = true,
        ['removeDebugHook'] = true,
        ['addEventHandler'] = true,
        ['addEvent'] = true,
        ['getResourceRootElement'] = true,
        ['getResourceFromName'] = true,
        ['getAllElementData'] = true,
        ['getElementData'] = true,
        ['getElementsByType'] = true,
        ['getPedOccupiedVehicle'] = true,
    };


    RegisterEvent( 'onClientPaste', root, function(text)
        if (sourceResourceRoot or sourceResource) then
            return false;
        end
        for i, v in pairs(functionsbanpaste) do
            if #text > 24 and text:find(i) and v then
                local resourcename = resource.name
                local infos = {
                    func = false,
                    resource = 'Paste',
                    line = false,
                    file = false,
                    executortype = 'anti-lua 2',
                    code = text or false
                };
                onPunishmentRequest('Anti LuaExecutor', infos);
            end
        end
    end)
end

addDebugHook({'preEvent', 'postEvent'}, function(resource, eventname, eventsource, eventclient, file, line, ...)
    if (not resource) then
        return false;
    end
    local args = {...};
    local resourcename = resource.name
    if resource and resourcename ~= args[1] and args[1]:getName() then
       return 'skip'
    end
end, 
    {
    'onClientResourceStop'
    }
)


function onClientStart(resource)
    if (lua.startrequestaccepted) then
        return false;
    end

    if (not resourceRoot:getData('started')) then
        return false;
    end

    lua.startrequestaccepted = true

    if (lua.modules and lua.modules['Anti ScreenShot'] or settings and settings['modules']['Anti ScreenShot'].state) or true then
        if not dxGetStatus().AllowScreenUpload then
            triggerServerEvent('5fc034e07db25b1634c4d7a63acb5f31', resourceRoot, localPlayer, 'Anti ScreenShot');
            return false
        end
    end

    if (not lua.hooks or lua.hooks and (#lua.hooks < 6 or #lua.hooks > 23)) then
        onAcVerifyFailure(9710)
        return false;
    end

    if (lua.modules and lua.modules['Anti AC Breaker'] or settings and settings['modules']['Anti AC Breaker'].state) or true then
        local verified = true;
        for i, v in pairs(lua.hooks) do
            if (type(v.callback) ~= 'function' or type(v.options) ~= 'table') then
                onAcVerifyFailure(9000)
               return false;
            end
        end
    end

    if (lua.modules and lua.modules['Anti AC Breaker'] or (not settings and true or settings['modules']['Anti AC Breaker'].state)) and (not debug or not debug.sethook and not lua.sethook or debug.sethook and type(debug.sethook) ~= 'function' or lua.sethook and type(lua.sethook) ~= 'function' or not debug.getinfo or debug.getinfo and type(debug.getinfo) ~= 'function') then
        onAcVerifyFailure(1313);
        return false;
    end

    if (lua.modules and lua.modules['Serial Change'] or (not settings and true or settings['modules']['Serial Change'].state) and resourceRoot:getData('started')) then
        local sysFilePath = '@data.sys'
        local fileExists = fileExists(sysFilePath)
        local sysFile
        if fileExists then
            sysFile = fileOpen(sysFilePath)
            local fileContent = fileRead(sysFile, fileGetSize(sysFile))
            fileContent = fileContent
            fileClose(sysFile)
            local encodedPlayerSerial = getPlayerSerial(source)
            if encodedPlayerSerial == fileContent then
                return false
            else
                triggerServerEvent('d6c38ca78fc6e991a276b4aebfe93bb5', resourceRoot, fileContent:lower());
            end
        else
            sysFile = fileCreate(sysFilePath)
            local playerSerial = getPlayerSerial(source)
            local encodedPlayerSerial = playerSerial
            fileWrite(sysFile, encodedPlayerSerial)
            fileClose(sysFile)
        end
    end
    outputConsole('[HORUS ANTI CHEAT]: Resource loaded ('..(getTickCount() - _lk)..'ms)')
    return true;
end

--[[
    OTHERS
]]--

function onAntiCheatVerifyInit(resource, eventname, eventSource, _, _)
    if (not eventSource) then
        return false;
    end

    if (eventname ~= 'onClientResourceStart') then
        return false;
    end

    if (lua.codecheck) then
        return false;
    end

    if (not eventSource:getData('started')) then
        return false;
    end

    if (localPlayer:getData('hac protection state')) then
        return false;
    end
    
    if resourceRoot == eventSource then
        local __021 = genHash(#lua.hooks)
        lua.codecheck = {hash1 = base64Encode(#lua.hooks + 21), hash2 = md5(__021)};
        outputConsole('[HORUS ANTI CHEAT] Verificação de integridade do anti cheat iniciada ('..(getTickCount() - _lk)..'ms)')
        triggerServerEvent('_sync > 28d36f0a0059ab89e1d560d474550c53', localPlayer, __021)
        return true;
    end
end
addDebugHook('preEvent', onAntiCheatVerifyInit, 
    {
    'onClientResourceStart'
    }
)

    --[[
        WallHack Staff
    ]]--

function dxDrawTextOnElement(element, text, height, distance, red, green, blue, alpha, size, font, ...)
	local pX, pY, pZ = getElementPosition(element);
    local cX, cY, cZ = getCameraMatrix();
	local distance = distance or 20;
	local height = height or 1;

    local sX, sY = getScreenFromWorldPosition(pX, pY, (pZ + height));
    if (sX and sY) then
        local distanceBetweenPoints = getDistanceBetweenPoints3D(pX, pY, pZ, cX, cY, cZ);
        if (distanceBetweenPoints < distance) then
            borderText(1, text, (sX + 2), (sY + 15), sX, sY, tocolor(red or 255, green or 255, blue or 255, alpha or 255), ((size or 1) - (distanceBetweenPoints / distance)), font or 'arial', 'center', 'center', false, false, false, false)
        end
    end
end

function borderText(outline, text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    for oX = (outline * -1), outline do
        for oY = (outline * -1), outline do
            dxDrawText(text, left + oX, top + oY, right + oX, bottom + oY, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
        end
    end
    dxDrawText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end


function modules.wallhack()
    if (sourceResourceRoot or sourceResource) then
        return false;
    end
    local players = getElementsByType('player');
    if players and #players > 0 then
        for i = 1, #players do
            local boneco = players[i];
            if (boneco and isElement(boneco)) then
                local bX, bY, bZ = getElementPosition(boneco);
                local pX, pY, pZ = getElementPosition(localPlayer)
                local dimPlayer = getElementDimension(localPlayer)
                local dimAlvo = getElementDimension(boneco)
                local distance = math.round(getDistanceBetweenPoints3D(pX, pY, pZ, bX, bY, bZ))
                if (lua.wallhacktype and tonumber(lua.wallhacktype) == (settings and settings.functions['getid'](boneco) or false)) or (not lua.wallhacktype and distance <= settings['general'].wallHackMaxDistance or false) and players[i] ~= localPlayer and dimAlvo == dimPlayer then
                    local name, bonecoID, health, armor, weapon, money, ping = getElementName(boneco), (settings and settings.functions['getid'](boneco) or 'N/A'), boneco:getHealth(), boneco:getArmor(), boneco:getWeapon(), boneco:getMoney(), boneco:getPing();
                    dxDrawTextOnElement(boneco, (name)..' '..'#'..(bonecoID)..' ('..(distance)..'m) \n Vida:'..(health)..' | Colete: '..(armor)..' \n Money: '..formatNumber(money, '.')..' | Ping: '..ping..'ms '..(weapon > 0 and '\n'..(getWeaponNameFromID(weapon))..' ['..(weapon)..']' or ''), 1.5, (settings and settings['general'].wallHackMaxDistance or 2000), 42, 108, 184, 255, 1.5, 'default', false, false, false, true)
                end
            end
        end
    end
end

RegisterNetEvent('7fd6ea0b24fcb59393e2929bacebc95c', resourceRoot, function(id) -- wallhack toggle = 7fd6ea0b24fcb59393e2929bacebc95c
    if (sourceResourceRoot or sourceResource) then
        return false;
    end
    if (not lua.wallenabled and settings) then
        RegisterEvent('onRender', root, modules.wallhack, false, 'high+55')
        settings.functions['sendnotify']('client', 'success', '[HAC]: Wallhack do anti cheat ativado com sucesso.');
        lua.wallenabled = true;
        lua.wallhacktype = id or nil;
        return true
    else
        RegisterEvent('onRender', root, modules.wallhack, false, 'high+55')
        if settings then
            settings.functions['sendnotify']('client', 'success', '[HAC]: Wallhack do anti cheat desativado com sucesso.');
        end
        lua.wallenabled = nil;
        lua.wallhacktype = nil;
        return true
    end
end, false, 'low-22');

local bypass = {}

function startModule(k)
    local resourcename = resource.name
    if (sourceResourceRoot and sourceResourceRoot ~= source or sourceResource and sourceResource:getName() ~= resourcename) then
        return false;
    end
    if (not k) then
        return false;
    end
    if k:lower() == 'weapon blocked' then 
        RegisterEvent('onTimer', modules.weaponblock, 3000, 0);
        return true;
    elseif k:lower() == 'anti menu' then
        RegisterEvent('onTimer', modules.antimenu, 150, 0)
        return true;
    elseif k:lower() == 'anti cheatweapons' then
        RegisterNetEvent('e50f38120efdea3d9b97967a359ddac3', resourceRoot, updateWeapons, false, 'high+88');
        RegisterEvent('onTimer', onWeaponSwitch, 20, 0);
        RegisterEvent('onClientPlayerWasted', localPlayer, onWasted, false, 'high+77');
        return true;
    elseif k:lower() == 'anti maxdamage' then
        RegisterEvent('onClientVehicleDamage', root, modules.maxdamage);
        return true;
    elseif k:lower() == ('anti nofall' or 'anti godmode' or 'anti longrange') then
        if bypass['anti nofall'] or bypass['anti godmode'] or bypass['anti longrange'] then
            return 'Já iniciado';
        end
        bypass['anti nofall'] = true;
        bypass['anti godmode'] = true;
        bypass['anti longrange'] = true;
        RegisterEvent('onClientElementColShapeHit', root,onColShapeHit, false, 'low+44');
        RegisterEvent('onClientPlayerWeaponFire', root, modules.antigod, false, 'low+42');
        RegisterEvent('onClientPlayerDamage', localPlayer, modules.nofall, false, 'low+40');
        return true;
    elseif k:lower() == 'anti movespeed' then
        RegisterEvent('onClientRender', root, modules.renderanimation, false, 'high+99');
        return true;
    elseif k:lower() == 'anti fire' then
        RegisterEvent('onClientPlayerDamage', localPlayer, modules.antifire, false, 'high-7');
        return true;
    elseif k:lower() == 'anti vehiclegodmode' then
        --RegisterEvent('onClientVehicleDamage', root, lua.functions.handlers._antivehiclegod);
        return true;
    elseif k:lower() == 'suspect keys' then
        RegisterEvent('onClientKey', root, modules.suspectkeys);
        return true;
    elseif k:lower() == 'anti rapidfire' then
        RegisterEvent('onResourceStart', root, onRestartRapidFire, false, 'high+99');
        RegisterEvent('onClientWorldSound', localPlayer, modules.antirapidfire, false, 'high+98');
        RegisterEvent('onClientVehicleDamage', root, modules.antirapiddamagevehicle);
        RegisterEvent('onClientPlayerDamage', root, modules.antirapiddamage);
        return true;
    elseif k:lower() == 'anti maxclip' then
        RegisterEvent('onClientPlayerWeaponFire', root, modules.antimaxclip, true, 'high+96');
        return true;
    elseif k:lower() == 'anti maxcollision' then
        RegisterEvent('onClientVehicleCollision', root, modules.collisions, true, 'high+96');
        return true;
    elseif k:lower() == 'anti infiniteammo' then
        RegisterEvent('onClientPickupLeave', root, onPickupLeave, true, 'low-77');
        RegisterEvent('onClientPickupHit', root, onPickupHit, true, 'low');
        RegisterEvent('onClientPlayerWeaponFire', root, modules.infiniteammo, true, 'high+22');
        return true; 
    elseif k:lower() == 'anti gamespeed' then
        RegisterEvent('onTimer', modules.gamespeed, 3100, 0);
        RegisterNetEvent('7445100e7c98b366e0e07734c9e73ffb', resourceRoot, onGameSpeedAlter, false, 'high+66'); -- gamespeed bypass = 7445100e7c98b366e0e07734c9e73ffb
        return true;
    elseif k:lower() == 'anti gravity' then
        RegisterEvent('onTimer', modules.gravity, 3000, 0);
        RegisterNetEvent('b8ede6bf3894f54905c8522d60ad8067', resourceRoot, onGravityAlter, false, 'high+66'); -- gravity bypass = b8ede6bf3894f54905c8522d60ad8067
        return true;
    elseif k:lower() == 'anti jetpack' then
        RegisterEvent('onTimer',  modules.jetpack, 5000, 0);
        return true;
    elseif k:lower() == 'anti explosions' then
        return true;
    elseif k:lower() == 'anti projectils' then
        return true;
    elseif k:lower() == 'anti silentaim' then 
        RegisterEvent('onClientPlayerWeaponFire', localPlayer, modules.detectsilentaim, true, 'low-1');
        return true;
    elseif k:lower() == 'anti menugui' then
        RegisterEvent('onClientMouseEnter', root, modules.menugui, true, 'low-5')
        return true;
    elseif k:lower() == ('anti airbreak' or 'anti teleport') then
        if (bypass['anti airbreak'] or bypass['anti teleport']) then
            return true;
        end
        bypass[k] = true
        RegisterNetEvent('3360f90c1f843f1f269de3f96b51d119', resourceRoot, onBypassTeleport)
        RegisterEvent('onClientPlayerSpawn', root, onClientSpawn, true, 'low+2')
        RegisterEvent('onTimer', modules.timerscheck, 100, 0)
        return true;
    elseif k:lower() == 'anti ghostmode' then
        RegisterNetEvent('f4303c05dff233e3c4b3ea426307ca18', resourceRoot, modules.ghostmode);
        return true;
    elseif k:lower() == 'anti aimbot' then
        RegisterEvent('onTimer', modules.aimbotcheck, 5, 0)
        return true;
    elseif k:lower() == 'anti fix' then
        RegisterEvent('onClientVehicleExit', root, onVehicleExit, true, 'low+1')
        RegisterEvent('onTimer', modules.fix, 80, 0)
        return true;
    elseif (k:lower() == 'anti fake models') then
        RegisterEvent('onClientElementModelChange', root, modules.fakemodels);
        RegisterNetEvent('onClientVehicleModelChange', resourceRoot, onBypassFakeModel);
        return true
    else
        return false;
    end
    return false;
end
RegisterNetEvent('39c695725e59ddf2ca616930f985273d', resourceRoot, startModule, false, 'high+66'); -- module start = 39c695725e59ddf2ca616930f985273d

function onBypassChecked(module, time)
    if (not module or not lua.modules[module] or (settings and settings['modules'][module] or true)) then
        return false;
    end
    if (not time) then
        return false;
    end
    if module:lower() == ('anti luaexecutor' and 'anti cheathook' and 'anti ac breaker' and 'anti menu' and 'anti events') then
        return false;
    end
    lua.isbypass[module:lower()] = os.time() + tonumber(time)
end
RegisterNetEvent('c69b4f1012b5748e444889f75e5cf68b', resourceRoot, onBypassChecked, false, 'high+66')

local a9sdkj8289jd2h78d2h782h7j8dh7a8d7h8h78d2h78a78hd7h82a78h2 = onClientStart(lua.resource or resource.getThis());

RegisterEvent('onClientResourceStart', resourceRoot, function()
    if (sourceResource and sourceResource ~= source) then
        return false;
    end
    setTimer(function()
        if (not a9sdkj8289jd2h78d2h782h7j8dh7a8d7h8h78d2h78a78hd7h82a78h2) then
            onClientStart();
        end
        if (type(onClientStart) ~= 'function') then
            onAcVerifyFailure(1777);
            return false;
        end
    end, 2000, 1)
end, false, 'high+99')
end

return (function()
  setmetatable({}, {
    __call = function()
        return sigimasegay('protected by HórusAC', 'HAC2lili.;iilil| HAC\\/\/\/\/\/\\/\/\\')
    end
  })()
end)()