local player = {}  --player pacote

function player.novo(nome)  --Criar novo player
    return {
        vida = 200
        pocoes = {}
        nome = nome
    }
end

function player.atacado(instancia, forca)
    if instancia.vida > 0 then
        instancia.vida = instancia.vida - forca
        if instancia.vida <= 0 then
            print("Após o ataque, "..player_instancia.." agora tem "..player_instancia.vida)
        end
    end
end
return player