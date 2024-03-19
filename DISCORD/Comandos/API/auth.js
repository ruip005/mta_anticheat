const Discord = require("discord.js");
const axios = require("axios");
module.exports = {
  name: "auth",
  description: "Saiba o estado da sua chave",
  options: [
    {
      type: Discord.ApplicationCommandOptionType.String,
      name: "auth",
      description: "Qual é o seu User?",
      required: true,
    },
  ],

  run: async (client, interaction) => {
    try {
      let authID = interaction.options.getString("auth");

      const response = await axios.get(
        `https://api.uw33dac.me/v2/public/auth/json/${authID}`
      );
      const data = response.data;
      console.log(response)

      let embedY = new Discord.EmbedBuilder()
        .setColor("Green")
        .setTitle("🔍 Chave encontrada!")
        .addFields(
          {
            name: `🔑 ID`,
            value: `${data.id}`,
            inline: true,
          },
          {
            name: `📡 Servidor`,
            value: `${data.servidor}`,
            inline: true,
          },
          {
            name: `🔌 Estado`,
            value: `${data.status}`,
            inline: true,
          },
          {
            name: `📩 Requisitado em`,
            value: `${data.reqs}`,
            inline: true,
          },
          {
            name: `🗃 Expira em`,
            value: `${data.exp}`,
            inline: true,
          },
          {
            name: `📺 Screenshot API`,
            value: `${data.ss}`,
            inline: true,
          }
        );

      await interaction.reply({ embeds: [embedY] });
    } catch (error) {
      let embedN = new Discord.EmbedBuilder() // Sem ban
        .setAuthor({ name: `❌ Sem registo` })
        .setDescription(`Essa chave do anticheat não foi encontrada 😯!`)
        .setColor("Red");
      await interaction.reply({ embeds: [embedN] });
      return;
    }
  },
};
