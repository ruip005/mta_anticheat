local settings
function getSettings()
    return settings or true;
end

--- NÃO MEXA EM NADA DAQUI PRA CIMA!! ---

configLicense = {
    ['User'] = '',
    ['Key'] = '',
}

settings = {
    ['general'] = {
        updates = false, -- se true irá avisar de futuros updates sempre que iniciar o resource.
        wallHackMaxDistance = 2000, --- distancia wall hack para staff
        screenshotquality = 30, -- quanto maior for a qualidade, mais tempo vai demorar para o processamento do ban ser feito!
        colors = '#00ff00', -- cor de destaque de algumas mensagens exemplo, alertas e avisos de banimentos. 
        globalnotify = true, -- notificação global chat, warning bans etc
        defaultban = false, -- se ativo usará apenas o banimento do anti cheat(não tem muita diferença, apenas que o banimento do anti cheat é full tabelas e database)
        erros_log = true, -- se desativo não enviará logs de erros do ac para o discord
        elementdataloggedin = 'HAC:LoggedIn', -- elementdata usada para verificar se o jogador está ou não logado
        ratelimitscreenshot = 30, --caso o módulo tenha screenshot ativa e não seja enviado nada nesse tempo, irá prosseguir sem a screenshot.

        --[[
            PERMISSÕES
        ]]--

        notify = function(player)
            return isElementOnGroup(player, 'Console') or isElementOnGroup(player, 'Admin') or isElementOnGroup(player, 'Staff');
        end,

        commands = function(player)
            return isElementOnGroup(player, 'Console') or isElementOnGroup(player, 'Admin');
        end,

        screenshot = function(player)
            return isElementOnGroup(player, 'Console') or isElementOnGroup(player, 'Admin');
        end,

        compiler = function(player)
            return isElementOnGroup(player, 'Console');
        end,

        language = { -- languages
            use = 'english',

            ['portuguese'] = {
                ['failed connect db'] = 'Falha ao conectar na database.',
                ['loading modules'] = 'Carregando módulos...',
                ['module loaded'] = 'Módulo ${module} carregado com sucesso.',
                ['loaded punishments'] = 'banimentos carregados.',
                ['resource started'] = 'Resource iniciado com sucesso.',
                ['looking for updates'] = 'Buscando por atualizações...',
                ['auto-update failed'] = 'error ao verificar a versão atual do anti cheat.',
                ['not registred event'] = 'Não foi possivel registrar o evento ${eventname}',
            },

            ['english'] = {
                ['failed connect db'] = 'Não foi possivel conectar a database.',
                ['loading modules'] = 'Loading modules...',
                ['module loaded'] = 'Module ${module} loaded successfully.',
                ['loaded punishments'] = 'bans loaded',
                ['resource started'] = 'Resource started successfully.',
                ['looking for updates'] = 'Looking for updates...',
                ['auto-update failed'] = 'error when checking the current version of anti cheat.',
                ['not registred event'] = 'Unable to register the event ${eventname}',
            },

            ['spanish'] = {
                ['failed connect db'] = 'Error al conectarse a la base de datos.',
                ['loading modules'] = 'Cargando módulos...',
                ['module loaded'] = 'El módulo ${module} se cargó correctamente.',
                ['loaded punishments'] = 'prohibiciones cargadas',
                ['resource started'] = 'El resource se inició correctamente',
                ['looking for updates'] = 'Buscando actualizaciones...',
                ['auto-update failed'] = 'error al comprobar la versión actual de anti trampa.',
                ['not registred event'] = 'No se puede registrar el evento ${eventname}',
            },

        },
    };

    ['modules'] = {
        ['WhiteListed Countrys'] = {
            state = true;
            punishreason = 'Você tentou logar de um país não permitido!';
            whitelist = {
                ['US'] = true,
                ['BR'] = true,
                ['RU'] = true,
                ['IR'] = true,
                ['UK'] = true,
                ['GB'] = true,
                ['PT'] = true,
                ['AR'] = true
            },
        };

        ['Suspect Keys'] = {
            state = true;
            action = 'warning', -- NÃO MEXER!!
            screenshot = true,
            keys = {
                ['insert'] = true,
                ['f12'] = true,
            },
        };

        ['Triggers Monitor'] = { -- essa função monitora os triggers
            state = true,
            events = {
                ['relWep'] = true,
                ['onPlayerRequestScoreboardBanners'] = true,
            },
        };

        ['Anti Event Flood'] = {
            state = true,
            --[[ 
                ESSA PARTE SÓ FUNCTIONARÁ CASO SEU SERVIDOR MTA ESTEJA ATUALIZADO PRA VERSÃO: 
                MTA Server 1.6.0 r22313 OU SUPERIOR! 
             ]]--
            interval = 500,
            maxeventsperiterval = 200,
        };

        ['Serial Change'] = {
            state = true,
            punishreason = 'Serial change',
        };

        ['Serial Cloner'] = {
            state = true,
            punishreason = 'Já existe um jogador online com esse serial.',
        };

        ['Anti AC Breaker'] = {
            state = true, -- são duas verificações feitas
            punishreason = 'Não foi possivel verificar sua auth token',
            
            codes = {
                [9811] = 'You are banned permanently for AC #9811',
                [9815] = 'You are banned permanently for AC #9815',
                [9816] = 'You are banned permanently for AC #9816',
                [9800] = 'You are banned permanently for AC #9800',
                [9710] = 'You are banned permanently for AC #9710',
                [9000] = 'You are banned permanently for AC #9000',
                [1313] = 'You are banned permanently for AC #1313',
                [1777] = 'You are banned permanently for AC #1717'
            },
        };

        ['Anti Gank'] = {
            state = true, -- essa função bloqueia o uso de redirectPlayer e deleteResource do lado server para que caso algo aconteça, você não perca seus jogadores ou backup.
        };

        ['Anti Dump'] = {
            state = false, -- se ativo está função irá ser ligada(apenas ative essa função quando você for usar!)
        };

        ['Anti Reconnect'] = { -- essa função é para evitar injetores de lua que precisam reconectar para injetar!
            state = true, -- se ativo está função irá ser ligada.
            punishreason = 'Não foi possivel verificar sua autenticidade, tente novamente',
            cooldown = 15000, -- tempo em que o jogador precisa esperar para relogar!
        };

        ['Anti Menu'] = { -- essa função é para detectar automaticamente usuários com Opressor, VBR, Deadly, etc...
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            punishreason = 'Você foi ${punish} por utilizar ModMenu',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            bypass = function(player)
                return false;
            end,

        };

        ['Anti VBR'] = { -- essa função é para detectar automaticamente usuários com VBR
            state = true, -- se ativo está função irá ser ligada.
            punishreason = 'Você foi ${punish} por usar VBR CHEATS.',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            bypass = function(player)
                return false;
            end,
        };

        ['Anti MenuGui'] = { -- essa função é para detectar automaticamente usuários com Shine e outros
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            punishreason = 'Você foi ${punish} por utilizar ModMenu',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            bypass = function(player)
                return false;
            end,

            resources = { -- coloque os resources que usam painel GUI, como painel p e sua senha padrão, 
                 ['admin4'] = true,
                 ['ipb'] = true,
            },
        };

        ['Anti KillNoID'] = { -- essa função cancelará danos causados por jogadores sem ID
            state = true, -- se ativo está função irá ser ligada.
            screenshot = false,
            punishreason = 'Você foi ${punish} por utilizar Kill NOID',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            bypass = function(player)
                return false;
            end,

        };

        ['Anti Events'] = {
            state = true,
            screenshot = false,
            punishreason = 'Você foi ${punish} por utilizar forced Triggers',
            action = 'warning',

            talking = {
                ['infinity_hud'] = {
                    'infinity_login',
                    'infinity_scoreboard'
                }, -- nesse exemplo a hud poderá enviar triggers para o login e scoreboard.
            },
            
            bypass = function(player)
                return false;
            end,

        };

        ['Anti MaxDamage'] = { -- essa função detecta danos alterados ou máximados. (ChangeDamage or MaxDamage)
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            maxDamageVehicle = 300,
            punishreason = 'Você foi ${punish} por utilizar MaxDamage',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            bypass = function(player)
                return player:getData('Hac.Bypass')-- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end, 

        };

        ['Anti MaxClip'] = { -- essa função detecta balas no pente a mais do que o normal do jogo.
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,        
            punishreason = 'Você foi ${punish} por utilizar MaxClip',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            --[[
                PARA MELHOR OTIMIZAÇÃO E LIBERDADE, o bypass é uma função com return,
                se retornar true irá dar bypass e se retornar false, nil, string etc etc,
                irá ignorar, usamos a mesma função backend e frontend, por isso seja cauteloso no exemplo
                abaixo:

                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                -- dessa forma só irá checar por essa elementdata quando a função for chamada do lado client,
                    é útil para caso você use um exports de outros resources lado client ou server
                    se atente a isso para não ocorrer erros...
            ]]--

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') or isElementOnGroup(player, 'Console'); -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };

        ['Weapon Blocked'] = { -- essa função aqui bloqueia de ele alterar a handling de um veículo que ele não está dentro.
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            punishreason = 'Você foi ${punish} por utilizar armas proibidas.',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 
            
            weapons = {
                [31] = true,
                [36] = true,
                [37] = true,
                [38] = true,
                [18] = true,
                [39] = true,
                [17] = true,
                [16] = true,
                [40] = true,
            },

            bypass = function(player)
                return player:getData('Hac.Bypass') or isElementOnGroup(player, 'Console'); -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };

        ['Anti AirBreak'] = {
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            velocity = 20, -- velocidade voando para cima
            velocityBreak = 40, -- velocidade contra AirBreak stayZ
            height = 4, -- altura para banimentos do fly voando
            punishreason = 'Você foi ${punish} por utilizar Fly',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') --or isElementOnGroup(player, 'Console'); -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };
        ['Anti GhostMode'] = {
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            punishreason = 'Você foi ${punish} por utilizar Fly',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            bypass = function()
                return false;
            end,
        };
        ['Anti VehicleFly'] = {
            state = true, -- se ativo está função irá ser ligada.
            screenshot = false,
            punishreason = 'Você foi ${punish} por utilizar Vehicle Fly',
            action = 'kick', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') --or isElementOnGroup(player, 'Console'); -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };
        ['Anti MoveSpeed'] = {
            state = true, -- se ativo está função irá ser ligada.

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,
        };

        ['Anti Teleport'] = {
            state = false, -- se ativo está função irá ser ligada.
            screenshot = true,
            distance = 100, -- distância do teleport
            punishreason = 'Você foi ${punish} por utilizar Teleport',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas.

            --[[
                PARA MELHOR OTIMIZAÇÃO E LIBERDADE, o bypass é uma função com return,
                se retornar true irá dar bypass e se retornar false, nil, string etc etc,
                irá ignorar, usamos a mesma função backend e frontend, por isso seja cauteloso no exemplo
                abaixo:

                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                -- dessa forma só irá checar por essa elementdata quando a função for chamada do lado client,
                    é útil para caso você use um exports de outros resources lado client ou server
                    se atente a isso para não ocorrer erros...
            ]]--

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };

        ['Anti Fix'] = {
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            punishreason = 'Você foi ${punish} por utilizar FixCheat',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas.

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass')-- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };

        ['Anti GameSpeed'] = {
            state = true, -- se ativo está função irá ser ligada.
            screenshot = false,
            punishreason = 'Você foi ${punish} por utilizar gamespeed',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') or isElementOnGroup(player, 'Console'); -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };

        ['Anti ScreenShot'] = {
            state = true, -- se ativo está função irá ser ligada.
            punishreason = 'Por favor permita que o servidor tire screenshot de sua tela [ESC > CONFIG > MARCAR CAIXA PERMITIR UPLOAD DE SCREENSHOTS].',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') or isElementOnGroup(player, 'Console'); -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };

        ['Anti ElementDataChange'] = {
            state = true, -- se ativo está função irá ser ligada.
            screenshot = false,
            punishreason = 'Você foi ${punish} por utilizar elementdatachange.',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            --[[
                se quiser escolher certos tipos de elementos usar o exemplo: {['player'] = true, ['vehicle'] = true, ['colshape'] = true, ['marker'] = true},
                veja a lista de elementos possiveis aqui: https://wiki.multitheftauto.com/wiki/Element 
            ]]--

            types = {
                ['player'] = true,
                ['vehicle'] = true,
                ['marker'] = true,
                ['colshape'] = true,
            },
            
            dates = {
                ['staff:wall'] = true,
                ['staff:point'] = true,
            },

            bypass = function(player)
                return false;
            end,

        };
        
        ['Anti LuaExecutor'] = {
            state = true, -- se ativo está função irá ser ligada.
            screenshot = false,
            punishreason = 'Você foi ${punish} por utilizar Lua Executor.',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            resources = { -- scripts com bypass
               ['runcode'] = true,
            },

            bypass = function(player, forabinis)
                return false;
            end,

        };

        ['Anti VehicleHack'] = { -- essa função é para proibir certos hacks de tunning do veiculo, como o carro voar etc(ela bloqueia o setVehicleHandling no client, mas apenas aquelas variaveis ali abaixo)
            state = true, -- se ativo está função irá ser ligada.
            screenshot = false,
            punishreason = 'Você foi ${punish} por utilizar vehicle hack.',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            propertys = { 
                ['engineAcceleration'] = true,
                ['centerOfMass'] = true,
                ['maxVelocity'] = true,
            },

            resources = { -- scripts com bypass
                ['[AS]SistemaDrift'] = true,
                ['infinity_tuning2'] = true,
            },

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') or isElementOnGroup(player, 'Console'); -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };

        ['Anti MaxCollision'] = { -- essa função é para proibir certos hacks de tunning do veiculo, como o carro voar etc(ela bloqueia o setVehicleHandling no client, mas apenas aquelas variaveis ali abaixo)
            state = true, -- se ativo está função irá ser ligada.
            screenshot = false,
            action = 'warning',

            damage = 10,

            bypass = function(player)
                return false;
            end,

        };

        ['Anti SpecialProperty'] = { -- essa função bloquea do jogador alterar o setWorldSpecialPropertyEnabled
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            punishreason = 'Você foi ${punish} por utilizar SpecialProperty.',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            propertys = { -- se você botar true a property será desativada!
                ['hovercars'] = false,
                ['aircars'] = true,
                ['extrabunny'] = false,
                ['extrajump'] = false,
                ['randomfoliage'] = true,
                ['snipermoon'] = false,
                ['extraairresistance'] = true,
                ['underworldwarp'] = true,
                ['vehiclesunglare'] = false,
                ['coronaztest'] = true,
                ['watercreatures'] = true,
                ['burnflippedcars'] = true,
                ['fireballdestruct'] = true,
            },

            resources = { -- coloque seu resource que usa setworldpropertyenabled! https://wiki.multitheftauto.com/wiki/SetWorldSpecialPropertyEnabled
                ['desempenho'] = true,
                ['antimato'] = true,		
            },

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') or isElementOnGroup(player, 'Console'); -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };

        ['Anti ElementVelocity'] = { -- essa função aqui bloqueia de ele alterar a handling de um veículo que ele não está dentro.
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            punishreason = 'Você foi ${punish} por utilizar cheat!',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas.

            resources = {
                ['EncomendaHitore'] = true,
                ['atlantic_jobtrain'] = true,
                ['parachute'] = true,
            },

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') --or isElementOnGroup(player, 'Console'); -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };

        ['Anti ESP'] = { -- essa função aqui bloqueia de ele alterar a handling de um veículo que ele não está dentro.
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            punishreason = 'Você foi ${punish} por utilizar ESP Hack!',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas.

            resources = {
                ['colorpicker'] = true,
                ['desempenho'] = true,
                ['vehicle-radio'] = true,				
                ['Clear_chat'] = true,
                ['cheatTest'] = true,
            },

            --[[
                PARA MELHOR OTIMIZAÇÃO E LIBERDADE, o bypass é uma função com return,
                se retornar true irá dar bypass e se retornar false, nil, string etc etc,
                irá ignorar, usamos a mesma função backend e frontend, por isso seja cauteloso no exemplo
                abaixo:

                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                -- dessa forma só irá checar por essa elementdata quando a função for chamada do lado client,
                    é útil para caso você use um exports de outros resources lado client ou server
                    se atente a isso para não ocorrer erros...
            ]]--

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') or isElementOnGroup(player, 'Console'); -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };

        ['Anti NoFall'] = { -- essa função aqui bloqueia de ele alterar a handling de um veículo que ele não está dentro.
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            punishreason = 'Você foi ${punish} por utilizar NoFall!',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas.

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') or isElementOnGroup(player, 'Console'); -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };

        ['Anti VehiclePull'] = { -- essa função detecta usuários puxando veículos
            state = true, -- se ativo está função irá ser ligada.
            screenshot = false,
            punishreason = 'Você foi ${punish} por utilizar VehiclePull!',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas.
            -- recomendado apenas utilizar com warning

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,
        };

        ['Anti VehicleRain'] = { -- essa função detecta usuários puxando veículos
            state = true, -- se ativo está função irá ser ligada.
            screenshot = false,
            punishreason = 'Você foi ${punish} por utilizar Car Fucker!',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas.
            -- recomendado apenas utilizar com warning

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,
        };

        ['Anti GodMode'] = { -- essa função aqui bloqueia de ele alterar a handling de um veículo que ele não está dentro.
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            punishreason = 'Você foi ${punish} por utilizar GodMode',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas.

            vehicles = { -- coloque veículos que cancelam o dano nos passageiros.
                [558] = false,
            },

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') or isElementOnGroup(player, 'Console'); -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };

        ['Anti LongRange'] = { -- essa função aqui anula dano de distâncias não permitidas!
            state = true, -- se ativo está função irá ser ligada.

            bypass = function(player)
                return false;
            end,

        };

        ['Anti SilentAim'] = { -- essa função detecta Silent Aim
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            pov = 2,
            punishreason = 'Você foi ${punish} por utilizar Silent Aim!',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas.

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') or isElementOnGroup(player, 'Console'); -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };

        ['Anti Aimbot'] = { -- essa função detecta aimbot!
            state = false, -- se ativo está função irá ser ligada.
            screenshot = true,
            flickspeed = 3,
            flags = 3,
            action = 'warning', -- não é recomendado o uso de punições nessa função.

            bypass = function(player)
                return false;
            end,
        };

        ['Anti CheatHook'] = { -- essa função aqui bloqueia a criação de debugHooks externos.
            state = true,
            punishreason = 'Você foi ${punish} por utilizar Hook Hack!',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas.

            resources = {
                ['cheatTest'] = true,
            },

            bypass = function(player)
                return false;
            end,

        };

        ['Anti VehicleGravity'] = { -- essa função bloqueia o setVehicleGravity de ser usado!
            state = true, -- se ativo está função irá ser ligada.
            screenshot = false,
            punishreason = 'Você foi ${punish} por utilizar vehicle gravity.',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas.

            resources = {
                ['infinity_lowrider'] = true,
            },


            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') or isElementOnGroup(player, 'Console'); -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,
        };

        ['Anti VehicleGodMode'] = { -- essa função bloqueia o vehicleGodMode de ser usado!
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            punishreason = 'Você foi ${punish} por utilizar vehicle godmode',
            integrityCar = 350, -- Coloque o valor mínimo que um carro pode chegar no seu servidor. 
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas.
            
            resources = { -- script que utiliza setVehicleDamageProof
                ['infinity_vip'] = true,
            },

            vehicles = { -- coloque aqui veículos que não tomam dano em algum script que não utiliza setVehicleDamageProof. (Não precisa colocar de painel vip, que utilizam o VehicleDamageProof)
                [428] = true,
            },

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,
        };

        ['Anti CheatWeapons'] = { -- essa função detecta se a rma é verdadeira ou de cheat
            state = true, -- se ativo está função irá ser ligada.
            screenshot = false,
            punishreason = 'Você foi ${punish} por utilizar fake weapons.',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            bypass = function(player)
                return player:getData('isPointing') or false;
            end,

        };

        ['Anti Gravity'] = { -- essa função detecta se o jogador está na gravidade global
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            punishreason = 'Você foi ${punish} por utilizar gravidade.',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') or isElementOnGroup(player, 'Console'); -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };

        ['Anti Fake Models'] = { -- essa função detecta caso jogadores estejam com um carro com um tank do lado client e para todos ser outro veiculo.
            state = true, 
            screenshot = true,
            punishreason = 'Você foi ${punish} por utilizar Fake Car.',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            bypass = function(player)
                return player:getData('Hac.Bypass');
            end,
        };

        ['Anti Fire'] = { -- essa função irá anular criação de fogo
            state = true, -- se ativo está função irá ser ligada.
        };

        ['Anti Explosions'] = { -- essa função aqui irá desabilitar as explosões do MTA.
            state = true, -- se ativo está função irá ser ligada.
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 
            punishreason = 'Você foi ${punish} por criar explosões ilegais.',
            onlyblockall = false, --se ativado apenas irá destruir todas explosões em explosions.

            resources = { --resources permitidas de usar explosão.
                ['horus_ac'] = true,
                ['runcode'] = true
            },

            explosions = { --explosões para serem checadas.
                [0] = true,
                [1] = true,
                [2] = true,
                [3] = true,
                [4] = true,
                [5] = true,
                [6] = true,
                [7] = true,
                [8] = true,
                [9] = true,
                [10] = true,
                [11] = true,
                [12] = true,
            },

            weapons = { -- armas permitidas para usar aquele projectil
                [0] = {[16] = true},
                [1] = {[18] = true},
                [2] = {[35] = true, [36] = true},
                [3] = {[35] = true, [36] = true},
                [4] = { },
                [5] = { },
                [6] = { },
                [7] = { },
                [8] = { },
                [9] = { },
                [10] = { },
                [11] = { },
                [12] = {}
            },

            vehicles = {
                [432] = {
                    [10] = true
                },
                [520] = {
                    [2] = true,
                    [7] = true
                },
            },

            names = {
                [0] = 'Grenade',
                [1] = 'Molotov',
                [2] = 'Rocket',
                [3] = 'Rocket Weak',
                [4] = 'Car',
                [5] = 'Car Quick',
                [6] = 'Boat',
                [7] = 'Aircraft',
                [8] = 'Mine',
                [9] = 'Object',
                [10] = 'Tank Grenade',
                [11] = 'Small',
                [12] = 'Tiny',
            },

            bypass = function(player)
                return false;
            end,

        };

        ['Anti Projectils'] = { -- essa função aqui irá desabilitar as projectils do MTA.
            state = true, -- se ativo está função irá ser ligada.		
            punishreason = 'Você foi ${punish} por criar projectils ilegais.',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 
            onlyblockall = false, -- se ativo apenas bloqueará todos em projectils.
            
            projectiles = { -- projectils a ser checado a veracidade
                [16] = true,
                [17] = true,
                [18] = true,
                [19] = true,
                [20] = true,
                [21] = true,
                [39] = true,
                [58] = true,
            },

            names = { -- nomes dos prójectils
                [16] = 'Grenade',
                [17] = 'Tear Gas Grenade',
                [18] = 'Molotov',
                [19] = 'Rocket (simple)',
                [20] = 'Rocket (heat seeking)',
                [21] = 'Air Bomb',
                [39] = 'Satchel Charge',
                [58] = 'Hydra flare'
            },

            resources = { -- resources permitidas de usar projectiles (serverside)
                ['horus_ac'] = true,
            },

            vehicles = {
                [425] = {[19] = true},
                [520] = {[19] = true, [58] = true},
            },

            weapons = { -- armas permitidas para usar aquele projectil
                [16] = {[16] = true},
                [17] = {[17] = true},
                [18] = {[18] = true},
                [19] = {[35] = true, [36] = true},
                [20] = {[35] = true,[36] = true},
                [39] = {[40] = true},
            },

            bypass = function(player)
                return false;
            end,

        };

        ['Anti RapidFire'] = { -- essa função aqui irá detectar tiros numa velocidade anormal.
            state = true, -- se ativo está função irá ser ligada.
            screenshot = false,
            punishreason = 'Você foi ${punish} por atirar rapidamente.',
            action = 'kick', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            weapons = {
                [22] = 0.15, -- Colt 45
                [23] = 0.20, -- Silenced
                [24] = 0.40, -- Deagle
                [25] = 0.7, -- Shotgun
                [26] = 0.1, -- Sawed-off
                [27] = 0.15, -- Combat Shotgun
                [28] = 0.07, -- Uzi
                [29] = 0.06, -- MP5
                [30] = 0.08, -- AK-47
                [31] = 0.08, -- M4
                [32] = 0.08, -- Tec-9 // Caso seja duas Tec-9 irá considerar metade do valor.
                [33] = 0.8, -- Rifle
                [34] = 0.8, -- Sniper
            },

            bypass = function(player)
                return false;
            end,

        };

        ['Anti Jetpack'] = {
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            punishreason = 'Você foi ${punish} por utilizar JetPack',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };

        ['Anti InfiniteAmmo'] = {
            state = true, -- se ativo está função irá ser ligada.
            screenshot = true,
            punishreason = 'Você foi ${punish} por utilizar munições infinitas',
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas. 

            bypass = function(player)
                if localPlayer and localPlayer == player then
                    return player:getData('Hac.Bypass');
                end
                return player:getData('Hac.Bypass') or isElementOnGroup(player, 'Console'); -- a função isElementOnGroup é do próprio anti cheat e faz verificação se um usuário está em um grupo automaticamente
            end,

        };

        ['Anti Overflow'] = { -- Essa função bane usuários que tentarem derrubar o servidor com ElementData Overflow
            state = true, -- se ativo está função irá ser ligada.
            punishreason = 'Você foi ${punish} por utilizar ElementData OverFlow',
            rateLimit = 10, -- Altere a menos que você tehna scripts que utilizam vários elementData no mesmo bloco de código! (Recomendado otimizar o script com tabelas)
            action = 'warning', -- Ação caso detectado: warning, kick, ban, warning irá avisar apenas as ACLS escolhidas.

            bypass = function(player)
                return false;
            end,

        };
    },


    functions = {
        ['sendnotify'] = function (srctype, ...)
            if (not srctype) then
                return outputDebugString ('['..getResourceName (getThisResource ( ))..']: Falha ao enviar mensagem, tipo de origem não especificado.', 4, 255, 50, 50)
            end
            if (srctype == 'client') then
                local type, message = ...
                outputChatBox(message, 255, 255, 255);  
                return true
            elseif (srctype == 'server') then
                local element, type, message = ...
                outputChatBox(message, element, 255, 255, 255)
                return true
            end
        end,

        ['getid'] = function (element)
            local srctype = localPlayer and 'client' or 'server';
            if (srctype == 'client') then
                return (getElementData(element, 'ID') or 'N/A');
            elseif (srctype == 'server') then
                return (getElementData(element, 'ID') or 'N/A');
            end
        end,

        ['getaccount'] = function (player)
            if localPlayer then
                return false;
            end
            local player_acc = getAccountName(getPlayerAccount(player)) or false
            return player_acc
        end

    };
}