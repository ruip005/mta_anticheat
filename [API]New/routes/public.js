const express = require("express");
const { Router } = express;
const router = Router();
const bansController = require("../controllers/bans");
const serverController = require("../controllers/server");

router.get("/bans", bansController.getBans);
router.get("/demo", serverController.requestDemo);
router.get("/gbans/user/:id", bansController.getBanById);
router.get("/gbans/serial/:id", bansController.getBanBySerial);
router.get("/gbans/json/:id", bansController.getBanInJSON);
router.get("/auth/:id", serverController.lookupAuth);
router.get("/auth/json/:id", serverController.lookupAuthInJSON);
router.post("/demo/plz", serverController.requestMailgun);

module.exports = router;
