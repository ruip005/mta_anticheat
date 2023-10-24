local inimigo = require("entidades/inimigo")
local player = require("entidades/player")
local zumbi = {}

function zumbi.novo()
	local instancia = inimigo.novo(50, "zumbis")
	instancia.come_cerebros = true
	instancia.explode = false

	function instancia:atacar(player_instancia)
		if self == nil then
			print("Esse zumbi já está morto!")
		elseif self.explode then
			print("Zumbi explodiu!")
			player_instancia:matar()
			return nil
		else
			print("Zumbi atacou " .. player_instancia.nome .. "!")
			player_instancia:atacado(self.forca)
			return instancia
		end
	end

	return instancia
end

function zumbi.novo_bomber()
	local zumbi = zumbi.novo()
	zumbi.come_cerebros = false
	zumbi.explode = true
	return zumbi
end

return zumbi
