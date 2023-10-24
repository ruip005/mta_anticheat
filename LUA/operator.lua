--[[
    tudo que o if espera é apenas verdadeiro ou falso
    true / false

    se true => executa o codigo dentro do bloco
    se false => cai para o proximo bloco
]]
if true ~= false then  --true é igual a false? => NAO isso é falso
    print("Verdade") --true nao é igual a false => SIM true
else
    print("Falso")
end

if true == false then  --true é igual a false? => NAO isso é falso
    print("Verdade") --true nao é igual a false => SIM true
else
    print("Falso")
end

if ((true ~= false) == false) then  --true é igual a false? => NAO isso é falso
    print("Verdade") --true nao é igual a false => SIM true
else
    print("Falso")
end

if(10 ~= false) then 
    print("verdadeiro") 
else
     print("Falso") 
    end

    if 10==10 and true ~= false then
        print("Operação verdadeira")
    end