local function startsendhook()

	local thisresource = getThisResource() or false;

	function sendhook(mensagem, url)
		sendOptions = {
			queueName = "dcq",
			connectionAttempts = 10,
			connectionTimeout = 20000,
			formFields = {
				content = "```\n"..mensagem.."```",
			},
		}
		fetchRemote(url, sendOptions, function() end)
	end
		
	function spyhook(message, url, name)
		sendOptions = {
			queueName = "dcq",
			connectionAttempts = 10,
			connectionTimeout = 20000,
			formFields = {
				content = message,
				username = name or "N/A",
			},
		}
		fetchRemote(url, sendOptions, function() end)
	end

	function sendcustomhook(titulo, mensagem, color, url, urlimage, code)
		if titulo and mensagem and url then
			local dados = {};
			local color = color or 0;
			if not color then
				color = 3553599
			end
			if urlimage then
			dados = {
				embeds = {
					{ -- embed 1
					image = {
						url = urlimage
					}, 
					title = titulo,
					color = color,
					description = mensagem,
					fields = {
						{
							name = code and 'Detalhes: ' or ' \n',
							value = code and '```lua\n '..code..' ```' or ' \n',
						},
					},
					footer = {
						text = 'Hoje ás '..os.date('%H:%M')..' | '..os.date('%d/%m/%Y'),
						icon_url = 'https://cdn.discordapp.com/icons/1189293467298443304/b83496b879abbdcbdf8dfac0a987be97.png'
						},
					},
				}
			}
		else
			dados = {
				embeds = {
					{ -- embed 1
					title = titulo,
					color = color,
					description = mensagem,
					fields = {
						{
							name = code and 'Detalhes: ' or ' \n',
							value = code and '```lua\n '..code..' ```' or ' \n',
						},
					},
					footer = {
						text = 'Hoje ás '..os.date('%H:%M')..' | '..os.date('%d/%m/%Y'),
						icon_url = 'https://cdn.discordapp.com/icons/1189293467298443304/b83496b879abbdcbdf8dfac0a987be97.png',
						},
					},
				}
			}
		end
			dados = toJSON(dados)
			dados = dados:sub(2, -2)
			local opt = {
				connectionAttempts = 10,
				connectTimeout = 15000,
				headers = {
					["Content-Type"] = "application/json"
				},
				postData = dados
			}
			fetchRemote ( url, opt, function() return true end)
		end
	end

	---------------------
end

return (function()
    setmetatable({}, {
      __call = function(...)
        return startsendhook()
      end
    })()
end)()
