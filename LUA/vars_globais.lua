-- variavel global nome
nome = "rui"
print(nome)
-- variavel local
function qualnome(nome)
    print(nome)
    --Aqui, a variavel loca nome é destruida/apagada do RUN
end

qualnome("Rui")
print(nome)