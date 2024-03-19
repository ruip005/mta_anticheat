const Discord = require("discord.js")
require('dotenv').config()
const { QuickDB } = require('quick.db')
const db = new QuickDB()

const client = new Discord.Client({
  intents: [1, 512, 32768, 2, 128,
    Discord.IntentsBitField.Flags.DirectMessages,
    Discord.IntentsBitField.Flags.GuildInvites,
    Discord.IntentsBitField.Flags.GuildMembers,
    Discord.IntentsBitField.Flags.GuildPresences,
    Discord.IntentsBitField.Flags.Guilds,
    Discord.IntentsBitField.Flags.MessageContent,
    Discord.IntentsBitField.Flags.Guilds,
    Discord.IntentsBitField.Flags.GuildMessageReactions,
    Discord.IntentsBitField.Flags.GuildEmojisAndStickers
  ],
  partials: [
    Discord.Partials.User,
    Discord.Partials.Message,
    Discord.Partials.Reaction,
    Discord.Partials.Channel,
    Discord.Partials.GuildMember
  ]
});

module.exports = client

client.on('interactionCreate', (interaction) => {

  if (interaction.type === Discord.InteractionType.ApplicationCommand) {

    const cmd = client.slashCommands.get(interaction.commandName);

    if (!cmd) return interaction.reply(`Error`);

    interaction["member"] = interaction.guild.members.cache.get(interaction.user.id);

    cmd.run(client, interaction)

  }
})

client.slashCommands = new Discord.Collection()

require('./handler')(client)

client
  .on('ready', () => {
    console.log(`😘 BOT Online, autenticado como: ${client.user.username}`)
    client.user.setStatus("idle")
    client.user.setActivity("Seja já um testador beta do Anticheat V2. Aceda https://api.uw33dac.me/demo")

  })

  .on('messageCreate', async (message) => {
    if (message.author.bot) return
    console.log(message.content)
    //await message.react("✅")
  })

  .on("interactionCreate", async (interaction) => {
    if (interaction.isButton()) {
      if (interaction.customId === "formulario") {
        if (!interaction.guild.channels.cache.get(await db.get(`canal_logs_${interaction.guild.id}`))) return interaction.reply({ content: `O sistema está desativado.`, ephemeral: true })
        const modal = new Discord.ModalBuilder()
          .setCustomId("modal")
          .setTitle("Pedido de Key do Anticheat v2");

        const pergunta1 = new Discord.TextInputBuilder()
          .setCustomId("pergunta1") // Coloque o ID da pergunta
          .setLabel("Sigla do Server") // Coloque a pergunta
          .setMaxLength(30) // Máximo de caracteres para a resposta
          .setMinLength(3) // Mínimo de caracteres para a respósta
          .setPlaceholder("Ex:. BFP ou Brasil Focus Roleplay!") // Mensagem que fica antes de escrever a resposta
          .setRequired(true) // Deixar para responder obrigatório (true | false)
          .setStyle(Discord.TextInputStyle.Short) // Tipo de resposta (Short | Paragraph)

        const pergunta2 = new Discord.TextInputBuilder()
          .setCustomId("pergunta2") // Coloque o ID da pergunta
          .setLabel("Duração da Key") // Coloque a pergunta
          .setMaxLength(8) // Máximo de caracteres para a resposta
          .setMinLength(4) // Mínimo de caracteres para a respósta
          .setPlaceholder("demo, monthly, lifetime") // Mensagem que fica antes de escrever a resposta
          .setStyle(Discord.TextInputStyle.Short) // Tipo de resposta (Short | Paragraph)
          .setRequired(true)

        modal.addComponents(
          new Discord.ActionRowBuilder().addComponents(pergunta1),
          new Discord.ActionRowBuilder().addComponents(pergunta2),
        )

        await interaction.showModal(modal)
      }
    } else if (interaction.isModalSubmit()) {
      if (interaction.customId === "modal") {
        let resposta1 = interaction.fields.getTextInputValue("pergunta1")
        let resposta2 = interaction.fields.getTextInputValue("pergunta2")

        if (!resposta1) resposta1 = "Não informado."
        if (!resposta2) resposta2 = "Não informado."

        if (resposta2 !== 'demo' && resposta2 !== 'monthly' && resposta2 !== 'lifetime')
        return interaction.reply({ content: `**${interaction.user.username}**, seu pedido foi cancelado devido ao introduzir dados inválidos (Duração)`})

        let embed = new Discord.EmbedBuilder()
          .setColor("Green")
          .setAuthor({ name: interaction.guild.name, iconURL: interaction.guild.iconURL({ dynamic: true }) })
          .setThumbnail(interaction.user.displayAvatarURL({ dynamic: true }))
          .setDescription(`O usuário ${interaction.user} enviou o pedido abaixo:`)
          .addFields(
            {
              name: `📡 Qual a sigla ou nome do seu servidor:`,
              value: `*Resposta :* \`${resposta1}\``,
              inline: false
            },
            {
              name: `⌛ Qual seria a duração da sua Key:`,
              value: `*Resposta :* \`${resposta2}\``,
              inline: false
            },
          );

        interaction.reply({ content: `Olá **${interaction.user.username}**, seu pedido está em espera.\n**Atenção** deixe a DM ligada!`, ephemeral: true })
        await interaction.guild.channels.cache.get(await db.get(`canal_logs_${interaction.guild.id}`)).send({ embeds: [embed] })

        pedir(resposta1, resposta2)
        .then((res) => {
          interaction.user.send(res)
        })
        .catch((err) => {
          console.log("ERR FUNC:", err)
        })
      }
    }
  })

  .login(process.env.TOKEN)

  pedir = async (sigla, dur) => {
    const axios = require('axios')
      /*
      axios.get(url, requestData)
        .then((resposta) => {
          console.log(`dadaos da api`, resposta.data)
        })
        .catch((error) => {
          console.log("erro", error)
        })
      */
        try {
          const requestData = {
            sigla: sigla,
            duracao: dur,
          }
      
          const response = await axios.post('https://api.uw33dac.me/demo/json/', requestData);
      
          if (response.status === 200) {
            const data = response.data;
            if (data.message) {
              return data.message;
            } else {
              return 'Dados da API não possuem a propriedade "message".';
            }
          } else {
            return 'Erro na resposta da API: ' + response.status;
          }
        } catch (error) {
          console.error('ERRO API DEMO:', error);
          return 'Erro na chamada da API.';
        }
  }
const fs = require('fs');

fs.readdir('./Events', (err, file) => {
  file.forEach(event => {
    require(`./Events/${event}`)
  })
})
