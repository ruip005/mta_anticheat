if not false then --se o valor for falso, a condição é verdadeiro
    print("Not false")
end

if not true then
    print("Nt true")
end

--[[
function contarPontos(nome)
    if nome == "Tartaruga" and not nome == "Tartarugaverde" then
        return 100
    else
        return 200
    end
end
--]]
function contarPontos(nome)
    if nome == "Tartaruga" or not nome == "Tartarugaverde" then
        return 100
    else
        return 200
    end
end

print(contarPontos("Tartaruga"))
print(contarPontos("Tartarugaverde"))