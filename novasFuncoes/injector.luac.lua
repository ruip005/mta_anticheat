addDebugHook("preFunction", function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, ...)
  if getElementData(localPlayer, "staff:cargo") then
    return
  end
  for _FORV_12_, _FORV_13_ in pairs({
    ...
  }) do
  end
  if #("" .. tostring(_FORV_13_) .. "\n") > 2000 then
  end
  exports.destiny_discord:send("ANTICHEAT", {
    content = ("### %s#%s foi banido por tentar injetar código lua.\n\n> **Resource:** %s\n> **File:** %s (line %s)\n\n**Code:** ```lua\n%s```\n@everyone"):format(getPlayerName(localPlayer):gsub("_", " "), getElementData("character:id") or getPlayerSerial(), _ARG_0_ and getResourceName(_ARG_0_), _ARG_3_, _ARG_4_, ("" .. tostring(_FORV_13_) .. "\n"):sub(1, 2000) .. "..."),
    username = "Destiny AC"
  })
  triggerServerEvent("destiny_anticheat:onPlayerBan", localPlayer, "AC-07")
end, {"loadstring"})
addDebugHook("preFunction", function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, ...)
  if getElementData(localPlayer, "staff:cargo") then
    return
  end
  for _FORV_11_, _FORV_12_ in pairs(({
    ...
  })[3]) do
    if _UPVALUE0_[_FORV_12_] then
      exports.destiny_discord:send("ANTICHEAT", {
        content = ("### %s#%s foi banido por tentar injetar código lua.\n\n> **Resource:** %s\n> **File:** %s (line %s)\n\n**DebugHook Function:** ```lua\n%s```\n@everyone"):format(getPlayerName(localPlayer):gsub("_", " "), getElementData("character:id") or getPlayerSerial(), _ARG_0_ and getResourceName(_ARG_0_), _ARG_3_, _ARG_4_, _FORV_12_),
        username = "Destiny AC"
      })
      triggerServerEvent("destiny_anticheat:onPlayerBan", localPlayer, "AC-07")
      break
    end
  end
end, {
  "addDebugHook"
})
addEventHandler("onClientPaste", root, function(_ARG_0_)
  if getElementData(localPlayer, "staff:cargo") then
    return false
  end
  for _FORV_5_ = 1, #_UPVALUE0_ do
    if _ARG_0_:gsub("\n", " "):gsub("\r", " "):find(_UPVALUE0_[_FORV_5_]) then
      exports.destiny_discord:send("ANTICHEAT", {
        content = ("### %s#%s suspeita de colar código lua.\n\n**Code:** ```lua\n%s```"):format(getPlayerName(localPlayer):gsub("_", " "), getElementData("character:id") or getPlayerSerial(), _ARG_0_),
        username = "Destiny AC"
      })
      return false
    end
  end
end)
addEventHandler("onClientGUIChanged", root, function()
  if getElementData(localPlayer, "staff:cargo") then
    return false
  end
  for _FORV_5_ = 1, #_UPVALUE0_ do
    if guiGetText(source):gsub("\n", " "):gsub("\r", " "):find(_UPVALUE0_[_FORV_5_]) then
      exports.destiny_discord:send("ANTICHEAT", {
        content = ("### %s#%s suspeita de injetar código.\n\n**Code:** ```lua\n%s```"):format(getPlayerName(localPlayer):gsub("_", " "), getElementData("character:id") or getPlayerSerial(), (guiGetText(source))),
        username = "Destiny AC"
      })
      return false
    end
  end
end)
setTimer(function()
  if not _G.isAsyncActive or not _G.getDiscordAppId then
    sendDiscord({
      webhook = "ANTICHEAT",
      title = "Injetor de código lua carregado",
      content = "@everyone",
      action = "ban"
    })
    setTimer(function()
      triggerServerEvent("destiny_anticheat:onPlayerBan", localPlayer, "AC-15")
    end, 10000, 1)
  end
end, 5000, 1)
