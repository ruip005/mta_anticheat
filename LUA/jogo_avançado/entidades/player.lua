local player = {}

function player.novo(nome)
	local instancia = {
		vida = 200,
		pocoes = {},
		nome = nome
	}

	function instancia:obter_pocao(pocao)
		table.insert(self.pocoes, pocao)
	end

	function instancia:atacado(forca)
		if self:vivo() then
			self.vida = self.vida - forca

			if not self:vivo() then
				print("Ap�s o ataque, " .. self.nome .. " morreu!")
			else
				print("Ap�s o ataque, " .. self.nome .. " agora tem " .. self.vida .. " de vida!")
			end
		else
			print(self.nome .. " j� est� morto!")
		end
	end

	function instancia:matar()
		if self:vivo() then
			self.vida = 0
			print(self.nome .. " morreu!")
		else
			print(self.nome .. " j� est� morto!")
		end
	end

	function instancia:vivo()
		return self.vida > 0
	end

	function instancia:usar_pocao()
		if #self.pocoes > 0 then
			self.vida = self.vida + self.pocoes[1].vida
			table.remove(self.pocoes, 1)
			print(self.nome .. " usou uma po��o e agora tem " .. self.vida .. " de vida!")
		else
			print(self.nome .. " n�o tem po��es!")
		end
	end

	return instancia
end

return player


