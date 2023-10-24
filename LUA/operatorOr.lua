function contarPontos(nome)
    if(nome == "Tartaruga" or nome == "Planta")then
    return 100
else
    return 50
end
end
print(contarPontos("Tartaruga"))
print(contarPontos("Bloco"))
print(contarPontos("Planta"))

if true or false then
    print("true or false")
end

if false or false then
    print("false or false")
end