local conta = require("conta")

local banco_brasil = conta.novo(500) --Ficheiro conta vai ter 500 $ setados
assert(banco_brasil.saldo == 500) -- verificação

--conta.depositar(banco_brasil, 500) -- Vai adicionar saldo de +500$
--assert(banco_brasil.saldo == 1000) --verificação

banco_brasil:depositar(500) --deposita 500 | função(conta) na função(instancia)
assert(banco_brasil.saldo == 1000) --verificação
-- Para que server ":" dois pontos?
-- Transforma (conta.lua)function instancia em self