const mongoose = require("mongoose");

const gbansSchema = new mongoose.Schema({
  user: {
    type: String,
    required: false,
  },
  serial: {
    type: String,
    required: true,
    maxlength: 32,
  },
  ip: {
    type: String,
    required: false,
  },
  motivo: {
    type: String,
    required: false,
  },
  autor: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "server",
    required: true,
  },
  img: {
    type: String,
    required: false,
  },
});

const gbansModel = mongoose.model("gbans", gbansSchema);

module.exports = gbansModel;
