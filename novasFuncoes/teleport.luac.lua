setTimer(function()
  if not getElementData(localPlayer, "character:logged") then
    return false
  end
  if getElementData(localPlayer, "character:desmaiado") then
    return false
  end
  if getElementData(localPlayer, "staff:cargo") then
    return false
  end
  if getElementData(localPlayer, "character.mission") then
    _UPVALUE0_ = {}
    return false
  end
  if getElementData(localPlayer, "character:cutscene") then
    _UPVALUE0_ = {}
    return false
  end
  if getElementDimension(localPlayer) ~= 0 then
    _UPVALUE0_ = {}
    return false
  end
  if getElementInterior(localPlayer) ~= 0 then
    _UPVALUE0_ = {}
    return false
  end
  if getElementData(localPlayer, "character:inService") == "petro-engineer" then
    _UPVALUE0_ = {}
    return false
  end
  if exports.destiny_ui:GetActiveUI() == "police:camera" then
    _UPVALUE0_ = {}
    return false
  end
  if _UPVALUE0_.x and _UPVALUE0_.y and _UPVALUE0_.z and getDistanceBetweenPoints3D(getElementPosition(localPlayer)) >= 1000 then
    for _FORV_9_, _FORV_10_ in pairs((getElementsWithinRange(getElementPosition(localPlayer)))) do
      if getElementData(_FORV_10_, "staff:cargo") and not getElementData(_FORV_10_, "character:freecam") then
        break
      end
    end
    for _FORV_10_, _FORV_11_ in pairs({
      {
        1334.1507568359,
        -1384.3909912109,
        13.689167976379
      },
      {
        2306.4045410156,
        2393.7724609375,
        10.8203125
      },
      {
        -2713.9406738281,
        365.58856201172,
        4.4051003456116
      },
      {
        2027.161,
        -1421.293,
        17
      }
    }) do
      if 50 >= getDistanceBetweenPoints3D(getElementPosition(localPlayer)) then
        break
      end
    end
    if false then
      sendDiscord({
        webhook = "ANTICHEAT",
        title = "Suspeita de teleporte",
        details = "Foi de " .. getZoneName(_UPVALUE0_.x, _UPVALUE0_.y, _UPVALUE0_.z) .. " para " .. getZoneName(getElementPosition(localPlayer)) .. " (" .. getDistanceBetweenPoints3D(getElementPosition(localPlayer)) .. "m)",
        screenshot = true
      })
    end
  end
  _UPVALUE0_.x, _UPVALUE0_.y, _UPVALUE0_.z = getElementPosition(localPlayer)
end, 10000, 0)
addEventHandler("onClientPlayerWasted", root, function()
  if source == localPlayer then
    _UPVALUE0_ = {}
  end
end)
addEventHandler("onClientPlayerFaint", root, function()
  _UPVALUE0_ = {}
end)
addEventHandler("onLoginSelectCharacter", root, function()
  _UPVALUE0_ = {}
end)
