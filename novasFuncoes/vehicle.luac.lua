function checkVehicleHealth()
  if getElementData(localPlayer, "staff:cargo") then
    return false
  end
  if isElement((getPedOccupiedVehicle(localPlayer))) then
    if math.floor(getElementHealth((getPedOccupiedVehicle(localPlayer)))) > 250 and math.floor(getElementHealth((getPedOccupiedVehicle(localPlayer)))) - 1 > math.floor(_UPVALUE0_.repaired.old_health) and math.floor(getElementHealth((getPedOccupiedVehicle(localPlayer)))) ~= 800 then
      for _FORV_9_, _FORV_10_ in pairs(_UPVALUE1_) do
        if getDistanceBetweenPoints3D(getElementPosition((getPedOccupiedVehicle(localPlayer)))) < _UPVALUE2_ then
          break
        end
      end
      if false then
        sendDiscord({
          webhook = "ANTICHEAT",
          title = "Suspeita de reparo de veículo",
          details = ("De **%s** para **%s**"):format(_UPVALUE0_.repaired.old_health, (math.floor(getElementHealth((getPedOccupiedVehicle(localPlayer)))))),
          screenshot = true
        })
      end
    end
    _UPVALUE0_.repaired.old_health = math.floor(getElementHealth((getPedOccupiedVehicle(localPlayer))))
  else
    if _UPVALUE0_.repaired.timer then
      killTimer(_UPVALUE0_.repaired.timer)
    end
    _UPVALUE0_.repaired = {}
  end
end
addEventHandler("onClientElementModelChange", root, function(_ARG_0_, _ARG_1_)
  if getElementType(source) == "vehicle" then
    if isElementLocal(source) then
      return false
    end
    triggerServerEvent("destiny_anticheat:onModelChange", localPlayer, source, _ARG_1_)
  end
end)
addEventHandler("onClientVehicleStartEnter", root, function(_ARG_0_)
  if _ARG_0_ == localPlayer then
    if isVehicleLocked(source) then
      exports.destiny_notifications:CreateNotification("Este veículo está trancado.", "error")
      cancelEvent()
    end
  elseif isVehicleLocked(source) then
    if _UPVALUE0_.locked[_ARG_0_] then
      killTimer(_UPVALUE0_.locked[_ARG_0_])
    end
    _UPVALUE0_.locked[_ARG_0_] = setTimer(function(_ARG_0_, _ARG_1_)
      if isElement(_ARG_0_) and isElement(_ARG_1_) and getPedOccupiedVehicle(_ARG_0_) == _ARG_1_ and getPedOccupiedVehicleSeat(_ARG_0_) == 0 then
        triggerServerEvent("destiny_anticheat:vehicle-islocked", localPlayer, _ARG_0_)
      end
      _UPVALUE0_.locked[_ARG_0_] = nil
    end, 5000, 1, _ARG_0_, source)
  end
end)
addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(_ARG_0_, _ARG_1_)
  _UPVALUE0_.repaired.old_health = getElementHealth(_ARG_0_)
  _UPVALUE0_.repaired.timer = setTimer(checkVehicleHealth, 1000, 0)
  _UPVALUE0_.colshape = createColSphere(0, 0, 0, 0.05)
  attachElements(_UPVALUE0_.colshape, _ARG_0_, 0, 0, 0)
end)
addEventHandler("onClientPlayerVehicleExit", localPlayer, function(_ARG_0_, _ARG_1_)
  if _UPVALUE0_.colshape then
    destroyElement(_UPVALUE0_.colshape)
  end
end)
addEventHandler("onClientElementDestroy", root, function()
  if source == getPedOccupiedVehicle(localPlayer) and _UPVALUE0_.colshape then
    destroyElement(_UPVALUE0_.colshape)
  end
end)
addEventHandler("onClientResourceStart", root, function()
  if getPedOccupiedVehicle(localPlayer) and getPedOccupiedVehicleSeat(localPlayer) == 0 then
    _UPVALUE0_.repaired.old_health = getElementHealth((getPedOccupiedVehicle(localPlayer)))
    _UPVALUE0_.repaired.timer = setTimer(checkVehicleHealth, 1000, 0)
  end
  if getPedOccupiedVehicle(localPlayer) then
    _UPVALUE0_.colshape = createColSphere(0, 0, 0, 0.05)
    attachElements(_UPVALUE0_.colshape, getPedOccupiedVehicle(localPlayer), 0, 0, 0)
  end
  bindKey("x", "down", function()
    setElementData(localPlayer, "player.cfkey", getRealTime().timestamp)
  end)
end)
addEventHandler("onClientColShapeHit", resourceRoot, function(_ARG_0_)
  if source ~= _UPVALUE0_.colshape then
    return
  end
  if getElementType(_ARG_0_) ~= "vehicle" then
    return
  end
  if not getPedOccupiedVehicle(localPlayer) then
    return
  end
  if _ARG_0_ == getPedOccupiedVehicle(localPlayer) then
    return
  end
  if getElementData(getPedOccupiedVehicle(localPlayer), "vehicle:inRace") or getElementData(_ARG_0_, "vehicle:inRace") then
    return
  end
  if _UPVALUE0_.car_fuck_timer then
    return
  end
  if not getVehicleOccupant(_ARG_0_, 0) then
    return
  end
  if not getElementData(getVehicleOccupant(_ARG_0_, 0), "player.cfkey") then
    return
  end
  if getRealTime().timestamp - getElementData(getVehicleOccupant(_ARG_0_, 0), "player.cfkey") > 5 then
    return
  end
  setElementPosition(_ARG_0_, getElementPosition(_ARG_0_))
  sendDiscord({
    webhook = "ANTICHEAT",
    title = "Vitima de car fuck (VBR)",
    details = ("**%s#%s** é suspeito de tentar car fuck."):format(getPlayerName((getVehicleOccupant(_ARG_0_, 0))):gsub("_", " "), getElementData(getVehicleOccupant(_ARG_0_, 0), "character:id") or getElementData(getVehicleOccupant(_ARG_0_, 0), "account:id") .. " (id da conta)"),
    content = "@everyone",
    screenshot = true
  })
  _UPVALUE0_.car_fuck_timer = setTimer(function()
    _UPVALUE0_.car_fuck_timer = nil
  end, 5000, 1)
end)
addEventHandler("onClientPlayerWasted", root, function()
  if source == localPlayer and _UPVALUE0_.repaired.timer then
    killTimer(_UPVALUE0_.repaired.timer)
    _UPVALUE0_.repaired = {}
  end
end)
addEventHandler("onClientPlayerFaint", root, function()
  if _UPVALUE0_.repaired.timer then
    killTimer(_UPVALUE0_.repaired.timer)
    _UPVALUE0_.repaired = {}
  end
end)
