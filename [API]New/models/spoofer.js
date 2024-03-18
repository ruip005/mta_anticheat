const mongoose = require("mongoose");

const spooferSchema = new mongoose.Schema({
  genHWID: {
    type: String,
    required: true,
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
  authID: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "login",
    required: true,
  },
});

const spooferModel = mongoose.model("spoofer", spooferSchema);

module.exports = spooferModel;
