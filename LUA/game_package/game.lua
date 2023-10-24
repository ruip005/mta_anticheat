local mapa = require("mapa")

print(mapa.load("level1.txt"))
print(mapa.load("level2.txt"))

--se n funcionar pq é do Visual Studio


--[[
--Outro exemplo
for k, v in pairs(map.load("level1.txt"))do
    print v
end

--

for k, v in pairs(map.load("level1.txt"))do
    print("Line:".. map.replace(v))
end

--]]