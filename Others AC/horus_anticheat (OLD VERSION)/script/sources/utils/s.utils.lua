local function startsutils()

    settings = getSettings()
    Async:setPriority('high'); 
    for i, v in pairs(getServerSettings()) do
        if i == 'MySQL' or i == 'webhook´s' or i == 'serialbypass' or (i == 'database')then
            settings[i] = v
        end
    end

    local modulesindex = 0

    for i, v in pairs(settings['modules']) do
        modulesindex = modulesindex + 1
    end

    func = {}
    local thisresource = getThisResource() or false;

    waits = {
        antinoscreen = 5000,
        vehiclepull = 800,
        antighostmode = 2000,
        acbreaker = 1000
    }

    lua = {
        countrysip = {};
        isloadingscreenshotapi = {};
        modules_index = modulesindex,
        connection = false;
        whitelists = { };
        resourcesindex = 0;
        antireconnect = { };
        resourcesrow = { };
        modules = { };
        banslist = { };
        redirectpunishment = { };
        elementfucker = { };
        vehiclesList = { };
        rainVehicles = { };
        inspectSender = { };
        collisionFuckers = { };
        integrityfail = { };
        players = { };
        teleportbypass = { };
        fixedbypass = { };
        players_weapons = { };
        players_weapons_delay = { };
        screenshotverify = {};
        rate_limit = {
            ['elementdatachange'] = { };
        };
    };

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

    function RegisterEvent(k, ...)
        if (k == 'onTimer') then
            return setTimer(...);
        end

        if (k == 'onCommand') then
            return addCommandHandler(...);
        end
        
        return addEventHandler(k, ...)
    end

    function RegisterNetEvent(eventname, ...)
        addEvent((thisresource.name)..' > '..eventname, true)
        addEventHandler((thisresource.name)..' > '..eventname, ...);
        return true;
    end

    function getActionByIndex(index)
        if (index > modulesindex) then
            return false;
        end

        local contagem = 0
        for i, v in pairs(settings['modules']) do
            contagem = contagem + 1
            if contagem == index then
                return i
            end
        end
        return false;
    end

    function isElementModuleBypass(element, module)
        if element and isElement(element) and module and settings['modules'][module] and settings['modules'][module].bypass and type(settings['modules'][module].bypass) == 'function' then
            local yes = settings['modules'][module].bypass(element) or false;
            return yes
        end
        return false;
    end

    function isCountryAllow(country)
        if (not country) then
            return false;
        end
        if settings['modules']['WhiteListed Countrys'].whitelist[country] then
            return true;
        end
        return false;
    end

    function getPlayerBySerial( serial )
        if (not type(serial) == 'string' or not #serial == 32) then
            return false;
        end
        for index, player in ipairs ( getElementsByType ( "player" ) ) do
            if ((getPlayerSerial(player)) == serial ) then
                return player
            end
        end
        return false
    end

    function startHook(hookType, callback, options)
        if type(hookType) == 'table' then
            for i, hook in ipairs(hookType) do
                if (not addDebugHook(hook, callback, options)) then
                    outputDebugString('['..(thisresource.name)..']: '..string.change(getSystemLanguage('not registred event'), {eventname = 'hooked'})..' CODIGO ERROR: x'..(not _hooked and '0032931'), 4, 255, 0, 0)
                    stopResource(getThisResource())
                    return false;
                end
            end
            return true;
        else
            if (not addDebugHook(hookType, callback, options)) then
                outputDebugString('['..(thisresource.name)..']: '..string.change(getSystemLanguage('not registred event'), {eventname = 'hooked'})..' CODIGO ERROR: x'..(not _hooked and '0032931'), 4, 255, 0, 0)
                stopResource(getThisResource())
                return false;
            end
            return true; -- tratando os hooks(permitir apenas uma certa linha!)
        end
        return false;
    end

    function getSystemLanguage(k)
        if (not settings.general.language.use or not k or not settings.general.language[(settings.general.language.use or 'english')][k]) then
            return 'Sem mensagem configurada';
        end
        return settings.general.language[(settings.general.language.use or 'english')][k];
    end

    function string.change (s, t)
        if not s or type (s) ~= 'string' then
            return error ('O modulo '..t.reason..' não existe no arquivo de configuração!');
        end
        for w in s:gmatch ('${(%w+)}') do
            s = s:gsub ('${'..w..'}', tostring ((t and t[w]) or 'undefined'));
        end
        return s;
    end

    function formatNumber(number)   
        local formatted = number   
        while true do       
            formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')     
            if ( k==0 ) then       
                break   
            end   
        end   
        return formatted 
    end 

    function isElementOnGroup(element, acl)
        local isvalidelement, isplayervalid, isgroupvalid = isElement(element), isValidPlayer(element), aclGetGroup(acl)

        if (not isvalidelement or not isplayervalid) then
            return false;
        end

        if (not settings.functions['getaccount'] or type(settings.functions['getaccount']) ~= 'function') then
            return false;
        end

        local account = settings.functions['getaccount'](element) or false;

        if (not account or account == 'guest') then
            return false;
        end

        if (not isgroupvalid) then
            return false;
        end

        return isObjectInACLGroup('user.' .. settings.functions['getaccount'](element), isgroupvalid)
    end

    local removeHex = function (message)
        if (type(message) == "string") then
            while (message ~= message:gsub("#%x%x%x%x%x%x", "")) do
                message = message:gsub("#%x%x%x%x%x%x", "")
            end
        end
        return message or false
    end

    function isPlayerVehicleSyncer(player, posX, posY, posZ)
        local minDistance = math.huge
        for _, vehicle in ipairs(getElementsWithinRange(posX, posY, posZ, '30', 'vehicle')) do
            if (getElementSyncer(vehicle) == player) then
                return true;
            end
        end
        return false;
    end

    function getVehicleInRange(posX, posY, posZ)
        for _, vehicle in ipairs(getElementsWithinRange(posX, posY, posZ, '40', 'vehicle')) do
            return vehicle
        end
        return false;
    end

    function isVehicleOnExplosion(posX, posY, posZ, _type, range)
        for _, vehicle in ipairs(getElementsWithinRange(posX, posY, posZ, range, 'vehicle')) do
            if vehicle and settings['modules']['Anti Explosions'].vehicles[getElementModel(vehicle)] and settings['modules']['Anti Explosions'].vehicles[getElementModel(vehicle)][_type] then
                return true;
            end
        end
        return false;
    end

    function isPlayerWithWeapon(player, _type)
        if (not player) then
            return false;
        end
        local isvalidelement, isplayervalid = isElement(player), isValidPlayer(player);

        if (not isvalidelement or not isplayervalid) then
            return false;
        end

        for i = 1, 12 do
            if (settings['modules']['Anti Projectils'].weapons[_type] and settings['modules']['Anti Projectils'].weapons[_type][getPedWeapon(player, i)] or settings['modules']['Anti Explosions'].weapons[_type] and settings['modules']['Anti Explosions'].weapons[_type][getPedWeapon(player, i)]) then
                return true;
            end
        end
        return false
    end

    function isValidPlayer(element)
        if (not element) then
            return false;
        end

        if (isElement(element) and getElementType(element) == 'player') then
            return true;
        end
        return false;
    end

    function getElementName(element)
        if not element or not isElement(element) then 
            return 'N/A';
        end

        if getElementType(element) == 'player' then
            return getPlayerName(element):gsub("#%x%x%x%x%x%x", "") or getPlayerName(element);
        end

        if getElementType(element) == 'resource' then
            return getResourceFromName(getElementID(element)) and getElementID(element) or getResourceName(element);
        end

        return 'N/A';
    end

    function removeAnti(str)
        return string.gsub(str, "Anti%s*", "")
    end

        --[[
            FUNçÔES ÚTEIS
        ]]--
        
    function AnnounceBan(element, typeBan)
        if (not settings['general'].globalnotify) then
            return false;
        end

        if not element or not isValidPlayer(element) then
            return false;
        end

        if not typeBan or not settings['modules'][typeBan] then
            return false;
        end

        if not typeBan == 'Anti AC Breaker' and settings['modules'][typeBan].action:lower() ~= 'ban' then
            return false;
        end

        local color = settings['general'].colors or '#ffff00'
        outputChatBox(' ', root, 255, 255, 255);
        outputChatBox(color .. '[HÓRUS ANTI CHEAT] #ffffffO jogador '..getElementName(element).. ' [' .. settings.functions['getid'](element) .. '] foi banido permanentemente do servidor por utilizar #FF0000' .. removeAnti(tostring(typeBan)), root, 255, 255, 255, true)
        outputChatBox(' ', root, 255, 255, 255);
    end

    function sendWarning(element, typeBan)
        if (not settings['general'].globalnotify) then
            return false;
        end

        if not element or not isValidPlayer(element) then
            return false;
        end

        if not typeBan or not settings['modules'][typeBan] then
            return false;
        end

        local action = settings['modules'][typeBan].action:lower()

        if (not action == 'warning' or not action == 'kick') then
            return false;
        end

        for i, v in ipairs(getElementsByType('player')) do 
            if isPlayerNotifiable(v) then
                local color = settings['general'].colors or '#ffff00'
                outputChatBox(' ', v, 255, 255, 255);
                outputChatBox(color..'↪ [HÓRUS ANTI CHEAT] #ffffffO jogador '..getElementName(element)..' ['..settings.functions['getid'](element)..'] '..(action == 'warning' and 'Está com suspeita de usar' or action == 'kick' and 'Foi kickado por usar')..' #FF0000'..removeAnti(tostring(typeBan)), v, 255, 255, 255, true);
                outputChatBox(' ', v, 255, 255, 255);
            end
        end
    end

    function getPlayerFromID(id)
        local idp = tonumber(id)
        if idp then
            for i, v in ipairs(getElementsByType('player')) do
                if settings.functions['getaccount'] ~= 'guest' and settings.functions['getid'](v) == idp then
                    return v
                end
            end
            return false
        end
        return false
    end

    function isPlayerAdmin(player)
        if not isElement(player) then
            return false;
        end

        if (settings['general'].commands and type(settings['general'].commands) == 'function') then
            return settings['general'].commands(player) or false;
        end

        return false
    end

    function isPermissionToCompile(player)
        if not isElement(player) then
            return false;
        end

        if (settings['general'].compiler and type(settings['general'].compiler) == 'function') then
            return settings['general'].compiler(player) or false;
        end

        return false
    end

    function isPlayerModuleBypass(player, reason)
        if not isValidPlayer(player) then
            return false;
        end

        if (not settings['modules'][reason].bypass or type(settings['modules'][reason].bypass) ~= 'function') then
            return false;
        end

        local yes = settings['modules'][reason].bypass(player) or false;

        return yes
    end

    function isPlayerNotifiable(player)
        if not isValidPlayer(player) then
            return false;
        end

        if settings['general'].notify and type(settings['general'].notify) == 'function' then
            return settings['general'].notify(player) or false;
        end
        
        return false
    end

        
    function getPlayerBanBySerial(serial)
        if serial then
            for i, ban in ipairs(lua.banslist) do
                if ban.userSerial == serial then
                    return ban, i
                end
            end
            return false
        end
        return false
    end

    function getPlayerBanByDiscordID(DiscordID)
        if DiscordID then
            for i, ban in ipairs(lua.banslist) do
                if ban.userDiscordID == DiscordID then
                    return ban, i
                end
            end
            return false
        end
        return false
    end

    function getPlayerBanByAccount(conta)
        if conta then
            for i, ban in ipairs(lua.banslist) do
                if ban.userAccount == conta then
                    return ban, i
                end
            end
            return false
        end
        return false
    end

    function getPlayerBanByID(id)
        if id then
            for i, ban in ipairs(lua.banslist) do
                if ban.userID == id then
                    return ban, i
                end
            end
            return false
        end
        return false
    end

    function getPlayerBanByIP(ip)
        if ip then
            for i, ban in ipairs(lua.banslist) do
                if ban.userIP == ip then
                    return ban, i
                end
            end
            return false
        end
        return false
    end

    function getPlayersBannedByReason(reason)
        if reason then
            local bans = {};
            for i, ban in ipairs(lua.banslist) do
                if ban.userReasonBanned == reason then
                    local banredirect = ban
                    banredirect.index = i;
                    table.insert(bans, banredirect);
                end
            end
            return bans
        end
        return false
    end

    function unbanPlayerACBySerial(serial)
        local vban, itban = getPlayerBanBySerial(serial);
            if itban and vban then
                for i, v in ipairs(getBans()) do 
                    if getBanSerial(v) == serial then
                        removeBan(v);
                    end
                end
            table.remove(lua.banslist, itban);
            if (#dbPoll(dbQuery(lua.connection, 'SELECT * FROM banList WHERE userSerial = ?', vban.userSerial), - 1) ~= 0) then
                dbExec(lua.connection, 'DELETE FROM banList WHERE userSerial = ?', vban.userSerial)
                return true;
            end
            return true;
        end
        return false
    end

    function unbanPlayerACByID(id)
        local vban, itban = getPlayerBanByID(id);
            if (itban and vban) then
                for i, v in ipairs(getBans()) do 
                    if getBanSerial(v) == vban.userSerial then
                        removeBan(v);
                    end
                end
            table.remove(lua.banslist, itban);
            if (#dbPoll(dbQuery(lua.connection, 'SELECT * FROM banList WHERE userID = ?', vban.userID), - 1) ~= 0) then
                dbExec(lua.connection, 'DELETE FROM banList WHERE userID = ?', vban.userID)
                return true
            end
            return true;
        end
        return false
    end

    function math.round(number, decimals, method)
        decimals = decimals or 0;
        local factor = 10 ^ decimals;
        if (method == 'ceil' or method == 'floor') then return math[method](number * factor) / factor;
        else return tonumber(('%.'..decimals..'f'):format(number)); end
    end

    function compileLoadFile(path)
        local File = fileOpen(path, true)
        if File then
            local data = [[
                local function loadhook()
                    ]] .. fileRead(File, 500000000) .. [[
                end
                return (function()
                    return loadhook("protection by discord.gg/horusac", "aHR0cHM6Ly95b3V0dS5iZS9POF8xdVBUVFpHSQ==", {
                        "GteZDOFzI067",
                        "GRyj",
                        "iWj+s5iotMz6eEtc",
                        "kWjKsMXf",
                        "e7uB9TgGfL==",
                        "YL==",
                        "3to7Eq0Jgv+pEAz7WhQsWL==",
                        "kEzKsM79kZtdeCqdeEQ=",
                        "PrqnH9znL4joPMA9hv==",
                        "zoXIiE9FHJzPH9sizv==",
                        "SgXfRFGdcYoeVWC3XdcBDhB=",
                        "QOSQqPH=",
                        "eDU7MpPnW9UQg+hAVS0E5Z5IbxAF",
                        "5B==",
                        "/kHCDg+gDr79SwP+ZZhVVkIbfXzG+JgFi0/yaDJULb+jnjlJQ0Pl4YPrxNksSK0TSoZtNZt3sy9vQzpP9tcvS7V7HRMIkHIG6AdTZObG2H3+O8Ftc6qe7RLYhJJnsAwQApQdrZo1mtaacxGrj8CQW/M7wa/wgBuskaAbgmpBkMkMeur6XPWjs5g0hWqe6IaFycoG1hTVQo7wfQCU+plHQakf9zQU1jjb",
                        "X5hNhpYoSkEe",
                        "i1zjk1sNz6qhzEsDzv==",
                        "7ZBZkCtmtjzRs4fS",
                        "ury67QOs",
                        "Ooqqw4/4jAW3aV==",
                        "vaMRrL==",
                        "cn4+pG9aVwbB",
                        "e9g375vVkM8si57+kL==",
                        "U9fadvYWwew9pMyZ0n/qqEL=",
                        "gQ7GxW8n",
                        "iW3qiEfQY17o",
                        "wBefWJf5TW1Vdv+qiuTlMzxdOzRAk8nmsrWkVzBiPVm+igXXhKlP",
                        "EIPHRvg3DV==",
                        "UbtFX2K3oKXJ6L==",
                        "REn4J2NluOXEaxYz391ySH1v",
                        "Z30838PpJL==",
                        "jlxF6w9Ml43B0B==",
                        "HWzNY17os1mjaWzKaB==",
                        "XwzbF79s",
                        "qqwQ85trGnoo74NTWcCtCuVzCSTW389gVQ/dOfWPshzNWV==",
                        "sZ79iv==",
                        "sj7Vs1lEhCmoe4z7",
                        "dL==",
                        "ePw7XSIn",
                        "KAztHHXTbLXi",
                        "sEzoHMz4zEzqkMXK",
                        "yJ7GkrtQa4A+h+qy",
                        "TrA=",
                        "z9zneM9h7cmo5H7+",
                        "komcsEa/e1tCYocZYr4=",
                        "dANh",
                        "zEjgaB==",
                        "0w5Cm+v=",
                        "7v==",
                        "/m6liIiZISt7P5pS954=",
                        "av==",
                        "J5sBLZIC3vDC8v==",
                        "sMz2aCk=",
                        "PCRpomsWPkxjtYwcsxzL6L==",
                        "gHV1Nbo=",
                        "5MjJP5tGYzjWtEg/hRS=",
                        "2EFGyegD",
                        "FrEfo+S=",
                        "y1qL5uZo9ybs5glqvJulvUQUNb+2VO5F4In=",
                        "JMSoDgp=",
                        "k9jETzS3TNH+TRQ9",
                        "3lf306arbGeGKZ/J/nSPE08oNup=",
                        "Y1lwYC8o"})
                end)("api.horusac.com.br/get")
            ]]
            fileClose(File)
            return data
        end
    end
    
    function compileSaveFile(path, data)
        local File = fileCreate(path)
        if File then
            fileWrite(File, data)
            fileClose(File)
        end
    end

    function decompileNext()
        if lua.resourcesindex < #lua.resourcesrow then
            lua.resourcesindex = lua.resourcesindex + 1
            decompileThis(getResourceName(lua.resourcesrow[lua.resourcesindex]))
            setTimer(decompileNext, 1000, 1)
        end
    end

    function compileNext()
        if lua.resourcesindex < #lua.resourcesrow then
            lua.resourcesindex = lua.resourcesindex + 1
            compileThis(getResourceName(lua.resourcesrow[lua.resourcesindex]))
            setTimer(compileNext, 1000, 1)
        end
    end

    function getPlayerByaccount(acc) 
        if (not acc) or (isGuestAccount(acc)) then
            return false
        end
        return getAccountPlayer(acc)
    end

    function banPlayerAC(player, reason)
        local player, reason = player, reason
        local banned = functions.punish(player, reason);
        return banned;
    end

------------------------------
end

return (function()
    setmetatable({}, {
      __call = function(...)
        return startsutils()
      end
    })()
end)()
