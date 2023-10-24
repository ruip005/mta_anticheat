indice =1
print("Acima do LOOP")
    while indice <= 10 do
    print(indice)
    indice = indice + 1
    end
print("Fora do LOOP")

    function verificarTiro()
        if io.read() == "F" then
            return true
        else
            return false
        end
    end
print("F para atirar:")
    while verificarTiro() do
        print("Atirar")
    end
 --while io.read() == "F" do