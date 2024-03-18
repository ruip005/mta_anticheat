const api = require("../models/api");
const sendDiscordMessage = require("../utils/discord");

const authenticate = async (req, res, next) => {
  const apiKey = req.header("x-api-key"); // Obtém a chave de API do cabeçalho da solicitação

  if (!apiKey) {
    sendDiscordMessage(
      process.env.DISCORD_SECURITY,
      `🚨 **ALERTA DE SEGURANÇA** 🚨\n\nUma tentativa de acesso foi bloqueada devido à falta de uma chave de API.\nIPv4: ${req.clientIp
      }\nRota: ${req.originalUrl || "NIL"}`
    );
    return res.status(401).json({ message: "Acesso negado" });
  }

  const apiInstance = await api.findOne({ key: apiKey });
  if (!apiInstance) {
    sendDiscordMessage(
      process.env.DISCORD_SECURITY,
      `🚨 **ALERTA DE SEGURANÇA** 🚨\n\nUma tentativa de acesso foi bloqueada devido a uma chave de API inválida.\nIPv4: ${req.clientIp
      }\nRota: ${req.originalUrl || "NIL"}`
    );
    return res.status(401).json({ message: "Acesso negado" });
  }
  console.log(`[API] Chave de API válida: ${apiInstance.key}, Rotas: ${req.originalUrl}`);
  next();
};

module.exports = authenticate;
