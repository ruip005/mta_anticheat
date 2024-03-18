const gbansSchema = require("../models/gbans");
const localbanSchema = require("../models/localbans");
const logsModel = require("../models/logs");
const sendDiscordMessage = require("../utils/discord");
const mongoose = require("mongoose");
const loginSchema = require("../models/login");

const bansController = {
  getBans: async (req, res) => {
    try {
      // Utilize o método .find() para obter todos os gbans e popule o campo 'autor' para obter o nome do servidor
      const gbans = await gbansSchema.find().populate("autor", "originalName");

      // Mapeie o resultado para formatar a resposta da maneira desejada
      const formattedGbans = gbans.map((gban) => ({
        user: gban.user,
        serial: gban.serial,
        ip: "NO ACCESS",
        motivo: gban.motivo,
        autor: gban.autor.originalName, // Substitua 'originalName' pelo nome correto do campo no seu modelo 'login'
        img: gban.img,
      }));

      res.json(formattedGbans);
    } catch (error) {
      console.error(error);
      res.status(500).json({ success: false, message: "Erro ao buscar gbans" });
    }
  },

  newGlobalBan: async (req, res) => {
    const { user, serial, ip, reason, auth, img } = req.body;

    if (!user || !serial || !reason || !auth) {
      return res
        .status(400)
        .json({ success: false, message: "Ausência de dados!" });
    }

    const newBan = new gbansSchema({
      user,
      serial,
      ip,
      motivo: reason,
      autor: auth,
      img,
    });

    if (auth) {
      const login = await loginSchema.findOne({ _id: auth });

      if (!login) {
        return res
          .status(400)
          .json({ success: false, message: "Servidor não encontrado!" });
      }
    }

    await newBan.save();

    sendDiscordMessage(
      process.env.DISCORD_GBAN,
      "**[Novo banimento global]**\nCódigo do servidor: " +
      auth +
      "\nJogador: " +
      user +
      "\nSerial: " +
      serial +
      "\nIP: " +
      ip +
      "\nMotivo: " +
      reason +
      "\nProva: https://images.uw33dac.me/" +
      img
    );
    res.status(201).json({
      success: true,
      message: "Registro GlobalBan adicionado com sucesso",
    });
  },

  newLocalBan: async (req, res) => {
    const { player, serial, ip, reason, authID, img } = req.body;
    if (!player || !serial || !ip || !authID || !reason) {
      return res
        .status(400)
        .json({ success: false, message: "Ausência de dados!" });
    }

    const newBan = new localbanSchema({
      user: player,
      serial,
      ip,
      reason,
      autor: authID,
      img,
    });

    await newBan.save();

    sendDiscordMessage(
      process.env.DISCORD_LOCALBAN,
      "**[Novo banimento local]**\nCódigo do servidor: " +
      authID +
      "\nJogador: " +
      player +
      "\nSerial: " +
      serial +
      "\nIP: " +
      ip +
      "\nMotivo: " +
      reason +
      "\nProva: https://images.uw33dac.me/" +
      img
    );
    res.status(201).json({
      success: true,
      message: "Registro LocalBan adicionado com sucesso",
    });
  },

  checkBan: async (req, res) => {
    const { serial, ip } = req.body;

    if (!serial && !ip) {
      return res
        .status(400)
        .json({ success: false, message: "Serial ou IP não fornecido" });
    }

    try {
      // Pesquisar se o serial ou IP está na lista de banidos
      const gban = await gbansSchema.findOne({ $or: [{ serial }, { ip }] });
      return res.json({ success: true, isBlacklisted: !!gban });
    } catch (error) {
      console.error("Erro ao consultar o banco de dados MongoDB:", error);
      res.status(500).json({
        success: false,
        message: "Erro ao consultar o banco de dados",
      });
    }
  },

  listBans: async (req, res) => {
    try {
      // Use o método find do modelo gbansSchema para obter seriais e IPs
      const gbans = await gbansSchema.find({}, "serial ip");

      // Mapeie o resultado para obter uma lista de seriais e ips
      const seriais = gbans.map((gban) => gban.serial);
      const ips = gbans.map((gban) => gban.ip);

      res.json({ seriais, ips });
    } catch (error) {
      console.error("Erro ao consultar o banco de dados MongoDB:", error);
      res.status(500).json({
        success: false,
        message: "Erro ao consultar o banco de dados",
      });
    }
  },

  getBanById: async (req, res) => {
    const { id } = req.params;

    if (!id) {
      return res
        .status(400)
        .json({ success: false, message: "ID não fornecido" });
    }

    try {
      if (!mongoose.Types.ObjectId.isValid(id)) {
        return res
          .status(400)
          .json({ success: false, message: "ID não é válido!" });
      }
      // Use o método findById para buscar o registro pelo ID
      const record = await gbansSchema.findById(id);

      if (!record) {
        return res
          .status(404)
          .json({ success: false, message: "Registro não encontrado" });
      }

      // Use o método findOne do modelo 'logs' para buscar o nome do servidor
      const resultss = await logsModel.findOne(
        { authID: record.autor },
        "originalName"
      );

      if (resultss) {
        const serverName = resultss.originalName;

        // Montar a resposta com valores dinâmicos e mensagem
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
      } else {
        return res
          .status(404)
          .json({ success: false, message: "Registro não encontrado" });
      }
    } catch (error) {
      console.error("Erro ao consultar a base de dados MongoDB:", error);
      res
        .status(500)
        .json({ success: false, message: "Erro ao verificar dados" });
    }
  },

  getBanBySerial: async (req, res) => {
    const { id } = req.params;

    if (!id) {
      return res
        .status(400)
        .json({ success: false, message: "SERIAL não fornecido" });
    }

    try {
      // Use o método findOne do modelo 'gbansModel' para buscar o registro pelo serial
      const record = await gbansSchema.findOne({ serial: id });

      if (!record) {
        return res
          .status(404)
          .json({ success: false, message: "Registro não encontrado" });
      }

      // Use o método findOne do modelo 'logsModel' para buscar o nome do servidor
      const resultss = await logsModel.findOne(
        { authID: record.autor },
        "originalName"
      );

      if (resultss) {
        const serverName = resultss.originalName;

        // Montar a resposta com valores dinâmicos e mensagem
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
      } else {
        return res
          .status(404)
          .json({ success: false, message: "Registro não encontrado" });
      }
    } catch (error) {
      console.error("Erro ao consultar o banco de dados MongoDB:", error);
      res
        .status(500)
        .json({ success: false, message: "Erro ao verificar dados" });
    }
  },

  getBanInJSON: async (req, res) => {
    const { id } = req.params;

    if (!id) {
      return res
        .status(400)
        .json({ success: false, message: "ID não fornecido" });
    }

    try {
      // Use o método findOne do modelo 'gbansModel' para buscar o registro pelo serial
      const record = await gbansSchema.findOne({ serial: id });

      if (!record) {
        return res
          .status(404)
          .json({ success: false, message: "Registro não encontrado" });
      }

      // Use o método findOne do modelo 'logsModel' para buscar o nome do servidor
      const resultss = await logsModel.findOne(
        { authID: record.autor },
        "originalName"
      );

      if (resultss) {
        const serverName = resultss.originalName;

        // Retornar a resposta JSON
        res.status(200).json({
          success: true,
          id: record.id,
          usuário: record.user,
          serial: record.serial,
          ip: record.ip,
          motivo: record.motivo,
          server: serverName,
          img: record.img,
        });
      } else {
        return res
          .status(404)
          .json({ success: false, message: "Registro não encontrado" });
      }
    } catch (error) {
      console.error("Erro ao consultar o banco de dados MongoDB:", error);
      res
        .status(500)
        .json({ success: false, message: "Erro ao verificar dados" });
    }
  },
};

module.exports = bansController;
