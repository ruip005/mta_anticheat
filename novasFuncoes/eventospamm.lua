-- server-side
setServerConfigSetting("player_triggered_event_interval", "1000", true) -- 1000ms == 1 segundo
setServerConfigSetting("max_player_triggered_events_per_interval", "50", true)
-- resumindo acima, se o player em menos de 1 segundo enviar mais de 50 triggerServerEvent (sejam eles existentes ou não)
-- a função abaixo vai disparar fazendo com que ele seja expulso do servidor (tambêm pode colocar pra banir)

addEventHandler("onPlayerTriggerEventThreshold", root, function()
    local id = getElementData(source, "ELEMENT_DATA_DO_ID_AQUI") or getPlayerSerial(source)
    print(getPlayerName(source), id, "está fazendo trigger rápido demais!") -- pode ser trocado por um sistema de log
    kickPlayer(source, "Event spam") -- requer resource.nomeScript na acl admin pra kikar ou banir
end)

-- Lembrando que essa é uma das formas que os hackers atacam, tambêm existe a forma de criar novos elementData para lagar o servidor e emfim cair;
