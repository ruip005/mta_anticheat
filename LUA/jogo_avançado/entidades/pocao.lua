local item = require("entidades/item")
local pocao = {}

function pocao.novo()
	local pocao = item.novo("pocao", "vida", 50)
	pocao.vida = 50
	return pocao
end

return pocao
