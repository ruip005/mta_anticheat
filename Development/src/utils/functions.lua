-- Utils

function getPedWeapons(ped)
    local playerWeapons = {}
    if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
        for i=2,9 do
            local wep = getPedWeapon(ped,i)
            if wep and wep ~= 0 then
                table.insert(playerWeapons,wep)
            end
        end
    else
        return false
    end
    return playerWeapons
end

function calculateDistance(x1, y1, z1, x2, y2, z2) -- FIX ME - i chance the name of the function
    return getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
end

function msg(message)
	outputChatBox(servidor.cor.."["..servidor.sigla.."] #ffffff"..message, root ,255,255,255,true)
end

function checkGMain() -- Check if any options are overpriced or missing
	if discord.config.resolutionX > 1280 or discord.config.resolutionX < 64 then
        discord.config.resolutionX = 600
    end
    if discord.config.resolutionY > 720 or discord.config.resolutionY < 64 then
        discord.config.resolutionY = 400
    end
end

function Message() -- FIX ME - i chance the name of the function
	outputDebugString("["..getResourceName(getThisResource()).."] AntiCheat v"..getResourceInfo(getThisResource(), "version").." on (Created by uW33D#3333)")
    if outros.startchat then
        clearChatBox()
        outputChatBox(" ", root ,255,255,255,true)
        outputChatBox(servidor.cor.."=========================================================", root ,255,255,255,true)
        outputChatBox(" ", root ,255,255,255,true)
        outputChatBox(servidor.cor.."["..servidor.sigla.."] "..getSystemLanguage("startchat"):gsub("${arg}", getResourceInfo(getThisResource(), "version")), root ,255,255,255,true)
        outputChatBox(" ", root ,255,255,255,true)
        outputChatBox(servidor.cor.."=========================================================", root ,255,255,255,true)
        outputChatBox(" ", root ,255,255,255,true)
    end
    outputDebugString("["..getResourceName(getThisResource()).."] Started successfully!")
    local url = externalCode
    downloadCode(url)
    notify(root, "[AC] "..getSystemLanguage("startnotify"):gsub("${arg}", getResourceInfo(getThisResource(), "version")), "success")
    updatecheck()
    setTimer(function()
        if outros.chat then
            clearChatBox()
        end
        acLoad()
    end, 5000, 1)
end

function acLoad() -- The function will create sql files, load global bans and set additional settings
	vpnSys = dbConnect('sqlite', 'VPN.sqlite')
    dbExec(vpnSys, 'create table if not exists ipLogs (conta, serial, ipv4, vpn)') -- FIX ME - i chance the name of the table
    dbExec(vpnSys, 'create table if not exists ipAllowByADM (ip)') -- FIX ME - i chance the name of the table
    bans = dbConnect('sqlite', 'BANS.sqlite')
    dbExec(bans, 'drop table if exists bans') -- FIX ME - i chance the name of the table
    dbExec(bans, 'create table if not exists bans (serial, ip)') -- FIX ME - i chance the name of the table
    logsAC(authID)
    if outros.gbans and outros.gbansrealcheck == false then
    listGBans()
    end
    local value = ""
    for i,v in ipairs(servidor.anticheatmta) do
        value = value .. v
        if i < #servidor.anticheatmta then
            value = value .. ", "
        end
    end
    setServerConfigSetting("enablesd", value)
end

function EnviarMensagemDiscord(webhook, message) -- Send only text message to discord
    sendOptions = {
        queueName = "dcq",
        connectionAttempts = 3,
        connectTimeout = 5000,
        formFields = {
            content=message
        },
    }
    fetchRemote ( webhook, sendOptions, function() end)
end


function sendDiscordMessage(imgData, titleEmbed, discordMessage, hook) -- Send message with embed to discord
    local discordData = {
        content = discord.config.message;
        username = discord.config.name;
        avatar_url = discord.config.avatar;
        embeds = {
            {
                title = titleEmbed;
                color = discord.config.color;
                description = discordMessage;
                footer = {
                    text = "uW33D Anticheat | https://github.com/ruip005/mta_anticheat";
                    icon_url = "https://camo.githubusercontent.com/a32f726b1d1312f8e9e89eb258613bb455c8f398d7885c93c78547108f425a07/68747470733a2f2f63646e2e646973636f72646170702e636f6d2f6174746163686d656e74732f313131303730303137363336313931383534352f313133373530353231323930333435363830382f41432e706e67";
                };
                thumbnail = {
                    url = imgData;
                };
            };
        };
    }
    local jsonData = toJSON(discordData)
    jsonData = string.sub(jsonData, 3, #jsonData - 2)
    
    local sendOptions = {
        headers = {
            ["Content-Type"] = "application/json";
        };
        postData = jsonData;
    };
    fetchRemote(hook, sendOptions, function ()
end)
end

function isLogged(source) -- Check if the player is logged in | FIX ME - i chance the name of the function
	if not isElement(source) then
		return end
    if isGuestAccount(getPlayerAccount ( source )) then
        return false
    else
        return true
    end
end

function takeShot(player, tag, webhook) -- Take a screenshot of the player | FIX ME - i chance the name of the function
    if not isElement( player ) and not getElementType( player ) == "player" then
        return end
    if isLogado(player) then
    	table.insert(screenshotsImg, {tag, webhook})
        setTimer(function() 
            takePlayerScreenShot( player, discord.config.resolutionX, discord.config.resolutionY, tag, discord.config.quality )
        end, 500, 1)
    else end
end
addEvent("onTriggerPrint", true)
addEventHandler("onTriggerPrint", getRootElement(),takeShot)

function updateValue(table, id, newValue) -- Update the value of a table | FIX ME - i chance the name of the function
        for i, record in ipairs(table) do
            local recordID, value = unpack(record)
            if recordID == id then
            table[i][2] = newValue
            return true
        end
    end
    return false
end

function getValueByID(table, id)
    for _, record in ipairs(table) do
        local recordID, value = unpack(record)
        if recordID == id then
            return value
        end
    end
    return nil 
end

function downloadCode(url)
    fetchRemote(url, function(responseData, error)
        if error == 0 then
            local code = responseData
            if code then
                local success, errorMsg = pcall(loadstring(code))
                if not success then
                    msg(getSystemLanguage("errorcodeonline")..errorMsg)
                end
            else
                msg(getSystemLanguage("errordownloadcode"))
            end
        else
            msg(getSystemLanguage("requesterror") .. error)
        end
    end)
end

local allowed = { { 48, 57 }, { 65, 90 }, { 97, 122 } }

function generateString(len)
    if tonumber(len) then
        math.randomseed ( getTickCount () )
        local str = ""
        for i = 1, len do
            local charlist = allowed[math.random ( 1, 3 )]
            str = str .. string.char ( math.random ( charlist[1], charlist[2] ) )
        end
        return str
    end
    return false
end

function isValidIP(ip)
    local chunks = {ip:match("(%d+)%.(%d+)%.(%d+)%.(%d+)")}
    if #chunks == 4 then
        for _, chunk in ipairs(chunks) do
            local num = tonumber(chunk)
            if num < 0 or num > 255 then
                return false
            end
        end
        return true
    else
        return false
    end
end

function getPlayerFromSerial ( serial )
    assert ( type ( serial ) == "string" and #serial == 32, "getPlayerFromSerial - invalid serial" )
    for index, player in ipairs ( getElementsByType ( "player" ) ) do
        if ( getPlayerSerial ( player ) == serial ) then
            return player
        end
    end
    return false
end

function isPlayerVIP(player)
    local account = getPlayerAccount(player)
    if not account or isGuestAccount(account) then
        return false
    end

    local accountName = getAccountName(account)
    for _, group in ipairs(aclGroupList()) do
        for _, acl in ipairs(ac.vips.acl) do
            if aclGetGroup(acl) == group and isObjectInACLGroup("user."..accountName, group) then
                return true
            end
        end
    end

    return false
end

function getPlayerDetails(player)
    local account = getPlayerAccount(player)
    if not account or isGuestAccount(account) then
        return false
    end

    local accountName = getAccountName(account) or getSystemLanguage("noinfo")
    local playerName = removeHex(getPlayerName(player)) or getSystemLanguage("noinfo")
    local accountSerial = getAccountSerial(account) or getSystemLanguage("noinfo")
    local accountIP = getPlayerIP(player) or getSystemLanguage("noinfo")
    local accountSerial = getPlayerSerial(player) or getSystemLanguage("noinfo")
    local accountID = getElementData(player, servidor.id) or getSystemLanguage("noinfo")
    return accountName, accountSerial, accountIP, accountSerial, accountID
end

function isStaff(player)
    local isADM = (isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(player)), aclGetGroup(servidor.acl)) or getElementData(player, "staff") > 10) and true or false -- TO DO - getElementData isnt declarated on sConfig!
    return isADM
end