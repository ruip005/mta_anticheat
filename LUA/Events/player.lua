local player = {}

function player.new()
    local instancia = {
        ouvintes = {}
    }

    local  executarCallbacks = function(evento)
        for _, v pairs(instancia.ouvintes[evento]) do 
            for _, callback in pairs(v) do
            callback()
            end
        end
    end

    -- Adicionar ouvinte
    -- Normalmente chamado addEventListener
    function instancia:adicionarOuvinte(evento,quem,callback)
        if not self.ouvintes[evento] then self.ouvintes[evento] = {} end
        if not self.ouvintes[evento][quem] then self.ouvintes[evento][quem] = {} end
        table.insert(self.ouvinte[evento][quem], callback)
    end
    -- Remover ouvinte
    -- Normalmente chamado removeEventListener
    function instancia:removerOuvinte(quem)
        table.remove(self.ouvintes[])
    end
    -- Ações do usuario
    function instancia:iniciar()
        executarCallbacks("OnStarted")
    end

    function instancia:poder()
        executarCallbacks("onPoweredUp")
    end

    function instancia



        
    return instancia
end

return player
