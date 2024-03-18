const mongoose = require("mongoose");

const loginSchema = new mongoose.Schema({
  server: {
    type: String,
    required: false,
  },
  user: {
    type: String,
    required: true,
  },
  pwd: {
    type: String,
    required: true,
  },
  active: {
    type: Boolean,
    required: true,
  },
  created: {
    type: Date,
    required: true,
    default: Date.now,
  },
  endSubscription: {
    type: Date,
    required: true,
  },
  ss: {
    type: Boolean,
    required: true,
    default: true,
  },
});

const loginModel = mongoose.model("login", loginSchema);

module.exports = loginModel;
