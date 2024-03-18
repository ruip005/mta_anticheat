const mongoose = require("mongoose");

const logsSchema = new mongoose.Schema({
  authID: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "login",
    required: true,
  },
  originalIP: {
    type: String,
    required: true,
  },
  entry: {
    type: Number,
    required: false,
    default: 1,
  },
  lastIP: {
    type: String,
    required: false,
  },
  suspectIP: {
    type: String,
    required: false,
  },
  originalName: {
    type: String,
    required: true,
  },
  lastName: {
    type: String,
    required: false,
  },
  discord: {
    type: String,
    required: false,
  },
  lastStart: {
    type: Date,
    required: false,
    default: Date.now,
  },
});

const logsModel = mongoose.model("logs", logsSchema);

module.exports = logsModel;
