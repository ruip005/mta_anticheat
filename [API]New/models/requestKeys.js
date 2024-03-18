const mongoose = require("mongoose");

const requestKeysSchema = new mongoose.Schema({
  ip: {
    type: String,
    required: true,
  },
  type: {
    type: String,
    required: true,
    enum: ["demo", "monthly", "lifetime"],
  },
  authID: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "login",
    required: true,
  },
});

const requestKeysModel = mongoose.model("requestKeys", requestKeysSchema);

module.exports = requestKeysModel;
