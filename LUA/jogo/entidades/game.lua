local player = require("entidades/player")
local pocao = require("entidades/pocao")
local zumbi = require("entidades/zumbi")
-- Criação, essas vars são objetos
local player1 = player.novo("uW33D")
local player2 = player.novo("Unknown")

local zumbi1 = zumbi.novo()
local zumbi2 = zumbi.novo()
local zumbi3 = zumbi.novo_bomber()
-- adicionar inventário
table.insert(player1.pocoes,pocoes.novo())
table.insert(player2.pocoes,pocoes.novo())
-- Verificações
assert(#player1.pocoes == 1)
assert(#player2.pocoes == 1)

-- Zumbi atacam os players
zumbi.atacar(zumbi1, player1)