function checkClientBinds()
  for _FORV_3_, _FORV_4_ in ipairs(KEYBOARD_TABLE) do
    for _FORV_9_ in pairs((getCommandsBoundToKey(_FORV_4_, "down"))) do
      if string.len(_FORV_9_) >= 25 then
        triggerServerEvent("anti-cheat:onPlayerKick", localPlayer, "N\195\163o foi possível conectar-se ao servidor. Código de erro: DCMBK-001")
        break
      end
      if string.find(_FORV_9_, "[^a-zA-Z0-9_]") and not string.find(_FORV_9_, " ") then
        triggerServerEvent("anti-cheat:onPlayerKick", localPlayer, "N\195\163o foi possível conectar-se ao servidor. Código de erro: DCMBK-002")
        break
      end
    end
  end
end
function checkServerKeys()
  for _FORV_4_ in pairs(BLOCKED_SERVER_KEYS) do
    if table.length((getCommandsBoundToKey(_FORV_4_, "down"))) > 0 then
      break
    end
  end
  if true then
    if not _UPVALUE0_ then
      _UPVALUE0_ = getTickCount()
      exports.destiny_notifications:CreateNotification("Foi detectado uma bind em uma tecla padr\195\163o do Destiny. Remova ou voc\195\170 será expulso em 1 minuto.", "error")
    end
    if getTickCount() - _UPVALUE0_ > 60000 then
      setElementData(localPlayer, "player:bind", true)
      triggerServerEvent("anti-cheat:onPlayerKick", localPlayer, "Voc\195\170 foi expulso por ter uma bind em uma tecla padr\195\163o do Destiny.")
    end
  elseif _UPVALUE0_ then
    _UPVALUE0_ = nil
  end
end
addEventHandler("onClientKey", root, function(_ARG_0_, _ARG_1_)
  if _ARG_1_ then
    if _ARG_0_ == "mouse_wheel_up" or _ARG_0_ == "mouse_wheel_down" then
      return
    end
    if _UPVALUE0_.count >= 30 then
      if _UPVALUE0_.tick > getTickCount() and not _UPVALUE0_.warned then
        sendDiscord({
          webhook = "ANTICHEAT",
          title = "Flood de teclas/macro",
          details = ("%s cliques em teclas em %sms"):format(_UPVALUE0_.count, _UPVALUE0_.tick - getTickCount()),
          action = "kick",
          screenshot = true
        })
        setElementData(localPlayer, "player:macro", true)
        _UPVALUE0_.warned = true
        setTimer(function()
          triggerServerEvent("anti-cheat:onPlayerKick", localPlayer, "Voc\195\170 foi expulso por flood de teclas/cliques.")
        end, 5000, 1)
      end
      _UPVALUE0_.count = 0
      _UPVALUE0_.tick = getTickCount() + 500
    else
      _UPVALUE0_.count = _UPVALUE0_.count + 1
    end
  end
end)
addEventHandler("onClientKey", root, function(_ARG_0_, _ARG_1_)
  if _ARG_1_ then
    if not isVoiceEnabled() then
      if _ARG_0_ == "insert" then
        sendDiscord({
          webhook = "AC_EVENT",
          title = "Apertou insert",
          screenshot = true
        })
      end
      return
    end
    if _ARG_0_ == "insert" and not _UPVALUE0_.enabled then
      _UPVALUE0_.enabled = true
      _UPVALUE0_.timestamp = getRealTime().timestamp
    end
    if _UPVALUE0_.enabled and _UPVALUE0_.list[_ARG_0_] then
      if #_UPVALUE0_.text == 0 then
        _UPVALUE0_.text = _ARG_0_
      else
        _UPVALUE0_.text = _UPVALUE0_.text .. " > " .. _ARG_0_ .. " (" .. getRealTime().timestamp - _UPVALUE0_.timestamp .. "s)"
      end
      table.insert(_UPVALUE0_.keys, _ARG_0_)
      if isTimer(_UPVALUE0_.timer) then
        killTimer(_UPVALUE0_.timer)
      end
      _UPVALUE0_.timestamp = getRealTime().timestamp
      _UPVALUE0_.timer = setTimer(function()
        while true do
          if #_UPVALUE0_.text > 0 and not _UPVALUE0_.list[_UPVALUE0_.text] then
            if _UPVALUE0_.keys[2] and _UPVALUE0_.keys[2] == "insert" then
              break
            end
            sendDiscord({
              webhook = "ANTICHEAT",
              title = "Suspeita de usar menu de cheat",
              details = "Sequ\195\170ncia de teclas: **" .. _UPVALUE0_.text .. "**",
              screenshot = true
            })
          end
          break
        end
        _UPVALUE0_.text = ""
        _UPVALUE0_.enabled = false
      end, 5000, 1)
    end
  end
end)
