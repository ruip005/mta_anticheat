local conta = {}

function conta.novo(deposito_inicial)
    local instancia = { --Vincular função á instancia linha 8
        saldo = deposito_inicial
    }
    --[[
        -- O que posso fazer tbm
        function conta.novo(deposito_inicial)
            return {
                saldo = deposito_inicial
                depositar = function(self, valor)
                    self.saldo = self.saldo + valor
                end
            }
        end
        return conta
    --]]
    -- Self  = SI mesma, ao "eu"
    function instancia.depositar(self, valor)
        self.saldo = self.saldo + valor
    end
    return instancia
end

return account