-- Os eventos sao ações que ocorreram

-- Como nomear eventos?

-- on[AcaoQueOcorreu]
-- onPlayerPoweredUp --Quando o player ficou poderoso



-- Como adicionar e ouvir eventos?

-- addEventListener(eventName, listener)

-- Alguém emite um evento

-- Nesse caso, o jogador emte o evento onPoweredUp, e partir disso, ele vai emitir o "som", e todos os "ouvintes", vão reagir.

-- Exemplo c/ pacman: 
--[[
if usuario.colidir == "pizza" then
    for fantasmas do
        fantasmas.sairCorrendo()
    end
end
--pode isso? R: sim, mas vem o conceito de o Objeto ñ conhece o outro por isso q necessita de eventos
-- O player n precisa conhecer os fantasmas e os fantasmas n precisaam conhecer o player]]


]]