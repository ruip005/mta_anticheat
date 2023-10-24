pausado = true

function contarPontos(nome)
    if nome ~= "Tartaruga" and not pausado then
        return 100
    else
        return 200
    end
end

print(contarPontos("Tartaruga"))
print(contarPontos("Tartarugaverde"))