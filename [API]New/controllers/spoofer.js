const spooferSchema = require("../models/spoofer");
const gbansSchema = require("../models/gbans");
const localbanSchema = require("../models/localbans");
const sendDiscordMessage = require("../utils/discord");

const spooferController = {
  addLocalBan: async (req, res) => {
    const { player, serial, ip, reason, authID, img } = req.body;
    if (!player || !serial || !ip || !authID || !reason) {
      return res
        .status(400)
        .json({ success: false, message: "Ausência de dados!" });
    }

    const newBan = new localbanSchema({
      user: player,
      serial,
      ip,
      reason,
      autor: authID,
      img,
    });

    try {
      await newBan.save();
      return res.status(201).json({
        success: true,
        message: "Ban local adicionado com sucesso!",
      });
    } catch (err) {
      return res.status(500).json({ success: false, message: err.message });
    }
  },
  revokeBan: async (req, res) => {
    const { serial, auth } = req.body;

    if (!serial || !auth) {
      return res
        .status(400)
        .json({ success: false, message: "Ausência de dados!" });
    }

    const haveBan = await localbanSchema.findOne({ serial, autor: auth });

    if (!haveBan) {
      return res
        .status(400)
        .json({ success: false, message: "Ban não encontrado!" });
    }

    await localbanSchema.deleteOne({
      serial,
      autor: auth,
    });

    return res.status(200).json({
      success: true,
      message: "Ban revogado com sucesso!",
    });
  },

  checkSpoofer: async (req, res) => {
    const { haveHWID, auth, hwid, serial, ip } = req.body;

    if (!hwid || !auth || !serial) {
      return res
        .status(400)
        .json({ success: false, message: "Ausência de dados!" });
    }

    const checkIPBanned = await checkIP(ip);
    const genhwid = await tryFindHWID(serial);

    if (!haveHWID) {
      // Se não tiver HWID criado no client-side
      const isSerial = await tryFindSerial(serial);
      if (isSerial) {
        // Verifica se o serial está na base de dados
        const isBanned = await isSerialBanned(serial);
        const isBannedLocal = await banEqualsServer(serial, auth);
        if (isBanned || isBannedLocal) {
          // Se o serial estiver banido retorna um JSON com a propriedade banned a true
          return res.status(200).json({
            success: true,
            banned: true,
            hwid: (genhwid === undefined || genhwid == 'nil') ? hwid : genhwid,
          });
        } else {
          // Se o serial não estiver banido retorna um JSON com a propriedade banned a false
          return res.status(200).json({
            success: true,
            banned: false,
            hwid: (genhwid === undefined || genhwid == 'nil') ? hwid : genhwid,
          });
        }
      }
      const newHWID = new spooferSchema({
        // Se o serial não estiver na base de dados, cria um novo HWID
        genHWID: hwid,
        serial,
        ip,
        authID: auth,
      });
      await newHWID.save();
      return res.status(201).json({
        success: true,
        banned: false,
        hwid,
        suspected: checkIPBanned,
      });
    }

    const isExist = await isExistHWID(hwid); // Verifica se o HWID já existe na base de dados
    if (!isExist) {
      const isBanned = await isSerialBanned(serial);
      const isBannedLocal = await banEqualsServer(serial, auth);
      if (isBanned || isBannedLocal) {
        // Se o serial estiver banido retorna um JSON com a propriedade banned a true
        return res.status(200).json({
          success: true,
          banned: true,
          suspected: false,
          hwid: (genhwid === undefined || genhwid == 'nil') ? hwid : genhwid,
        });
      }
    }

    const isBanned = await isSerialBanned(serial);
    const isHWIDBanned = await isHWIDHaveBan(hwid);
    const isHWIDHaveMoreSerials = await isHWIDHaveMoreThanOneSerial(hwid);
    const isBannedLocal = await banEqualsServer(serial, auth);

    if (isBanned || isHWIDBanned || isHWIDHaveMoreSerials || isBannedLocal) {
      // Se o serial estiver banido ou o HWID estiver banido ou o HWID tiver mais de um serial retorna um JSON com as propriedades banned, hwidBanned e hwidHaveMoreSerials a true
      sendDiscordMessage(process.env.DISCORD_SPOOFER, `**[Spoofer]**\nSerial: ${serial}\nHWID: ${hwid}\nIP: ${ip}\nAuth: ${auth}`);
      return res.status(200).json({
        success: true,
        banned: true,
        suspected: false,
        hwid: (genhwid === undefined || genhwid == 'nil') ? hwid : genhwid,
      });
    } else {
      // Se o serial não estiver banido ou o HWID não estiver banido ou o HWID não tiver mais de um serial retorna um JSON com as propriedades banned, hwidBanned e hwidHaveMoreSerials a false
      return res.status(200).json({
        success: true,
        banned: false,
        suspected: checkIPBanned,
        hwid: (genhwid === undefined || genhwid == 'nil') ? hwid : genhwid,
      });
    }
  },
};

module.exports = spooferController;

const isSerialBanned = async (serial) => {
  // Verifica se o serial está banido
  const banned = await gbansSchema.findOne({ serial });
  return !!banned;
};

const isHWIDHaveBan = async (hwid) => {
  // Verifica se o HWID está banido
  const hhwid = await spooferSchema.findOne({ genHWID: hwid });

  if (!hhwid) return false;

  const banned = await gbansSchema.findOne({ serial: hwid.serial });
  return !!banned;
};

const isHWIDHaveMoreThanOneSerial = async (hwid) => {
  // Verifica se o HWID tem mais de um serial associado
  const hhwid = await spooferSchema.findOne({ genHWID: hwid });

  if (!hhwid) return false;

  const serials = await spooferSchema.find({ genHWID: hwid });

  return serials.length > 1 ? true : false;
};

const isExistHWID = async (hwid) => {
  // Verifica se o HWID existe na base de dados
  const hhwid = await spooferSchema.findOne({ genHWID: hwid });
  return !!hhwid;
};

const tryFindSerial = async (serial) => {
  // Verifica se o serial existe na base de dados
  const sserial = await spooferSchema.findOne({ serial });
  return !!sserial;
};

const tryFindHWID = async (serial) => {
  // Retorna o HWID associado ao serial
  const hwid = await spooferSchema.findOne({ serial });
  if (!hwid) return false;
  return hwid.genHWID;
};

const checkIP = async (ip) => {
  // Verifica se o IP existe na base de dados
  const hip = await spooferSchema.findOne({ ip });
  if (hip) {
    const banned = await gbansSchema.findOne({ serial: ip.serial });
    return banned ? true : false;
  } else return false;
};

const banEqualsServer = async (serial, auth) => {
  // Verifica se o serial foi banido por mesmo servidor
  // serial for igual ao serial na base de dados e auth for igual ao auth na base de dados
  const banned = await localbanSchema.findOne({ serial, auth });
  return !!banned;
};