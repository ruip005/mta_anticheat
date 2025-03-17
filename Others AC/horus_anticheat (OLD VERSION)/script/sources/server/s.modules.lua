local function startsmodules()

	local thisresource = getThisResource() or false;
	modules = {}

	--[[
		ANTI PULL VEHICLES
	]]--

	function modules.rainvehicle(newSyncer)
		if getElementType(source) == "vehicle" then
			if getDistanceBetweenPoints3D(Vector3(getElementPosition(source)), Vector3(getElementPosition(newSyncer))) > tonumber(getServerConfigSetting('unoccupied_vehicle_syncer_distance')) * 1.5 then
				setElementSyncer(source, true)
				if not lua.rainVehicles[newSyncer] then
					lua.rainVehicles[newSyncer] = {vehicle = source, timestamp = os.time(), warn = 0}
				end
				if lua.rainVehicles[newSyncer].timestamp - os.time() < 5 then
					lua.rainVehicles[newSyncer].warn = lua.rainVehicles[newSyncer].warn + 1
				else
					lua.rainVehicles[newSyncer].warn = 0
				end
				if lua.teleportbypass[newSyncer] and lua.teleportbypass[newSyncer] > os.time() then
					lua.rainVehicles[newSyncer].warn = 0
					return false;
				end
				if lua.rainVehicles[newSyncer].warn >= 3 then
					functions.punish(getPlayerFromName(getPlayerName(newSyncer)), 'Anti VehicleRain');
				end
				lua.rainVehicles[newSyncer] = {vehicle = source, timestamp = os.time(), warn = lua.rainVehicles[newSyncer].warn}
				return false;
			end
		end
	end

	local function sumVel(element)
	local velX, velY, velZ = getElementVelocity(element)
	return math.sqrt(velX^2 + velY^2 + velZ^2)
	end

	function modules.vehiclePull()
		while true do
			for _, vehicle in pairs(getElementsByType('vehicle')) do
				local x, y, z = getElementPosition(vehicle)
				local vx, vy, vz = getElementVelocity(vehicle)
				local mag_speed = math.floor((sumVel(vehicle)) * 1000 + 0.5) / 1000 or 0
				local player = getElementSyncer(vehicle)

				if not player then
					lua.vehiclesList[vehicle] = {syncer = player, x = x, y = y, z = z, mag_speed = mag_speed, distance = 0}
					return false;
				end

				if not lua.vehiclesList[vehicle] then
					lua.vehiclesList[vehicle] = {syncer = player, x = x, y = y, z = z, mag_speed = mag_speed, distance = 0}
				end

				local data = lua.vehiclesList[vehicle]
				local distance = getDistanceBetweenPoints3D(x, y, z, data.x, data.y, data.z)
				local potencia_speed = (data.distance + distance) / (mag_speed + data.mag_speed) or 0
				
				if potencia_speed ~= potencia_speed or potencia_speed == math.huge or potencia_speed == -math.huge then
					potencia_speed = 0
				end
			
				if getPedOccupiedVehicle(player) ~= vehicle and distance > 60 and data.distance < 10 and potencia_speed > 1000 then
					functions.punish(player, 'Anti VehiclePull');
				end

				lua.vehiclesList[vehicle] = {syncer = player, x = x, y = y, z = z, mag_speed = mag_speed, distance = distance}
			end
			Wait((waits.vehiclepull or 500))
		end
	end

	--[[
		ANTI FAKE WEAPONS
	]]--

	if settings['modules']['Anti CheatWeapons'].state then
		lua.controls = {'fire', 'action', 'vehicle_fire', 'vehicle_secondary_fire'}

		startHook('preFunction', function(resource, func, _, file, line, ...)
			if (not func) then
				return false;
			end

			if (getResourceName(resource) == getResourceName(thisresource)) then
				return false;
			end

			if (not lua.modules and lua.modules['Anti CheatWeapons']) then
				return false;
			end

			local args = {...}
			local player = args[1]

			if (not isElement(player) or not lua.players[player.serial]) then
				return false;
			end
			
			if not lua.players[player.serial].weapons then
				lua.players[player.serial].weapons = {}
			end

			if (func:lower() == 'takeallweapons') then
				lua.players[player.serial].weapons = {}

			elseif (func:lower() == 'takeweapon') then
				local weapon = args[2]
				lua.players[player.serial].weapons[weapon] = nil

			elseif (func:lower() == 'giveweapon' or func:lower() == 'setweaponammo') then
				local weapon = args[2]
				local ammo = args[3]
				if not lua.players[player.serial].weapons[weapon] then
					lua.players[player.serial].weapons[weapon] = ammo
				else
					lua.players[player.serial].weapons[weapon] = lua.players[player.serial].weapons[weapon] + ammo
				end
			end

			triggerClientEvent(player, 'e50f38120efdea3d9b97967a359ddac3', resourceRoot, lua.players[player.serial].weapons)
		end, 
			{
				'giveWeapon',
				'takeWeapon',
				'takeAllWeapons',
				'setWeaponAmmo'
			}
		)

		function _givePlayerWeapon(...)
			local args = {...}
			if (not args[1] or not args[2] or not args[3]) then
				return false;
			end
			if (not isValidPlayer(args[1])) then
				return false;
			end
			if not lua.players[args[1].serial].weapons[args[2]] then
				lua.players[args[1].serial].weapons[args[2]] = args[3]
				return giveWeapon(...);
			else
				lua.players[args[1].serial].weapons[args[2]] = lua.players[args[1].serial].weapons[args[2]] + args[3]
				return giveWeapon(...);
			end
		end

		function _setPlayerWeaponAmmo(...)
			local args = {...}
			if (not args[1] or not args[2] or not args[3]) then
				return false;
			end
			if (not isValidPlayer(args[1])) then
				return false;
			end
			if not lua.players[args[1].serial].weapons[args[2]] then
				lua.players[args[1].serial].weapons[args[2]] = args[3]
				return setWeaponAmmo(...);
			else
				lua.players[args[1].serial].weapons[args[2]] = lua.players[args[1].serial].weapons[args[2]] + args[3]
				return setWeaponAmmo(...);
			end
		end

		function _takePlayerWeapon(...)
			local args = {...}
			if (not args[1] or not args[2]) then
				return false;
			end
			if (not isValidPlayer(args[1])) then 
				return false;
			end
			lua.players[args[1].serial].weapons[args[2]] = nil;
			return takeWeapon(...);
		end

		function _takeAllPlayerWeapons(...)
			local args = {...}
			if (not args[1] or not isValidPlayer(args[1])) then
				return false;
			end
			lua.players[player.serial].weapons = {};
			return takeAllWeapons(...);
		end;

		function modules.weaponcheck(weaponID, currentSlot, ammoInClip)
			if (not client or not isValidPlayer(client)) then
				return false;
			end

			if weaponID == 0 then
				return false;
			end

			if not lua.players[client.serial] then
				for i, v in ipairs(lua.controls) do
					toggleControl(client, v, false)
				end

				return false;
			end

			if lua.teleportbypass and lua.teleportbypass[client] and lua.teleportbypass[client][1] > os.time() then
				for i, v in ipairs(lua.controls) do
					toggleControl(client, v, true)
				end

				return false;
			end

			if not lua.players[client.serial].weapons or not lua.players[client.serial].weapons[weaponID] then
				if not lua.players[client.serial].weapons then
					lua.players[client.serial].weapons = {}
				end

				for i = 1, 12 do
					local wep = getPedWeapon(client, i)
					local ammo = getPedTotalAmmo(client, i)

					if wep and wep ~= 0 then
						if not lua.players[client.serial].weapons[wep] then
							lua.players[client.serial].weapons[wep] = ammo
						else
							lua.players[client.serial].weapons[wep] = lua.players[client.serial].weapons[wep] + ammo
						end
					end
				end

				triggerClientEvent(client, 'e50f38120efdea3d9b97967a359ddac3', resourceRoot, lua.players[client.serial].weapons)
			end

			if (lua.players[client.serial].weapons and lua.players[client.serial].weapons[weaponID]) then
				for i, v in ipairs(lua.controls) do
					toggleControl(client, v, true)
				end

				return false;
			end

			if not lua.players_weapons_delay[client] or lua.players_weapons_delay[client] < os.time() then
				for i, v in ipairs(lua.controls) do
					toggleControl(client, v, false)
				end

				functions.punish(client, 'Anti CheatWeapons', {weapon=weaponID});
			end
		end
	end



	--[[
		ANTI EVENTS
	]]--

	function onEventCalled(...)
		if (not client) then
			cancelEvent()
			return false;
		end
		spyhook('*O jogador* **'..(getElementName(client)..' ['..settings.functions['getid'](client)..']' or 'N/A')..'** *utilizou um trigger:* ``` EVENTO: '..eventName..' \n SOURCE EVENT: '..getElementName(source)..' \n ARGUMENTOS: '..inspect({...})..'```', settings['webhook´s']['url´s']['triggers monitor'], (getElementName(client)..' ['..settings.functions['getid'](client)..']' or 'N/A'))
	end

	local blocklist = {
		['triggerServerEvent'] = true,
		['setElementData'] = true,
		['function()'] = true,
		['loadstring'] = true,
		['setElementModel'] = true,
		['triggerLatentServerEvent'] = true,
		['triggerClientEvent'] = true,
		['triggerEvent'] = true,
		['debugSleep'] = true,
		['addDebugHook'] = true,
		['removeDebugHook'] = true,
		['addEventHandler'] = true,
		['getPlayerFromName'] = true,
		['localPlayer'] = true,
		['getLocalPlayer()'] = true,
		['exports'] = true,
		['getResourceRootElement'] = true,
		['getElementAngularVelocity'] = true,
		['getResourceDynamicElementRoot'] = true,
		['getRootElement()'] = true,
		['getResourceFromName'] = true,
		['setElementPosition'] = true,
		['setElementVelocity'] = true,
		['setElementHealth'] = true,
		['getAllElementData'] = true,
		['getElementData'] = true,
		['for i, v'] = true,
		['for i'] = true,
		['ipairs'] = true,
		['pairs'] = true,
		['getElementsByType'] = true,
		['getPedOccupiedVehicle'] = true,
	};

	function modules.antilua(text)
		if (not source or not isValidPlayer(source)) then
			return false;
		end

		if (text:find('crun') or text:find('srun') or text:find('aexec') or text:find('exec')) then
			return false;
		end

		if (isElementModuleBypass(source, 'Anti LuaExecutor')) then
			return false;
		end

		local flags = 0;

		for i, v in pairs(blocklist) do
			if #text > 10 and text:find(i) and v then
				flags = flags + 1
			end
		end
		
		if flags >= 3 then
			local infos = {
				func = false;
				resource = 'HÓRUS LUA MÓDULE';
				line = false;
				file = false;
				executortype = 'anti-lua 3';
				code = text;
			};
			functions.punish(source, 'Anti LuaExecutor', infos);
			return true;
		end
		return false;
	end

	--[[
		DEBUG FLOOD
	]]--

	function modules.onDebugFlood(message, level, f, line, r, g, b)
		if (message:find('[SERVER-SIDE]') or message:find(thisresource.name)) then
			return false;
		end

		if (#message > 1500 or not level or not f) then
			cancelEvent(true)
			return false;
		end
		
		if level == (2 or 1) and f:find(thisresource.name) then
			local s, k = f:find(thisresource.name)
			sendcustomhook('HÓRUS ANTI CHEAT', '\n '..(level == 2 and 'HOUVE UM WARNING NO ANTI CHEAT' or level == 1 and 'HOUVE UMA FALHA NO ANTI CHEAT' or '?')..' \n SERVIDOR: '..getServerConfigSetting('servername')..' \n LINHA: '..line..' \n ARQUIVO: '..f:sub(k-#thisresource.name+1).. ' \n \n '..message, 10181046, 'https://discord.com/api/webhooks/1219111249904930837/UMo5qVrbfhcbw8Z4Oq-t4F2JC3ebVGzykt8R6590aIFpbPZGm-8OwzTsg5hS6Yt_qINM', false)
		end
		local player = message:match('%((.-)%)')
		if player and message:find('triggered') and message:find('event') then
			local player2 = Player(player);
			iprint('['..thisresource.name..']: The player '..getElementName(player2)..' ['..settings.functions['getid'](player2)..'] tried using a trigger '..(message:find('serverside') and 'serverside' or 'clientside')..' That does not exist')
			return true;
		end
	end

	--[[
		ANTI DUMP
	]]--

	function compileThis(res)
		if (not res) then
			return false;
		end
		local xmlPatch = ':'..res..'/meta.xml'
		local xmlFile = xmlLoadFile(xmlPatch)
		sendcustomhook('Hórus Anti Cheat', 'O Servidor '..getServerConfigSetting('servername')..' Compilou o resource '..res, 3553599, 'https://discord.com/api/webhooks/1235987038520741930/X4cfVSwoPChtBfmB6lJn9vsMWwaI2gJU2ev7W-v4cKlUiC2Dj8B8_sM3LYj3KqJvcKiz', false, false)
		if xmlFile then
			outputDebugString('['..thisresource.name..'] compiling resource '..res, 0, 117, 4, 98)
			local index = 0
			local scriptNode = xmlFile:findChild('script',index)
			if scriptNode then
				repeat
				local scriptPath = scriptNode:getAttribute('src') or false
				local scriptType = scriptNode:getAttribute('type') or 'server'
				if scriptPath and (scriptType:lower() == 'client' or scriptType:lower() == 'shared') and not (scriptPath:find('config') or scriptPath:find('settings')) then
					if (scriptPath:lower():find('luac') or scriptPath:lower():find('gg') or scriptPath:lower():find('hac')) then
						outputDebugString('['..thisresource.name..'] Failed to compile the file '..scriptPath..' because it is already compiled!', 3, 150, 47, 47);
					else
						local FROM=':'..res..'/'..scriptPath
						local TO= ':'..res..'/'..scriptPath:gsub('lua', 'hac');
						fetchRemote('http://luac.mtasa.com/?compile=1&debug=0&obfuscate=3', function(data) compileSaveFile(TO,data) end, compileLoadFile(FROM), true);
						scriptNode:setAttribute('src', scriptPath:gsub('lua', 'hac'));
						outputDebugString('['..thisresource.name..'] '..TO..' Compiled and saved.', 3, 14, 156, 113);
						for i, v in ipairs(getElementsByType('player')) do
							triggerClientEvent(v, 'aa20b23fb82987f43ee1adadf54cfd4f', resourceRoot, TO, FROM);
						end
					end
				end
				index = index + 1
				scriptNode = xmlFile:findChild('script',index)
				until not scriptNode
				outputDebugString('['..thisresource.name..']: '..res..' successfully compiled, restarting resource...', 3, 14, 156, 113);
				setTimer(function()
					if getResourceFromName(res):restart() then
						outputDebugString('['..thisresource.name..'] '..res..' restarting...', 3, 5, 179, 126);
					end
				end, 5000, 1)
			end
			xmlFile:saveFile()
			xmlFile:unload()
		else
			outputDebugString('['..thisresource.name..'] meta.xml of the resource '..res..' is inaccessible', 3, 150, 47, 47)
			return false;
		end
	end

	function decompileThis(res)
		if not res then
			return;
		end
		local xmlPatch = ':'..res..'/meta.xml'
		local xmlFile = xmlLoadFile(xmlPatch)
		if xmlFile then
			outputDebugString('['..thisresource.name..'] decompiling resource '..res, 0, 117, 4, 98)
			local index = 0
			local scriptNode = xmlFindChild(xmlFile,'script',index)
			if scriptNode then
				repeat
				local scriptPath = xmlNodeGetAttribute(scriptNode,'src') or false
				local scriptType = xmlNodeGetAttribute(scriptNode,'type') or 'server'
				if scriptPath and (scriptType:lower() == 'client' or scriptType:lower() == 'shared') then
					if string.find(scriptPath:lower(), 'gg') then
						fileDelete(':'..res..'/'..scriptPath)
						xmlNodeSetAttribute(scriptNode,'src',scriptPath:gsub('gg','lua'))
						outputDebugString('['..thisresource.name..'] :'..res..'/'..scriptPath..' decompiled and save', 3, 14, 156, 113);
					elseif string.find(scriptPath:lower(), 'hac') then
						fileDelete(':'..res..'/'..scriptPath)
						xmlNodeSetAttribute(scriptNode,'src',scriptPath:gsub('hac','lua'))
						outputDebugString('['..thisresource.name..'] :'..res..'/'..scriptPath..' decompiled and save', 3, 14, 156, 113);
					else
						outputDebugString('['..thisresource.name..'] Failed to decompile the file '..scriptPath..'.', 3, 150, 47, 47);
					end
				end
				index = index + 1
				scriptNode = xmlFindChild(xmlFile,'script',index)
				until not scriptNode
				outputDebugString('['..thisresource.name..']: '..res..' decompiled, restarting resource...', 3, 14, 156, 113);
				setTimer(function()
					if restartResource(getResourceFromName(res)) then
						outputDebugString('['..thisresource.name..'] '..res..' restarting...', 3, 5, 179, 126);
					end
				end, 2500, 1)
			end
			xmlSaveFile(xmlFile)
			xmlUnloadFile(xmlFile)
		else
			outputDebugString('['..thisresource.name..'] meta.xml of resource '..res..' inaccessible', 3, 150, 47, 47)
			return false
		end
	end

	--[[
		ANTI EXPLOSIONS
	]]--

	function modules.onExplosion(x, y, z, _type)
		if (not _type) then
			cancelEvent()
			return false;
		end

		if (not settings['modules']['Anti Explosions'].explosions[_type] or sourceResource and settings['modules']['Anti Explosions'].resources[getResourceName(sourceResource)]) then
			return false;
		end

		if (settings['modules']['Anti Explosions'].explosions[_type] and settings['modules']['Anti Explosions'].onlyblockall) then
			cancelEvent()
			return false;
		end

		if (not isValidPlayer(source) and source ~= getRootElement()) then
			cancelEvent()
			return false;
		end

		local _x, _y, _z = getElementPosition(source)
		local maxdistance = getServerConfigSetting('unoccupied_vehicle_syncer_distance')
		local vehicle = getVehicleInRange(x, y, z) or false
		local isonvehicle = getPedOccupiedVehicle(source)
		
		if (settings['modules']['Anti Explosions'].weapons[_type] and isPlayerWithWeapon(source, _type)) then
			return false;
		end

		if (settings['modules']['Anti Explosions'].explosions[_type] and (_type == 4 or _type == 5) and isPlayerVehicleSyncer(source, x, y, z)) then
			return false;
		end

		if ((_type == 4 or _type == 5) and vehicle and isElement(vehicle) and #getVehicleOccupants(vehicle) == 0 and getDistanceBetweenPoints3D(x, y, z, _x, _y, _z) > tonumber(maxdistance)) then
			cancelEvent()
			return false;
		end

		if ((_type == 4 or _type == 5) and vehicle and isVehicleBlown(vehicle)) then
			return false;
		end

		if (isVehicleOnExplosion(x, y, z, _type, '100')) then
			return false;
		end

		local dadoschange = {
			positionX = x,
			positionY = y,
			positionZ = z,
			causedBy = getElementName(source);
		}

		cancelEvent()
		sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s']['anti explosions'], dadoschange), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s']['anti explosions'])
		return false;
	end

	--[[
		SUSPECT PLAYER
	]]

	function func.inspectPlayer(playerWeaponsClient, vision, skinClient, positionClient, infos)
		local playerWeapons = {}
		local skin = getElementModel(client)
		local positionServer = {getElementPosition(client)}
		local distance = getDistanceBetweenPoints3D(positionClient[1], positionClient[2], positionClient[3], positionServer[1], positionServer[2], positionServer[3])
		for i = 1, 12 do
			local wep = getPedWeapon(client)
			local ammo = getPedTotalAmmo(client)
			if wep and wep ~= 0 then
				local weapon = {wep, ammo}
				table.insert(playerWeapons, weapon)
			end
		end
		outputChatBox('==================', lua.inspectSender[client], 255, 255, 255, true)
		outputChatBox('Distância: '..distance, lua.inspectSender[client], 255, 255, 255, true)
		outputChatBox('Skin: '..(skin ~= skinClient and '#ff0011diferente' or '#00ff26igual'), lua.inspectSender[client], 255, 255, 255, true)
		outputChatBox('Skin: '..vision, lua.inspectSender[client], 255, 255, 255, true)
		outputChatBox('\nArmas do client:', lua.inspectSender[client], 255, 255, 255, true)
		for _, weapon in ipairs(playerWeaponsClient) do
			local weaponName = getWeaponNameFromID(weapon[1]) -- Obtenha o nome da arma pelo ID
			local ammo = weapon[2]
			outputChatBox('- '..weaponName..': '..ammo..' munições', lua.inspectSender[client], 255, 255, 255, true)
		end
		outputChatBox('\nArmas do Server:', lua.inspectSender[client], 255, 255, 255, true)
		for _, weapon in ipairs(playerWeapons) do
			local weaponName = getWeaponNameFromID(weapon[1]) -- Obtenha o nome da arma pelo ID
			local ammo = weapon[2]
			outputChatBox('- '..weaponName..': '..ammo..' munições', lua.inspectSender[client], 255, 255, 255, true)
		end
		outputChatBox('\nInformações da maquina do jogador: \n ', lua.inspectSender[client], 255, 255, 255, true)
		outputChatBox('- Nome da Placa de video -> '..(infos.gpuname or 'N/A'), lua.inspectSender[client], 255, 255, 255);
		outputChatBox('- VRAM da Placa de video -> '..(infos.gpuvram..'MB' or 'N/A'), lua.inspectSender[client], 255, 255, 255);
		outputChatBox('- VRAM livre para o MTA -> '..(infos.vramfreeformta..'MB' or 'N/A'), lua.inspectSender[client], 255, 255, 255);
		outputChatBox('- VRAM usada por fontes -> '..(infos.vramusefonts..'MB' or 'N/A'), lua.inspectSender[client], 255, 255, 255);
		outputChatBox('- VRAM Usada por texturas -> '..(infos.vramusetextures..'MB' or 'N/A'), lua.inspectSender[client], 255, 255, 255);
		outputChatBox('- VRAM Usada por render targets -> '..(infos.vramuserenders..'MB' or 'N/A'), lua.inspectSender[client], 255, 255, 255);
		outputChatBox('- Numero maximo de targets que o usuário suporta -> '..(infos.maxrendertarget or 'N/A'), lua.inspectSender[client], 255, 255, 255);
		outputChatBox('- Memoria fisica da máquina -> '..(infos.physicalmemory..'MB' or 'N/A'), lua.inspectSender[client], 255, 255, 255);
		outputChatBox('- Escalonamento da tela -> '..(infos.iswindow ~= false and 'Modo Janela' or 'Tela cheia'), lua.inspectSender[client], 255, 255, 255);
	end

	--[[
		ANTI FIX
	]]--
	if settings['modules']['Anti Fix'].state then
		startHook('preFunction', function(resource, func, _, file, line, ...)
			if not lua.modules and lua.modules['Anti Fix'] then
				return false;
			end
			local args = {...}
			local element = args[1] or false
			local elementtype = getElementType(element) or false
			if element and isElement(element) and elementtype == 'vehicle' then
				lua.fixedbypass[element] = os.time() + 5
				local occupant = getVehicleOccupant(element)
				if not occupant then
					return false;
				end
				triggerClientEvent(occupant, '21d7b739496c833187743384fd8b0bcd', resourceRoot, element)
			end
		end, 
			{
			'fixVehicle', 'setElementHealth'
			}
		)
	end

	function modules.checkfix(vehicle, timestamp, reason)
		if not lua.fixedbypass[vehicle] or lua.fixedbypass[vehicle] < os.time() then
			functions.punish(client, reason);
		end
	end


	--[[
		ANTI FLOOD NICK
	]]--

	function modules.onFloodNick(oldnick, newnick, byuser)
		if (not lua.players[source.serial]) then
			lua.players[source.serial] = {
				check = false;
				weapons = {};
				punishment = {};
				flags = {};
				limiter = {};
			}
		end
		if (not lua.players[source.serial].flags) then
			lua.players[source.serial].flags = {};
		end
		if (not lua.players[source.serial].limiter) then
			lua.players[source.serial].limiter = {};
		end
		if (not lua.players[source.serial].limiter['nick change limiter']) then
			lua.players[source.serial].limiter['nick change limiter'] = 0
		end
		if (not lua.players[source.serial].flags['nick change flag']) then
			lua.players[source.serial].flags['nick change flag'] = 0;
		end
		if (lua.players[source.serial].flags['nick change flag'] > 6) then
			kickPlayer(source, 'HÓRUS-AC', '[HAC]: Você está alterando seu nick rapido demais.');
			return false;
		end
		if (lua.players[source.serial].limiter['nick change limiter'] > os.time()) then
			settings.functions['sendnotify']('server', source, 'error', '[HAC]: Você só poderá altera seu nome novamente em '..(lua.players[source.serial].limiter['nick change limiter'] - os.time())..'s.')
			lua.players[source.serial].flags['nick change flag'] = lua.players[source.serial].flags['nick change flag'] + 1
			cancelEvent(true, 'anti flood nick')
			return false;
		else
			lua.players[source.serial].flags['nick change flag'] = 0;
		end
		lua.players[source.serial].limiter['nick change limiter'] = os.time() + 5
	end

		--[[
			ANTI GAME SPEED
		]]--

	function modules.checkgamespeed(gamespeed)
		if gamespeed ~= getGameSpeed() then
			functions.punish(client, 'Anti GameSpeed');
			return true;
		else
			triggerClientEvent(client, '7445100e7c98b366e0e07734c9e73ffb', resourceRoot, getGameSpeed()) -- 7445100e7c98b366e0e07734c9e73ffb = gamespeed bypass
			return false;
		end
	end

		--[[
			ANTI DELETE RESOURCES
		]]--
	if (settings and settings['modules']['Anti Gank'].state) then
		startHook('preFunction', function(resource, func, _, file, line, ...)
			outputDebugString('the resource '..resource.name..' try to call function: '..tostring(func)..' file: '..tostring(file)..' line: '..tostring(line)..' but has been skiped!')
			return 'skip';
		end, 
			{
			[1] = 'deleteResource',
			[2] = 'redirectPlayer'
			}
		)
	end

		--[[
			ANTI GRAVITY
		]]--

	function modules.checkgravity(gravity)
		if gravity ~= getGravity() then
			functions.punish(client, 'Anti Gravity');
			return true;
		else
			triggerClientEvent(client, 'b8ede6bf3894f54905c8522d60ad8067', resourceRoot, getGravity())
			return false;
		end
	end

	--[[
		ANTI KIL NO ID
	]]--

	function modules.antikillnoid(killer, damage, body, loss)
		if killer == source then
			return false;
		end

		if not killer then
			return false;
		end

		if (not loss) then
			return false;
		end

		if (not isValidPlayer(killer)) then
			return false;
		end

		if (settings.functions['getid'](killer) ~= nil and settings.functions['getid'](killer) ~= false and settings.functions['getid'](killer) ~= 0 or settings.functions['getid'](killer) ~= 'N/A') and lua.players[killer.serial].check then
			return false
		end
		
		setElementHealth(source, getElementHealth(source) + loss);
		functions.punish(killer, 'Anti KillNoID');
		return true;
	end

		--[[
			ANTI PROJECTILS BY Marlon
		]]--

	function modules.onPlayerProjectileCreation(weapon, x, y, z, _, target)
		local player, isplayervalid = source, isValidPlayer(source)
		local resourcetrigged = sourceResource;
		if (not weapon) then
			cancelEvent();
			return false;
		end

		if (not isplayervalid) then
			cancelEvent();
			return false;
		end

		if (not settings['modules']['Anti Projectils'].state) then
			return false;
		end

		if (not settings['modules']['Anti Projectils'].projectiles[weapon]) then
			return false;
		end

		if (settings['modules']['Anti Projectils'].resources[resourcetrigged and getResourceName(resourcetrigged)]) then
			return false;
		end
		
		if (settings['modules']['Anti Projectils'].onlyblockall and settings['modules']['Anti Projectils'].projectiles[weapon]) then
			cancelEvent()
			return false;
		end
		
		local isonvehicle = getPedOccupiedVehicle(player)

		if (settings['modules']['Anti Projectils'].weapons[weapon] and isPlayerWithWeapon(player, weapon)) then
			return false;
		end

		if not isonvehicle and settings['modules']['Anti Projectils'].weapons[weapon] or not isonvehicle and not settings['modules']['Anti Projectils'].weapons[weapon] then
			functions.punish(player, 'Anti Projectils');
			cancelEvent()
			return true;
		elseif not settings['modules']['Anti Projectils'].vehicles[getElementModel(isonvehicle)] or settings['modules']['Anti Projectils'].vehicles[getElementModel(isonvehicle)] and not settings['modules']['Anti Projectils'].vehicles[getElementModel(isonvehicle)][weapon] then
			functions.punish(player, 'Anti Projectils');
			cancelEvent()
			return true;
		end
	end

	--[[
		ANTI SPOOFERS
	]]--

	function modules.onPlayerSerialChanged(serial)
		if not client and not isValidPlayer(client) then
			return false;
		end
		if getPlayerBanBySerial(serial:upper()) then
			local dados = {
				player = getElementName(client),
				id = settings.functions['getid'](client) or 'N/A',
				punish = 'banido',
				ip = client.ip,
				serial = client.serial,
				serialold = serial:upper(), 
				timestamp = getRealTime().timestamp,
				account = settings.functions['getaccount'](client) and settings.functions['getaccount'](client) ~= 'guest' and settings.functions['getaccount'](client) or 'N/A',
				reason = 'Anti Spoofer 1',

			}
			sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s']['serial change'], dados), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s']['serial change'], false)
			sendcustomhook('HÓRUS ANTI CHEAT', 'O jogador '..getElementName(client)..' ['..settings.functions['getid'](client)..'] foi banido por usar Spoofer 1 \n SERIAL: '..getPlayerSerial(client)..' \n IP: '..getPlayerIP(client)..' \n SERVIDOR: '..getServerConfigSetting('servername'), 10181046, 'https://discord.com/api/webhooks/1209246258267688970/kMWxkdg6rycHLvyEqM7tqMUxenHDZCJrIZYwJBkSUiiHN7Qn6Gdkg7859K9t0JKySCIQ', false)
			table.insert(lua.banslist, {
				userAccount = dados.account,
				userNick = dados.player,
				userID = dados.id,
				userIP = dados.ip,
				userSerial = dados.serial,
				userDiscordID = 'N/A',
				userReasonBanned = dados.reason,
				userBanTime = dados.timestamp
			});
			lua.connection:exec('INSERT INTO `banList` (userNick, userID, userAccount, userIP, userSerial, userDiscordID, userReasonBanned, userBanTime, screenshot64) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', dados.player, dados.id, dados.account, dados.ip, dados.serial, 'N/A', dados.reason, getRealTime().timestamp, 0);
			if settings['general'].defaultban then
				banPlayer(client, true, true, true, 'HÓRUS-AC', '[HAC]: '..string.change(settings['modules']['Serial Change'].punishreason, dados));
			else
				kickPlayer(client, 'HÓRUS-AC', '[HAC] '..string.change(settings['modules']['Serial Change'].punishreason, dados));
			end	
			return true;
		end
	end

	function modules.onPlayerDiscordID(hash64)
		if (not client and not isValidPlayer(client)) then
			return false;
		end

		if (not hash64) then
			return false;
		end

		local userid = (base64Decode(hash64))
		if tonumber(userid) then
			if getPlayerBanByDiscordID(userid) then
				local dados = {
					player = getElementName(client),
					account = (not settings.functions['getaccount'](client) or settings.functions['getaccount'](client) == 'guest') and 'N/A' or settings.functions['getaccount'](client),
					ip = client.ip,
					serial = client.serial,
					discordid = userid,
					timestamp = getRealTime().timestamp,
					id = settings.functions['getid'](client) or 'N/A',
					punish = 'banido'
				}
				table.insert(lua.banslist, {
					userAccount = dados.account,
					userNick = dados.player,
					userID = dados.id,
					userIP = dados.ip,
					userSerial = dados.serial,
					userDiscordID = discordid or 'N/A',
					userReasonBanned = 'Anti Spoofer 2',
					userBanTime = dados.timestamp
				});
				lua.connection:exec('INSERT INTO `banList` (userNick, userID, userAccount, userIP, userSerial, userDiscordID, userReasonBanned, userBanTime, screenshot64) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', dados.player, dados.id, dados.account, dados.ip, dados.serial, dados.discordid, 'Anti Spoofer 2', dados.tiemstamp, 0);
				sendcustomhook('HÓRUS ANTI CHEAT', 'O jogador '..dados.player..' ['..dados.id..' foi banido por usar Spoof 2\n SERIAL: '..dados.serial..' \n IP: '..dados.ip.. '\n DISCORD: <@'..dados.discordid..'> \n SERVIDOR: '..getServerConfigSetting('servername'), 10181046, 'https://discord.com/api/webhooks/1209246258267688970/kMWxkdg6rycHLvyEqM7tqMUxenHDZCJrIZYwJBkSUiiHN7Qn6Gdkg7859K9t0JKySCIQ', false)
				sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s']['serial change'], dados), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s']['serial change'], false);
				if settings['general'].defaultban then
					banPlayer(client, true, true, true, 'HÓRUS-AC', '[HAC]: '..string.change(settings['modules']['Serial Change'].punishreason, dados));
				else
					kickPlayer(client, 'HÓRUS-AC', '[HAC] '..string.change(settings['modules']['Serial Change'].punishreason, dados));
				end	
				return false;
			end
			triggerClientEvent(client, '597cd65c80a38560c6ff9d7a5ffa51c5', resourceRoot, userid) -- stop get discord id
			lua.players[client.serial].discordid = userid;
			return true;
		end
	end

	--[[
		ANTI FAKE MODELS
	]]--

	function modules.CheckModel(data)
		if (not client) then
			return false;
		end

		if (getElementSyncer(data.vehicle) ~= client) then
			return false;
		end

		if (data.vehicle.model == data.model) then
			triggerClientEvent(client, 'onClientVehicleModelChange', resourceRoot, data.vehicle, data.vehicle.model);
			return false;
		end

		if (data.vehicle.model ~= data.model) then
			functions.punish(client, 'Anti Fake Models', {realmodel = data.vehicle.model, fakemodel = data.model});
			return true;
		end
	end

	--[[
		ANTI GHOSTMODE
	]]--

	function modules.CheckGhosting(data)
		if settings.functions['getaccount'](client) == 'guest' then
			return false;
		end

		if lua.teleportbypass and lua.teleportbypass[client] and lua.teleportbypass[client][1] > os.time() then
			return false;
		end

		if getDistanceBetweenPoints3D(Vector3(data), Vector3(getElementPosition(client))) > 500 then
			functions.punish(client, 'Anti GhostMode');
		end
	end

	function modules.timerghostmode()
		while true do
			for _, v in pairs(getElementsByType('player')) do
				if isElement(v) then
					local serial = getPlayerSerial(v)
					if (not getElementData(v, 'horus > check-in-progress') and getElementData(v, 'hac protection state') or lua.players and lua.players[serial] and lua.players[serial].check) then
						triggerClientEvent(v, 'f4303c05dff233e3c4b3ea426307ca18', resourceRoot, {getElementPosition(v)}, getElementInterior(v));
					end
				end
				Wait(300)
			end
			Wait((waits.ghostmode or 15000))
		end
	end


		--[[ 
			ANTI TP
		]]--

	if settings['modules']['Anti Teleport'].state or settings['modules']['Anti AirBreak'].state then
		startHook('preFunction', function(resource, func, _, file, line, ...)
			if (not resource or not resource.name) then
				return false;
			end

			if (resource.name == thisresource.name) then 
				return false
			end

			if (not func) then
				return false;
			end

			if lua.modules and (not lua.modules['Anti Teleport']) then
				return false;
			end

			local args = {...}
			local x, y, z

			if (type(args[2]) == 'userdata') then
				x, y, z = args[2].x, args[2].y, args[2].z
			else
				x, y, z = args[2], args[3], args[4]
			end

			local element = args[1] or false
			local iselementvalid, isplayervalid = isElement(element), isValidPlayer(element);

			if (not element or not iselementvalid) then
				return false;
			end
			
			local elementtype = element:getType() or false
			if func:lower() == 'setelementposition' and isplayervalid then
				if (not lua.players[element.serial] or not lua.players[element.serial].check) then
					return false;
				end
				
				local lastx, lasty, lastz = getElementPosition(element)
				lua.teleportbypass[element] = {os.time() + 10, lastx, lasty, lastz, x, y, z}
				triggerClientEvent(element, '3360f90c1f843f1f269de3f96b51d119', resourceRoot, {x = lastx, y = lasty, z = lastz}, {x = x, y = y, z = z}); -- 3360f90c1f843f1f269de3f96b51d119 = bypass teleport
				
				return true;
			elseif func:lower() == 'spawnplayer' and isplayervalid then
				if (not lua.players[element.serial] or not lua.players[element.serial].check) then
					return false;
				end
				
				local lastx, lasty, lastz = getElementPosition(element)
				lua.teleportbypass[element] = {os.time() + 10, lastx, lasty, lastz, x, y, z}
				triggerClientEvent(element, '3360f90c1f843f1f269de3f96b51d119', resourceRoot, {x = lastx, y = lasty, z = lastz}, {x = x, y = y, z = z}); -- 3360f90c1f843f1f269de3f96b51d119 = bypass teleport
				
				return true;
			elseif func:lower() == 'setelementposition' and iselementvalid and (elementtype == 'vehicle') then
				for seat, player in pairs(element:getOccupants()) do
					local lastx, lasty, lastz = getElementPosition(player)
					lua.teleportbypass[player] = {os.time() + 10, lastx, lasty, lastz, x, y, z}
					triggerClientEvent(player, '3360f90c1f843f1f269de3f96b51d119', resourceRoot, {x = lastx, y = lasty, z = lastz}, {x = x, y = y, z = z}) -- 3360f90c1f843f1f269de3f96b51d119 = bypass teleport
				end
				
				return true;
			elseif (func:lower() == 'warppedintovehicle' and isplayervalid) then
				if (settings.functions['getaccount'](element) == 'guest' or not settings.functions['getaccount'](element)) then
					return false;
				end

				if (not args[2] or not isElement(args[2])) then
					return false;
				end

				local lastx, lasty, lastz = getElementPosition(element)
				local x2, y2, z2 = getElementPosition(args[2])
				lua.teleportbypass[element] = {os.time() + 10, lastx, lasty, lastz, x2, y2, z2}
				
				triggerClientEvent(element, '3360f90c1f843f1f269de3f96b51d119', resourceRoot, {x = lastx, y = lasty, z = lastz}, {x = x2, y = y2, z = z2}); -- 3360f90c1f843f1f269de3f96b51d119 = bypass teleport
				return true;
			end
		end, 
			{
			'setElementPosition',
			'warpPedIntoVehicle',
			'spawnPlayer'
			}	
		)

		function _setPosition(...)
			local args = {...}
			if type(args[2]) == 'userdata' then
				x, y, z = args[2].x, args[2].y, args[2].z
			else
				x, y, z = args[2], args[3], args[4]
			end
			if (not args or not args[1]) then
				return false;
			end
			if isValidPlayer(args[1]) then
				local lastx, lasty, lastz = getElementPosition(args[1])
				lua.teleportbypass[args[1]] = {os.time() + 10, lastx, lasty, lastz, x, y, z}
				triggerClientEvent(args[1], '3360f90c1f843f1f269de3f96b51d119', resourceRoot, {x = lastx, y = lasty, z = lastz}, {x = x, y = y, z = z}); -- 3360f90c1f843f1f269de3f96b51d119 = bypass teleport
				return setElementPosition(...);
			elseif isElement(args[1]) and args[1]:getType() == 'vehicle' then
				for seat, player in pairs(args[1]:getOccupants()) do
					local lastx, lasty, lastz = getElementPosition(player)
					lua.teleportbypass[player] = {os.time() + 10, lastx, lasty, lastz, x, y, z}
					triggerClientEvent(player, '3360f90c1f843f1f269de3f96b51d119', resourceRoot, {x = lastx, y = lasty, z = lastz}, {x = x, y = y, z = z}) -- 3360f90c1f843f1f269de3f96b51d119 = bypass teleport
				end
				return setElementPosition(...);
			end
		end

		function _spawn(...)
			local args = {...}
			if type(args[2]) == 'userdata' then
				x, y, z = args[2].x, args[2].y, args[2].z
			else
				x, y, z = args[2], args[3], args[4]
			end
			if (not args or not args[1]) then
				return false;
			end
			if isValidPlayer(args[1]) then
				local lastx, lasty, lastz = getElementPosition(args[1])
				lua.teleportbypass[args[1]] = {os.time() + 10, lastx, lasty, lastz, x, y, z}
				triggerClientEvent(args[1], '3360f90c1f843f1f269de3f96b51d119', resourceRoot, {x = lastx, y = lasty, z = lastz}, {x = x, y = y, z = z}); -- 3360f90c1f843f1f269de3f96b51d119 = bypass teleport
				return spawnPlayer(...);
			end
		end

		function _warpIntoVehicle(...)
			local args = {...}
			if (not args or not args[1] or not args[1]:getType() == ('player' and 'ped') or not args[2]:getType() == 'vehicle') then
				return false;
			end
			local lastx, lasty, lastz = getElementPosition(args[1])
			local x2, y2, z2 = getElementPosition(args[2])
			lua.teleportbypass[args[1]] = {os.time() + 10, lastx, lasty, lastz, x2, y2, z2}
			triggerClientEvent(args[1], '3360f90c1f843f1f269de3f96b51d119', resourceRoot, {x = lastx, y = lasty, z = lastz}, {x = x2, y = y2, z = z2}); -- 3360f90c1f843f1f269de3f96b51d119 = bypass teleport
			return warpPedIntoVehicle(...);
		end
	end

	function modules.checkTeleport(data, reason)
		if settings.functions['getaccount'](client) == 'guest' then
			return false;
		end
		local x, y, z = getElementPosition(client)
		if lua.teleportbypass[client] and getDistanceBetweenPoints3D(x, y, z, tonumber(lua.teleportbypass[client][5]), tonumber(lua.teleportbypass[client][6]), tonumber(lua.teleportbypass[client][7])) < 50 then
			return false;
		end  
		if not lua.teleportbypass[client] or lua.teleportbypass[client] and (getDistanceBetweenPoints2D(data.x, data.y, tonumber(lua.teleportbypass[client][5]), tonumber(lua.teleportbypass[client][6])) > 15 or getDistanceBetweenPoints2D(tonumber(lua.teleportbypass[client][5]), tonumber(lua.teleportbypass[client][6]), x, y) > 40) then
			functions.punish(client, reason);
			return true;
		end
	end

		--[[
			ANTI RECONNECT, ANTI VPN, WHITELIST COUNTRYS E INTEGRITY FALL
		]]--


	function func.onPlayerQuit(quitType)
		if lua.players and lua.players[source.serial] then
			lua.players[source.serial] = nil;
		end

		if lua.collisionFuckers and lua.collisionFuckers[source] then
			lua.collisionFuckers[source] = nil;
		end

		if lua.teleportbypass and lua.teleportbypass[source] then
			lua.teleportbypass[source] = nil;
		end

		if lua.fixedbypass and lua.fixedbypass[source] then
			lua.fixedbypass[source] = nil;
		end

		if lua.inspectSender and lua.inspectSender[source] then
			lua.inspectSender[source] = nil;
		end

		if settings.functions['getaccount'](source) == 'guest' and settings['modules']['Anti Reconnect'].state then
			lua.antireconnect[getPlayerSerial(source)] = {tick = getTickCount() + settings['modules']['Anti Reconnect'].cooldown, elementID = settings.functions['getid'](source)};
		end
	end


	function func.onPlayerPingRequest(playerNick, playerIP, _, playerSerial)
		local IS_PLAYER_ONLINE_WITH_SERIAL = getPlayerBySerial(playerSerial)
		if (IS_PLAYER_ONLINE_WITH_SERIAL or lua.players[playerSerial]) and (settings['modules']['Serial Cloner'].state) then
			cancelEvent(true, settings['modules']['Serial Cloner'].punishreason or 'Já existe um jogador online com seu serial!');
			return true;
		end
		local vban, iban = getPlayerBanBySerial(playerSerial)
		local vban2, iban2 = getPlayerBanByIP(playerIP)
		if (vban2 and iban2 and not vban and not iban) then
			if (settings['general'].defaultban) then
				addBan(tostring(playerIP), tostring(playerNick), tostring(playerSerial), root, '[HAC]: Serial Spoofer detected');
			end
			table.insert(lua.banslist, {
				userAccount = 'N/A',
				userNick = playerNick,
				userID = 'N/A',
				userIP = playerIP,
				userSerial = playerSerial,
				userDiscordID = 0,
				userReasonBanned = 'Anti Spoofer 3',
				userBanTime = getRealTime().timestamp
			});
			lua.connection:exec('INSERT INTO `banList` (userNick, userID, userAccount, userIP, userSerial, userDiscordID, userReasonBanned, userBanTime, screenshot64) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', playerNick, 'N/A', 'N/A', playerIP, playerSerial, 0, 'Anti Spoofer 3', getRealTime().timestamp, 'N/A');
			cancelEvent(true, 'You were banished by Horus AC\nReason:'..removeAnti(vban2.userReasonBanned)..'\nTime left: 999 days '..math.random(1, 23)..' hours \nDid we make a mistake? contact the administration')
			return true;
		end
		if vban and iban then
			cancelEvent(true, 'You were banished by Horus AC\nReason:'..removeAnti(vban.userReasonBanned)..'\nTime left: 999 days '..math.random(1, 23)..' hours \nDid we make a mistake? contact the administration')
			return true;
		end
		if vban2 and iban2 then
			cancelEvent(true, 'You were banished by Horus AC\nReason:'..removeAnti(vban.userReasonBanned)..'\nTime left: 999 days '..math.random(1, 23)..' hours \nDid we make a mistake? contact the administration')
			return true;
		end
		if (lua.integrityfail[ip] and lua.integrityfail[ip] > getRealTime().timestamp or lua.integrityfail[serial] and lua.integrityfail[serial] > getRealTime().timestamp) then
			cancelEvent(true, '[HAC]: Unable to verify anti cheat integrity, try again at '.. (lua.integrityfail[serial] - getRealTime().timestamp or lua.integrityfail[ip] - getRealTime().timestamp) ..'s')
			return true;
		end
			if settings['modules']['Anti Reconnect'].state then
				if lua.antireconnect[playerSerial] and lua.antireconnect[playerSerial].tick > getTickCount() then
					local dados = {
						player = playerNick,
						id = lua.antireconnect[playerSerial].elementID,
						punish = 'Impedido de conectar'
					}
				sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s']['anti reconnect'], dados), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s']['anti reconnect']);
				cancelEvent(true, '[HAC] '..string.change(settings['modules']['Anti Reconnect'].punishreason, dados));
				return true;
			end
		end
		if settings['modules']['WhiteListed Countrys'].state then
			local dados = {
				player = playerNick,
				id = lua.antireconnect[playerSerial] and lua.antireconnect[playerSerial].elementID or 'N/A',
				serial = playerSerial,
				ip = playerIP,
				punish = 'Impedido de conectar'
			}
			local allowed = true
			fetchRemote('https://api.country.is/'..playerIP, function(response, info)
				if info == 200 or info == 0 then
					local data = fromJSON(response)
					if data and (not isCountryAllow(data.country)) then
						allowed = isCountryAllow(data.country)
						setTimer(function()
							local plaeyr = getPlayerBySerial(dados.serial)
							if (not allowed and isElement(plaeyr)) then
								lua.countrysip[playerIP] = true,
								plaeyr:kick('HÓRUS', '[HAC] '..(string.change(settings['modules']['WhiteListed Countrys'].punishreason, dados)))
							end
						end, 400, 1)
					end
				end
			end)
			if (not allowed or lua.countrysip[playerIP]) then
				cancelEvent(true, '[HAC] '..(string.change(settings['modules']['WhiteListed Countrys'].punishreason, dados))..'')
			end
		end
	end


		--[[
			ANTI VEHICLE FUCKER
		]]--

	function modules.onCarFucked(attackerVeh, victimVeh, collisionCaused)
		if client ~= getElementSyncer(attackerVeh) then
			return false;
		end
		
		if collisionCaused / 1000 < 20 then
			return false;
		end

		local elementtype = victimVeh and getElementType(victimVeh)
		if not victimVeh or (victimVeh and elementtype ~= 'vehicle' and elementtype ~= 'player') then
			return false;
		end
		local victim = elementtype == 'player' and victimVeh or getElementSyncer(victimVeh)
		
		if not lua.collisionFuckers[client] then
			lua.collisionFuckers[client] = {}
		end
		if not lua.collisionFuckers[client][victim] then
			lua.collisionFuckers[client][victim] = {attackerVeh = attackerVeh, victimVeh = victimVeh, collisionCaused = collisionCaused, x = x, y = y, z = z}
		elseif collisionCaused > lua.collisionFuckers[client][victim].collisionCaused then
			lua.collisionFuckers[client][victim].collisionCaused = collisionCaused
		end
		local cvCount = 0
		collisionVerify = setTimer(function(attacker, victimVeh, victim)
			cvCount = cvCount + 1
			if not lua.collisionFuckers[victim] or not lua.collisionFuckers[victim][attacker] then
				functions.requestreport(victim, attacker, 'Anti MaxCollision')
				if getElementType(victimVeh) == 'vehicle' then
					fixVehicle(victimVeh)
				end
				return false
			end
		end, 3000, 1, client, victimVeh, victim)
	end


		--[[
			ANTI ELEMENTDATACHANGE
		]]--

	function modules.onElementDataChange(dataName, oldValue, newValue)
		if (sourceResource) then
			return false;
		end

		if (not client) then
			return false; 
		end

		if (client and dataName == 'lIIIlIlllIII' and (newValue == false or not newValue) or client ~= source) then
			removeElementData(source, 'lIIIlIlllIII');
			return true;
		end

		if (client and dataName == 'lIIIlIlllIII' and client == source) then
			if (oldValue and oldValue ~= false) then
				return false;
			end
			if (not lua.players[client.serial]) then
				kickPlayer(client, 'HÓRUS-AC', 'SYNC LOGIC ERROR');
				return false;
			end
			if (lua.players[client.serial].punishtimer and isTimer(lua.players[client.serial].punishtimer)) then
				killTimer(lua.players[client.serial].punishtimer);
			end
			lua.players[client.serial].punishtimer = setTimer(function(_player, _old, _new)
				if (not isElement(_player)) then
					return false;
				end
				local recovery = getElementData(_player, 'lIIIlIlllIII') or false
				if (recovery and tonumber(recovery) and recovery <= lua.modules_index and recovery == _new) then
					local name, table = getActionByIndex(recovery)
					functions.punish(_player, name)
					removeElementData(_player, 'lIIIlIlllIII');
					return true;
				end
			end, 2000, 1, source, oldValue, newValue)
		end

			if client and (source == c965492a50b519451be98427ea60397b or source == resourceRoot or dataName == 'HAC:loggedIn' or dataName == 'hac protection state' or dataName == 'horus > check-in-progress')  then
				setElementData(source, dataName, oldValue or false);
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
					banPlayer(client, true, true, true, 'HÓRUS-AC', '[HAC]: Tentativa de alterar dados sigilosos do anti cheat');
					return false;
				else
					kickPlayer(client, 'HÓRUS-AC', '[HAC] Tentativa de alterar dados sigilosos do anti cheat');
					return false;
				end
			end
			if client and source == getRootElement() and settings['modules']['Anti ElementDataChange'].dates[dataName] then
				setElementData(source, dataName, oldValue or false);
				functions.punish(client, 'Anti ElementDataChange', {resource = not resname and false or resname, func = 'setElementData', dataname = dataName or false, dataold = oldvalue or false, datanew = newValue or false})
				return false;
			end
			if not isValidPlayer(client) then
				return false; 
			end
			if lua.modules['Anti Overflow'] then
				local timestampAtual = getTickCount()
				local player_save = client
				if not lua.elementfucker[client] then
					lua.elementfucker[client] = {
						timestamp = timestampAtual,
						fluxo = 0,
						elementos = {}
					}
				end
				if not isValidPlayer(source) and source ~= client and timestampAtual - lua.elementfucker[client].timestamp <= 200 then
					lua.elementfucker[client].fluxo = (lua.elementfucker[client].fluxo or 0) + 1
					table.insert(lua.elementfucker[client].elementos, {source, dataname, oldvalue, newvalue})
				else
					lua.elementfucker[client].fluxo = 0
				end
				lua.elementfucker[client].timestamp = timestampAtual
				if lua.elementfucker[client].fluxo == (settings['modules']['Anti Overflow']['rateLimit']) then
					if isElement(source) and settings['modules']['Anti Overflow']['rateLimit'] then
						triggerClientEvent(client or player_save, '94a2c06b4f963c473d2d9e9fac990e8b', resourceRoot); -- set debugsleep
						functions.punish(client or player_save, 'Anti Overflow')
						setTimer(
							function()
								for i, v in ipairs(getElementsByType('player')) do
									if v[3] ~= nil and v[3] ~= false then
										setElementData(v[1], tostring(v[2]), v[3])
									else
										removeElementData(v[1], tostring(v[2]))
									end
								end
								outputDebugString('[HORUS ANTI CHEAT]: data flood attack successfully mitigated!', 4, 255, 255, 255)
							end, 5000, 1)
						return false;
					end
				end
			end
			if (settings['modules']['Anti ElementDataChange'].state) then
				if client and isElement(source) and settings['modules']['Anti ElementDataChange'].dates[dataName] and (type(settings['modules']['Anti ElementDataChange'].dates) == 'table' and settings['modules']['Anti ElementDataChange'].types[getElementType(source)] or settings['modules']['Anti ElementDataChange'].types == 'all' and true) then
					functions.punish(client, 'Anti ElementDataChange', {resource = not resname and false or resname, func = 'setElementData', dataname = dataName or false, dataold = oldvalue or false, datanew = newValue or false})
					setElementData(source, dataName, oldValue or false);
					return true;
				end
				if isValidPlayer(client) and isElement(source) then
					if client ~= source and isValidPlayer(source) then
						if (isElementModuleBypass(client, 'Anti ElementDataChange')) then
							return false;
						end
						setElementData(source, dataName, oldValue or false);
					if lua.rate_limit['elementdatachange'] and not lua.rate_limit['elementdatachange'][client] or lua.rate_limit['elementdatachange'][client] < getTickCount() then
						lua.rate_limit['elementdatachange'][client] = getTickCount() + 2500
						functions.punish(client, 'Anti ElementDataChange', {resource = not resname and false or resname, func = 'setElementData', dataname = dataName or false, dataold = oldvalue or false, datanew = newValue or false})
						return true;
					end
				end
			end	
		end
	end
------------------------------
end

return (function()
    setmetatable({}, {
      __call = function(...)
        return startsmodules()
      end
    })()
end)()
