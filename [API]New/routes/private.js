const express = require("express");
const { Router } = express;
const router = Router();
const authenticate = require("../utils/middlewares");
const bansController = require("../controllers/bans");
const serverController = require("../controllers/server");
const imagesController = require("../controllers/images");
const spooferController = require("../controllers/spoofer");

router.post("/login", serverController.authenticate);
router.post("/addgban", authenticate, bansController.newGlobalBan);
router.post("/addlocalban", authenticate, bansController.newLocalBan);
router.post("/errors", authenticate, serverController.error);
router.get("/bans", authenticate, bansController.listBans);
router.post("/checkban", authenticate, bansController.checkBan); // Parei aqui
router.post("/logs", authenticate, serverController.serverLogs);
router.post("/print", authenticate, serverController.printLogs);
router.post("/sendphoto", authenticate, imagesController.sendPhoto);
router.get("/getphoto/:id", imagesController.getPhoto);
router.post("/spoofer", authenticate, spooferController.checkSpoofer);
router.post("/revoke", authenticate, spooferController.revokeBan);

module.exports = router;
