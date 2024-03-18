const fs = require("fs").promises;
const path = require("path");
const axios = require("axios");

const uploadDir = path.join(__dirname, "../uploads"); // Diretório onde as imagens serão salvas

const imagesController = {
  sendPhoto: async (req, res) => {
    if (!(await fs.stat(uploadDir))) {
      await fs.mkdir(uploadDir);
    }
    try {
      const { id, nick, user, ide, serial, ip, webhook, image } = req.body;

      const imageData = Buffer.from(image, "base64");
      const fileName = `${id}.png`;
      const filePath = path.join(uploadDir, fileName);

      // Salvar a imagem usando fs.promises
      if (image) {
        await fs.writeFile(filePath, imageData);
      } else {
        const blackPixelBase64 =
          "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVR42mNkAAIAAAoAAggA";
        const blackImageData = Buffer.from(blackPixelBase64, "base64");
        await fs.promises.writeFile(filePath, blackImageData);
      }

      try {
        // Criar o objeto embed para a mensagem
        const embed = {
          title: "**Suspeito**",
          color: 10692302,
          description: `**NICK:** ${nick}\n**USER:** ${user}\n**ID:** ${ide}\n**SERIAL:** ${serial}\n**IP:** ${ip}`,
          image: { url: `https://images.uw33dac.me/${id}` },
        };

        // Criar o objeto de dados para a requisição axios
        const data = {
          content: "",
          username: "uW33D Anticheat",
          avatar_url:
            "https://github.com/ruip005/mta_anticheat/blob/main/AC.png?raw=true",
          embeds: [embed],
        };

        // Enviar a mensagem para o webhook usando axios
        await axios.post(webhook, data);
      } catch (err) {
        console.log("ERRO:", err);
      }

      res.json({
        success: true,
        message: "Imagem recebida e salva com sucesso",
        id,
      });
    } catch (err) {
      console.error("Erro ao salvar a imagem:", err);
      res
        .status(500)
        .json({ success: false, error: "Erro ao salvar a imagem" });
    }
  },

  getPhoto: async (req, res) => {
    if (!(await fs.stat(uploadDir))) {
      await fs.mkdir(uploadDir);
    }
    try {
      const { id } = req.params;
      const fileName = `${id}.png`;
      const filePath = path.join(uploadDir, fileName);

      const data = await fs.readFile(filePath);

      res.writeHead(200, { "Content-Type": "image/png" });
      res.end(data);
    } catch (err) {
      console.error("Erro ao ler a imagem:", err);
      res.status(404).json({ error: "Imagem não encontrada" });
    }
  },
};

module.exports = imagesController;
