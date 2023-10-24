local fantasma = {} -- Criar classe do fantasma

function fantasma.new(nome)
    local instance = {
        nome = nome,

    }

    local  executarCallbacks = function(evento)
        for _, v pairs(instancia.ouvintes[evento]) do 
            for _, callback in pairs(v) do
            callback()
            end
        end
    end

    -- Adicionar ouvinte

    -- Remover ouvinte

    -- Ações do fantasma
    return instancia
end

return ghosts