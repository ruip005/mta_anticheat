const loginSchema = require('../models/login');

module.exports = verificarAuth = async () => {
    // Verificar todos os logins se o endSubcriptionDate é menor que a data atual desativar a conta
    const logins = await loginSchema.find();
    const date = new Date();
    logins.forEach(login => {
        if (login.endSubcriptionDate < date) {
            login.active = false;
            login.save();
        }
    });
}