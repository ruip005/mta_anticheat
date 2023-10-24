-- ================================================
-- RAZÕES PELAS QUAIS TABELAS SÃO OBJETOS
-- ================================================

-- Tem estado
zumbi = {vida = 10, x = 20, y = 30} --Zumbi tornou-se uma tabela & vida,x,y são variaveis
--      |         Atributos       | --em cima

-- Tem identidade, independente dos valores
print(zumbi)
zumbi.vida = 50
print(zumbi)

-- 2 tabelas com os mesmos valores sao objetos diferentes
zumbi_novo = {vida = 60, x= 20, y= 30}
assert(zumbi ~= zumbi_novo) --assert comando testar sessoes ( 1 = 1 ) se ñ passar um erro tem que retornar
-- Operação se for falsa retorna erro senão faz td bonitinho
print(zumbi_novo)

-- Uma tabela pode ter valores diferentes em momentos diferentes
-- mas é sempre o mesmo objetos

zumbi.vida = 30
print(zumbi)

-- Tabelas tem um ciclo de vida independente de onde foram criadas onde (local etc)
function novo_zumbi(vida)
    return {vida=vida}
end

zumbix = novo_zumbi(100)
print(zumbix)

function altera_zumbi(zumbi)
    zumbi.vida = zumbi.vida +1
    print("Dentro: ")
    print(zumbi)
end

altera_zumbi(zumbix)
print(zumbix.vida)
print(zumbix)

-- Podem carregar em procedimentos
function zumbi.quem_sou_eu(zumbi)
    print(zumbi)
end

zumbi.quem_sou_eu(zumbi)

-- ... então esse procedimento ñ é um metodo

-- Transformar em objetos "reais"

-- Simulando OOP (Operações a Objetos )