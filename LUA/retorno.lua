function pular(intensidade)
    print("Vou pular com a intensidade: " .. tostring(intensidade))
end

function calcularFisica(forca)
    return forca * 0.5 + 32.9 / 4
end

function calcularFormula(senha)
    print("Calcularei a senha do pulo...")
        return senha + 1
end

pular(calcularFisica(13.5)+calcularFormula(443))

fisica = calcularFisica(1)
formula = calcularFormula(1)
intensidade = fisica + formula
pular(intensidade)