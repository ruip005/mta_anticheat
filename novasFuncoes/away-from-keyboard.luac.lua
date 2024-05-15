AFK_WARNING_TIME = AFK_WARNING_TIME * 1000 * 60
AFK_KICK_TIME_AFTER_WARN = AFK_KICK_TIME_AFTER_WARN * 1000 * 60
function resetAfk()
  _UPVALUE0_ = getTickCount()
  if _UPVALUE1_ then
    _UPVALUE1_ = false
    setElementData(localPlayer, "character:afk", _UPVALUE1_)
  end
end
function checkClientAfk()
  if not getElementData(localPlayer, "character:logged") then
    return false
  end
  if getElementData(localPlayer, "staff:cargo") or getElementData(localPlayer, "character:prisao") then
    return false
  end
  if getElementData(localPlayer, "character:desmaiado") then
    return false
  end
  if getElementData(localPlayer, "cinema:section") then
    return false
  end
  if _UPVALUE0_ and AFK_WARNING_TIME < getTickCount() - _UPVALUE0_ then
    if _UPVALUE1_ == false then
      _UPVALUE1_ = true
      setElementData(localPlayer, "character:afk", _UPVALUE1_)
    end
    ;({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).x = math.floor((_UPVALUE2_ - ({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).width) / 2)
    ;({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).y = math.floor((_UPVALUE3_ - ({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).height) / 2)
    dxDrawRectangle(0, 0, _UPVALUE2_, _UPVALUE3_, tocolor(0, 0, 0, 220))
    dxDrawImage(({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).x, ({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).y, ({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).width, ({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).height, "assets/images/afk.png")
    ;({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).x = ({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).x + 33
    ;({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).y = ({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).y + 75
    dxDrawText("Estamos calculando aqui e parece que voc\195\170 está ausente.\nRetorne em #5c6ba3" .. SecondsToTimeDesc(math.max(0, (math.floor((AFK_WARNING_TIME + AFK_KICK_TIME_AFTER_WARN + 1000 - (getTickCount() - _UPVALUE0_)) / 1000)))) .. " #ffffffpara n\195\163o sair\nautomaticamente.", ({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).x, ({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).y, ({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).x + ({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).width, ({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).y + ({
      x = 0,
      y = 0,
      width = 512,
      height = 208
    }).height, tocolor(255, 255, 255, 240), 1, _UPVALUE4_, "left", "top", _, true, _, true)
    if AFK_WARNING_TIME + AFK_KICK_TIME_AFTER_WARN + 1000 < getTickCount() - _UPVALUE0_ then
      triggerServerEvent("anti-cheat:onPlayerKick", localPlayer, "Ficou tempo demais em Nárnia.")
      resetAfk()
    end
  end
end
resetAfk()
addEventHandler("onClientRender", root, checkClientAfk)
addEventHandler("onClientMinimize", root, resetAfk)
addEventHandler("onClientRestore", root, resetAfk)
addEventHandler("onClientKey", root, resetAfk)
addEventHandler("onClientCursorMove", root, resetAfk)
