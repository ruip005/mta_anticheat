const apiSchema = require("../models/api");
const loginSchema = require("../models/login");
const logsSchema = require("../models/logs");
const requestKeysModel = require("../models/requestKeys");
const sendDiscordMessage = require("../utils/discord");
const mailgun = require("mailgun-js")({
  apiKey: process.env.MAILGUN_API,
  domain: process.env.MAILGUN_DOMAIN,
});
const criarApi = require("../utils/triggerApi");

const serverController = {
  authenticate: async (req, res) => {
    const { username, password, porta, ac_version } = req.body;

    try {
      // Use o método findOne do modelo 'loginModel' para buscar o usuário pelo nome de usuário
      const user = await loginSchema.findOne({ user: username });

      if (!user) {
        return res
          .status(401)
          .json({ success: false, message: "Não autorizado!" });
      }

      // Verifique a senha
      if (user.pwd === password) {
        // Use o método findOne do modelo 'apiAuthModel' para obter a chave da API
        const apiKey = await apiSchema.findOne({ serverId: user._id });

        sendDiscordMessage(
          process.env.DISCORD_LOGIN,
          `**[Anticheat v${ac_version}]**
            IP do servidor: ${req.clientIp}
            Porta do servidor: ${porta}
            Login: ${username}`
        );

        console.log(apiKey);

        res.json({
          success: true,
          id: user.id,
          server: user.server,
          live: user.active,
          ss: user.ss,
          api: apiKey.key || "N/A",
        });
      } else {
        res.status(401).json({ success: false, message: "Não autorizado!" });
      }
    } catch (error) {
      console.error("Erro ao consultar o banco de dados MongoDB:", error);
      res
        .status(500)
        .json({ success: false, message: "Erro ao buscar o usuário" });
    }
  },

  error: async (req, res) => {
    const { msg, authID } = req.body;
    if (!msg || !authID) {
      return res.status(400).json({ error: "Ausência de dados!" });
    }

    sendDiscordMessage(
      process.env.DISCORD_ERRORS,
      "**[Erro no anticheat]**\nCódigo do servidor: " +
        authID +
        "\nERRO: " +
        msg +
        "\n<@297122391580999692>"
    );
    res.json({ success: true, message: "Erro em análise" });
  },

  serverLogs: async (req, res) => {
    const { authid, porta, name, discord } = req.body;

    try {
      // Use o método findOne do modelo 'logsModel' para buscar o registro pelo authID
      const existingLog = await logsSchema.findOne({ authID: authid });

      if (existingLog) {
        // Atualize o registro existente
        const currentDate = new Date()
          .toISOString()
          .slice(0, 19)
          .replace("T", " ");
        existingLog.lastIP = req.clientIp + ":" + porta;
        existingLog.lastName = name;
        existingLog.discord = discord;
        existingLog.lastStart = currentDate;

        await existingLog.save();

        res.status(200).json({ message: "Registro atualizado com sucesso" });
      } else {
        // Insira um novo registro se não houver um valor igual no authID
        const currentDate = new Date()
          .toISOString()
          .slice(0, 19)
          .replace("T", " ");
        const newLog = new logsSchema({
          authID: authid,
          originalIP: req.clientIp + ":" + porta,
          entry: 1,
          lastIP: req.clientIp + ":" + porta,
          originalName: name,
          lastName: name,
          discord: discord,
          lastStart: currentDate,
        });

        await newLog.save();
        res
          .status(201)
          .json({ success: true, message: "Registro inserido com sucesso" });
      }
    } catch (error) {
      console.error("Erro ao consultar o banco de dados MongoDB:", error);
      res.status(500).json({ error: "Erro interno do servidor" });
    }
  },

  requestDemo: async (req, res) => {
    const requestKeysModel = require("../models/requestKeys");
    const loginModel = require("../models/login");

    const clientIp = req.clientIp;

    try {
      // Use o método findOne do modelo 'requestKeysModel' para verificar se já existe uma chave pendente para o IP
      const existingRequest = await requestKeysModel.findOne({ ip: clientIp });

      if (existingRequest) {
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

      const user = "demo" + generateRandomString(3);
      const password = generateRandomString(64);
      const currentDateAndTime = new Date();
      const twoDaysInMilliseconds = 7 * 24 * 60 * 60 * 1000;
      const newDateAndTime = new Date(
        currentDateAndTime.getTime() + twoDaysInMilliseconds
      );

      // Use o modelo 'loginModel' para inserir um novo registro na coleção 'login'
      const newLogin = new loginModel({
        server: "DEMO",
        user: user,
        pwd: password,
        active: 1,
        created: currentDateAndTime,
        endSubscription: newDateAndTime,
        ss: 1,
      });

      await newLogin.save();
      await criarApi(newLogin._id);

      // Use o modelo 'requestKeysModel' para inserir um novo registro na coleção 'requestKeys'
      const newRequestKey = new requestKeysModel({
        ip: clientIp,
        type: "demo",
        authID: newLogin._id,
      });

      await newRequestKey.save();

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
                <a class="download-button" href="https://github.com/ruip005/mta_anticheat/releases/download/v2.2.0.00/v2.2.zip" download>Baixar</a>
                <hr>
                <iframe width="560" height="315" src="https://www.youtube.com/embed/2OMdYLaOqTw?si=S_E3iUf2Qp2c3rbb" frameborder="0" allowfullscreen></iframe>
            </div>
        </body>
        </html>
    `);
    } catch (error) {
      console.error("Erro ao consultar o banco de dados MongoDB:", error);
      res.status(500).json({ error: "Erro interno do servidor" });
    }
  },

  printLogs: async (req, res) => {
    const { nick, serial, ip, authID, img } = req.body;

    try {
      // Use o modelo 'printsModel' para inserir um novo registro na coleção 'prints'
      const newPrint = new logsSchema({
        user: nick,
        serial: serial,
        ip: ip,
        authID: authID,
        img: img,
      });

      await newPrint.save();

      res.status(200).json({ success: true });
    } catch (error) {
      console.error("Erro ao consultar o banco de dados MongoDB:", error);
      res.status(500).json({ error: "Erro interno do servidor" });
    }
  },

  lookupAuth: async (req, res) => {
    const { id } = req.params;

    try {
      // Use o modelo 'loginModel' para encontrar o registro na coleção 'login' com o usuário correspondente
      const record = await loginSchema.findOne({ user: id });

      if (!record) {
        return res
          .status(404)
          .json({ success: false, message: "Registro não encontrado" });
      }

      const dataFormatada = record.created.toLocaleDateString();
      const dataFormatada1 = record.endSubscription.toLocaleDateString();

      const Status = record.active ? "Ativo" : "Desativado";
      const SS = record.ss ? "Habilitado" : "Desabilitado";

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
    `;

      // Retornar a resposta HTML
      res.send(htmlResponse);
    } catch (error) {
      console.error("Erro ao consultar o banco de dados MongoDB:", error);
      res.status(500).json({ error: "Erro interno do servidor" });
    }
  },

  lookupAuthInJSON: async (req, res) => {
    const { id } = req.params;

    try {
      // Use o modelo 'loginModel' para encontrar o registro na coleção 'login' com o usuário correspondente
      const record = await loginSchema.findOne({ user: id });

      if (!record) {
        return res
          .status(404)
          .json({ success: false, message: "Registro não encontrado" });
      }

      const dataFormatada = record.created.toLocaleDateString();
      const dataFormatada1 = record.endSubscription.toLocaleDateString();

      const Status = record.active ? "Ativo" : "Desativado";
      const SS = record.ss ? "Habilitado" : "Desabilitado";

      // Retornar a resposta JSON
      res.status(200).json({
        success: true,
        id: record.id,
        servidor: record.server,
        status: Status,
        reqs: dataFormatada,
        exp: dataFormatada1,
        ss: SS,
      });
    } catch (error) {
      console.error("Erro ao consultar o banco de dados MongoDB:", error);
      res
        .status(500)
        .json({ success: false, error: "Erro interno do servidor" });
    }
  },

  requestMailgun: async (req, res) => {
    const { sigla, duracao, email } = req.body;

    if (!sigla || !duracao) {
      return res
        .status(400)
        .json({ success: false, error: "Ausência de dados!" });
    }

    if (duracao !== "demo" && duracao !== "monthly" && duracao !== "lifetime") {
      return res
        .status(400)
        .json({ success: false, error: "Duração inválida!" });
    }

    const clientIp = req.clientIp;

    let user = generateRandomString(8);
    let password = generateRandomString(64);

    const currentDateAndTime = new Date();
    let twoDaysInMilliseconds;

    if (duracao === "demo") {
      twoDaysInMilliseconds = 7 * 24 * 60 * 60 * 1000;
    } else if (duracao === "monthly") {
      twoDaysInMilliseconds = 31 * 24 * 60 * 60 * 1000;
    } else {
      twoDaysInMilliseconds = 999999 * 24 * 60 * 60 * 1000;
    }

    const newDateAndTime = new Date(
      currentDateAndTime.getTime() + twoDaysInMilliseconds
    );

    try {
      const loginRecord = new loginSchema({
        server: sigla,
        user,
        pwd: password,
        active: 1,
        created: currentDateAndTime,
        endSubscription: newDateAndTime,
        ss: 1,
      });

      const savedLoginRecord = await loginRecord.save();
      await criarApi(savedLoginRecord._id);

      const requestKeysRecord = new requestKeysModel({
        ip: clientIp,
        type: duracao,
        authID: savedLoginRecord._id,
      });

      await requestKeysRecord.save();

      if (!email) {
        return res.status(200).json({
          success: true,
          message: `Sucesso! Aqui estão suas credenciais:\n**User**: ${user}\n**Key**: ${password}\nAnticheat: https://github.com/ruip005/mta_anticheat/releases/download/v2.0.1.01/v2.0.1.01S.zip`,
        });
      } else {
        const emailData = {
          from: "Anticheat Credentials <admin@uw33dac.me>",
          to: email,
          subject: "Anticheat Credentials",
          html: `
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
            <div class="header">
              <h1>Credenciais do Anticheat</h1>
            </div>
            <div class="content">
              <p>Olá,</p>
              <p>Aqui estão as credenciais do Anticheat para <strong>${sigla}</strong>:</p>
              <p><strong>Usuário:</strong> ${user}</p>
              <p><strong>Chave:</strong> ${password}</p>
              <p>Atenciosamente, Anticheat Admin</p>
              <a class="download-button" href="https://github.com/ruip005/mta_anticheat/releases/download/v2.3.0.00/v2.3.zip" target="_blank">Baixar Anticheat</a>
            </div>
          </div>
        </body>
        </html>
      `,
        };

        mailgun.messages().send(emailData, (error, body) => {
          if (error) {
            console.error("Erro ao enviar o e-mail:", error);
            return res
              .status(500)
              .json({ success: false, error: "Erro ao enviar e-mail" });
          } else {
            console.log("E-mail enviado com sucesso:", body);
            return res.status(200).json({
              success: true,
              message: "Credenciais enviadas por e-mail com sucesso!",
            });
          }
        });
      }
    } catch (error) {
      console.error("Erro ao salvar os registros no banco de dados:", error);
      return res
        .status(500)
        .json({ success: false, error: "Erro interno do servidor" });
    }
  },
};

module.exports = serverController;

function generateRandomString(length) {
  const characters =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  let randomString = "";
  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    randomString += characters.charAt(randomIndex);
  }

  return randomString;
}
