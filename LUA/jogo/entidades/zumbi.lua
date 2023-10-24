local inimigo = require("entidades/inimigo")
local zumbi = {}

function zumbi.novo()
    local zumbi = inimigo.novo(50, "zumbis")
    zumbi.come_cerebros = true
    zumbi.explode = false
    return zumbi
end

function zumbi.novo_bomber()
    local zumbi = zumbi.novo()
    zumbi.come_cerebros = false
    zumbi.explode = true
    return zumbi
end

function zumbi.atacar(zumbi, player_instancia)
    print("Zumbi atacou "..player_instancia.nome.."!")
    player_instancia.vida = player_instancia.vida - zumbi.forca

    if player_instancia.vida <= 0 then
        print(player_instancia.nome.." Morreu!")
    end

return zumbi
