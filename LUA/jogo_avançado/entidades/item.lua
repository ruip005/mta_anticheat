local item = {}

function item.novo(tipo, funcao, custo)
	return {
		tipo = tipo,
		funcao = funcao,
		custo = custo
	}
end

return item
