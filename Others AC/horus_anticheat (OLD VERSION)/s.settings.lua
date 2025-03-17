        --[[
                HÓRUS ANTI CHEAT

            Nós dividimos essas configurações das demais por elas serem usadas apenas
            do lado servidor e serem informações sensíveis; para jogadores má intencionados
            não terem acesso a essas configurações; agradecemos sua cooperação e compreensão.

        ]]--


local serversettings = {
    serialbypass = {
        ['serial'] = true;
    };
    
    database = function()
        return dbConnect ('sqlite', 'database.db'); -- mysql exports example
    end,

    ['webhook´s'] = {
        title = '⚙️ Hórus Anti Cheat ⚙️',
        color = 3553599, -- https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812
        ['url´s'] = {
            ['triggers monitor'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['screen share:ss'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti fake models'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti ac breaker'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['serial change'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['serial cloner'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti dump'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti reconnect'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti menu'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti menugui'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti events'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti maxdamage'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti maxclip'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['weapon blocked'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti vehiclepull'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti airbreak'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti movespeed'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti teleport'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti screenshot'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti gamespeed'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti elementdatachange'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti specialproperty'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti luaexecutor'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti vehiclehack'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti elementvelocity'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti esp'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti nofall'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti godmode'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti kill noid'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti ghostmode'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti longrange'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti cheathook'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti vehiclefly'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti vehiclegodmode'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti vehiclegravity'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti cheatweapons'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti gravity'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti fire'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti fix'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti explosions'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti projectils'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti rapidfire'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti jetpack'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti infiniteammo'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti overflow'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti removewheelsvehicle'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti silentaim'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti aimbot'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti maxcollision'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti vbr'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['anti vehiclerain'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['suspect keys'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT',
            ['error log'] = 'https://discord.com/api/webhooks/1166581462506684447/WgzUr9N375TNXhPmwudTUGahvfrmRNT8QQpO5bDMjHirXXZoxxROyH0CXEQe9IV2XvBT'
        };
        ['message´s'] = {

            --[[ARGUMENTOS POSSIVEIS: 
                id: ${id}
                nome: ${player} ou ${name} (Depende do módulo)
                serial:: ${serial}
                ip:: ${ip}
                conta:: ${account}
                tipo da punição: ${punish}
                novo valor da elementdata: ${datanew}
                valor antigo da elementdata: ${dataold}
                nome da elementdata: ${dataname}
                tipo do elemento da element data: ${datatype}
                resource ${resource}
                ação: ${action}
                nome do evento executado: ${eventname}
                nome do source do evento: ${sourcename}
                nome da resource do evento(que está registrado): ${resourcename}
                argumentos enviados no trigger: ${args}
                linha do codigo clientside: ${line}
                file do codigo clientside: {$file}
                qual modulo detectou o executor: ${executortype}
                real modelo: ${realmodel}
                fake modelo: ${fakemodel}
                função executada(caso exista): ${func}
                tempo que o ban foi gerado(retorna um timestamp!): ${timestamp}
                ]]--

            ['triggers monitor'] = '`🕵️` Usuário: ${player} [${id}]\n utilizou um trigger: ``` EVENTO: ${eventname} \n SOURCE EVENT: ${sourcename} \n RESOURCE LADO SERVER: ${resourcename} \n ARGUMENTOS: ${args}```',
            ['screen share:ss'] = '`🔗` Screen shot de ${name} [${id}]\n',
            ['anti ac breaker'] = '`🛠️` Usuário: ${player} [${ip}] \n📌 Suspeita: está tentando quebrar o anti cheat \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['serial change'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por estar alterando o serial \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['serial cloner'] = '`🕵️` Usuário: ${player}\n`🛠️` ${punish} por possivelmente clonar um serial \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti dump'] = '`📌` Usuário: ${player} [${id}] ${action} {$resource} \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti reconnect'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} porque reconectou muito rapido!! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti menu'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} porque está usando um mod menu!! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti menugui'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} porque abriu um menu gui não registrado!! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip} \n `📌` RESOURCE: ${resource}',
            ['anti events'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} porque está usando events \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti maxdamage'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por utilizar MaxDamage! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti maxclip'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por utilizar MaxClip! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti silentaim'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por utilizar silentaim! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti aimbot'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por utilizar silentaim! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti vehiclepull'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por utilizar vehiclepull! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['weapon blocked'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar usar armas bloqueadas! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}\n`⚔️` WEAPON: ${weapon}',
            ['anti airbreak'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} porque estava voando!! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti ghostmode'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} porque estava de modo fantasma!! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti movespeed'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} porque estava de MoveSpeed \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti teleport'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} porque deu um Teleport \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti screenshot'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por estar com o screenshot desativado! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti gamespeed'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por usar GameSpeed! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti elementdatachange'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar alterar uma elementdata não autorizada! (${dataname} | ${dataold} | ${datanew}) \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti specialproperty'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar usar Special Propertys não autorizado! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti luaexecutor'] = '`🕵️` Usuário: ${player} [${id}] [${resource}] [${line}] [${file}]\n`🛠️` ${punish} por tentar usar lua executor (${executortype})!',
            ['anti vehiclehack'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar usar Vehicle Hack! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti elementvelocity'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar usar element velocity! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti esp'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar usar um ESP não cadastrado! \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti nofall'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por NoFall Hack \n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti godmode'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar usar GodMode (hack de vida)!\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti killnoid'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar causar dano sem está verificado no anticheat ou logado!\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti longrange'] = '`🕵️` Usuário: ${player} [${id}]\n sofreu uma tentativa de LongRage!\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti cheathook'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar usar um Hook!\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti vehiclefly'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar usar Vehicle Fly\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti vehiclegodmode'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar usar Vehicle God!\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti fix'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar usar Vehicle God!\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti vehiclegravity'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar usar Vehicle gravity!\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti cheatweapons'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar usar fake armas!\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}\n`⚔️` WEAPON: ${weapon}',
            ['anti gravity'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar usar gravidade!\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti fire'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar usar gravidade!\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti explosions'] = 'Uma explosãodetectada e anulada causada por: ${causedBy}\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti projectils'] = 'Um projectilanulado com sucesso! criado por ${player}\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti rapidfire'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por tentar usar rapidFire!\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti jetpack'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por usar JetPack!\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti infiniteammo'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por usar munições infinitas!\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti overflow'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por usar ElementData OverFlow\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti maxcollision'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por usar Max Collision\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti vehiclerain'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por usar Vehicle Rain\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti vbr'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por usar VBR\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['suspect keys'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por usar Suspect Keys\n`🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}\n`⌨️` KEY: ${button}',
            ['anti fake models'] = '`🕵️` Usuário: ${player} [${id}]\n`🛠️` ${punish} por usar Fake models (car) \n MODELO REAL: ${realmodel} \n MODELO FALSO: ${fakemodel} (o mesmo da print) \n `🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}',
            ['anti removewheelsvehicle'] = 'O veiculo ${vehiclename} ${vehicleid} estava sem rodas na posição: ${posX} ${posY} ${posZ}!\n `🔗` SERIAL: ${serial} \n`🛰️` IP: ${ip}'
        },
    },
};

function getServerSettings()
    return serversettings
end
