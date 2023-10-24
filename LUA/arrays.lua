--Arrays: cadeia de dados ou uma matriz

inimigos= { --tabela
    10,13,10,2,45,50,50,50,16,27
}
--Arrays sao criados com {}
--E numerados ou indexados c/ []
print(inimigos[4])
print(inimigos[10])

print("Quantos elementos existem?")
print(#inimigos) -- O # ve quantos "ints" existem na variavel inimigos

qtdInimigos = #inimigos
print("Inimigo 3:"..inimigos[3])
inimigos[3]= 99  --Modificar vida do inimigo 3
print("Inimigo 3:"..inimigos[3])
--adicionar inimigos
inimigos[qtdInimigos +1] = 33 --33 é a "vida" do inimigo
print("Novo inimigo: "..inimigos[11])

for idx=1,11,1 do --variavel idx vai até ao ultimo valor para ver vida de todos pela repetição FOR
    print("Inimigo "..idx.." tem vida: "..inimigos[idx])
end

