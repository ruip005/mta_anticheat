const Discord = require("discord.js");
const axios = require("axios");
module.exports = {
  name: "serial",
  description: "Saiba se o serial está banido",
  options: [
    {
      type: Discord.ApplicationCommandOptionType.String,
      name: "serial",
      description: "Qual é o serial (SERIAL)?",
      required: true,
    },
  ],

  run: async (client, interaction) => {
    let serials;
    try {
      serials = interaction.options.getString("serial");

      const response = await axios.get(
        `https://api.uw33dac.me/v2/public/gbans/json/${serials}`
      );
      const data = response.data;

      let embedY = new Discord.EmbedBuilder()
        .setColor("Green")
        .setTitle("🔍 Banimento encontrado!")
        .addFields(
          {
            name: `🔑 ID`,
            value: `${data.id}`,
            inline: true,
          },
          {
            name: `👤 Nick`,
            value: `${data.usuário}`,
            inline: true,
          },
          {
            name: `💻 Serial`,
            value: `${data.serial}`,
            inline: true,
          },
          {
            name: `🔌 IPv4`,
            value: `${data.ip}`,
            inline: true,
          },
          {
            name: `👮‍♂️ Motivo`,
            value: `${data.motivo}`,
            inline: true,
          },
          {
            name: `📡 Servidor`,
            value: `${data.server}`,
            inline: true,
          },
          {
            name: `📷 Prova`,
            value: `${data.img}`,
            inline: true,
          }
        );

      await interaction.reply({ embeds: [embedY] });
    } catch (error) {
      let embedN = new Discord.EmbedBuilder() // Sem ban
        .setAuthor({ name: `❌ Sem banimento` })
        .setDescription(
          `O Jogador com o serial **${serials}** não está banido!`
        )
        .setColor("Red");
      await interaction.reply({ embeds: [embedN] });
      return;
    }
  },
};
