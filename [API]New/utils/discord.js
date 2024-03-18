const axios = require("axios");

const sendDiscordMessage = async (webhookUrl, message) => {
  try {
    const payload = {
      content: message,
    };

    await axios.post(webhookUrl, payload);
  } catch (error) {
    console.log("[API] Erro ao enviar a mensagem para o Discord:", error);
  }
};

module.exports = sendDiscordMessage;
