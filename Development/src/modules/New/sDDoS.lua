function processPlayerTriggerEventThreshold()
    kickPlayer(source, "Event spam")
end
addEventHandler("onPlayerTriggerEventThreshold", root, processPlayerTriggerEventThreshold)

-- max_player_triggered_events_per_interval
