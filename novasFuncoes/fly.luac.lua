timer = 

addEventHandler("onClientKey", root, function(_ARG_0_, _ARG_1_)
  if getElementData(localPlayer, "character:policeChief") or getElementData(localPlayer, "staff:cargo") or getElementData(localPlayer, "character:inService") or getElementDimension(localPlayer) ~= 0 then
    return false
  end
  if _ARG_0_ == "end" and getPedOccupiedVehicle(localPlayer) and getPedOccupiedVehicleSeat(localPlayer) == 0 then
    if timer and isTimer(timer) then
      killTimer(timer)
    end
    timer = setTimer(function()
      if getElementPosition(localPlayer) - getGroundPosition(getElementPosition(localPlayer)) > 4 then
        sendDiscord({
          webhook = "ANTICHEAT",
          title = "Suspeita de pular com ve�culo",
          screenshot = true
        })
      end
    end, 1000, 1)
  end
  if (_ARG_0_ == "pgup" or _ARG_0_ == "pgdn") and _ARG_1_ and not getPedOccupiedVehicle(localPlayer) and getGroundPosition(getElementPosition(localPlayer)) and getElementPosition(localPlayer) - getGroundPosition(getElementPosition(localPlayer)) > 4 then
    if getTickCount() < key_tick then
      return false
    end
    key_tick = getTickCount() + 5000
    warns = warns + 1
    if warns == 3 then
      warns = 0
      exports.destiny_discord:send("STAFF_CHAT", {
        content = "",
        username = "Destiny AC",
        embeds = {
          {
            title = ("%s#%s"):format(getPlayerName(localPlayer):gsub("_", " "), getElementData("character:id") or getPlayerSerial()),
            description = ("Suspeito de utilizar cheat para voar."):format((getPlayerName(localPlayer):gsub("_", " "))),
            color = 27295
          }
        }
      })
    end
    sendDiscord({
      webhook = "ANTICHEAT",
      title = "Suspeita de voar",
      details = "Bot\195\163o pressionado: **" .. _ARG_0_ .. "**.",
      screenshot = true
    })
  end
end)
