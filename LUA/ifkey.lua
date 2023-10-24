function verificarAtirar1()
    tecla = io.read()

    if tecla == "F" or tecla == "E" then
        return true
    else
        return false
    end
end

    if verificarAtirar1()then
        print("Atirar")
    end