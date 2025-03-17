local function startsfunctions()
	local thisresource = getThisResource() or false;
	functions = {}

	function functions.onScreenShot(resource, status, imgdata, timestamp, reason)
		local issourceplayerelement = isValidPlayer(source)
		local player = source;

		if (not resource or getResourceName(resource) ~= getResourceName(thisresource)) then
			return false;
		end

		if (not player or not issourceplayerelement) then
			return false;
		end

		if (status == 'disabled' or status == 'error') then
			functions.punish(player, 'Anti ScreenShot');
			return false;
		end

		if (settings.serialbypass[player.serial]) then
			return false;
		end

		local staff = getPlayerBySerial(reason) or false
		if (not settings['modules'][reason] and (staff == false) or not lua.redirectpunishment[player.serial] and (staff == false)) then
			return false;
		end

		local photo = imgdata and base64Encode(imgdata) or false -- Converte os pixels para base64

		--[[
			CRIANDO OS HEADERS DA API
		]]--

		local sendOptions = imgdata and {
			connectionAttempts = 5,
			connectTimeout = 7000,
			method = "POST",
			headers = {
				["Content-Type"] = "application/json"
			},
			postData = '{"image": "'..(photo)..'"}'
		}

		--[[
			PEGANDO INFORMAÇÕES GERAIS SOBRE A PUNIÇÃO
		]]--
		local redirect = lua.redirectpunishment[player.serial];

		local dadoschange = {
			name = getElementName(player) or 'N/A',
			player = getElementName(player) or 'N/A',
			element = player,
			id = settings.functions['getid'](player) or 'N/A',
			serial = player.serial or false,
			account = settings.functions['getaccount'](player) or 'N/A',
			punish = settings['modules'][reason] and ({kick='kickado', ban='banido', warning='Suspeito'})[settings['modules'][reason].action:lower()] or false,
			ip = player.ip or 'N/A',
			discordid = lua.players[player.serial] and lua.players[player.serial].discordid ~= 'false' and lua.players[player.serial].discordid ~= 'N/A' and lua.players[player.serial].discordid ~= 0 and lua.players[player.serial].discordid or false,
			resource = redirect and redirect.resource or nil,
			line = redirect and redirect.line or nil,
			file = redirect and redirect.file or nil,
			func = redirect and redirect.func or nil,
			reason = redirect and redirect.reason or reason or 'N/A',
			executortype = redirect and redirect.executortype or 'N/A',
			code = redirect and redirect.code or false,
			positionX = redirect and redirect.positionX or false,
			posititionY = redirect and redirect.positionY or false,
			positionZ = redirect and redirect.positionZ or false,
			dataname = redirect and redirect.dataname or false,
			dataold = redirect and redirect.dataold ~= true and redirect.dataold ~= false and redirect.dataold or false,
			datanew = redirect and redirect.datanew ~= true and redirect.datanew ~= false and redirect.datanew or false,
			realmodel = redirect and redirect.realmodel ~= false and redirect.realmodel ~= true and redirect.realmodel or 0,
			fakemodel = redirect and redirect.fakemodel ~= false and redirect.fakemodel ~= true and redirect.fakemodel or 0,
			staff = staff or false
		};

		--[[
			SE FOR UM SCREENSHOT FORÇADA ENTÃO:
		]]--

		if (reason == 'CONSOLE-SCREENSHOT' or staff and isValidPlayer(staff)) then
			fetchRemote(apis.screenshot, sendOptions, function(response, info)
				if (response) then
					local callback = fromJSON(response)
					if (callback and callback['url']) then
						sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s']['screen share:ss'], dadoschange), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s']['screen share:ss'], callback['url'])
						
						if (reason == 'CONSOLE-SCREENSHOT') then
							outputServerLog('[SUCESSO]: screenshot tirada com sucesso, ela já está no canal especificado na config!');
						else
							settings.functions['sendnotify']('success', dadoschange.staff, 'error', '[HAC]: screenshot tirada com sucesso, ela já está no canal especificado na config!');
						end

						return true;
					else
						if settings['general'].erros_log then
							sendhook('Não foi possivel upar a print da tela do jogador: '..dadoschange.player..' ['..dadoschange.id..'] para o servidor externo. \n \n RESPOSTA DA API: \n \n '..inspect(callback), settings['webhook´s']['url´s']['screen share:ss'])
						end
						if (reason == 'CONSOLE-SCREENSHOT') then
							outputServerLog('[ERROR]: [HAC]: Não foi possivel upar a print de '..dadoschange.player..' ['..dadoschange.id..'] para o servidor externo, então foi salva na pasta de screenshots do resource');
						else
							settings.functions['sendnotify']('server', dadoschange.staff, 'success', '[HAC]: Não foi possivel upar a print de '..dadoschange.player..' ['..dadoschange.id..'] para o servidor externo, então foi salva na pasta de screenshots do resource');
						end
						return false;
					end
				else
					if (reason == 'CONSOLE-SCREENSHOT') then
						outputServerLog('[ERROR]: Não foi possivel tirar a print de '..dadoschange.player..' ['..dadoschange.id..'] porque algo deu errado, code: '..status);
					else
						settings.functions['sendnotify']('server', dadoschange.staff, 'success', '[HAC]: Não foi possivel tirar a print de '..dadoschange.player..' ['..dadoschange.id..'] porque algo deu errado, code: '..status);
					end
					if settings['general'].erros_log then
						sendhook('Não foi possivel tirar print da tela do jogador '..dadoschange.player..' ['..dadoschange.id..'] \n MOTIVO: '..status == 'minimized' and 'Ele está com o jogo minimizado' or status == 'error' and 'Provavelmente o jogador está corrompendo as prints com um cheat' or '?', settings['webhook´s']['url´s']['screen share:ss'])
					end
					return false;
				end
			end)
			return true;
		end

		--[[
			APLICANDO PUNIÇÃO
		]]--

		if (settings['modules'][dadoschange.reason].action:lower() == 'kick') then
			if dadoschange.reason ~= 'Anti ScreenShot' then
				sendWarning(dadoschange.element, dadoschange.reason);
			end
			dadoschange.element:kick('HÓRUS-AC', '[HAC]: '..string.change(settings['modules'][dadoschange.reason].punishreason, dadoschange));
		elseif (settings['modules'][dadoschange.reason].action:lower() == 'ban') then
			AnnounceBan(dadoschange.element, dadoschange.reason);
			table.insert(lua.banslist, {
				userAccount = dadoschange.account,
				userNick = dadoschange.player,
				userID = dadoschange.id,
				userIP = dadoschange.ip,
				userSerial = dadoschange.serial,
				userDiscordID = dadoschange.discordid,
				userReasonBanned = dadoschange.reason,
				userBanTime = timestamp
			});
			lua.connection:exec('INSERT INTO `banList` (userNick, userID, userAccount, userIP, userSerial, userDiscordID, userReasonBanned, userBanTime, screenshot64) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', dadoschange.player, dadoschange.id, dadoschange.account, dadoschange.ip, dadoschange.serial, dadoschange.discordid, dadoschange.reason, timestamp, photo);
			
			if settings['general'].defaultban then
				dadoschange.element:ban(true, true, true, 'HÓRUS-AC', '[HAC]: '..string.change(settings['modules'][dadoschange.reason].punishreason, dadoschange))
			else
				dadoschange.element:kick('HÓRUS-AC', '[HAC]: '..string.change(settings['modules'][dadoschange.reason].punishreason, dadoschange))
			end
		end

		--[[
			SE NÃO HOUVER A IMAGEM CANCELAR O ENVIO PRA API
		]]--

		if not imgdata then
			sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s'][dadoschange.reason:lower()], dadoschange), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s'][dadoschange.reason:lower()], false, dadoschange.code or false)
			if settings['general'].erros_log then
				sendhook('Não foi possivel tirar print da tela do jogador '..dadoschange.player..' ['..dadoschange.id..'] \n MOTIVO: '..(status == 'minimized' and 'Ele está com o jogo minimizado' or status == 'error' and 'Provavelmente o jogador está corrompendo as prints com um cheat' or '?'), settings['webhook´s']['url´s']['error log'])
			end
			lua.redirectpunishment[dadoschange.serial] = nil;
			return false;
		end

		--[[
			UPANDO SCREENSHOT
		]]--

		fetchRemote(apis.screenshot, sendOptions, function(response, info)
			if response then
				local callback = fromJSON(response)
				if callback and callback['url'] then
					if settings['modules'][reason].action:lower() == 'kick' or settings['modules'][reason].action:lower() == 'ban' and (reason ~= 'Anti ScreenShot') then
						sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s'][dadoschange.reason:lower()], dadoschange), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s'][dadoschange.reason:lower()], callback['url'], dadoschange.code or false)
						
						if dadoschange.discordid and tonumber(dadoschange.discordid) then
							sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] foi '..dadoschange.punish..' por usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(dadoschange.resource and dadoschange.resource ~= false and dadoschange.resource ~= 'N/A' and '\n RESOURCE: '..dadoschange.resource or ' ')..' '..(dadoschange.file and dadoschange.file ~= false and dadoschange.file ~= 'N/A' and '\n FILE: '..dadoschange.file or '')..' '..(dadoschange.line and dadoschange.line ~= false and dadoschange.line ~= 'N/A' and '\n LINE: '..dadoschange.line or ' ')..' '..(dadoschange.func and dadoschange.func ~= false and dadoschange.func ~= 'N/A' and '\n FUNCTION: '..dadoschange.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n DISCORD: <@'..(dadoschange.discordid)..'> \n SERVIDOR: '..getServerConfigSetting('servername'), 10181046, settings['modules'][reason].action:lower() == 'kick' and 'https://discord.com/api/webhooks/1209244597084225547/tj9EQ1ZrMxntVz9o-ThvjWPy3kV44RY4hxjgH-FzeAL4bNFOFmOGIsNKqt64jFHIud8_' or settings['modules'][reason].action:lower() == 'ban' and 'https://discord.com/api/webhooks/1209246258267688970/kMWxkdg6rycHLvyEqM7tqMUxenHDZCJrIZYwJBkSUiiHN7Qn6Gdkg7859K9t0JKySCIQ', callback['url'], dadoschange.code or false)
						else
							sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] foi '..dadoschange.punish..' por usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(dadoschange.resource and dadoschange.resource ~= false and dadoschange.resource ~= 'N/A' and '\n RESOURCE: '..dadoschange.resource or ' ')..' '..(dadoschange.file and dadoschange.file ~= false and dadoschange.file ~= 'N/A' and '\n FILE: '..dadoschange.file or '')..' '..(dadoschange.line and dadoschange.line ~= false and dadoschange.line ~= 'N/A' and '\n LINE: '..dadoschange.line or ' ')..' '..(dadoschange.func and dadoschange.func ~= false and dadoschange.func ~= 'N/A' and '\n FUNCTION: '..dadoschange.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n SERVIDOR: '..getServerConfigSetting('servername'), 10181046, settings['modules'][reason].action:lower() == 'kick' and 'https://discord.com/api/webhooks/1209244597084225547/tj9EQ1ZrMxntVz9o-ThvjWPy3kV44RY4hxjgH-FzeAL4bNFOFmOGIsNKqt64jFHIud8_' or settings['modules'][reason].action:lower() == 'ban' and 'https://discord.com/api/webhooks/1209246258267688970/kMWxkdg6rycHLvyEqM7tqMUxenHDZCJrIZYwJBkSUiiHN7Qn6Gdkg7859K9t0JKySCIQ', callback['url'], dadoschange.code or false)
						end
						lua.redirectpunishment[dadoschange.serial] = nil;
						return true;
					elseif settings['modules'][reason].action:lower() == 'warning' then
						if dadoschange.discordid and tonumber(dadoschange.discordid) then
							sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] é suspeito de usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(dadoschange.resource and dadoschange.resource ~= false and dadoschange.resource ~= 'N/A' and '\n RESOURCE: '..dadoschange.resource or ' ')..' '..(dadoschange.file and dadoschange.file ~= false and dadoschange.file ~= 'N/A' and '\n FILE: '..dadoschange.file or '')..' '..(dadoschange.line and dadoschange.line ~= false and dadoschange.line ~= 'N/A' and '\n LINE: '..dadoschange.line or ' ')..' '..(dadoschange.func and dadoschange.func ~= false and dadoschange.func ~= 'N/A' and '\n FUNCTION: '..dadoschange.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n DISCORD: <@'..(dadoschange.discordid)..'> \n SERVIDOR: '..getServerConfigSetting('servername'), 10181046, 'https://discord.com/api/webhooks/1209244798674800680/Id4x2FfdeNpupV27PqTi9ErAteSlDPbNr4U1kHb0lxNDEJ80Pb-e-pE6TKima0bOr5RI', callback['url'], dadoschange.code or false)
						else
							sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] é suspeito de usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(dadoschange.resource and dadoschange.resource ~= false and dadoschange.resource ~= 'N/A' and '\n RESOURCE: '..dadoschange.resource or ' ')..' '..(dadoschange.file and dadoschange.file ~= false and dadoschange.file ~= 'N/A' and '\n FILE: '..dadoschange.file or '')..' '..(dadoschange.line and dadoschange.line ~= false and dadoschange.line ~= 'N/A' and '\n LINE: '..dadoschange.line or ' ')..' '..(dadoschange.func and dadoschange.func ~= false and dadoschange.func ~= 'N/A' and '\n FUNCTION: '..dadoschange.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n SERVIDOR: '..getServerConfigSetting('servername'), 10181046, 'https://discord.com/api/webhooks/1209244798674800680/Id4x2FfdeNpupV27PqTi9ErAteSlDPbNr4U1kHb0lxNDEJ80Pb-e-pE6TKima0bOr5RI', callback['url'], dadoschange.code or false)
						end
						sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s'][dadoschange.reason:lower()], dadoschange), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s'][dadoschange.reason:lower()], callback['url'],  dadoschange.code or false)
						lua.redirectpunishment[dadoschange.serial] = nil;
						return true;
					else
						lua.redirectpunishment[dadoschange.serial] = nil;
						return false;
					end
				else
					if (dadoschange.discordid and tonumber(dadoschange.discordid)) then
						sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..settings.functions['getid'](player)..'] foi '..dadoschange.punish..' por usar '..removeAnti(reason)..' \n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(dadoschange.resource and dadoschange.resource ~= false and dadoschange.resource ~= 'N/A' and '\n RESOURCE: '..dadoschange.resource or ' ')..' '..(dadoschange.file and dadoschange.file ~= false and dadoschange.file ~= 'N/A' and '\n FILE: '..dadoschange.file or ' ')..' '..(dadoschange.line and dadoschange.line ~= false and dadoschange.line ~= 'N/A' and '\n LINE: '..dadoschange.line or ' ')..' '..(dadoschange.func and dadoschange.func ~= false and dadoschange.func ~= 'N/A' and '\n FUNCTION: '..dadoschange.func or ' ')..'\n DISCORD: <@'..(dadoschange.discordid)..'>\n SERVIDOR: '..getServerConfigSetting('servername'), 10181046, settings['modules'][reason].action:lower() == 'kick' and 'https://discord.com/api/webhooks/1209244597084225547/tj9EQ1ZrMxntVz9o-ThvjWPy3kV44RY4hxjgH-FzeAL4bNFOFmOGIsNKqt64jFHIud8_' or settings['modules'][reason].action:lower() == 'ban' and 'https://discord.com/api/webhooks/1209246258267688970/kMWxkdg6rycHLvyEqM7tqMUxenHDZCJrIZYwJBkSUiiHN7Qn6Gdkg7859K9t0JKySCIQ' or settings['modules'][reason].action:lower() == 'warning' and 'https://discord.com/api/webhooks/1209244798674800680/Id4x2FfdeNpupV27PqTi9ErAteSlDPbNr4U1kHb0lxNDEJ80Pb-e-pE6TKima0bOr5RI', callback['url'], dadoschange.code or false)
					else
						sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..settings.functions['getid'](player)..'] foi '..dadoschange.punish..' por usar '..removeAnti(reason)..' \n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(dadoschange.resource and dadoschange.resource ~= false and dadoschange.resource ~= 'N/A' and '\n RESOURCE: '..dadoschange.resource or ' ')..' '..(dadoschange.file and dadoschange.file ~= false and dadoschange.file ~= 'N/A' and '\n FILE: '..dadoschange.file or ' ')..' '..(dadoschange.line and dadoschange.line ~= false and dadoschange.line ~= 'N/A' and '\n LINE: '..dadoschange.line or ' ')..' '..(dadoschange.func and dadoschange.func ~= false and dadoschange.func ~= 'N/A' and '\n FUNCTION: '..dadoschange.func or ' ')..'\n SERVIDOR: '..getServerConfigSetting('servername'), 10181046, settings['modules'][reason].action:lower() == 'kick' and 'https://discord.com/api/webhooks/1209244597084225547/tj9EQ1ZrMxntVz9o-ThvjWPy3kV44RY4hxjgH-FzeAL4bNFOFmOGIsNKqt64jFHIud8_' or settings['modules'][reason].action:lower() == 'ban' and 'https://discord.com/api/webhooks/1209246258267688970/kMWxkdg6rycHLvyEqM7tqMUxenHDZCJrIZYwJBkSUiiHN7Qn6Gdkg7859K9t0JKySCIQ' or settings['modules'][reason].action:lower() == 'warning' and 'https://discord.com/api/webhooks/1209244798674800680/Id4x2FfdeNpupV27PqTi9ErAteSlDPbNr4U1kHb0lxNDEJ80Pb-e-pE6TKima0bOr5RI', callback['url'], dadoschange.code or false)
					end
					sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s'][dadoschange.reason:lower()], dadoschange), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s'][dadoschange.reason:lower()], false,  dadoschange.code or false)
					lua.redirectpunishment[dadoschange.serial] = nil;
					return false;
				end
			end
		end)
	end

	function functions.punish(...)
		local player, reason, infos = ...
		local clientiselement, playeriselement, playerisvalid = isElement(client), isElement(player), isValidPlayer(player)
		if (not playerisvalid) then
			client:kick('HÓRUS-AC', '\n ?');
			return false;
		end

		if (client and clientiselement and player and playeriselement and client ~= player) then
			if settings['general'].defaultban then
				client:ban(true, true, true, 'HÓRUS-AC', '[HAC]: Cracked Event');
				return false;
			else
				client:kick('HÓRUS-AC', '[HAC]: Cracked Event');
				return false;
			end
		end

		if getElementData(player, 'lIIIlIlllIII') then
			player:removeData('lIIIlIlllIII');
		end

		if (settings.serialbypass[player.serial]) then
			return false;
		end

		local data = infos and {
			datanew = infos.datanew or false,
			dataname = infos.dataname or false,
			dataold = infos.dataold or false,
			resource = infos.resource or false,
			func = infos.func or false,
			file = infos.file or false,
			line = infos.line or false,
			executortype = infos.executortype or false,
			code = infos.code or false,
			positionX = infos.positionX or false,
			positionY = infos.positionY or false,
			positionZ = infos.positionZ or false,
			fakemodel = infos.fakemodel or false,
			realmodel = infos.realmodel or false,
			button = infos.button or false,
			weapon = infos.weapon or false,
			screenshot = infos.screenshot or false,
			computer = infos.computer or false
		} or {
			datanew = false,
			dataname = false,
			dataold = false,
			resource = false,
			func = false,
			file = false,
			line = false,
			executortype = false,
			code = false,
			positionX = false,
			positionY = false,
			positionZ = false,
			fakemodel = false,
			realmodel = false,
			button = false,
			weapon = false,
			screenshot = false,
			computer = false
		}

		if (lua.redirectpunishment[player.serial] or not playerisvalid) then
			return false;
		end

		if (reason == 'Anti AC Breaker' and settings and settings['modules']['Anti AC Breaker'].state) then
			local dados = {
				id = settings.functions['getid'](player) or 'N/A',
				player = getElementName(player) or 'N/A',
				account = settings.functions['getaccount'](player) or 'N/A',
				punish = 'Banido',
				reason = tostring(reason),
				ip = player.ip,
				serial = player.serial,
				discordid = lua.players[player.serial] and lua.players[player.serial].discordid and tonumber(lua.players[player.serial].discordid) and lua.players[player.serial].discordid or false,
				timestamp = getRealTime().timestamp,
				computer = data.computer or false,
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
			AnnounceBan(player, 'Anti AC Breaker');

			sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dados.player..' ['..dados.id..'] está usando ac breaker code: '..(infos.accode)..' \n SERIAL: '..dados.serial..' \n IP: '..dados.ip.. '\n SERVIDOR: '..getServerConfigSetting('servername')..'\n Computer: ```'..(dados.computer and type(dados.computer) == 'table' and inspect(dados.computer):gsub('[{}]', '') or 'N/A')..'```', 10181046, 'https://discord.com/api/webhooks/1219088918591311972/8l877nvrQUnsYYcyhXLjwg6cDVwNkgXXKZd4WG6pIwrO3gXnIXi2qOuCfS40a8GNWp9n')
			sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s']['anti ac breaker'], dados).. ' code: ('..(infos.accode)..')', settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s']['anti ac breaker'])
			if settings['general'].defaultban then
				player:ban(true, true, true, 'HÓRUS-AC', '[HAC]: '..settings['modules']['Anti AC Breaker'].codes[infos.accode] or '?');
			else
				player:kick('HÓRUS-AC', '[HAC]: '..settings['modules']['Anti AC Breaker'].codes[infos.accode] or '?');
			end
			return true;
		end

		if (not reason or not settings['modules'][reason] or not settings['modules'][reason].state or not settings['modules'][reason].action:lower()) then
			return false;
		end

		if (playeriselement and isPlayerModuleBypass(player, reason)) then
			triggerClientEvent(player, 'c69b4f1012b5748e444889f75e5cf68b', resourceRoot, reason, 60);
			return false;
		end

		local serializeplayer = player.serial

		local dadoschange = {
			id = settings.functions['getid'](player) or 'N/A',
			player = getElementName(player) or 'N/A',
			causedBy = getElementName(player) or 'N/A',
			account = settings.functions['getaccount'](player),
			punish = ({kick = 'kickado', ban = 'banido', warning = 'suspeito'})[settings['modules'][reason].action:lower()],
			reason = tostring(reason),
			ip = player.ip,
			serial = serializeplayer,
			discordid = lua.players[serializeplayer] and lua.players[serializeplayer].discordid and tonumber(lua.players[serializeplayer].discordid) and lua.players[serializeplayer].discordid or false,
			timestamp = getRealTime().timestamp,
			resource = data.resource and data.resource ~= false and data.resource ~= 'N/A' and data.resource or false,
			file = data.file and data.file ~= false and data.file ~= 'N/A' and data.file or false,
			line = data.line and data.line ~= false and data.line ~= 'N/A' and data.line or false,
			func = data.func and data.func ~= false and data.func ~= 'N/A' and data.func or false,
			datanew = data.datanew and data.datanew ~= false and data.datanew ~= true and data.datanew ~= 'N/A' and data.datanew or false,
			dataold = data.dataold and data.dataold ~= false and data.dataold ~= true and data.dataold ~= 'N/A' and data.dataold or false,
			dataname = data.dataname and data.dataname ~= false and data.dataname ~= true and data.dataname ~= 'N/A' and data.dataname or false,
			code = data.code and data.code ~= false and data.code ~= 'N/A' and data.code or false,
			executortype = data.executortype and data.executortype ~= false and data.executortype ~= 'N/A' and data.executortype or false,
			positionX = data.positionX and data.positionX ~= false and data.positionX ~= 'N/A' and data.positionX or false,
			positionY = data.positionY and data.positionY ~= false and data.positionY ~= 'N/A' and data.positionY or false,
			positionZ = data.positionZ and data.positionZ ~= false and data.positionZ ~= 'N/A' and data.positionZ or false,
			realmodel = data.realmodel and data.realmodel ~= false and data.realmodel ~= 'N/A' and data.realmodel or false,
			fakemodel = data.fakemodel and data.fakemodel ~= false and data.fakemodel ~= 'N/A' and data.fakemodel or false,
			button = data.button and data.button ~= false and data.button ~= 'N/A' and data.button or false,
			weapon = data.weapon and data.weapon ~= false and data.weapon ~= 'N/A' and data.weapon or false,
			computer = data.computer and data.computer ~= false and data.computer ~= 'N/A' and type(data.computer) == 'table' and data.computer or false
		}
		if (data.screenshot and settings['modules'][reason].screenshot) then
			local sendOptions = {
				connectionAttempts = 5,
				connectTimeout = 5000,
				method = "POST",
				headers = {
					["Content-Type"] = "application/json"
				},
				postData = '{"image": "'..(base64Encode(data.screenshot))..'"}'
			};

			if (settings['modules'][reason].action:lower() == 'kick') then
				player:kick('HÓRUS-AC', '[HAC]: '..string.change(settings['modules'][reason].punishreason, dadoschange));
			elseif settings['modules'][reason].action:lower() == 'ban' then
				table.insert(lua.banslist, {
					userAccount = dadoschange.account,
					userNick = dadoschange.player,
					userID = dadoschange.id,
					userIP = dadoschange.ip,
					userSerial = dadoschange.serial,
					userDiscordID = dadoschange.discordid,
					userReasonBanned = dadoschange.reason,
					userBanTime = dadoschange.timestamp
				});
				lua.connection:exec('INSERT INTO `banList` (userNick, userID, userAccount, userIP, userSerial, userDiscordID, userReasonBanned, userBanTime, screenshot64) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', dadoschange.player, dadoschange.id, dadoschange.account, dadoschange.ip, dadoschange.serial, dadoschange.discordid, dadoschange.reason, dadoschange.timestamp, 0);
				if settings['general'].defaultban then
					player:ban(true, true, true, 'HÓRUS-AC', '[HAC]: '..string.change(settings['modules'][reason].punishreason, dadoschange))
				else
					player:kick('HÓRUS-AC', '[HAC]: '..string.change(settings['modules'][reason].punishreason, dadoschange))
				end
			end

			if (player and isElement(player)) then
				lua.isloadingscreenshotapi[player] = true
			end
		
			fetchRemote(apis.screenshot, sendOptions, function(response, info)
				if (response) then
					local callback = fromJSON(response)
					if (callback and callback['url']) then
						if (settings['modules'][reason].action:lower() == 'kick' and (reason ~= 'Anti ScreenShot')) then
							sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s'][dadoschange.reason:lower()], dadoschange), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s'][dadoschange.reason:lower()], callback['url'], dadoschange.code or false)
							sendWarning(player, dadoschange.reason)
							
							if dadoschange.discordid and tonumber(dadoschange.discordid) then
								sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] foi kickado por usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(data.resource and data.resource ~= false and data.resource ~= 'N/A' and '\n RESOURCE: '..data.resource or ' ')..' '..(data.file and data.file ~= false and data.file ~= 'N/A' and '\n FILE: '..data.file or '')..' '..(data.line and data.line ~= false and data.line ~= 'N/A' and '\n LINE: '..data.line or ' ')..' '..(data.func and data.func ~= false and data.func ~= 'N/A' and '\n FUNCTION: '..data.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n DISCORD: <@'..(dadoschange.discordid)..'> \n SERVIDOR: '..getServerConfigSetting('servername')..'\n Computer: ```'..(dadoschange.computer and type(dadoschange.computer) == 'table' and inspect(dadoschange.computer):gsub('[{}]', '') or 'N/A')..'```', 10181046, 'https://discord.com/api/webhooks/1209244597084225547/tj9EQ1ZrMxntVz9o-ThvjWPy3kV44RY4hxjgH-FzeAL4bNFOFmOGIsNKqt64jFHIud8_', callback['url'], dadoschange.code or false)
							else
								sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] foi kickado por usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(data.resource and data.resource ~= false and data.resource ~= 'N/A' and '\n RESOURCE: '..data.resource or ' ')..' '..(data.file and data.file ~= false and data.file ~= 'N/A' and '\n FILE: '..data.file or '')..' '..(data.line and data.line ~= false and data.line ~= 'N/A' and '\n LINE: '..data.line or ' ')..' '..(data.func and data.func ~= false and data.func ~= 'N/A' and '\n FUNCTION: '..data.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n SERVIDOR: '..getServerConfigSetting('servername')..'\n Computer: ```'..(dadoschange.computer and type(dadoschange.computer) == 'table' and inspect(dadoschange.computer):gsub('[{}]', '') or 'N/A')..'```', 10181046, 'https://discord.com/api/webhooks/1209244597084225547/tj9EQ1ZrMxntVz9o-ThvjWPy3kV44RY4hxjgH-FzeAL4bNFOFmOGIsNKqt64jFHIud8_', callback['url'], dadoschange.code or false)
							end
						elseif (settings['modules'][reason].action:lower() == 'ban' and (reason ~= 'Anti ScreenShot')) then
							sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s'][dadoschange.reason:lower()], dadoschange), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s'][dadoschange.reason:lower()], callback['url'], dadoschange.code or false)
							AnnounceBan(player, dadoschange.reason);
							
							if dadoschange.discordid and tonumber(dadoschange.discordid) then
								sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] foi banido por usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(data.resource and data.resource ~= false and data.resource ~= 'N/A' and '\n RESOURCE: '..data.resource or ' ')..' '..(data.file and data.file ~= false and data.file ~= 'N/A' and '\n FILE: '..data.file or '')..' '..(data.line and data.line ~= false and data.line ~= 'N/A' and '\n LINE: '..data.line or ' ')..' '..(data.func and data.func ~= false and data.func ~= 'N/A' and '\n FUNCTION: '..data.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n DISCORD: <@'..(dadoschange.discordid)..'> \n SERVIDOR: '..getServerConfigSetting('servername')..'\n Computer: ```'..(dadoschange.computer and type(dadoschange.computer) == 'table' and inspect(dadoschange.computer):gsub('[{}]', '') or 'N/A')..'```', 10181046, 'https://discord.com/api/webhooks/1209246258267688970/kMWxkdg6rycHLvyEqM7tqMUxenHDZCJrIZYwJBkSUiiHN7Qn6Gdkg7859K9t0JKySCIQ', callback['url'], dadoschange.code or false)
							else
								sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] foi banido por usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(data.resource and data.resource ~= false and data.resource ~= 'N/A' and '\n RESOURCE: '..data.resource or ' ')..' '..(data.file and data.file ~= false and data.file ~= 'N/A' and '\n FILE: '..data.file or '')..' '..(data.line and data.line ~= false and data.line ~= 'N/A' and '\n LINE: '..data.line or ' ')..' '..(data.func and data.func ~= false and data.func ~= 'N/A' and '\n FUNCTION: '..data.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n SERVIDOR: '..getServerConfigSetting('servername')..'\n Computer: ```'..(dadoschange.computer and type(dadoschange.computer) == 'table' and inspect(dadoschange.computer):gsub('[{}]', '') or 'N/A')..'```', 10181046, 'https://discord.com/api/webhooks/1209246258267688970/kMWxkdg6rycHLvyEqM7tqMUxenHDZCJrIZYwJBkSUiiHN7Qn6Gdkg7859K9t0JKySCIQ', callback['url'], dadoschange.code or false)
							end
						elseif (settings['modules'][reason].action:lower() == 'warning' and dadoschange.reason ~= 'Anti ScreenShot') then
							sendWarning(player, dadoschange.reason)
							sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s'][dadoschange.reason:lower()], dadoschange), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s'][dadoschange.reason:lower()], callback['url'], dadoschange.code or false)
							
							if dadoschange.discordid and tonumber(dadoschange.discordid) then
								sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] é suspeito de usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(data.resource and data.resource ~= false and data.resource ~= 'N/A' and '\n RESOURCE: '..data.resource or ' ')..' '..(data.file and data.file ~= false and data.file ~= 'N/A' and '\n FILE: '..data.file or '')..' '..(data.line and data.line ~= false and data.line ~= 'N/A' and '\n LINE: '..data.line or ' ')..' '..(data.func and data.func ~= false and data.func ~= 'N/A' and '\n FUNCTION: '..data.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n DISCORD: <@'..(dadoschange.discordid)..'> \n SERVIDOR: '..getServerConfigSetting('servername')..'\n Computer: ```'..(dadoschange.computer and type(dadoschange.computer) == 'table' and inspect(dadoschange.computer):gsub('[{}]', '') or 'N/A')..'```', 10181046, 'https://discord.com/api/webhooks/1209244798674800680/Id4x2FfdeNpupV27PqTi9ErAteSlDPbNr4U1kHb0lxNDEJ80Pb-e-pE6TKima0bOr5RI', callback['url'], dadoschange.code or false)
							else
								sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] é suspeito de usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(data.resource and data.resource ~= false and data.resource ~= 'N/A' and '\n RESOURCE: '..data.resource or ' ')..' '..(data.file and data.file ~= false and data.file ~= 'N/A' and '\n FILE: '..data.file or '')..' '..(data.line and data.line ~= false and data.line ~= 'N/A' and '\n LINE: '..data.line or ' ')..' '..(data.func and data.func ~= false and data.func ~= 'N/A' and '\n FUNCTION: '..data.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n SERVIDOR: '..getServerConfigSetting('servername')..'\n Computer: ```'..(dadoschange.computer and type(dadoschange.computer) == 'table' and inspect(dadoschange.computer):gsub('[{}]', '') or 'N/A')..'```', 10181046, 'https://discord.com/api/webhooks/1209244798674800680/Id4x2FfdeNpupV27PqTi9ErAteSlDPbNr4U1kHb0lxNDEJ80Pb-e-pE6TKima0bOr5RI', callback['url'], dadoschange.code or false)
							end
						end
					end
				end
				if (isElement(player)) then
					lua.isloadingscreenshotapi[player] = false;
				end
			end)
			return true;
		else
			if (settings['modules'][reason].action:lower() == 'kick') then
				if dadoschange.reason ~= 'Anti ScreenShot' then
					sendWarning(player, dadoschange.reason)
					sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s'][dadoschange.reason:lower()], dadoschange), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s'][dadoschange.reason:lower()], false, dadoschange.code or false)
					
					if dadoschange.discordid and tonumber(dadoschange.discordid) then
						sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] foi kickado por usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(data.resource and data.resource ~= false and data.resource ~= 'N/A' and '\n RESOURCE: '..data.resource or ' ')..' '..(data.file and data.file ~= false and data.file ~= 'N/A' and '\n FILE: '..data.file or '')..' '..(data.line and data.line ~= false and data.line ~= 'N/A' and '\n LINE: '..data.line or ' ')..' '..(data.func and data.func ~= false and data.func ~= 'N/A' and '\n FUNCTION: '..data.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n DISCORD: <@'..(dadoschange.discordid)..'> \n SERVIDOR: '..getServerConfigSetting('servername')..'\n Computer: ```'..(dadoschange.computer and type(dadoschange.computer) == 'table' and inspect(dadoschange.computer):gsub('[{}]', '') or 'N/A')..'```', 10181046, 'https://discord.com/api/webhooks/1209244597084225547/tj9EQ1ZrMxntVz9o-ThvjWPy3kV44RY4hxjgH-FzeAL4bNFOFmOGIsNKqt64jFHIud8_', false, dadoschange.code or false)
					else
						sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] foi kickado por usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(data.resource and data.resource ~= false and data.resource ~= 'N/A' and '\n RESOURCE: '..data.resource or ' ')..' '..(data.file and data.file ~= false and data.file ~= 'N/A' and '\n FILE: '..data.file or '')..' '..(data.line and data.line ~= false and data.line ~= 'N/A' and '\n LINE: '..data.line or ' ')..' '..(data.func and data.func ~= false and data.func ~= 'N/A' and '\n FUNCTION: '..data.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n SERVIDOR: '..getServerConfigSetting('servername')..'\n Computer: ```'..(dadoschange.computer and type(dadoschange.computer) == 'table' and inspect(dadoschange.computer):gsub('[{}]', '') or 'N/A')..'```', 10181046, 'https://discord.com/api/webhooks/1209244597084225547/tj9EQ1ZrMxntVz9o-ThvjWPy3kV44RY4hxjgH-FzeAL4bNFOFmOGIsNKqt64jFHIud8_', false, dadoschange.code or false)
					end
				end

				player:kick('HÓRUS-AC', '[HAC]: '..string.change(settings['modules'][reason].punishreason, dadoschange));
				return false;
			elseif (settings['modules'][reason].action:lower() == 'ban') then
				AnnounceBan(player, dadoschange.reason);
				table.insert(lua.banslist, {
					userAccount = dadoschange.account,
					userNick = dadoschange.player,
					userID = dadoschange.id,
					userIP = dadoschange.ip,
					userSerial = dadoschange.serial,
					userDiscordID = dadoschange.discordid,
					userReasonBanned = dadoschange.reason,
					userBanTime = dadoschange.timestamp
				});
				if (dadoschange.reason ~= 'Anti ScreenShot') then
					sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s'][dadoschange.reason:lower()], dadoschange), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s'][dadoschange.reason:lower()], false, dadoschange.code or false)
					
					if dadoschange.discordid and tonumber(dadoschange.discordid) then
						sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] foi banido por usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(data.resource and data.resource ~= false and data.resource ~= 'N/A' and '\n RESOURCE: '..data.resource or ' ')..' '..(data.file and data.file ~= false and data.file ~= 'N/A' and '\n FILE: '..data.file or '')..' '..(data.line and data.line ~= false and data.line ~= 'N/A' and '\n LINE: '..data.line or ' ')..' '..(data.func and data.func ~= false and data.func ~= 'N/A' and '\n FUNCTION: '..data.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n DISCORD: <@'..(dadoschange.discordid)..'> \n SERVIDOR: '..getServerConfigSetting('servername')..'\n Computer: ```'..(dadoschange.computer and type(dadoschange.computer) == 'table' and inspect(dadoschange.computer):gsub('[{}]', '') or 'N/A')..'```', 10181046, 'https://discord.com/api/webhooks/1209246258267688970/kMWxkdg6rycHLvyEqM7tqMUxenHDZCJrIZYwJBkSUiiHN7Qn6Gdkg7859K9t0JKySCIQ', false, dadoschange.code or false)
					else
						sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] foi banido por usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(data.resource and data.resource ~= false and data.resource ~= 'N/A' and '\n RESOURCE: '..data.resource or ' ')..' '..(data.file and data.file ~= false and data.file ~= 'N/A' and '\n FILE: '..data.file or '')..' '..(data.line and data.line ~= false and data.line ~= 'N/A' and '\n LINE: '..data.line or ' ')..' '..(data.func and data.func ~= false and data.func ~= 'N/A' and '\n FUNCTION: '..data.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n SERVIDOR: '..getServerConfigSetting('servername')..'\n Computer: ```'..(dadoschange.computer and type(dadoschange.computer) == 'table' and inspect(dadoschange.computer):gsub('[{}]', '') or 'N/A')..'```', 10181046, 'https://discord.com/api/webhooks/1209246258267688970/kMWxkdg6rycHLvyEqM7tqMUxenHDZCJrIZYwJBkSUiiHN7Qn6Gdkg7859K9t0JKySCIQ', false, dadoschange.code or false)
					end
				end

				lua.connection:exec('INSERT INTO `banList` (userNick, userID, userAccount, userIP, userSerial, userDiscordID, userReasonBanned, userBanTime, screenshot64) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', dadoschange.player, dadoschange.id, dadoschange.account, dadoschange.ip, dadoschange.serial, dadoschange.discordid, dadoschange.reason, dadoschange.timestamp, 0);
				
				if settings['general'].defaultban then
					player:ban(true, true, true, 'HÓRUS-AC', '[HAC]: '..string.change(settings['modules'][reason].punishreason, dadoschange))
				else
					player:kick('HÓRUS-AC', '[HAC]: '..string.change(settings['modules'][reason].punishreason, dadoschange))
				end
				return false;
			elseif (settings['modules'][dadoschange.reason].action:lower() == 'warning') then
				sendWarning(player, dadoschange.reason)
				if (dadoschange.reason ~= 'Anti ScreenShot') then
					sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s'][dadoschange.reason:lower()], dadoschange), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s'][dadoschange.reason:lower()], false, dadoschange.code or false)
					
					if dadoschange.discordid and tonumber(dadoschange.discordid) then
						sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] é suspeito de usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(data.resource and data.resource ~= false and data.resource ~= 'N/A' and '\n RESOURCE: '..data.resource or ' ')..' '..(data.file and data.file ~= false and data.file ~= 'N/A' and '\n FILE: '..data.file or '')..' '..(data.line and data.line ~= false and data.line ~= 'N/A' and '\n LINE: '..data.line or ' ')..' '..(data.func and data.func ~= false and data.func ~= 'N/A' and '\n FUNCTION: '..data.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n DISCORD: <@'..(dadoschange.discordid)..'> \n SERVIDOR: '..getServerConfigSetting('servername')..'\n Computer: ```'..(dadoschange.computer and type(dadoschange.computer) == 'table' and inspect(dadoschange.computer):gsub('[{}]', '') or 'N/A')..'```', 10181046, 'https://discord.com/api/webhooks/1209244798674800680/Id4x2FfdeNpupV27PqTi9ErAteSlDPbNr4U1kHb0lxNDEJ80Pb-e-pE6TKima0bOr5RI', false, dadoschange.code or false)
					else
						sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] é suspeito de usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(data.resource and data.resource ~= false and data.resource ~= 'N/A' and '\n RESOURCE: '..data.resource or ' ')..' '..(data.file and data.file ~= false and data.file ~= 'N/A' and '\n FILE: '..data.file or '')..' '..(data.line and data.line ~= false and data.line ~= 'N/A' and '\n LINE: '..data.line or ' ')..' '..(data.func and data.func ~= false and data.func ~= 'N/A' and '\n FUNCTION: '..data.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n SERVIDOR: '..getServerConfigSetting('servername')..'\n Computer: ```'..(dadoschange.computer and type(dadoschange.computer) == 'table' and inspect(dadoschange.computer):gsub('[{}]', '') or 'N/A')..'```', 10181046, 'https://discord.com/api/webhooks/1209244798674800680/Id4x2FfdeNpupV27PqTi9ErAteSlDPbNr4U1kHb0lxNDEJ80Pb-e-pE6TKima0bOr5RI', false, dadoschange.code or false)
					end
				end
				return false;
			end
		end
	end

	function functions.antinoscreen()
		while true do
			for i, v in pairs(lua.redirectpunishment) do
				local player = getPlayerBySerial(i)
				if i and player and isElement(player) then
					if (v.time and os.time() > v.time) then
						local dadoschange = {
							name = getElementName(player) or 'N/A',
							player = getElementName(player) or 'N/A',
							element = player,
							id = settings.functions['getid'](player) or 'N/A',
							serial = i or player.serial or false,
							account = settings.functions['getaccount'](player) or 'N/A',
							punish = settings['modules'][v.reason] and ({kick='kickado', ban='banido', warning='Suspeito'})[settings['modules'][v.reason].action:lower()] or false,
							ip = player.ip or 'N/A',
							discordid = lua.players[player.serial] and lua.players[player.serial].discordid ~= 'false' and lua.players[player.serial].discordid ~= 'N/A' and lua.players[player.serial].discordid ~= 0 and lua.players[player.serial].discordid or false,
							resource = v.resource or nil,
							line = v.line or nil,
							file = v.file or nil,
							func = v.func or nil,
							reason = v.reason or v.reason or 'Anti AC Breaker',
							executortype = v.executortype or 'N/A',
							code = v.code or false,
							positionX = v.positionX or false,
							posititionY = v.positionY or false,
							positionZ = v.positionZ or false,
							dataname = v.dataname or false,
							dataold = v.dataold ~= true and v.dataold ~= false and v.dataold or false,
							datanew = v.datanew ~= true and v.datanew ~= false and v.datanew or false,
							realmodel = v.realmodel ~= false and v.realmodel ~= true and v.realmodel or 0,
							fakemodel = v.fakemodel ~= false and v.fakemodel ~= true and v.fakemodel or 0,
							button = v.button or 'N/A',
							weapon = v.weapon or 'N/A',
							timestamp = getRealTime().timestamp
						};

						if settings['modules'][dadoschange.reason].action:lower() == 'kick' then
							sendWarning(player, dadoschange.reason)

							if dadoschange.reason ~= 'Anti ScreenShot' then
								sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s'][dadoschange.reason:lower()], dadoschange).. ' \n `🛡️` *Este usuário está possivelmente usando um screenshot broken, demorou mais de ('..(settings['general'].ratelimitscreenshot*1000)..'ms) para dar uma resposta para a screenshot do módulo.*', settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s'][dadoschange.reason:lower()], false, dadoschange.code or false)
								
								if dadoschange.discordid and tonumber(dadoschange.discordid) then
									sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] foi kickado por usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(dadoschange.resource and dadoschange.resource ~= false and dadoschange.resource ~= 'N/A' and '\n RESOURCE: '..dadoschange.resource or ' ')..' '..(dadoschange.file and dadoschange.file ~= false and dadoschange.file ~= 'N/A' and '\n FILE: '..dadoschange.file or '')..' '..(dadoschange.line and dadoschange.line ~= false and dadoschange.line ~= 'N/A' and '\n LINE: '..dadoschange.line or ' ')..' '..(dadoschange.func and dadoschange.func ~= false and dadoschange.func ~= 'N/A' and '\n FUNCTION: '..dadoschange.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n DISCORD: <@'..(dadoschange.discordid)..'> \n `🛡️` *Este usuário está possivelmente usando um screenshot broken, demorou mais de ('..(settings['general'].ratelimitscreenshot*1000)..'ms) para dar uma resposta para a screenshot do módulo.* \n SERVIDOR: '..getServerConfigSetting('servername'), 10181046, 'https://discord.com/api/webhooks/1209244597084225547/tj9EQ1ZrMxntVz9o-ThvjWPy3kV44RY4hxjgH-FzeAL4bNFOFmOGIsNKqt64jFHIud8_', false, dadoschange.code or false)
								else
									sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] foi kickado por usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(dadoschange.resource and dadoschange.resource ~= false and dadoschange.resource ~= 'N/A' and '\n RESOURCE: '..dadoschange.resource or ' ')..' '..(dadoschange.file and dadoschange.file ~= false and dadoschange.file ~= 'N/A' and '\n FILE: '..dadoschange.file or '')..' '..(dadoschange.line and dadoschange.line ~= false and dadoschange.line ~= 'N/A' and '\n LINE: '..dadoschange.line or ' ')..' '..(dadoschange.func and dadoschange.func ~= false and dadoschange.func ~= 'N/A' and '\n FUNCTION: '..dadoschange.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n `🛡️` *Este usuário está possivelmente usando um screenshot broken, demorou mais de ('..(settings['general'].ratelimitscreenshot*1000)..'ms) para dar uma resposta para a screenshot do módulo.* \n SERVIDOR: '..getServerConfigSetting('servername'), 10181046, 'https://discord.com/api/webhooks/1209244597084225547/tj9EQ1ZrMxntVz9o-ThvjWPy3kV44RY4hxjgH-FzeAL4bNFOFmOGIsNKqt64jFHIud8_', false, dadoschange.code or false)
								end
							end
				
							kickPlayer(player, 'HÓRUS-AC', '[HAC]: '..string.change(settings['modules'][v.reason].punishreason, dadoschange));
							lua.redirectpunishment[i] = nil;
						elseif settings['modules'][dadoschange.reason].action:lower() == 'ban' then
							AnnounceBan(player, dadoschange.reason);
							table.insert(lua.banslist, {
								userAccount = dadoschange.account,
								userNick = dadoschange.player,
								userID = dadoschange.id,
								userIP = dadoschange.ip,
								userSerial = dadoschange.serial,
								userDiscordID = dadoschange.discordid,
								userReasonBanned = dadoschange.reason,
								userBanTime = dadoschange.timestamp
							});

							if (dadoschange.reason ~= 'Anti ScreenShot') then
								sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s'][dadoschange.reason:lower()], dadoschange).. ' \n `🛡️` *Este usuário está possivelmente usando um screenshot broken, demorou mais de ('..(settings['general'].ratelimitscreenshot*1000)..'ms) para dar uma resposta para a screenshot do módulo.*', settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s'][dadoschange.reason:lower()], false, dadoschange.code or false)
								if dadoschange.discordid and tonumber(dadoschange.discordid) then
									sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] foi banido por usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(dadoschange.resource and dadoschange.resource ~= false and dadoschange.resource ~= 'N/A' and '\n RESOURCE: '..dadoschange.resource or ' ')..' '..(dadoschange.file and dadoschange.file ~= false and dadoschange.file ~= 'N/A' and '\n FILE: '..dadoschange.file or '')..' '..(dadoschange.line and dadoschange.line ~= false and dadoschange.line ~= 'N/A' and '\n LINE: '..dadoschange.line or ' ')..' '..(dadoschange.func and dadoschange.func ~= false and dadoschange.func ~= 'N/A' and '\n FUNCTION: '..dadoschange.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n DISCORD: <@'..(dadoschange.discordid)..'> \n `🛡️` *Este usuário está possivelmente usando um screenshot broken, demorou mais de ('..(settings['general'].ratelimitscreenshot*1000)..'ms) para dar uma resposta para a screenshot do módulo.* \n SERVIDOR: '..getServerConfigSetting('servername'), 10181046, 'https://discord.com/api/webhooks/1209246258267688970/kMWxkdg6rycHLvyEqM7tqMUxenHDZCJrIZYwJBkSUiiHN7Qn6Gdkg7859K9t0JKySCIQ', false, dadoschange.code or false)
								else
									sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] foi banido por usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(dadoschange.resource and dadoschange.resource ~= false and dadoschange.resource ~= 'N/A' and '\n RESOURCE: '..dadoschange.resource or ' ')..' '..(dadoschange.file and dadoschange.file ~= false and dadoschange.file ~= 'N/A' and '\n FILE: '..dadoschange.file or '')..' '..(dadoschange.line and dadoschange.line ~= false and dadoschange.line ~= 'N/A' and '\n LINE: '..dadoschange.line or ' ')..' '..(dadoschange.func and dadoschange.func ~= false and dadoschange.func ~= 'N/A' and '\n FUNCTION: '..dadoschange.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n `🛡️` *Este usuário está possivelmente usando um screenshot broken, demorou mais de ('..(settings['general'].ratelimitscreenshot*1000)..'ms) para dar uma resposta para a screenshot do módulo.* \n SERVIDOR: '..getServerConfigSetting('servername'), 10181046, 'https://discord.com/api/webhooks/1209246258267688970/kMWxkdg6rycHLvyEqM7tqMUxenHDZCJrIZYwJBkSUiiHN7Qn6Gdkg7859K9t0JKySCIQ', false, dadoschange.code or false)
								end
							end
							lua.connection:exec('INSERT INTO `banList` (userNick, userID, userAccount, userIP, userSerial, userDiscordID, userReasonBanned, userBanTime, screenshot64) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', dadoschange.player, dadoschange.id, dadoschange.account, dadoschange.ip, dadoschange.serial, dadoschange.discordid, dadoschange.reason, dadoschange.timestamp, 0);
							if settings['general'].defaultban then
								banPlayer(player, true, true, true, 'HÓRUS-AC', '[HAC]: '..string.change(settings['modules'][v.reason].punishreason, dadoschange))
							else
								kickPlayer(player, 'HÓRUS-AC', '[HAC]: '..string.change(settings['modules'][v.reason].punishreason, dadoschange))
							end
							lua.redirectpunishment[i] = nil;
						elseif settings['modules'][dadoschange.reason].action:lower() == 'warning' then
							if (dadoschange.reason ~= 'Anti ScreenShot') then
								sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s'][dadoschange.reason:lower()], dadoschange).. ' \n `🛡️` *Este usuário está possivelmente usando um screenshot broken, demorou mais de ('..(settings['general'].ratelimitscreenshot*1000)..'ms) para dar uma resposta para a screenshot do módulo.*', settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s'][dadoschange.reason:lower()], false, dadoschange.code or false)
								if dadoschange.discordid and tonumber(dadoschange.discordid) then
									sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] é suspeito de usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(dadoschange.resource and dadoschange.resource ~= false and dadoschange.resource ~= 'N/A' and '\n RESOURCE: '..dadoschange.resource or ' ')..' '..(dadoschange.file and dadoschange.file ~= false and dadoschange.file ~= 'N/A' and '\n FILE: '..dadoschange.file or '')..' '..(dadoschange.line and dadoschange.line ~= false and dadoschange.line ~= 'N/A' and '\n LINE: '..dadoschange.line or ' ')..' '..(dadoschange.func and dadoschange.func ~= false and dadoschange.func ~= 'N/A' and '\n FUNCTION: '..dadoschange.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ')..'\n DISCORD: <@'..(dadoschange.discordid)..'> \n `🛡️` *Este usuário está possivelmente usando um screenshot broken, demorou mais de ('..(settings['general'].ratelimitscreenshot*1000)..'ms) para dar uma resposta para a screenshot do módulo.* \n SERVIDOR: '..getServerConfigSetting('servername'), 10181046, 'https://discord.com/api/webhooks/1209244798674800680/Id4x2FfdeNpupV27PqTi9ErAteSlDPbNr4U1kHb0lxNDEJ80Pb-e-pE6TKima0bOr5RI', false, dadoschange.code or false)
								else
									sendcustomhook('HÓRUS ANTI CHEAT', '\n O jogador '..dadoschange.player..' ['..dadoschange.id..'] é suspeito de usar '..removeAnti(dadoschange.reason)..'!\n SERIAL: '..dadoschange.serial..' \n IP: '..dadoschange.ip.. ' '..(dadoschange.resource and dadoschange.resource ~= false and dadoschange.resource ~= 'N/A' and '\n RESOURCE: '..dadoschange.resource or ' ')..' '..(dadoschange.file and dadoschange.file ~= false and dadoschange.file ~= 'N/A' and '\n FILE: '..dadoschange.file or '')..' '..(dadoschange.line and dadoschange.line ~= false and dadoschange.line ~= 'N/A' and '\n LINE: '..dadoschange.line or ' ')..' '..(dadoschange.func and dadoschange.func ~= false and dadoschange.func ~= 'N/A' and '\n FUNCTION: '..dadoschange.func or ' ')..' '..(dadoschange.dataname and dadoschange.dataname ~= false and dadoschange.dataname ~= 'N/A' and '\n DATA: '..dadoschange.dataname or ' ')..' '..(dadoschange.dataold and dadoschange.dataold ~= false and dadoschange.dataold ~= 'N/A' and '\n DATA OLD: '..dadoschange.dataold or ' ')..' '..(dadoschange.datanew and dadoschange.datanew ~= false and dadoschange.datanew ~= 'N/A' and '\n DATA: '..dadoschange.datanew or ' ')..' '..(dadoschange.executortype and dadoschange.executortype ~= false and dadoschange.executortype ~= 'N/A' and '\n EXECUTOR TYPE: '..dadoschange.executortype or ' ')..' '..(dadoschange.positionX and dadoschange.positionY and dadoschange.positionZ and '\n POSITION: '..dadoschange.positionX..', '..dadoschange.positionY..', '..dadoschange.positionZ or ' ').. ' \n `🛡️` *Este usuário está possivelmente usando um screenshot broken, demorou mais de ('..(settings['general'].ratelimitscreenshot*1000)..'ms) para dar uma resposta para a screenshot do módulo.* \n SERVIDOR: '..getServerConfigSetting('servername'), 10181046, 'https://discord.com/api/webhooks/1209244798674800680/Id4x2FfdeNpupV27PqTi9ErAteSlDPbNr4U1kHb0lxNDEJ80Pb-e-pE6TKima0bOr5RI', false, dadoschange.code or false)
								end
							end
							lua.redirectpunishment[i] = nil;
						end
						if (lua.redirectpunishment[i]) then
							lua.redirectpunishment[i] = nil;
						end
					end
				else
					lua.redirectpunishment[i] = nil;
				end
				Wait(500)
			end
			Wait((waits.antinoscreen or 1500));
		end
	end

	function functions.requestreport(victim, attacker, reason)
		if (not client) then
			return false;
		end

		local dadoschange = {
			victim = getElementName(victim) or 'N/A',
			victimid = settings.functions['getid'](victim) or 'N/A',
			victimserial = victim.serial,
			victimip = victim.ip,
			attacker = getElementName(attacker) or 'N/A',
			attackerid = settings.functions['getid'](attacker) or 'N/A',
			attackerserial = attacker.serial,
			attackerip = attacker.ip,
		};
		sendcustomhook(settings['webhook´s'].title, string.change('O jogador ${victim} [${victimid}] reportou uma colisão não confiável de ${attacker} [${attackerid}] \n SERIAL VITIMA: ${victimserial} \n SERIAL ATTACKER: ${attackerserial} \n IP VITIMA: ${victimip} \n IP ATTACKER: ${attackerip}', dadoschange), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s'][reason:lower()])
	end

	function functions.onReceiveScreenShot(uuid, screenshot)
		if (not uuid or not client) then
			return false;
		end

		local decoded = decodeString('tea', uuid, {key = 'SG9ydXMgQUMgw6kgbyBtZWxob3IgYW50aSBjaGVhdA'});
		if decoded and getPlayerBySerial(decoded) and isElement(client) then
			local player = getPlayerBySerial(decoded)
			triggerEvent('onPlayerScreenShot', client, thisresource, 'ok', screenshot, getRealTime().timestamp, decoded);
			return true;
		elseif (decoded and isElement(client)) then
			triggerEvent('onPlayerScreenShot', client, (thisresource or getThisResource()), 'ok', screenshot, getRealTime().timestamp, 'CONSOLE-SCREENSHOT');
		end
	end

	function functions.commands(player, cmd, typecommand, ...)
		if (not player or not isElement(player)) then
			return false;
		end
		local _type = getElementType(player)

		if (not typecommand and _type == 'console') then
			outputServerLog('[ERROR]: Tipo de comando não especificado')
			return false;
		elseif (not typecommand and _type == 'player') then
			settings.functions['sendnotify']('server', player, 'error', '[HAC]: Tipo de comando não especificado');
			return false;
		end

		if typecommand:lower() == 'removeban' then
			if (not isPlayerAdmin(player) and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Você não tem permissão para isso.');
				return false;
			end
			local args = {...}
		
			if (not args[1] and _type == 'console') then
				outputServerLog('[ERROR]: serial ou ID inválido.')
				return false;
			elseif (not args[1] and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: serial ou ID inválido.');
				return false;
			end

			if args[1] and not tonumber(args[1]) then
				local vban, itban = getPlayerBanBySerial(args[1]);
				if itban and vban then
					for i, v in ipairs(getBans()) do 
						if v.serial == args[1] then
							v:remove();
						end
					end
					table.remove(lua.banslist, itban);
					if (#dbPoll(dbQuery(lua.connection, 'SELECT * FROM banList WHERE userSerial = ?', vban.userSerial), - 1) ~= 0) then
						lua.connection:exec('DELETE FROM banList WHERE userSerial = ?', vban.userSerial)
					end
					if (_type == 'console') then
						outputServerLog('[SUCESSO]: Ban removido da database.')
					elseif (_type == 'player') then
						settings.functions['sendnotify']('server', player, 'error', '[HAC]: Ban removido da database.');
					end
					return true;
				else
					if (_type == 'console') then
						outputServerLog('[ERROR]: Não existe um ban com esse serial na database!')
					elseif (_type == 'player') then
						settings.functions['sendnotify']('server', player, 'error', '[HAC]: Não existe um ban com esse serial na database!');
					end
					return false;
				end
			elseif args[1] and tonumber(args[1]) then
				local vban, itban = getPlayerBanByID(args[1]);
				if itban and vban then
					for i, v in ipairs(getBans()) do 
						if v.serial == vban.userSerial then
							v:remove();
						end
					end
					table.remove(lua.banslist, itban);
					if (#dbPoll(dbQuery(lua.connection, 'SELECT * FROM banList WHERE userSerial = ?', vban.userID), - 1) ~= 0) then
						lua.connection:exec('DELETE FROM banList WHERE userSerial = ?', vban.userID)
					end
					if (_type == 'console') then
						outputServerLog('[SUCESSO]: Ban removido da database.')
					elseif (_type == 'player') then
						settings.functions['sendnotify']('server', player, 'error', '[HAC]: Ban removido da database.');
					end
					return true;
				else
					if (_type == 'console') then
						outputServerLog('[ERROR]: Não existe um ban com esse id na database!')
					elseif (_type == 'player') then
						settings.functions['sendnotify']('server', player, 'error', '[HAC]: Não existe um ban com esse id na database!');
					end
					return false;
				end
			end
		elseif (typecommand:lower() == 'inspect') then
			local args = {...}

			if (not isPlayerAdmin(player) and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Você não tem permissão para isso.');
				return false;
			end
			player_cheater = tonumber(args[1]) and getPlayerFromID(args[1]) or getPlayerFromName(args[1])
			if (not isElement(player_cheater)) then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Não existe nenhum jogador online com esse NOME ou ID.');
				return false;
			end
			lua.inspectSender[player_cheater] = player
			triggerClientEvent(player_cheater, 'd4ce288bbaf7f622f2a8a1dbc76c7e93', resourceRoot);
		elseif typecommand:lower() == 'wallhack' then
			if (not isPlayerAdmin(player) and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Você não tem permissão para isso.');
				return false;
			end
			local args = {...};
			if (getPlayerFromID(args[1]) == player) then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Você não pode usar o wallhack em sí mesmo.');
				return false;
			end
			triggerClientEvent(player, '7fd6ea0b24fcb59393e2929bacebc95c', resourceRoot, args[1]); -- wallhack toggle
			return true;
		elseif typecommand:lower() == 'screenshot' then
			local args = {...}
			local player_cheater = tonumber(args[1]) and getPlayerFromID(args[1]) or getPlayerFromName(args[1]);
			if (not isPlayerAdmin(player) and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Você não tem permissão para isso.');
				return false;
			end

			if (not args[1] and _type == 'console') then
				outputServerLog('[ERROR]: sintaxe incorreta (formato: /hac screenshot (id ou nome)!');
				return false;
			elseif (not args[1] and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: sintaxe incorreta (formato: /hac screenshot (id ou nome)!');
				return false;
			end

			if (not isValidPlayer(player_cheater) and _type == 'console') then
				outputServerLog('[ERROR]: Jogador não está online');
				return false;
			elseif (not isValidPlayer(player_cheater) and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Jogador não está online');
				return false;
			end

			if (((lua.players[player_cheater.serial].screenshot and lua.players[player_cheater.serial].screenshot or 0) > os.time()) and _type == 'console') then
				outputServerLog('[ERROR]: Você poderá tirar print desse jogador novamente em '..lua.players[player_cheater.serial].screenshot - os.time()..'s');
				return false;
			elseif (((lua.players[player_cheater.serial].screenshot and lua.players[player_cheater.serial].screenshot or 0) > os.time()) and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Você poderá tirar print desse jogador novamente em '..lua.players[player_cheater.serial].screenshot - os.time()..'s');
				return false;
			end

			if player and isElement(player) and player_cheater and isValidPlayer(player_cheater) then
				if (_type == 'console') then
					outputServerLog('[SUCESSO]: screenshot tirada com sucesso, ela será enviada para o discord ou salvada na pasta em alguns segundos!');
				elseif (_type == 'player') then
					settings.functions['sendnotify']('server', player, 'success', '[HAC]: screenshot tirada com sucesso, ela será enviada para o discord ou salvada na pasta em alguns segundos!');
				end
				lua.players[player_cheater.serial].screenshot = os.time() + 15
				local hash = encodeString('tea', (player.serial or 'CONSOLE-SCREENSHOT'), {key = 'SG9ydXMgQUMgw6kgbyBtZWxob3IgYW50aSBjaGVhdA'})
				triggerClientEvent(player_cheater, 'onClientLoadTexture', resourceRoot, hash)
				--player_cheater:takeScreenShot(1280, 720, player.serial or 'CONSOLE-SCREENSHOT', (settings['general'].screenshotquality or 20));
				return true;
			end
		elseif typecommand:lower() == 'compileall' then
			if (not isPermissionToCompile(player) and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Você não tem permissão para isso.');
				return false;
			end
			local dados = {
				player = getElementName(player),
				id = settings.functions['getid'](player),
				action = 'Compilou',
				resource = 'todos resources'
			}
			sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s']['anti dump'], dados), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s']['anti dump'])
			lua.resourcesrow = getResources()
			lua.resourcesindex = 0
			compileNext()
		elseif typecommand:lower() == 'uncompileall' then
			if (not isPermissionToCompile(player) and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Você não tem permissão para isso.');
				return false;
			end
			local dados = {
				player = getElementName(player),
				id = settings.functions['getid'](player),
				action = 'Descompilou',
				resource = 'todos resources'
			}
			sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s']['anti dump'], dados), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s']['anti dump'])
			lua.resourcesrow = getResources()
			lua.resourcesindex = 0
			decompileNext()
		elseif typecommand:lower() == 'compile' then
			local args = {...}
			if (not isPermissionToCompile(player) and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Você não tem permissão para isso.');
				return false;
			end
			if not args[1] then
				return false;
			end
			if not getResourceFromName(args[1]) then
				return false;
			end
			local resource = getResourceFromName(args[1])
			if resource then
				local dados = {
					player = getElementName(player),
					id = settings.functions['getid'](player),
					action = 'compilou',
					resource = 'o resource '..args[1]
				}
				sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s']['anti dump'], dados), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s']['anti dump'])	
				compileThis(args[1])
			end
		elseif typecommand:lower() == 'uncompile' then
			local args = {...}
			if (not isPermissionToCompile(player) and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Você não tem permissão para isso.');
				return false;
			end
			if not args[1] then
				return false;
			end
			if not getResourceFromName(args[1]) then
				return false;
			end
			local resource = getResourceFromName(args[1])
			if resource then
				local dados = {
					player = getElementName(player),
					id = settings.functions['getid'](player),
					action = 'descompilou',
					resource = 'o resource '..args[1]
				}
				sendcustomhook(settings['webhook´s'].title, string.change(settings['webhook´s']['message´s']['anti dump'], dados), settings['webhook´s'].color or 3553599, settings['webhook´s']['url´s']['anti dump'])
				decompileThis(args[1])
			end
		elseif typecommand:lower() == 'status' then
			local args = {...}
			if (not isPlayerAdmin(player) and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Você não tem permissão para isso.');
				return false;
			end
			outputChatBox(' ', player);
			outputChatBox(' ', player);
			outputChatBox(' ', player);
			outputChatBox(' ', player);
			outputChatBox(' ', player);
			outputChatBox(' ', player);
			outputChatBox(' ', player);
			outputChatBox(' ', player);
			outputChatBox('VERSÃO DO HÓRUS ANTI CHEAT: '..tostring(getResourceInfo (getThisResource(), 'version')), player, 255, 255, 255);
			return true;
		elseif typecommand:lower() == 'addwl' then
			local args = {...}
			if (not isPlayerAdmin(player) and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Você não tem permissão para isso.');
				return false;
			end
			if (lua.whitelists[args[1]] and _type == 'console') then
				outputServerLog('[ERROR]: Esse jogador já está na whitelist');
				return false;
			elseif (lua.whitelists[args[1]] and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Esse jogador já está na whitelist');
				return false;
			end
			if (_type == 'console') then
				outputServerLog('[SUCESSO]: O jogador foi adicionado na whitelist');
			elseif ( _type == 'player') then
				settings.functions['sendnotify']('server', player, 'success', '[HAC]: O jogador foi adicionado na whitelist');
			end
			lua.whitelists[args[1]] = true;
			lua.connection:exec('INSERT INTO `whitelist` (serial) VALUES (?)', args[1]);
		elseif typecommand:lower() == 'remwl' then
			local args = {...}
			if (not isPlayerAdmin(player) and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Você não tem permissão para isso.');
				return false;
			end
			if (not lua.whitelists[args[1]] and _type == 'console') then
				outputServerLog('[ERROR]: Esse jogador já está na whitelist');
				return false;
			elseif (not lua.whitelists[args[1]] and _type == 'player') then
				settings.functions['sendnotify']('server', player, 'error', '[HAC]: Esse jogador Não está na whitelist');
				return false;
			end
			if ((#dbPoll(dbQuery(lua.connection, 'SELECT * FROM whitelist WHERE serial = ?', args[1]), - 1) ~= 0)) then
				lua.whitelists[args[1]] = true;
				lua.connection:exec('DELETE FROM `whitelist` WHERE serial = ?', args[1]);
				if (_type == 'console') then
					outputServerLog('[SUCESSO]: O jogador foi removido da whitelist');
					return false;
				elseif ( _type == 'player') then
					settings.functions['sendnotify']('server', player, 'success', '[HAC]: O jogador foi removido da whitelist');
					return false;
				end
			end
		end
	end
end


return (function()
    setmetatable({}, {
      __call = function(...)
        return startsfunctions('VSF JOAO')
      end
    })()
end)()