function verificarAtirar()
    tecla = io.read()
--[[
    tecla = io.read()
    return tecla == "F"
]]
    if tecla == "f" then
        return true
    else
        return false
    end
end

municao=1

function verificarMunicao()
    if municao >= 1 then 
    return true
    else
        return false
    end
end

if verificarAtirar() and verificarMunicao() then
    print("BOOM")
    municao = municao-1
end

print("Munição na arma: " .. municao)
