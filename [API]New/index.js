const port = 9000;
const express = require("express");
const app = express();
const db = require("mongoose");
const requestIp = require("request-ip");
const bodyParser = require("body-parser");
require("dotenv").config();
const verificarAuth = require("./utils/verifyAuthDate");

app.use(express.json());
app.use(requestIp.mw());
app.use(bodyParser.json());

connectDB = async () => {
  // Função para ligar à base de dados
  try {
    await db.connect(process.env.MONGO_URL, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log("Ligação MongoDB estabelecida.");
    console.log("Database atual:" + db.connection.db.databaseName);
  } catch (error) {
    console.error("[ERRO] Ligação MongoDB não estabelecida:");
    process.exit(1);
  }
};

connectDB();
verificarAuth();

// A cada dia chamar verificarAuth para desativar contas
setInterval(verificarAuth, 86400000);


// Rotas
app.use("/v2/public", require("./routes/public"));
app.use("/v2/priv8", require("./routes/private"));

app.listen(port, function () {
  console.log(`Servidor arrancado na porta ${port}!`);
});
