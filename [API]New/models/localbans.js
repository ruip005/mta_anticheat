const mongoose = require("mongoose");

const localbansSchema = new mongoose.Schema({
  player: {
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
  reason: {
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

const localbansModel = mongoose.model("localbans", localbansSchema);

module.exports = localbansModel;
