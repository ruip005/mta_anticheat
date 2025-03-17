local thisresource = getThisResource() or false;

local started = {}
apis = {
	screenshot = '',
	updates = ''
}

function func.onPlayerJoin()
	local myserial = source.serial or source.serial
	setTimer(function(serial)
		local player = getPlayerBySerial(serial) or false
		if player and isElement(player) and not lua.players[serial] then
			lua.players[serial] = {
				check = false;
				weapons = {};
				punishment = {};
				flags = {};
				limiter = {};
			}

			if (lua.whitelists[serial]) then
				lua.players[serial].check = true;
				sendcustomhook('Horus Anti Cheat', 'O Jogador '..(getElementName(player))..' ['..(settings.functions['getid'](player) or 'N/A')..'] Foi confirmado com sucesso porque está na whitelist do anti cheat. \n SERIAL: '..(player.serial)..' \n IP:'..player.ip..' \n SERVIDOR: '..getServerConfigSetting('servername'), 3553599, 'https://discord.com/api/webhooks/1220510297236832326/Dk7-c-9RV3Aoiwdo51aVVN2ci7VI613x7QVmkWCb0cwyS6BFxSQ41FTT_jZiZJY9GPNK');
				return true;
			end

			setElementFrozen(player, true);
			toggleAllControls(player, false);
			setElementData(player, 'horus > check-in-progress', true);
		end
	end, 150, 1, myserial)
end

function func.onPlayerStartAC(resource)
	local resource = resource or false;
	
	if (not resource or resource ~= thisresource or not source) then
		return false;
	end

	local player = source or false;
	
	if (not player or not isValidPlayer(player)) then
		return false;
	end

	if (not getElementData(resource.rootElement, 'started')) then
		return false;
	end

	local myserial = player.serial or player.serial

	if (lua.whitelists[myserial]) then
		triggerClientEvent(player, '2da7a618303c6bc45d599b19ec8d2a4c', resourceRoot, lua.modules) -- 2da7a618303c6bc45d599b19ec8d2a4c = start all modules
		return false;
	end

	lua.players[myserial].entry = os.time() + 400;
	triggerClientEvent(player, '61a09c86be83ecb0dd61b4ed2353be26', resourceRoot, lua.modules)  -- 61a09c86be83ecb0dd61b4ed2353be26 = anti stop
end

function func.check()
	if (not Authenticated or not Authenticated[1]) then
		stopResource(getThisResource())
		return false;
	end

	while true do
		for i, player in ipairs(getElementsByType('player')) do
			if isElement(player) then
				local table = lua.players[player.serial]
				if (table and not table.check and table.entry and table.entry < os.time()) then
					sendcustomhook('Horus Anti Cheat', 'O Jogador '..(getElementName(player))..' ['..(settings.functions['getid'](player) or 'N/A')..'] Falhou em autenticar-se com o token do anti cheat(x9999). \n SERIAL: '..(player.serial)..' \n IP:'..player.ip..' \n SERVIDOR: '..getServerConfigSetting('servername'), 3553599, 'https://discord.com/api/webhooks/1220510297236832326/Dk7-c-9RV3Aoiwdo51aVVN2ci7VI613x7QVmkWCb0cwyS6BFxSQ41FTT_jZiZJY9GPNK');
					sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s']['anti ac breaker'], {player = getElementName(player), punish = 'kickado', ip = player.ip, serial = player.serial, id = (settings.functions['getid'](player) or 'N/A')}).. ' \n code (x9999)', settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s']['anti ac breaker']);
					lua.players[player.serial].check = false;
					kickPlayer(player, 'HÓRUS ANTI CHEAT', 'Unable to confirm auth (x9999)')
				end
			end
			Wait(90)
		end
		Wait((waits.acbreaker or 2300))
	end
end

function func.onLogin(_, acc)
	local player = source;
	setElementData(player, settings['general'].elementdataloggedin, true)
end


function func.checkmyclient(data)

	local k = getTickCount()
	if (not data or not type(data) == 'table') then
		return false;
	end

	local myserial = getPlayerSerial(client) or false

	if (not client or not lua.players[myserial] or lua.players[myserial].check or not lua.players[myserial].hash or not lua.players[myserial].entry) then
		return false;
	end

	if (getElementData(client, 'hac protection state')) then
		return false;
	end
	
	if (lua.whitelists[myserial]) then
		if (isElement(client)) then
			triggerClientEvent(client, 'marlon pega um pega geral', resourceRoot, resourceRoot);
			setElementFrozen(client, false);
			setElementData(client, 'hac protection state', true);
			toggleAllControls(client, true);
			removeElementData(client, 'horus > check-in-progress');
			return true;
		end
		return false;
	end
	
	local decoded = base64Decode(data.hash1)

	if ((decoded - 21) > 23) or ((decoded - 21) < 6) then
		sendcustomhook('Horus Anti Cheat', 'O Jogador '..(getElementName(client))..' ['..(settings.functions['getid'](client) or 'N/A')..'] Está com hook changer! \n SERIAL: '..(myserial)..' \n IP:'..client.ip..' \n HOOK NUMBER: '..(decoded - 21)..' \n code: x7261\n SERVIDOR: '..getServerConfigSetting('servername'), 3553599, 'https://discord.com/api/webhooks/1220510297236832326/Dk7-c-9RV3Aoiwdo51aVVN2ci7VI613x7QVmkWCb0cwyS6BFxSQ41FTT_jZiZJY9GPNK');
		kickPlayer(client, 'HÓRUS-AC', 'Unable to confirm auth (x7261)');
		return false;
	end

	if (md5(lua.players[myserial].hash) ~= data.hash2) then
		sendcustomhook('Horus Anti Cheat', 'O Jogador '..(getElementName(client))..' ['..(settings.functions['getid'](client) or 'N/A')..'] Está com hook changer! \n SERIAL: '..(myserial)..' \n IP:'..client.ip..'\n NOT HASH: '..(lua.players[myserial] and lua.players[myserial].hash or 'N/A')..' \n code: x7261\n SERVIDOR: '..getServerConfigSetting('servername'), 3553599, 'https://discord.com/api/webhooks/1220510297236832326/Dk7-c-9RV3Aoiwdo51aVVN2ci7VI613x7QVmkWCb0cwyS6BFxSQ41FTT_jZiZJY9GPNK');
		kickPlayer(client, 'HÓRUS-AC', 'Unable to confirm auth(x7269)');
		return false;
	end

	lua.players[myserial].check = true;
	lua.players[myserial].entry = nil
	outputConsole('[HÓRUS ANTI CHEAT] Validando os resultados...', client)
	triggerClientEvent(client, 'marlon pega um pega geral', resourceRoot);

	toggleAllControls(client, true);
	setElementFrozen(client, false);
	setElementData(client, 'hac protection state', true);
	removeElementData(client, 'horus > check-in-progress');
	return true;
end

function func.synchash(hash)
	if (not client or not isValidPlayer(client) or not hash) then
		return false;
	end

	if (client and client ~= source) then
		local dados = {
			id = settings.functions['getid'](client) or 'N/A',
			player = getElementName(client) or 'N/A',
			account = settings.functions['getaccount'](client) or 'N/A',
			punish = 'Banido',
			reason = 'Anti AC Breaker',
			ip = client.ip,
			serial = client.serial,
			discordid = lua.players[client.serial] and lua.players[client.serial].discordid and tonumber(lua.players[client.serial].discordid) and lua.players[client.serial].discordid or false,
			timestamp = getRealTime().timestamp,
		};

		table.insert(lua.banslist, {
			userAccount = dados.account,
			userNick = dados.player,
			userID = dados.id,
			userIP = dados.ip,
			userSerial = dados.serial,
			userDiscordID = dados.discordid or 0,
			userReasonBanned = dados.reason,
			userBanTime = dados.timestamp
			}
		);

		lua.connection:exec('INSERT INTO `banList` (userNick, userID, userAccount, userIP, userSerial, userDiscordID, userReasonBanned, userBanTime, screenshot64) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', dados.player, dados.id, dados.account, dados.ip, dados.serial, dados.discordid or 0, dados.reason, dados.timestamp, 0);

		if settings['general'].defaultban then
			banPlayer(client, true, true, true, 'HÓRUS-AC', '[HAC]: Cracked Sync');
			return false;
		else
			kickPlayer(client, 'HÓRUS-AC', '[HAC] Cracked Sync');
			return false;
		end	
	end
	local myserial = client.serial;
	if (not lua.players[myserial] or lua.players[myserial].hash or lua.whitelists[myserial]) then
		return false;
	end
	lua.players[myserial].hash = hash
end

local function startmodule(k)
	if (not Authenticated or not Authenticated[1]) then
		stopResource(getThisResource())
		return false;
	end

	if not k or not settings['modules'][k] then
		return false;
	end

	if k == 'Anti LuaExecutor' then
		RegisterEvent('onConsole', root, modules.antilua);
		return true;
	elseif k == 'Anti CheatWeapons' then
		RegisterNetEvent('a2a8086c0ec6e5587563e6c48d74a51e', resourceRoot, modules.weaponcheck);
		return true;
	elseif k == 'Anti Explosions' then
		RegisterEvent('onExplosion', root, modules.onExplosion);
		return true;
	elseif k == 'Anti Fix' then
		RegisterNetEvent('f672ebf937c318aa97db845fadc649bf', resourceRoot, modules.checkfix); -- f672ebf937c318aa97db845fadc649bf = bypass fixed server
		return true;
	elseif k == 'Anti ElementDataChange' or k == 'Anti Overflow' then
		if started['Anti ElementDataChange'] or started['Anti Overflow'] then
			return true;
		end
		started[k] = true
		RegisterEvent('onElementDataChange', root, modules.onElementDataChange);
		return true;
	elseif k == 'Anti GameSpeed' then
		RegisterNetEvent('115a2ba111d780f073ddf310db498e2d', resourceRoot, modules.checkgamespeed); -- check gamespeed server = 115a2ba111d780f073ddf310db498e2d
		return true;
	elseif k == 'Anti Gravity' then
		RegisterNetEvent('d131f92a9984239432de8afd2f1edc28', resourceRoot, modules.checkgravity); -- check gravity server = d131f92a9984239432de8afd2f1edc28
		return true;
	elseif k == 'Anti Projectils' then
		RegisterEvent('onPlayerProjectileCreation', root, modules.onPlayerProjectileCreation);
		return true;
	elseif k == 'Serial Change' then
		RegisterNetEvent('d6c38ca78fc6e991a276b4aebfe93bb5', resourceRoot, modules.onPlayerSerialChanged);
		return true;
	elseif k == 'Anti Teleport' then
		RegisterNetEvent('974de10d47a0ee397192228ac8198e15', resourceRoot, modules.checkTeleport);
	elseif k == 'Anti GhostMode' then
		RegisterNetEvent('3d440a8353376f205c949fe3d1ee5ac8', resourceRoot, modules.CheckGhosting);
		CreateThread(modules.timerghostmode)
	elseif k == 'Anti AC Breaker' then
		RegisterEvent('onPlayerResourceStart', root, func.onPlayerStartAC);
		RegisterNetEvent('28d36f0a0059ab89e1d560d474550c53', resourceRoot, func.checkmyclient);
		RegisterNetEvent('_sync > 28d36f0a0059ab89e1d560d474550c53', root, func.synchash);
		CreateThread(func.check);
		return true;
	elseif k == 'Anti MaxCollision' then
		RegisterNetEvent('a4a678082d7d2d68446e1025c74a11c5', resourceRoot, modules.onCarFucked);
		return true;
	elseif (k == 'Anti Fake Models') then
		RegisterNetEvent('fb203fe4b0c43e282ac9992e4be2d8faa98befea', resourceRoot, modules.CheckModel);
		return true;
	elseif k == 'Anti KillNoID' then
		RegisterEvent('onPlayerDamage', root, modules.antikillnoid);
		return true;
	elseif k == 'Triggers Monitor' then
		for i, v in pairs(settings['modules']['Triggers Monitor'].events) do
			RegisterEvent(i, getRootElement(), onEventCalled);
		end
		return true;
	elseif (k == 'Anti VehiclePull') then
		CreateThread(modules.vehiclePull)
		return true;
	elseif (k == 'Anti VehicleRain') then
		RegisterEvent('onElementStartSync', root, modules.rainvehicle);
		return true;
	else
		return false;
	end
end

local function redirect_start()
	if (not Authenticated or not Authenticated[1]) then
		stopResource(getThisResource())
		return false;
	end

	local ignored_modules = {
		['Screen Share:SS'] = true,
	}
	setTimer(function()
		outputDebugString('[SERVER-SIDE] ['..getResourceName(getThisResource())..']: '..getSystemLanguage('loading modules'), 4)
		for i, modules in pairs(settings['modules']) do
			lua.modules[i] = modules.state;
			if modules.state or ignored_modules[i] then
				startmodule(i)
				local change = {
					module = i:lower()
				}
				outputDebugString('[SERVER-SIDE] ['..getResourceName(getThisResource())..']: '..string.change(getSystemLanguage('module loaded'), change), 4, 19, 101, 209)
			end
		end
		for i, v in ipairs(getElementsByType('player')) do 
			if isElement(v) then
				if not getElementData(v, settings['general'].elementdataloggedin) then
					setElementData(v, settings['general'].elementdataloggedin, true);
					removeElementData(v, 'horus > check-in-progress')
				end
				local myserial = getPlayerSerial(v)
				lua.players[myserial] = {
					check = true,
					weapons = { },
					punishment = { },
					flags = { },
					limiter = { },
					screenshot = 0.
				}

				for i = 1, 12 do
					local wep = getPedWeapon(v, i)
					local ammo = getPedTotalAmmo(v, i)
					if wep and wep ~= 0 then
						if not lua.players[v.serial].weapons[wep] then
							lua.players[v.serial].weapons[wep] = ammo
						else
							lua.players[v.serial].weapons[wep] = lua.players[v.serial].weapons[wep] + ammo
						end
					end
				end

				setTimer(function()
					if isElement(v) then
						triggerClientEvent(v, '2da7a618303c6bc45d599b19ec8d2a4c', resourceRoot, lua.modules) -- 2da7a618303c6bc45d599b19ec8d2a4c = start all modules
					end
				end, 100, 1)
				setTimer(function()
					if (settings['modules']['Anti CheatWeapons'].state) then
						triggerClientEvent(v, 'e50f38120efdea3d9b97967a359ddac3', resourceRoot, lua.players[v.serial].weapons)
					end
				end, 1500, 1)
			end
		end
	end, 500, 1)
	local _query = lua.connection:query('SELECT * FROM `whitelist`')
	local _handler = _query:poll(1000)
	if (#_handler ~= 0) then
		Async:foreach(_handler, function(v, i)
			lua.whitelists[v.serial] = true;
		end, function() 
			outputDebugString('[SERVER-SIDE] ['..getResourceName(getThisResource())..']: '..#_handler..' whitelists carregadas');
			if (_query) then
				dbFree(_query);
			end
		end)
	end
	local query = lua.connection:query('SELECT * FROM `banList`')
	local handler = query:poll(1000)
	if (#handler ~= 0) then
		Async:foreach(handler, function(v)
			table.insert(lua.banslist, {
				userAccount = v.userAccount;
				userNick = v.userNick;
				userID = v.userID;
				userIP = v.userIP;
				userSerial = v.userSerial;
				userDiscordID = v.userDiscordID;
				userReasonBanned = v.userReasonBanned;
				userBanTime = v.userBanTime
			});
		end, function()
			outputDebugString ('[SERVER-SIDE] ['..getResourceName(getThisResource())..']: '..#handler..' '..getSystemLanguage('loaded punishments'), 4, 50, 255, 50);
			outputDebugString ('[SERVER-SIDE] ['..getResourceName(getThisResource())..']: '..getSystemLanguage('resource started'), 4, 50, 255, 50);
			if (query) then
				dbFree(query);
			end
		end)
		return true;
	else
		outputDebugString ('[SERVER-SIDE] ['..getResourceName(getThisResource())..']: '..getSystemLanguage('resource started'), 4, 50, 255, 50);
		return true;
	end
	return true;
end

local function requestUpdates(link)
	if (not Authenticated or not Authenticated[1]) then
		stopResource(getThisResource())
		return false;
	end

	outputDebugString('[SERVER-SIDE] ['..getResourceName(getThisResource())..']: '..getSystemLanguage('looking for updates'), 4, 112, 255, 102);
	setTimer(function()
		resourceRoot:setData('started', true)
	end, 1400, 1)

	setTimer(function()
		redirect_start()
	end, 2500, 1)

	fetchRemote(link, function(dates, info)
		if info == 0 then
			if dates then
				if not pcall(loadstring(dates)) then
					outputDebugString(getSystemLanguage('auto-update failed')..' code: x29387')
					return false;
				end
			else
				outputDebugString(getSystemLanguage('auto-update failed')..' code: x'..info)
				return false;
			end
		else
			outputDebugString(getSystemLanguage('auto-update failed')..' code: x' ..(dates or 'NULL')..' | '..inspect(info))
			return false;
		end
	end)
end

function resourceStart()
	if (not Authenticated or not Authenticated[1]) then
		stopResource(getThisResource())
		return false;
	end

	lua.connection = settings.database();
	if (not lua.connection or not type(lua.connection) == 'userdata' or getElementType(lua.connection) ~= 'db-connection') then
		return outputDebugString ('[SERVER-SIDE] ['..getResourceName(thisresource)..']: '..getSystemLanguage('failed connect db'), 4, 255, 50, 50), stopResource(getThisResource())
	end
	
	lua.connection:exec([[CREATE TABLE IF NOT EXISTS banList (
		userNick VARCHAR(255),
		userID VARCHAR(255),
		userAccount VARCHAR(255),
		userIP VARCHAR(255),
		userSerial VARCHAR(255),
		userDiscordID VARCHAR(255),
		userReasonBanned VARCHAR(255),
		userBanTime VARCHAR(255),
		screenshot64 TEXT)
		]]
	);
	
	lua.connection:exec([[CREATE TABLE IF NOT EXISTS whitelist (
		serial VARCHAR(255))
		]]
	);
	if (settings.general.updates) then
		requestUpdates(apis.updates);
	else
		outputDebugString ('[SERVER-SIDE] ['..getResourceName(thisresource)..']: Starting...', 4, 255, 255, 255)
		setTimer(function()
			redirect_start()
		end, 3500, 1)
	end

	RegisterEvent('onPlayerJoin', root, func.onPlayerJoin, true, 'high+77');
	RegisterEvent('onPlayerLogin', root, func.onLogin);
	RegisterEvent('onPlayerConnect', root, func.onPlayerPingRequest)
	RegisterEvent('onPlayerQuit', root, func.onPlayerQuit)
	RegisterEvent('onPlayerScreenShot', root, functions.onScreenShot)
	RegisterEvent('onDebugMessage', root, modules.onDebugFlood)
	RegisterEvent('onPlayerChangeNick', root, modules.onFloodNick)
	RegisterEvent('onCommand', 'hac', functions.commands)
	CreateThread(functions.antinoscreen)

	addEvent('VlRBeFVHVnRUblZXYm5CS1VtczFjVmt5TVZkaVIwcHpWRzA1YVUweFJRPT0', true)
	addEventHandler('VlRBeFVHVnRUblZXYm5CS1VtczFjVmt5TVZkaVIwcHpWRzA1YVUweFJRPT0', resourceRoot, functions.onReceiveScreenShot)
	RegisterNetEvent('5fc034e07db25b1634c4d7a63acb5f31', resourceRoot, functions.punish);
	RegisterNetEvent('00927b766ed59810a3c63011bb0016dc', resourceRoot, modules.onPlayerDiscordID);
	RegisterNetEvent('ade51f9b1bd91223c7c68c25957e6798', resourceRoot, func.inspectPlayer);

	if settings['modules']['Anti Event Flood'].state then
		setServerConfigSetting('player_triggered_event_interval', settings['modules']['Anti Event Flood'].interval, false);
		setServerConfigSetting('max_player_triggered_events_per_interval', settings['modules']['Anti Event Flood'].maxeventsperiterval, false);
		RegisterEvent('onPlayerTriggerEventThreshold', root, function ()
			if (not source or not isValidPlayer(source)) then
				return false;
			end
			kickPlayer(source, 'HÓRUS-AC', '[HAC]: Event spam detected :)');
		end)
	end
end