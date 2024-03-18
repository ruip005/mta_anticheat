const express = require('express');
const mysql = require('mysql2');
const app = express();
const port = 3000;
const requestIp = require('request-ip');
const axios = require('axios');
const fs = require('fs');
const path = require('path')
const mailgun = require('mailgun-js')({
  apiKey: 'XXXXXXXX',
  domain: 'uw33dac.me'
});
//
// Salvar o stream padrão do console.log
const consoleLog = console.log;

// Caminho para o arquivo de log
const logFilePath = path.join(__dirname, 'log.txt');

// Função para registrar dados no console, arquivo de log e arquivo local
function logToFileAndConsole() {
  const logMessage = Array.from(arguments).map(arg => arg.toString()).join(' ');

  // Salvar no arquivo de log
  fs.appendFile(logFilePath, logMessage + '\n', (err) => {
    if (err) {
      console.log('Erro ao salvar no arquivo de log:', err);
    }
  });

  // Chamar o console.log original para exibir no console
  consoleLog.apply(console, arguments);
}

// Substituir o console.log pelo logToFileAndConsole
console.log = logToFileAndConsole;

//

// Configurações de conexão com o banco de dados MariaDB
const db = mysql.createConnection({
  host: 'localhost', // Substitua pelo host do seu banco de dados MariaDB
  user: 'root', // Substitua pelo nome de usuário do banco de dados
  password: 'xxxxxxxxxx', // Substitua pela senha do banco de dados
  database: 'anticheat', // Substitua pelo nome da sua base de dados
});

// Verifica a conexão com o banco de dados
db.connect(err => {
  if (err) {
    console.log('[API] Erro ao conectar a base de dados:', err);
    return;
  }
  console.log('[API] Conexão bem-sucedida com a base de dados MariaDB');
});

app.use(express.json()); //Essa função serve como um middleware que ajuda a analisar solicitações HTTP com corpo (por exemplo, requisições POST, PUT, ou PATCH) no formato JSON.
app.use(requestIp.mw()); //Serve para adicionar um middleware ao seu aplicativo Express.js que permite que você acesse o endereço IP do cliente que fez uma solicitação HTTP à sua aplicação

// Middleware para autenticação por chave de API
const authenticate = (req, res, next) => {
  const apiKey = req.header('x-api-key'); // Obtém a chave de API do cabeçalho da solicitação

  if (!apiKey) {
    sendDiscordMessage("D_","**[ALERTA API]**\n" + formatIPv4(req.clientIp) + " está tentando hackear o sistema! <@297122391580999692>")
    console.log(formatIPv4(req.clientIp), "está tentando hackear o sistema!")
    return res.status(401).json({ success: false, message: 'Chave de API não fornecida' });
  }

  // Consulta SQL para verificar a chave de API no banco de dados "api_auth"
  const query = 'SELECT * FROM api_auth WHERE apiKey = ?';

  db.query(query, [apiKey], (err, results) => {
    if (err) {
      sendDiscordMessage("https://discord.com/aA7rdxN-_LD_","**[ALERTA API]**\n" + formatIPv4(req.clientIp) + " está tentando hackear o sistema! <@297122391580999692>")
      console.log('Erro ao executar a consulta SQL:', err);
      return res.status(500).json({ success: false, message: 'Erro ao verificar a chave de API' });
    }

    if (results.length === 0) {
      console.log(formatIPv4(req.clientIp), "está tentando hackear o sistema!")
      return res.status(401).json({ success: false, message: 'Chave de API inválida' });
    }

    next();
  });
};

// Função para enviar mensagem para o Webhook do Discord
async function sendDiscordMessage(webhookUrl, message) {
  try {
    const payload = {
      content: message,
    };

    await axios.post(webhookUrl, payload);
    //console.log('Mensagem enviada para o Discord:', message);
  } catch (error) {
    console.log('[API] Erro ao enviar a mensagem para o Discord:', error);
  }
}

// Função para formatar o endereço IP
function formatIPv4(ip) {
  if (ip && ip.startsWith('::ffff:')) {
    return ip.split(':').pop(); // Obtém apenas a parte do IPv4
  }
  return ip;
}


// Rota para verificar se o usuário e a senha são idênticos
app.post('/login_ac', (req, res) => {
  const { username, password, porta, ac_version } = req.body;

  if (!username || !password) {
    return res.status(400).json({ error: "Ausência de dados!" })
  }
  // Consulta SQL para buscar o usuário pelo nome de usuário
  const query = 'SELECT login.*, api_auth.apiKey FROM login, api_auth WHERE login.user = ?';

  db.query(query, [username, password], (err, results) => {
    if (err) {
      console.log('Erro ao executar a consulta SQL:', err);
      return res.json({ success: false, message: 'Erro ao buscar o usuário' });
    }

    if (results.length === 0) {
      return res.json({ success: false, message: 'Não autorizado!' });
    }

    const user = results[0];
    console.log(formatIPv4(req.clientIp), "acedeu a API POST /login_ac ->", username, password)
    if (user.pwd === password) {
      sendDiscordMessage("https://discord.cA9kHFoaYqt9naXZMsSXSF5jjeOLIQJGavXPrlIEI3N","**[Anticheat v" + ac_version + "]**\nIP do servidor: " + formatIPv4(req.clientIp) + "\nPorta do servidor: " + porta + "\nLogin: " + username);
      res.json({ success: true, id: user.id, server: user.server, live: user.active, ss: user.ss, api: user.apiKey });
    } else {
      res.json({ success: false, message: 'Não autorizado!' });
    }
  });
});

// Rota POST para adicionar um registro à tabela gbans
app.post('/addgban_ac', authenticate, (req, res) => {
  const { user, serial, ip, reason, auth, img } = req.body;

  if (!user || !serial || !reason || !auth) {
    return res.status(400).json({ error: "Ausência de dados!" })
  }
  // Consulta SQL para inserir um registro na tabela gbans
  const query = 'INSERT INTO gbans (id, user, serial, ip, motivo, autor, img) VALUES (null, ?, ?, ?, ?, ?, ?)';

  db.query(query, [user, serial, ip, reason, auth, img], (err, results) => {
    if (err) {
      console.log('Erro ao executar a consulta SQL:', err);
      return res.json({ success: false, message: 'Erro ao adicionar registro' });
    }
    console.log(formatIPv4(req.clientIp), "acedeu a API POST /addgban_ac ->", user, serial, ip, reason, auth)
    sendDiscordMessage("https:/HrUqvCuoIjnOCWTUy6-wlpx3f_n0tIDawEKNIdEA3OHyp2dej","**[Novo banimento global]**\nCódigo do servidor: " + auth + "\nJogador: " + user + "\nSerial: " + serial + "\nIP: " + ip + "\nMotivo: " + reason + "\nProva: https://images.uw33dac.me/" + img)
    res.json({ success: true, message: 'Registro GlobalBan adicionado com sucesso' });
  });
});

// Rota POST para adicionar um registro à tabela localbans
app.post('/addlocalban_ac', authenticate, (req, res) => {
  const { player, serial, ip, reason, authID, img } = req.body;
  if (!player || !serial || !ip || !authID || !reason) {
    return res.status(400).json({ error: "Ausência de dados!" })
  }
  // Consulta SQL para inserir um registro na tabela gbans
  const query = 'INSERT INTO localbans (id, player, serial, ip, reason, autor, img) VALUES (null, ?, ?, ?, ?, ?, ?)';
  console.log(formatIPv4(req.clientIp), "acedeu a API POST /addlocalban_ac ->", player, serial, ip, reason, authID, img)
  db.query(query, [player, serial, ip, reason, authID, img], (err, results) => {
    if (err) {
      console.log('Erro ao executar a consulta SQL:', err);
      return res.json({ success: false, message: 'Erro ao adicionar registro' });
    }
    sendDiscordMessage("https://diO23RcjlZTyi3w1BffW1triq0pH6e0nziqd2cUbXLzS","**[Banimento]**\nCódigo do servidor: " + authID + "\nJogador: " + player + "\nSerial: " + serial + "\nIP: " + ip + "\nMotivo: " + reason + "\nProva: https://images.uw33dac.me/" + img)
    res.json({ success: true, message: 'Registro LocalBan adicionado com sucesso' });
  });
});

// Rota POST para receber error logs
app.post('/errors_ac', authenticate, (req, res) => {
  const { msg, authID } = req.body;
  if (!msg || !authID) {
    return res.status(400).json({ error: "Ausência de dados!" })
  }
  console.log(formatIPv4(req.clientIp), "acedeu a API POST /errors_ac ->", msg, authID)
  sendDiscordMessage("https://discordL1K4uV68i7eqztpj_sBk7NnolPH9bVES","**[Erro no anticheat]**\nCódigo do servidor: " + authID + "\nERRO: " + msg + "\n.<@297122391580999692>.")
  res.json({ success: true, message: 'Erro em análise' });
});

// Rota POST para verificar se o jogador está na lista negra
app.post('/checkgban_ac', authenticate, (req, res) => {
  const { serial, ip } = req.body;

  if (!serial && !ip) {
    return res.status(400).json({ error: "Ausência de dados!" })
  }
  // Consulta SQL para verificar se o serial ou o IP estão na tabela gbans
  const query = 'SELECT * FROM gbans WHERE serial = ? OR ip = ?';

  db.query(query, [serial, ip], (err, results) => {
    if (err) {
      console.log('Erro ao executar a consulta SQL:', err);
      return res.json({ success: false, message: 'Erro ao verificar o jogador' });
    }
    const isBlacklisted = results.length > 0;
    console.log(formatIPv4(req.clientIp), "acedeu a API POST /checkgban_ac ->", serial, ip)
    res.json({ isBlacklisted });
  });
});

// Rota GET para retornar todos os dados da tabela gbans
app.get('/gbans', (req, res) => {
  // Consulta SQL para selecionar todos os registros da tabela gbans
  const query = 'SELECT gbans.id, gbans.user, gbans.serial, gbans.motivo, login.server, gbans.img FROM gbans INNER JOIN login ON gbans.autor = login.id';
  console.log(formatIPv4(req.clientIp), "acedeu a API GET /gbans")
  db.query(query, (err, results) => {
    if (err) {
      console.log('Erro ao executar a consulta SQL:', err);
      return res.status(500).json({ success: false, message: 'Erro ao buscar os dados da tabela gbans' });
    }
    res.json(results);
  });
});

// Rota que retorna seriais e IPs do banco de dados
app.get('/gbans_ac', authenticate, (req, res) => {
  // Consulta SQL para selecionar seriais e IPs da tabela 'gbans'
  const query = 'SELECT serial, ip FROM gbans';

  db.query(query, (err, rows) => {
    if (err) {
      console.log('Erro ao consultar o banco de dados MySQL:', err);
      return res.status(500).json({ error: 'Erro ao consultar o banco de dados' });
    }

    const seriais = rows.map(row => row.serial);
    const ips = rows.map(row => row.ip);

    res.json({ seriais, ips });
  });
});

// Rota POST para inserir logs
app.post('/logsS_ac', authenticate, (req, res) => {
  const { authid, porta, name, discord } = req.body;

  if (!authid || !porta) {
    return res.status(400).json({ error: "Ausência de dados!" })
  }

  const query1 = "select * from logs where authID = ?"
  let ip = formatIPv4(req.clientIp)
  db.query(query1, [authid], (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Erro interno do servidor [01]' });
    }

    if (results.length > 0) {
      //  return res.status(400).json({ error: 'Um registro com o mesmo authID já existe' });
      //let updateQuery = 'update logs set lastIP = ?, lastName = ? where authID = ?';
      //if (discord) { // versao antiga
      let updateQuery = 'update logs set lastIP = ?, lastName = ?, discord = ?, lastStart = ? where authID = ?';
      ip = ip + ":" + porta
      const currentDate = new Date().toISOString().slice(0, 19).replace('T', ' ');
      db.query(updateQuery, [ip, name, discord, currentDate, authid], (err) => {
        if (err) {
          return res.status(500).json({ error: 'Erro interno do servidor [02]' });
        }

        res.status(200).json({ message: 'Registro atualizado com sucesso' });
      });
    } else {

      // Insira um novo registro se não houver um valor igual no loginID
      const insertQuery = 'INSERT INTO logs (id, authID, originalIP, entry, lastIP, suspectIP, originalName, lastName, discord, lastStart) VALUES (null, ?, ?, 1, ?, null, ?, ?, ?, ?)';
      const currentDate = new Date().toISOString().slice(0, 19).replace('T', ' ');
      db.query(insertQuery, [authid, ip + ":" + porta, ip + ":" + porta, name, name, discord, currentDate], (err) => {
        if (err) {
          return res.status(500).json({ error: 'Erro interno do servidor' });
        }
        console.log(formatIPv4(req.clientIp), "acedeu a API POST /logsS_ac ->", authid, porta, name)
        res.status(201).json({ message: 'Registro inserido com sucesso' });
      });
    }
  });
});

// Rota get para saber logs do sv
app.get('/ip', (req, res) => {
  let clientIp = formatIPv4(req.clientIp);
  console.log(formatIPv4(req.clientIp), "acedeu a API GET /ip")
  res.json({ ip: clientIp });
});

app.get('/demo', (req, res) => {
  let clientIp = formatIPv4(req.clientIp);
  console.log(formatIPv4(req.clientIp), "acedeu a API GET /demo")
  const alreadyPending = "SELECT * FROM request_keys where ip = ?"
  db.query(alreadyPending, [clientIp], (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Erro interno do servidor' });
    }
    if (results.length > 0) {
      return res.status(401).send(`
<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            max-width: 400px;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #FF6347;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Você já requisitou uma chave demo!</h1>
        <br>
        <h1 style='color:blue;'><a href="https://github.com/ruip005/mta_anticheat">Projeto</a></h1>
    </div>
</body>
</html>
`);

    }

    let user = "demo" + generateRandomString(3);
    let password = generateRandomString(64);
    const currentDateAndTime = new Date();
    const twoDaysInMilliseconds = 7 * 24 * 60 * 60 * 1000;
    const newDateAndTime = new Date(currentDateAndTime.getTime() + twoDaysInMilliseconds);
    const query = "INSERT INTO login(id, server, user, pwd, active, created, endSubscription, ss) VALUES(null, 'DEMO', ?, ?, 1, ?, ?, 1)";

    db.query(query, [user, password, currentDateAndTime, newDateAndTime], (err, results) => {
      if (err) {
        return res.status(500).json({ error: 'Erro interno do servidor' });
      }

      const query2 = "INSERT INTO request_keys(id, ip, type, authID) VALUES(null, ?, 'demo', ?)";
      db.query(query2, [clientIp, results.insertId], (err) => {
        if (err) {
          console.log(clientIp, "erro request_keys: ", err);
        }

        return res.send(`
<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
        }

        hr {
            border: 1px solid #ccc;
        }

        .download-button {
            display: inline-block;
            background-color: #007BFF;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Seu LogIN para autenticar o anticheat</h1>
        <hr>
        <p><strong>Usuário:</strong> ${user}</p>
        <p><strong>Chave:</strong> ${password}</p>
        <hr>
        <p>Por favor, salve os dados acima. Eles serão válidos por apenas 7 dias.</p>
        <a class="download-button" href="https://github.com/ruip005/mta_anticheat/releases/download/v2.0.1.01/v2.0.1.01S.zip" download>Baixar</a>
        <hr>
        <iframe width="560" height="315" src="https://www.youtube.com/embed/2OMdYLaOqTw?si=S_E3iUf2Qp2c3rbb" frameborder="0" allowfullscreen></iframe>
    </div>
</body>
</html>
`);

      });
    });
  });
});

app.post('/print_ac', authenticate, (req, res) => {
  const { nick, serial, ip, authID, img } = req.body;

  if (!serial || !ip || !img || !authID) {
    return res.status(400).json({ error: "Ausência de dados!" })
  }
  const query = 'INSERT INTO prints(id, user, serial, ip, authID, img) VALUES(null, ?, ?, ?, ?, ?)';

  db.query(query, [nick, serial, ip, authID, img], (err, results) => {
    if (err) {
      console.log('Erro ao executar a consulta SQL:', err);
      return res.json({ success: false, message: 'Erro ao verificar o jogador' });
    }
    console.log(formatIPv4(req.clientIp), "acedeu a API POST /checkgban_ac ->", serial, ip)
    res.status(200).json({ success: true });
  });
});

app.get('/gbans/user/:id', (req, res) => {
  const { id } = req.params;
  const query = 'SELECT * FROM gbans WHERE id = ?';
  console.log(formatIPv4(req.clientIp), "acedeu a API GET /gbans/user/:id ->", id)
  db.query(query, [id], (err, results) => {
    if (err) {
      console.log('Erro ao executar a consulta SQL:', err);
      return res.json({ success: false, message: 'Erro ao verificar dados' });
    }

    if (results.length === 0) {
      return res.status(404).json({ success: false, message: 'Registro não encontrado' });
    }

    const record = results[0];

    const queryName = 'SELECT originalName from logs where authID = ?';

    db.query(queryName, [record.autor], (err, resultss) => {
      if (err) {
        console.log('Erro ao executar a consulta SQL:', err);
        return res.json({ success: false, message: 'Erro ao verificar dados' });
      }

      if (resultss.length > 0) {
        const serverName = resultss[0].originalName;

        // Montar a string HTML de resposta com valores dinâmicos e mensagem
        const htmlResponse = `
        <!DOCTYPE html>
        <html>
        <head>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    text-align: center;
                    background-color: #f5f5f5;
                }
        
                .container {
                    max-width: 600px;
                    margin: 0 auto;
                    padding: 20px;
                    background-color: #ffffff;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                }
        
                h1 {
                    color: #333;
                }
        
                hr {
                    border: 1px solid #ccc;
                }
        
                .download-button {
                    display: inline-block;
                    background-color: #007BFF;
                    color: #fff;
                    padding: 10px 20px;
                    border-radius: 5px;
                    text-decoration: none;
                }
            </style>
        </head>
        <body>
            <div class="container">
                <h1>ID encontrado: ${record.id}</h1>
                <hr>
                <p><strong>Usuário:</strong> ${record.user}</p>
                <p><strong>Serial:</strong> ${record.serial}</p>
                <p><strong>IP:</strong> ${record.ip}</p>
                <p><strong>Motivo:</strong> ${record.motivo}</p>
                <hr>
                <p><strong>Server:</strong> ${serverName}</p>
                <hr>
                <img class="image" src="${record.img}" alt="Sem imagem">
            </div>
        </body>
        </html>
        `;

        // Retornar a resposta HTML
        res.send(htmlResponse);
      }
    });
  });
});

///

app.get('/gbans/serial/:id', (req, res) => {
  const { id } = req.params;
  const query = 'SELECT * FROM gbans WHERE serial = ?';
  console.log(formatIPv4(req.clientIp), "acedeu a API GET /gbans/serial/:id ->", id)
  db.query(query, [id], (err, results) => {
    if (err) {
      console.log('Erro ao executar a consulta SQL:', err);
      return res.json({ success: false, message: 'Erro ao verificar dados' });
    }

    if (results.length === 0) {
      return res.status(404).json({ success: false, message: 'Registro não encontrado' });
    }

    const record = results[0];

    const queryName = 'SELECT originalName from logs where authID = ?';

    db.query(queryName, [record.autor], (err, resultss) => {
      if (err) {
        console.log('Erro ao executar a consulta SQL:', err);
        return res.json({ success: false, message: 'Erro ao verificar dados' });
      }

      if (resultss.length > 0) {
        const serverName = resultss[0].originalName;

        // Montar a string HTML de resposta com valores dinâmicos e mensagem
        const htmlResponse = `
        <!DOCTYPE html>
        <html>
        <head>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    text-align: center;
                    background-color: #f5f5f5;
                }
        
                .container {
                    max-width: 600px;
                    margin: 0 auto;
                    padding: 20px;
                    background-color: #ffffff;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                }
        
                h1 {
                    color: #333;
                }
        
                hr {
                    border: 1px solid #ccc;
                }
        
                .download-button {
                    display: inline-block;
                    background-color: #007BFF;
                    color: #fff;
                    padding: 10px 20px;
                    border-radius: 5px;
                    text-decoration: none;
                }
            </style>
        </head>
        <body>
            <div class="container">
                <h1>ID encontrado: ${record.id}</h1>
                <hr>
                <p><strong>Usuário:</strong> ${record.user}</p>
                <p><strong>Serial:</strong> ${record.serial}</p>
                <p><strong>IP:</strong> ${record.ip}</p>
                <p><strong>Motivo:</strong> ${record.motivo}</p>
                <hr>
                <p><strong>Server:</strong> ${serverName}</p>
                <hr>
                <img class="image" src="${record.img}" alt="Sem imagem">
            </div>
        </body>
        </html>
        `;

        // Retornar a resposta HTML
        res.send(htmlResponse);
      }
    });
  });
});

app.get('/gbans/serial/json/:id', (req, res) => {
  const { id } = req.params;
  const query = 'SELECT * FROM gbans WHERE serial = ?';
  console.log(formatIPv4(req.clientIp), "acedeu a API GET /gbans/serial/json/:id ->", id)
  db.query(query, [id], (err, results) => {
    if (err) {
      console.log('Erro ao executar a consulta SQL:', err);
      return res.json({ success: false, message: 'Erro ao verificar dados' });
    }

    if (results.length === 0) {
      return res.status(404).json({ success: false, message: 'Registro não encontrado' });
    }

    const record = results[0];

    const queryName = 'SELECT originalName from logs where authID = ?';

    db.query(queryName, [record.autor], (err, resultss) => {
      if (err) {
        console.log('Erro ao executar a consulta SQL:', err);
        return res.json({ success: false, message: 'Erro ao verificar dados' });
      }

      if (resultss.length > 0) {
        const serverName = resultss[0].originalName;

        // Retornar a resposta HTML
        res.status(200).json({ success: true, id: record.id, usuário: record.user, serial: record.serial, ip: record.ip, motivo: record.motivo, server: serverName, img: record.img });
      }
    });
  });
});

app.get('/auth/:id', (req, res) => {
  const { id } = req.params;
  const query = 'SELECT * FROM login WHERE user = ?';
  console.log(formatIPv4(req.clientIp), "acedeu a API GET /auth/infos/:id ->", id)
  db.query(query, [id], (err, results) => {
    if (err) {
      console.log('Erro ao executar a consulta SQL:', err);
      return res.json({ success: false, message: 'Erro interno no servidor' });
    }

    if (results.length === 0) {
      return res.status(404).json({ success: false, message: 'Registro não encontrado' });
    }

    const record = results[0];

    const dataOriginal = new Date(record.created);
    const dia = dataOriginal.getUTCDate();
    const mes = dataOriginal.getUTCMonth() + 1; // O mês é baseado em zero, então você precisa adicionar 1.
    const ano = dataOriginal.getUTCFullYear();
    const dataFormatada = `${dia}/${mes}/${ano}`;

    const dataOriginal1 = new Date(record.endSubscription);
    const dia1 = dataOriginal1.getUTCDate();
    const mes1 = dataOriginal1.getUTCMonth() + 1; // O mês é baseado em zero, então você precisa adicionar 1.
    const ano1 = dataOriginal1.getUTCFullYear();
    const dataFormatada1 = `${dia1}/${mes1}/${ano1}`;

    let Status = record.active ? "Ativo" : "Desativado"
    let SS = record.ss ? "Habilitado" : "Desabilitado"
    const htmlResponse = `
        <!DOCTYPE html>
        <html>
        <head>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    text-align: center;
                    background-color: #f5f5f5;
                }
        
                .container {
                    max-width: 600px;
                    margin: 0 auto;
                    padding: 20px;
                    background-color: #ffffff;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                }
        
                h1 {
                    color: #333;
                }
        
                hr {
                    border: 1px solid #ccc;
                }
        
                .download-button {
                    display: inline-block;
                    background-color: #007BFF;
                    color: #fff;
                    padding: 10px 20px;
                    border-radius: 5px;
                    text-decoration: none;
                }
            </style>
        </head>
        <body>
            <div class="container">
                <h1>ID encontrado: ${record.id}</h1>
                <hr>
                <p><strong>Identificador:</strong> ${record.server}</p>
                <p><strong>Usuário:</strong> ${record.user}</p>
                <p><strong>Status:</strong> ${Status}</p>
                <p><strong>Requisitado em:</strong> ${dataFormatada}</p>
                <p><strong>Expira em:</strong> ${dataFormatada1}</p>
                <p><strong>Screenshot API:</strong> ${SS}</p>
            </div>
        </body>
        </html>
        `
    // Retornar a resposta HTML
    res.send(htmlResponse);
  }
  )
});

app.get('/auth/json/:id', (req, res) => {
  const { id } = req.params;
  const query = 'SELECT * FROM login WHERE user = ?';
  console.log(formatIPv4(req.clientIp), "acedeu a API GET /auth/json/:id ->", id)
  db.query(query, [id], (err, results) => {
    if (err) {
      console.log('Erro ao executar a consulta SQL:', err);
      return res.json({ success: false, message: 'Erro interno no servidor' });
    }

    if (results.length === 0) {
      return res.status(404).json({ success: false, message: 'Registro não encontrado' });
    }

    const record = results[0];

    const dataOriginal = new Date(record.created);
    const dia = dataOriginal.getUTCDate();
    const mes = dataOriginal.getUTCMonth() + 1; // O mês é baseado em zero, então você precisa adicionar 1.
    const ano = dataOriginal.getUTCFullYear();
    const dataFormatada = `${dia}/${mes}/${ano}`;

    const dataOriginal1 = new Date(record.endSubscription);
    const dia1 = dataOriginal1.getUTCDate();
    const mes1 = dataOriginal1.getUTCMonth() + 1; // O mês é baseado em zero, então você precisa adicionar 1.
    const ano1 = dataOriginal1.getUTCFullYear();
    const dataFormatada1 = `${dia1}/${mes1}/${ano1}`;

    let Status = record.active ? "Ativo" : "Desativado"
    let SS = record.ss ? "Habilitado" : "Desabilitado"

    // Retornar a resposta HTML
    res.status(200).json({ success: true, id: record.id, servidor: record.server, status: Status, reqs: dataFormatada, exp: dataFormatada1, ss: SS })
  }
  )
});

app.post('/demo/json', (req, res) => {
  const { sigla, duracao, email } = req.body
  //if (duracao != "demo" || duracao != "monthly" || duracao != "lifetime"){
  //	return res.status(400).json({sucess: false, message: "Duração inválida"})
  //}
  console.log(`Dados:\n${sigla}\n${duracao}`)
  let clientIp = formatIPv4(req.clientIp);
  console.log(formatIPv4(req.clientIp), "acedeu a API GET /demo/json")
  let user = generateRandomString(8);
  let password = generateRandomString(64);
  const currentDateAndTime = new Date();
  let twoDaysInMilliseconds
  if (duracao == "demo") {
    twoDaysInMilliseconds = 7 * 24 * 60 * 60 * 1000;
  } else if (duracao == "monthly") {
    twoDaysInMilliseconds = 31 * 24 * 60 * 60 * 1000;
  } else {
    twoDaysInMilliseconds = 999999 * 24 * 60 * 60 * 1000;
  }
  const newDateAndTime = new Date(currentDateAndTime.getTime() + twoDaysInMilliseconds);
  const query = "INSERT INTO login(id, server, user, pwd, active, created, endSubscription, ss) VALUES(null, ?, ?, ?, 1, ?, ?, 1)";

  db.query(query, [sigla, user, password, currentDateAndTime, newDateAndTime], (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Erro interno do servidor' });
    }

    const query2 = "INSERT INTO request_keys(id, ip, type, authID) VALUES(null, ?, ?, ?)";
    db.query(query2, [clientIp, duracao, results.insertId], (err) => {
      if (err) {
        console.log(clientIp, "erro request_keys: ", err);
      }

      if (!email) {
        return res.status(200).json({ success: true, message: `Sucesso! Aqui está sua autenticação:\n**User**: ${user}\n**Key**: ${password}\nAnticheat: https://github.com/ruip005/mta_anticheat/releases/download/v2.0.1.01/v2.0.1.01S.zip` })
      } else {
        const data = {
          from: 'Anticheat Credentials <admin@uw33dac.me>',
          to: `${email}`,
          subject: 'Anticheat Credentials',
          html: `
            <!DOCTYPE html>
            <html>
            <head>
              <style>
                body {
                  font-family: Arial, sans-serif;
                }
                .container {
                  max-width: 600px;
                  margin: 0 auto;
                  padding: 20px;
                  background-color: #f4f4f4;
                }
                .header {
                  background: rgb(2,0,36);
                  background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(67,9,121,1) 35%, rgba(255,0,211,1) 100%);
                  color: #fff;
                  text-align: center;
                  padding: 20px;
                }
                .content {
                  padding: 20px;
                  text-align: center; /* Centralize o conteúdo no centro da div. */
                }
                .download-button {
                  background-color: #4CAF50;
                  color: #fff;
                  padding: 10px 20px;
                  text-decoration: none;
                  display: inline-block;
                  border-radius: 5px;
                  font-weight: bold;
                }
              </style>
            </head>
            <body>
              <div class="container">
                <div class="header">
                  <h1>Credenciais do Anticheat</h1>
                </div>
                <div class="content">
                  <p>Olá,</p>
                  <p>Aqui estão as credenciais do Anticheat para <strong>${sigla}</strong>:</p>
                  <p><strong>Usuário:</strong> ${user}</p>
                  <p><strong>Chave:</strong> ${password}</p>
                  <p>Atenciosamente, Anticheat Admin</p>
                  <a class="download-button" href="https://github.com/ruip005/mta_anticheat/releases/download/v2.0.1.01/v2.0.1.01S.zip" target="_blank">Baixar Anticheat</a>
                </div>
              </div>
            </body>
            </html>
            
              `,
        };

        mailgun.messages().send(data, (error, body) => {
          if (error) {
            console.error('Erro ao enviar o e-mail:', error);
          } else {
            console.log('E-mail enviado com sucesso:', body);
          }
        });
      }
    });
  });
});

app.get("/spoofer/check", authenticate, (req, res) => {
  const { auth, hwid, serial } = req.body;
  if (!auth) {
    return res.status(400).json({ error: "Ausência de dados!" })
  }
  let liberado1 = false;
  let liberado2 = false;
  const query = "SELECT * FROM spoofer WHERE genHWID = ?"
  db.query(query, [hwid], (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Erro interno do servidor [01]' });
    }

    if (results.length == 0) {
      // Sem hwid
      const query1 = "SELECT * FROM spoofer WHERE serial = ?"
      db.query(query1, [serial], (err, results) => {
        if (err) {
          return res.status(500).json({ error: 'Erro interno do servidor [01]' });
        }

        if (results.length > 0) {
          // Tem hwid
          return res.status(202).json({ success: true, message: results[0].genHWID });
        } else {
          // Criar hwid
          return res.status(201).json({ success: false, message: "Sem hwid" });
        }
      })
    }

    if (results.length > 0) {
      if (results.length > 1) { // Se tiver mais de 1 hwid || serial
        for (let i = 0; i < results.length; i++) {
          if (results[i].serial != serial) {
            // Não é o mesmo serial - Spoofer!
            addBan(auth, serial)
            return res.status(200).json({ success: true, gban: true, message: "Spoofer" });
          }
        }
        liberado1 = true;
      } else { // se nao tiver + de 1 hwid || serial
        if (results[0].serial != serial) {
          addBan(auth, serial)
          return res.status(200).json({ success: true, gban: true, message: "Spoofer" });
          // to do spoofer
        } else {
          liberado1 = true;
        }
      }

      // Se tiver resultados do mesmo serial e ter hwid
      for (let i = 0; i < results.length; i++) {
        db.query("SELECT * FROM gbans WHERE serial = ?", [results[i].serial], (err, results1) => {
          if (err) {
            return res.status(500).json({ error: 'Erro interno do servidor [02]' });
          }

          if (results1.length > 0) {
            // Spoofer
            addBan(auth, serial)
            return res.status(200).json({ success: true, gban: true, message: "Está globalmente banido" });
          } else {
            // Não é spoofer
            liberado2 = true;
          }
        })
      }
      //
    } // se tiver resultados
    if (liberado1 && liberado2) {
      return res.status(200).json({ success: true, gban:false, message: "Liberado" });
    }
  })
})

app.post("/spoofer", authenticate, (req, res) => {
  const { auth, hwid, serial } = req.body;
  if (!auth || !hwid || !serial) {
    return res.status(400).json({ error: "Ausência de dados!" })
  }

  const query1 = "SELECT * FROM spoofer where serial = ?"
  db.query(query1, [serial], (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Erro interno do servidor [01]' });
    }

    if (results.length > 0) {
      return res.status(200).json({ success: true, message: results[0].genHWID });
    }
  })

  const query = "INSERT INTO spoofer(id, genHWID, serial, authID) VALUES(null, ?, ?, ?)"
  db.query(query, [hwid, serial, auth], (err, results) => {
    if (err) {
      return res.status(500).json({ success: false, error: 'Erro interno do servidor [01]' });
    }

    return res.status(200).json({ success: true, message: hwid });
  })
})

app.get("/beta", (req, res) => {
  res.send(`<!DOCTYPE html>
<html lang="pt-br">
<head>
  <meta charset="UTF-8">
  <title>Anticheat MTA (Beta)</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .container {
      text-align: center;
      padding: 20px;
      border-radius: 8px;
      background-color: #fff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h1 {
      color: #333;
    }
    p {
      color: #555;
      margin-bottom: 20px;
    }
    a {
      text-decoration: none;
    }
    button {
      padding: 12px 24px;
      font-size: 16px;
      border: none;
      border-radius: 4px;
      background-color: #4CAF50;
      color: white;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    button:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>

  <div class="container">
    <h1>Anticheat MTA (Beta)</h1>
  
    <p>Bem-vindo à página de download do anticheat em beta para MTA.</p>
  
    <p>Este anticheat está em fase de testes e pode conter bugs.</p>
  
    <a href="https://github.com/ruip005/mta_anticheat/releases/download/v2.1.0.00/v2.1.zip" download>
      <button>Baixar Anticheat</button>
    </a>
  </div>

</body>
</html>
`)
})

app.listen(port, () => {
  console.log(`[API] Rodando na porta: ${port}`);
});

function generateRandomString(length) {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let randomString = '';
  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    randomString += characters.charAt(randomIndex);
  }

  return randomString;
}

addBan = (auth, serial) => {
  const query = "INSERT INTO gbans(id, user, serial, ip, motivo, autor, img) VALUES(null, null, ?, null, 'Spoofer', ?, null)";
  db.query(query, [serial, auth], (err) => {
    if (err) {
      console.log("Erro ao adicionar spoofer: ", err);
    } else {
      console.log("Adicionado spoofer");
    }
  })
}
