const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs').promises;
const path = require('path');
const app = express();
const port = 8111;
const mysql = require('mysql2');
const FormData = require('form-data')
const axios = require('axios')

app.use(bodyParser.json());

const uploadDir = path.join(__dirname, 'uploads'); // Diretório onde as imagens serão salvas

// Middleware para autenticação por chave de API
const authenticate = (req, res, next) => {
  const apiKey = req.header('x-api-key'); // Obtém a chave de API do cabeçalho da solicitação

  if (!apiKey) {
    //sendDiscordMessage("**[ALERTA API]**\n"+formatIPv4(req.clientIp)+" está tentando hackear o sistema! <@297122391580999692>")
    return res.status(401).json({ success: false, message: 'Chave de API não fornecida' });
  }

  // Consulta SQL para verificar a chave de API no banco de dados "api_auth"
  const query = 'SELECT * FROM api_auth WHERE apiKey = ?';

  db.query(query, [apiKey], (err, results) => {
    if (err) {
      //sendDiscordMessage("**[ALERTA API]**\n"+formatIPv4(req.clientIp)+ " está tentando hackear o sistema! <@297122391580999692>")
      return res.status(500).json({ success: false, message: 'Erro ao verificar a chave de API' });
    }

    if (results.length === 0) {
      return res.status(401).json({ success: false, message: 'Chave de API inválida' });
    }

    next();
  });
};

// Configurações de conexão com o banco de dados MariaDB
const db = mysql.createConnection({
  host: 'localhost', // Substitua pelo host do seu banco de dados MariaDB
  user: 'root', // Substitua pelo nome de usuário do banco de dados
  password: 'xxxxxxx', // Substitua pela senha do banco de dados
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

app.post('/image/upload', authenticate, async (req, res) => {
  try {
    const { id, nick, user, ide, serial, ip, webhook, image } = req.body;
    const imageData = Buffer.from(image, 'base64');
    const fileName = `${id}.png`;
    const filePath = path.join(uploadDir, fileName);
    //
    if (image) {
      await fs.writeFile(filePath, imageData);
    } else {
      console.log(req.ip+": Erro ao receber imagem!")
    }
    //

    try {
    const embed = {
      title: '**Suspeito**',
      color: 10692302, // Cor (opcional)
      description: '**NICK:** '+nick+'\n**USER:** '+user+'\n**ID:** '+ide+'\n**SERIAL:** '+serial+'\n**IP:** '+ip,
      image: { url: `https://images.uw33dac.me/${id}` }, // Adicione a URL da imagem aqui
    };

    const data = {
      content: '', // Conteúdo da mensagem
      username: 'uW33D Anticheat', // Nome do bot
      avatar_url: 'https://github.com/ruip005/mta_anticheat/blob/main/AC.png?raw=true', // URL do avatar do bot (opcional)
      embeds: [embed],
    };

    await axios.post(webhook, data);
  } catch (err) {
    console.log("ERRO:",err)
  }
    console.log('Imagem salva com sucesso:', filePath);

    res.json({ success: true, message: 'Imagem recebida e salva com sucesso', id });

  } catch (err) {
    console.error('Erro ao salvar a imagem:', err);
    res.status(500).json({ success: false, error: 'Erro ao salvar a imagem' });
  }
});

app.get('/image/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const fileName = `${id}.png`;
    const filePath = path.join(uploadDir, fileName);

    const data = await fs.readFile(filePath);

    res.writeHead(200, { 'Content-Type': 'image/png' });
    res.end(data);
  } catch (err) {
    console.error('Erro ao ler a imagem:', err);
    res.status(404).json({ error: 'Imagem não encontrada' });
  }
});

const init = async () => {
  try {
    // Crie o diretório de upload se ele não existir
    if (!await fs.stat(uploadDir)) {
      await fs.mkdir(uploadDir);
    }

    app.listen(port, () => {
      console.log(`Servidor está ouvindo na porta ${port}`);
    });
  } catch (err) {
    console.error('Erro ao iniciar o servidor:', err);
  }
};

init();


// Função para enviar um webhook para o Discord
async function sendDiscordWebhook(webhook, message, tag) {
  const webhookData = {
  content: '**Suspeito**', // Conteúdo da mensagem
  username: 'uW33D Anticheat', // Nome do bot
  avatar_url: 'https://github.com/ruip005/mta_anticheat/blob/main/AC.png?raw=true', // URL do avatar do bot (opcional)
  embeds: [
    {
      title: '**Suspeito**',
      color: 10692302, // Cor (opcional)
      description: 'Descrição do Embed',
      footer: {
        text: 'Texto do rodapé',
        icon_url: 'URL do ícone do rodapé',
      },
      thumbnail: {
        url: 'https://images.uw33dac.me/'+tag,
      },
    },
  ],
  }
}
