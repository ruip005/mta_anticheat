function countryCheck(ipv4)
    if not outros.country.on then
        return
    end
    local url = 'https://api.country.is/'
    local allowed = true
    fetchRemote(url..ipv4, function(response, info)
        if info == 200 or info == 0 then
            local data = fromJSON(response)
            if data then
                for i, v in ipairs(outros.country.flags) do
                    if v == data.country then
                        allowed = true
                        break
                    end
                end
                if not allowed then
                    return kickPlayer(source, servidor.sigla.." Anticheat", getSystemLanguage("countrynotallowed")) 
                end
            end
        end
end)
end