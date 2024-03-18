const mongoose = require("mongoose");

const printsSchema = new mongoose.Schema({
  user: {
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
  img: {
    type: String,
    required: false,
  },
});

const printsModel = mongoose.model("prints", printsSchema);

module.exports = printsModel;
