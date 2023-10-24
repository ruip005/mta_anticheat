--Dicionário, array representado c/ uma chave e um valor
--para cada chave é um valor para cada chave
--Uma chave só pode ter 1 valor ||

items = { --tabela items
machado = 100, --Tem essas 2 formas
["Espada"] = 450, -- e essa forma
escudo = 650,
Elmo = 150,
chave = 45 
}
print(items[machado]) --Pq nil (null)? Machado n tem "numero"
print(items.machado) --Posso usar essas 2 formas para saber o "Valor"
print(items["Elmo"]) --Posso usar essas 2 formas para saber o "Valor"

--Adicionar um novo 
items.armadura = 1000
print(items.armadura)

--Função pairs (PARES)
--Usar FOR para percorrer o valor da tabela ITEMS
for chave,valor in pairs(items) do
print(chave .. ": "..valor)
end

--Contagem num dicionario
contagem = 0
for chave, valor in pairs(items) do
    print(chave..": "..valor)
    contagem=contagem+1
end
print(contagem) --Contagem das entidades do dicionario

--
cores = {
    moeda="amarela",
    armadura= "prateada"
}
print("Qual cor da moeda?")
print(cores.moeda)

posicoes={
    arqueiro = {10,20},
    canhao = {120,40},
    pikacho = {x=200, y=10},
    pokemon = {
        posicao={x=2,y=30},
        forca = 110,
        nome = "Pigoto"
    }
}

print(posicoes["arqueiro"][1]) --Posicão 1 do arqueiro // 10 \\
print(posicoes["arqueiro"][2]) --Posicão 2 do arqueiro // 20 \\
print(posicoes.pikacho[x]) --nil
print(posicoes.pikacho["x"]) -- 200
print(posicoes.pikacho.y) --10
print(posicoes.pokemon.nome)

