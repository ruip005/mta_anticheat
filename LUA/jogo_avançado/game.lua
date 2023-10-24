local player = require("entidades/player")
local pocao = require("entidades/pocao")
local zumbi = require("entidades/zumbi")

-- Cria��o de Inst�ncias das Classes Criadas
-- Essas vari�veis s�o objetos!
local player1 = player.novo("Orientad�o")
local player2 = player.novo("Objetoncio")

local zumbi1 = zumbi.novo()
local zumbi2 = zumbi.novo()
local zumbi3 = zumbi.novo_bomber()

-- Adicionar invent�rio
player1:obter_pocao(pocao.novo())
player2:obter_pocao(pocao.novo())
assert(#player1.pocoes == 1)
assert(#player2.pocoes == 1)

-- Zumbis atacam os players!
zumbi1:atacar(player1)
zumbi1:atacar(player1)
player1:usar_pocao()
zumbi1:atacar(player1)
zumbi1:atacar(player1)
player1:usar_pocao()
zumbi1:atacar(player1)

zumbi3:atacar(player2)

