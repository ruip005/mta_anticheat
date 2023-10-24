--Function somar --> definição ou assinatura da função

    function somarUm()
        print(1+1) --Função print() é local á função somarUm()
    end

    somarUm() --Global ou seja ela é parte de todo o arquivo

    function somarDoisNumeros(um, dois) --um e dois sao parametros da função
        print(um + dois)
    end

    somarDoisNumeros(2,2)
