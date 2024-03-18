const uuid = require('uuid');
const apiSchema = require('../models/api');
module.exports = criarApi = async (serverId) => {
    const key = gerarKey();
    const api = new apiSchema({ serverId, key });
    await api.save();
};

function gerarKey() {
    return uuid.v4().replace(/-/g, "");
}