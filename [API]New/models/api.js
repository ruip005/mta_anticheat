const mongoose = require("mongoose");

const apikeySchema = new mongoose.Schema({
  serverId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "server",
    required: true,
  },
  key: {
    type: String,
    required: true,
  },
});

const apikeyModel = mongoose.model("api", apikeySchema);

module.exports = apikeyModel;
