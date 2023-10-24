--Apenas teste

local calculadora = { --Local é tipo de variavel que só existe para aquela função por isso que se chama LOCAL
    somar = function(x,y)
        return x+y
    end
} 
--[[local inimigo = {
    x=0,
    y=0
}
--]]
function calculadora.multiplicar(x,y)
    return x * y
end

return calculadora --arquivo package.lua
--Pacote é um arquivo lua (IMPORTAR) outro pacote

--require("module")
