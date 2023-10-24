local mapa = {}

function mapa.load(name)
    local file = io.open(name, "r") --"r" le & "w" escreve
    local data = file:read("*a") --carregar arquivo
    io.close(file) --fechar 
    return data --retornar a função map.load(name) o nome da var data
end

return mapa


--[[
--Linha 4 outro exemplo
local file = io.open(name, "r")
local data = {}

for line in file:lines() do --para cada linha do arquivo
    table.insert(data, line)
end

return data

--]]

--[[
    function map.replace(line) --substituir (replace) 
        return string.gsub(line, "=") --substituição de texto
]]