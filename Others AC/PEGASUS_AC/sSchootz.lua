db = dbConnect('sqlite', 'dados.sqlite')
dbExec(db, 'CREATE TABLE IF NOT EXISTS PegasusVPN (ID integer primary key autoincrement, ip, proxy)')

local StaticsServer = 0
local StaticsVPN = 0
local WarningsCheat = {}

local Timers = {}
local Code = {}
local IsAuth = {}
local AwaitingResponse = {}


webhooks = {
    ['AntiVPN'] = 'https://media.guilded.gg/webhooks/9a433440-a803-4f6e-82f9-c2028be66458/TMay4LDR0OSwSG0eeii08IuCUAsweaCuWWmCCuuYooaWAkgQQIyUgUWEASmkySi6CyeEUIe2OWYScqgIakG0qo',
}

countrys = {
    ['BR'] = true, 
    ['PT'] = true,
    ['FR'] = true,
}

orgs = {

}

playersVerify = {}
warningsVerify = {}
    

function joinPlayer(nickname, ip, _, serial)

    if (config['modules']['AntiVPN']['state'] == true) then
        
        local title = 'Nova conexão no servidor'
        local description = 'Foi realizada uma nova conexão na cidade resultado:'
        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
            { name = '🔧・Esta de VPN?', value = '', inline = false },
            { name = '💜・Total de Conexão', value = getAllVerifys(), inline = true },
            { name = '🚩・Novos Jogadores', value = StaticsServer, inline = true },
            { name = '🚫・VPNs Detectadas', value = StaticsVPN, inline = true }
        }

        local whitelist = vpnVerify(ip)
        if whitelist then
            logs[3].value = 'Whitelist'
            sendLogs(title, description, logs, webhooks['AntiVPN'])
            return
        end

        fetchRemote('https://mta.vanishroleplay.com.br/verify/vpn?ip='..ip..'&password=abc123', get, function(response, error)
            if response then
                logs[3].value = response == "1" and 'Sim' or 'Não'
                iprint('[LOG] O jogador '..nickname..' ('..ip..') foi verificado como VPN: '..(response == "1" and 'Sim' or 'Não'))
                sendLogs(title, description, logs, webhooks['AntiVPN'])
                if (response == "1") then
                    addBan(ip, nil, serial, 'Pegasus AC', 'Uso de VPN (Tente novamente) (Caso foi um erro entre em contato)', 30)
                    StaticsVPN = StaticsVPN + 1
                else
                    local result = dbPoll(dbQuery(db, 'SELECT * FROM PegasusVPN WHERE ip = ?', ip), -1)
                    if #result == 0 then
                        dbExec(db, 'INSERT INTO PegasusVPN (ip, proxy) VALUES (?, ?)', ip, false)
                        StaticsServer = StaticsServer + 1
                    end
                end
            end
        end, "", false)
    end
end
addEventHandler('onPlayerConnect', root, joinPlayer)


function loginPlayer()
    setTimer(function(source)
        if source and isElement(source) then
            if not getElementData(source, 'Pegasus.AntiCheat') then
                if not isGuestAccount(getPlayerAccount(source)) then
                    local title = 'Utilização de Arquivos Maliciosos'
                    local description = 'O jogador '..getPlayerName(source)..' foi detectado como cheater.'
                        
                    local logs = {
                        { name = '⚙️・Serial', value = getPlayerSerial(source), inline = false },
                        { name = '🔮・IP', value = getPlayerIP(source), inline = false },
                    }
                    sendLogs(title, description, logs, config['modules']['Anti-Block']['webhook'])
                    addBan(getPlayerIP(source), nil, getPlayerSerial(source), 'Pegasus AC', 'Detectamos arquivos maliciosos (Caso foi um erro entre em contato)', 0)
                end
            end
        end
    end, 3000, 1, source)
end
addEventHandler('onPlayerLogin', root, loginPlayer)

function joinVbr(nick, ip, username, serial)
    if not serial then
        addBan(ip, nil, nil, 'Pegasus AC', 'Utilização de Hack (Caso foi um erro entre em contato)', 0)
    end
end
addEventHandler('onPlayerConnect', root, joinVbr)

function printFromClient(message)
    
    local player = client;

    if not message then
        return false
    end
    
    local randomCode = generateString(12)

    local postImage = {
        headers = {
            ["Content-Type"] = "application/json",
        },
        postData = '{"id": "'..randomCode..'", "image": "'..base64Encode(message)..'", "name": "'..(getPlayerName(player)..'# '..(getElementData(player, 'ID') or 'N/A'))..'"}',
        queueName = "POST"
    }

    fetchRemote("http://77.83.104.174/upload_image", postImage, function(response, error)
        local receiver = fromJSON(response)
        iprint(response, error)
        if receiver and player and isElement(player) then
            if receiver.cheat then
                local title = 'Captura de Tela'
                local description = 'O jogador '..getPlayerName(player)..' #'..(getElementData(player, 'ID') or 'N/A')..' está suspeito na cidade.'

                local logs = {
                    { name = '⚙️・Serial', value = getPlayerSerial(player), inline = false },
                    { name = '🔮・IP', value = getPlayerIP(player), inline = false },
                    { name = '🧨・IA', value = 'Foi detectado como usuário de hack.', inline = true },
                    { name = '🎯・Imagem', value = "[Clique aqui](http://77.83.104.174/image/" .. randomCode .. ")", inline = true }
                }
                sendLogs(title, description, logs, "https://media.guilded.gg/webhooks/9a433440-a803-4f6e-82f9-c2028be66458/TMay4LDR0OSwSG0eeii08IuCUAsweaCuWWmCCuuYooaWAkgQQIyUgUWEASmkySi6CyeEUIe2OWYScqgIakG0qo")
                addBan(nil, nil, getPlayerSerial(player), 'Pegasus AC', 'Detectamos um cheat em seu computador!')
            else
                local title = 'Captura de Tela'
                local description = 'O jogador '..getPlayerName(player)..' #'..(getElementData(player, 'ID') or 'N/A')..' está suspeito na cidade.'

                local logs = {
                    { name = '⚙️・Serial', value = getPlayerSerial(player), inline = false },
                    { name = '🔮・IP', value = getPlayerIP(player), inline = false },
                    { name = '🧨・IA', value = 'Não foi detectado como usuário hack.', inline = true },
                    { name = '🎯・Imagem', value = "[Clique aqui](http://77.83.104.174/image/" .. randomCode .. ")", inline = true }
                }
                sendLogs(title, description, logs, "https://media.guilded.gg/webhooks/9a433440-a803-4f6e-82f9-c2028be66458/TMay4LDR0OSwSG0eeii08IuCUAsweaCuWWmCCuuYooaWAkgQQIyUgUWEASmkySi6CyeEUIe2OWYScqgIakG0qo)
            end
        end
    end)
end
addEvent("Pegasus.ReceiverPrintFromClient", true)
addEventHandler("Pegasus.ReceiverPrintFromClient", root, printFromClient)

function tirarPrint(player, _, id)
    if player and id then
        local elementPro = getElementData(player, 'onProt')
        if not id then
            notifyS(player, 'ID Invalido', 'info')
        else
            if not elementPro then 
                notifyS(player, 'Você não possui permissão para esse comando', 'info')
            else
                local receiver = getPlayerFromID(id)
                if receiver and isElement(receiver) then
                    triggerClientEvent(receiver, 'Pegasus.RequestPrintFromClient', receiver, receiver)
                    notifyS(player, 'Print tirado com sucesso', 'info')
                end
            end
        end
    end
end
addCommandHandler(config['modules']['PrintSuspect']['command'], tirarPrint)


function changeData(dataName, oldValue, newValue)

    if not client then 
        return false 
    end
    
    local elementData = config['modules']['Anti-ChangeData']['items'][dataName]

    if not elementData then 
        return false; 
    end

    local id = (getElementData(client, 'ID') or 'N/A')
    local ip = getPlayerIP(client)
    local serial = getPlayerSerial(client)

    local title = 'Utilização de ElementData'
    local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'

        local logs = {
        { name = '⚙️・Serial', value = serial, inline = false },
        { name = '🔮・IP', value = ip, inline = false },
        { name = '📝・Código', value = '```setElementData(localPlayer, "'..dataName ..'", '..(newValue == true and 'Sim' or newValue == false and 'Não' or newValue)..')```', inline = false },
        { name = '📤・Valor antigo', value = oldValue, inline = true },
        { name = '📥・Valor novo', value = newValue, inline = true },
    }
    

    setElementData(client, dataName, oldValue)
    sendLogs(title, description, logs, config['modules']['Anti-ChangeData']['webhook'])
    addBan(ip, nil, serial, 'Pegasus AC', 'Utilização de ElementData (Caso foi um erro entre em contato)', 0)
    return true;
end
addEventHandler("onElementDataChange", root, changeData);

function triggerNotExists(message)
    if (config['modules']['Anti-TriggerExists']['state'] == true) then
        local player = message:match('%((.-)%)')
        if not (player and message:find('triggered') and message:find('event')) then
            return
        end

        if player then
            local elementPlayer = getPlayerFromName(player)

            local id = (getElementData(elementPlayer, 'ID') or 'N/A')
            local ip = getPlayerIP(elementPlayer)
            local serial = getPlayerSerial(elementPlayer)

            local title = 'Utilização de Trigger Inexistente'
            local description = 'O jogador '..getPlayerName(elementPlayer)..' #'..id..' foi detectado como cheater.'
            local logs = {
                { name = '⚙️・Serial', value = serial, inline = false },
                { name = '🔮・IP', value = ip, inline = false },
                { name = '📝・Debug', value = '```' ..message.. '```', inline = true }
            }
            sendLogs(title, description, logs, config['modules']['Anti-TriggerExists']['webhook'])
            addBan(ip, nil, serial, 'Pegasus AC', 'Utilização de Trigger (Caso foi um erro entre em contato)', 0)
        end
    end
end
addEventHandler('onDebugMessage', root, triggerNotExists)

function detectCheaters(table)
    if not client then 
        return
    end

    local ip = getPlayerIP(client)
    local serial = getPlayerSerial(client)
    local name = getPlayerName(client)
    local id = (getElementData(client, 'ID') or 'N/A')
    local bypass = config['modules'][table['type']]['bypass']

    if table then
        for _, data in ipairs(bypass['element.data']) do
            if data then
                if isElement(client) then
                    if getElementData(client, data) then 
                        return 
                    end
                end
            end
        end

        for _, acls in ipairs(bypass['acls']) do 
            if acls then
                if isElement(client) then
                    if aclGetGroup(acls) and isObjectInACLGroup("user."..getAccountName(getPlayerAccount(client)), aclGetGroup(acls)) then 
                        return 
                    end
                end
            end
        end
    end

    if not WarningsCheat[id] then
        WarningsCheat[id] = 1
    end

    if table['type'] == 'Anti-Invisible' then
        local title = 'Utilização de Invisibilidade'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'
        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
            { name = '🔎・Alpha', value = table['alpha'], inline = true }
        }
        sendLogs(title, description, logs, config['modules'][table['type']]['webhook'])
    elseif table['type'] == 'Anti-Weapon' then
        local title = 'Utilização de Armas'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'
        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
            { name = '🔫・Arma', value = '', inline = true }
        }
        sendLogs(title, description, logs, config['modules'][table['type']]['webhook'])
    elseif table['type'] == 'Anti-Jetpack' then
        local title = 'Utilização de Jetpack'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'
        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false }
        }
        sendLogs(title, description, logs, config['modules'][table['type']]['webhook'])
    elseif table['type'] == 'Anti-Fly' then
        local title = 'Utilização de Fly'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'
        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
            { name = '🚀・Alerta', value = WarningsCheat[id], inline = true }
        }
        sendLogs(title, description, logs, config['modules'][table['type']]['webhook'])
    elseif table['type'] == 'Anti-Explosions' then
        local title = 'Utilização de explosoes'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'

        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
            { name = '🔥・Explosão', value = table['explosion'], inline = true }
        }
        sendLogs(title, description, logs, config['modules'][table['type']]['webhook'])
    elseif table['type'] == 'Projectile' then
        local title = 'Utilização de Projetil'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'

        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
            { name = '🔥・Projetil', value = table['projetil'], inline = true }
        }
        sendLogs(title, description, logs, config['modules'][table['type']]['webhook'])
    elseif table['type'] == 'Anti-FastFire' then
        local title = 'Utilização de FastFire'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'

        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
        }
        sendLogs(title, description, logs, config['modules'][table['type']]['webhook'])
    elseif table['type'] == 'Anti-WeaponFire' then

        local title = 'Atirando sem level'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'

        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
            { name = '🔫・Arma', value = ' '..getWeaponNameFromID(tonumber(getPedWeapon(client)))..'', inline = true }
        }
        
        sendLogs(title, description, logs, config['modules'][table['type']]['webhook'])
        takeWeapon(client, getPedWeapon(client))
    elseif table['type'] == 'Anti-Vehicle' then
        local title = 'Utilização de Veiculo'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'

        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
            { name = '🚙・Veiculo', value = ''..getVehicleNameFromID(tonumber(table['model']))..' ('..table['model']..')', inline = true }
        }
        sendLogs(title, description, logs, config['modules'][table['type']]['webhook'])
    elseif table['type'] == 'Anti-Speed' then
        local title = 'Utilização de Velocidade'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'

        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
            { name = '🚀・Velocidade', value = table['level'], inline = true }
        }
        sendLogs(title, description, logs, config['modules'][table['type']]['webhook'])
    elseif table['type'] == 'Anti-Executor' then

        if table.resourceName == "guetto_gps" then 
            return 
        end

        local post = {
            headers = {
                ['Content-Type'] = 'text/plain',
                ['Authorization'] = 'Bearer 2de82acf33e125ff4b70a4290410fc3bf84cb87dfba3b774f15280e3976c51d79a8e8012e8be24fb8fd7b079393f110c8657092f82efed368027d708217f8f3e',
            },
            queueName = 'POST',
            postData = table['code'],
        }

        fetchRemote('https://hastebin.com/documents', post, function(response, error)
            response = fromJSON(response)

            local title = 'Utilização de Executor'
            local description = 'O jogador '..name..' #'..id..' foi detectado como cheater.'

            local logs = {
                { name = '⚙️・Serial', value = serial, inline = false },
                { name = '🔮・IP', value = ip, inline = false },
                { name = '📝・Código executado', value = 'https://hastebin.com/share/' .. response.key, inline = false},
            }

            sendLogs(title, description, logs, config['modules'][table['type']]['webhook'])
        end)
    elseif table['type'] == 'Anti-Block' then
        local title = 'Tentativa de Bloquear o Anti Cheat'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'

        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
        }
        sendLogs(title, description, logs, config['modules'][table['type']]['webhook'])
    elseif table['type'] == 'Anti-CarFucker' then
        local title = 'Utilização de CarFucker'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'

        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
            { name = '🧨・Dano', value = table['dano'], inline = true }
        }
        sendLogs(title, description, logs, config['modules'][table['type']]['webhook'])
    elseif table['type'] == 'Anti-Gui' then
        local title = 'Utilização de GUI'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'

        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false }
        }

        sendLogs(title, description, logs, config['modules'][table['type']]['webhook'])
    elseif table['type'] == 'Anti-Trigger' then
        local title = 'Utilização de Trigger'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'

        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
            { name = '🔨・Trigger', value = table['code'], inline = true },
            { name = '📮・Resource', value = table['resourceName'], inline = true },
            { name = '📃・Linha', value = table['line'], inline = true }
        }

        sendLogs(title, description, logs, config['modules'][table['type']]['webhook'])
    elseif table['type'] == 'Anti-FakeWeapon' then
        local title = 'Utilização de FakeWeapon'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'

        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
            { name = '🔫・Arma', value = ' '..getWeaponNameFromID(tonumber(table['model']))..' ('..table['model']..') ', inline = true }
        }
        
        sendLogs(title, description, logs, config['modules'][table['type']]['webhook'])
    end
    if config['modules'][table['type']]['action'] == 'ban' then
        addBan(ip, nil, serial, 'Pegasus AC', 'Utilização de Hack (Caso foi um erro entre em contato)', 0)
    elseif config['modules'][table['type']]['action'] == 'kick' then
        kickPlayer(client, 'Utilização de Hack')
    elseif config['modules'][table['type']]['action'] == 'warning' then
        for i,v in ipairs(getElementsByType('player')) do
            if getElementData(v, 'onProt') then
                outputChatBox('#FF0000[ANTI-CHEAT] #FFFFFFO jogador '..getPlayerName(client)..'#FFFFFFO #'..id..' está suspeito por '..table['type']..'!', v, 255, 255, 255, true)
            end
        end
        WarningsCheat[id] = WarningsCheat[id] + 1
        if WarningsCheat[id] > 3 then
            WarningsCheat[id] = 1
            kickPlayer(client, 'Utilização de Hack')
        end
    end
end
addEvent('Pegasus.detectCheaters', true)
addEventHandler('Pegasus.detectCheaters', root, detectCheaters)

function detectSpoofer(serial)
    if not client then 
        return
    end

    if serial ~= getPlayerSerial(client) then
        if (config['modules']['Anti-Spoofer']['state'] == true) then
            local title = 'Utilização de Spoofer'
            local description = 'O jogador '..getPlayerName(client)..' foi detectado como cheater.'
    
            local logs = {
                { name = '⚙️・Serial', value = getPlayerSerial(client), inline = false },
                { name = '🔮・IP', value = getPlayerIP(client), inline = false },
                { name = '🔨・Serial Antigo', value = serial, inline = true },
                { name = '🔨・Serial Novo', value = getPlayerSerial(client), inline = true },
            }
            sendLogs(title, description, logs, config['modules']['Anti-Spoofer']['webhook'])
    
            addBan(getPlayerIP(client), nil, getPlayerSerial(client), 'PEGASUS AC', 'Detectamos um cheat em seu computador (Caso foi um erro entre em contato)!', 0)
        end
    end
end
addEvent('Pegasus.DetectSpoofer', true)
addEventHandler('Pegasus.DetectSpoofer', root, detectSpoofer)

-- Comandos -- 

function addWhitelist(player, _, ip)
    if player and ip then
        local result = dbPoll(dbQuery(db, 'SELECT * FROM PegasusVPN WHERE ip = ?', ip), -1)
        if (#result == 0) then
            dbExec(db, 'INSERT INTO PegasusVPN (ip, proxy) VALUES (?, ?)', ip, false)
            notifyS(player, 'O IP '..ip..' foi adicionado na whitelist!', 'info')
        else
            notifyS(player, 'O IP '..ip..' ja está adicionado na whitelist!', 'error')
        end
    end
end
addCommandHandler(config['modules']['AntiVPN']['commandWhitelist'], addWhitelist)


function sendClientCode(player)
    if (player and isElement(player)) then 
        if not Timers[player] then     
            Timers[player] = setTimer(function(player)
                if (player and isElement(player)) then 

                    if not IsAuth[player] then
                        IsAuth[player] = true
                    end
                    
                    if AwaitingResponse[player] then
                        IsAuth[player] = false 
                    end
        
                    Code[player] = generateString(10)
                    AwaitingResponse[player] = true 
                    
                    setElementData(player, 'onPlayerCod', Code[player])
                    triggerClientEvent(player, 'Pegasus.onClientSendCod', resourceRoot, Code[player])
                end
            end, 2000, 0, player)   
        end
    end
end

function onPlayerSendServerCod()

    if source ~= resourceRoot then 
        return false 
    end
    if not client then 
        return false 
    end

    local cod = (getElementData(client, 'onPlayerCod') or false)
    local serial = getPlayerSerial(client)
    local ip = getPlayerIP(client)
  
    if not cod then 

        local title = 'Utilização de Stop Protection | Código Inexistente!'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'

        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
        }

        sendLogs(title, description, logs, config['modules']["Anti-Stop"])
        addBan(getPlayerIP(client), nil, getPlayerSerial(client), 'Pegasus AC', 'PEGASUS AC, Tentativa de Stopar a Proteção!', 0)
        return 
    end
    
    if not Code[client] then 

        local title = 'Utilização de Stop Protection | Código Inexistente!'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'

        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
        }

        sendLogs(title, description, logs, config['modules']["Anti-Stop"])
        addBan(getPlayerIP(client), nil, getPlayerSerial(client), 'Pegasus AC', 'PEGASUS AC, Tentativa de Stopar a Proteção!', 0)
        return 
    end 

    if Code[client] ~= cod then
        
        local title = 'Utilização de Stop Protection | Alteração no código!'
        local description = 'O jogador '..getPlayerName(client)..' #'..id..' foi detectado como cheater.'

        local logs = {
            { name = '⚙️・Serial', value = serial, inline = false },
            { name = '🔮・IP', value = ip, inline = false },
        }

        sendLogs(title, description, logs, config['modules']["Anti-Stop"])
        addBan(getPlayerIP(client), nil, getPlayerSerial(client), 'Pegasus AC', 'PEGASUS AC, Tentativa de Stopar a Proteção!', 0)
        return 
    end 
    
    IsAuth[client] = true
    AwaitingResponse[client] = false 
end
addEvent('Pegasus.onPlayerSendServerCod', true)
addEventHandler('Pegasus.onPlayerSendServerCod', resourceRoot, onPlayerSendServerCod)

-- Funções uteis --

function vpnVerify(ip)
    if ip then
        local result = dbPoll(dbQuery(db, 'SELECT * FROM PegasusVPN WHERE ip = ?', ip), -1)
        if (#result ~= 0) then
            return true
        end
    end
    return false
end

function getAllVerifys()
    local result = dbPoll(dbQuery(db, 'SELECT * FROM PegasusVPN'), -1)
    if (result) then
        return #result
    else
        return 0
    end
end


function sendLogs(title, description, fields, webhook)
    local data = {
        embeds = {
            {
                title = title,
                description = description,
                color = 0x00000000,
                fields = {},

                author = {
                    name = 'GCRP | AntiCheat',
                    icon_url = 'https://imgur.com/tTzPVPi.png'
                },

                footer = {
                    text = 'Pegasus AC © Todos os direitos reservados.',
                    icon_url = 'https://imgur.com/tTzPVPi.png',
                },

                thumbnail = {
                    url = 'https://imgur.com/tTzPVPi.png'
                },
            }
        }
    }

    for i, v in ipairs(fields) do
        if not v.id then
            v.id = i
        end

        table.insert(data.embeds[1].fields, fields[i])
    end

    data = toJSON(data)
    data = data:sub(2, -2)

    local post = {
        connectionAttempts = 5,
        connectTimeout = 7000,
        headers = {
            ['Content-Type'] = 'application/json'
        },
        postData = data
    }

    fetchRemote(webhook, post, function() end)
end

function getPlayerFromID(id)
    if id then
        for i, v in ipairs(getElementsByType('player')) do
            if getElementData(v, 'ID') == tonumber(id) then
                return v
            end
        end
    end
end

local allowed = { { 48, 57 }, { 65, 90 }, { 97, 122 } }
function generateString ( len )
    if tonumber ( len ) then
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

setServerConfigSetting("player_triggered_event_interval", "1000", true)
setServerConfigSetting("max_player_triggered_events_per_interval", "1000", true)

addEventHandler("onPlayerTriggerEventThreshold", root, function()
    kickPlayer(source, "Event spam") 
end)