function checkJetpack()
  if isPedWearingJetpack(localPlayer) then
    sendDiscord({
      webhook = "ANTICHEAT",
      title = "Jetpack detectado",
      action = "ban"
    })
    triggerServerEvent("destiny_anticheat:onPlayerBan", localPlayer, "AC-01")
  end
end
