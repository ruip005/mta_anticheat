addEvent("destiny_anticheat:receiveInfo", true)
addEvent("destiny_anticheat:clearClientLogs", true)
addEvent("onClientReceiveCharacters", true)
function loadSettings()
  if fileExists(_UPVALUE0_) then
    fileClose((fileOpen(_UPVALUE0_)))
    if fileRead(fileOpen(_UPVALUE0_), fileGetSize((fileOpen(_UPVALUE0_)))) then
      if decodeString("tea", fileRead(fileOpen(_UPVALUE0_), fileGetSize((fileOpen(_UPVALUE0_)))), {key = _UPVALUE1_}) then
        _UPVALUE2_ = fromJSON((decodeString("tea", fileRead(fileOpen(_UPVALUE0_), fileGetSize((fileOpen(_UPVALUE0_)))), {key = _UPVALUE1_}))) and debugJSON((decodeString("tea", fileRead(fileOpen(_UPVALUE0_), fileGetSize((fileOpen(_UPVALUE0_)))), {key = _UPVALUE1_}))) or {}
      end
    end
  end
end
function setSetting(_ARG_0_, _ARG_1_)
  _UPVALUE0_[_ARG_0_] = _ARG_1_
  if fileExists("@d") then
    fileDelete("@d")
  end
  if toJSON(_UPVALUE0_) then
    fileWrite(fileCreate("@d"), (encodeString("tea", toJSON(_UPVALUE0_), {key = _UPVALUE1_})))
    fileFlush((fileCreate("@d")))
  end
  fileClose((fileCreate("@d")))
end
function getSetting(_ARG_0_)
  return _UPVALUE0_[_ARG_0_]
end
addEventHandler("destiny_anticheat:receiveInfo", root, function(_ARG_0_)
  if getSetting("AC_DATA") then
    if getSetting("AC_DATA").ip and not getSetting("AC_DATA").ip[_ARG_0_.ip] and _ARG_0_.ip then
      getSetting("AC_DATA").ip[_ARG_0_.ip] = getRealTime().timestamp
    end
    if getSetting("AC_DATA").serial and not getSetting("AC_DATA").serial[_ARG_0_.serial] and _ARG_0_.serial then
      getSetting("AC_DATA").serial[_ARG_0_.serial] = getRealTime().timestamp
    end
    if getSetting("AC_DATA").video_card and not getSetting("AC_DATA").video_card[dxGetStatus().VideoCardName] and dxGetStatus().VideoCardName then
      getSetting("AC_DATA").video_card[dxGetStatus().VideoCardName] = getRealTime().timestamp
    end
    for _FORV_9_, _FORV_10_ in pairs((getSetting("AC_DATA"))) do
      if not ({})[_FORV_9_] then
        ({})[_FORV_9_] = 0
      end
      orderPairs(_FORV_10_, function(_ARG_0_, _ARG_1_)
        return _ARG_0_ < _ARG_1_
      end)
      for _FORV_14_, _FORV_15_ in pairs(_FORV_10_) do
        if not ({})[_FORV_9_] then
          ({})[_FORV_9_] = "> **" .. (_UPVALUE0_[_FORV_9_] or _FORV_9_) .. [[
:** 
> **]] .. ({})[_FORV_9_] + 1 .. "\194\176** " .. _FORV_14_ .. " (**" .. os.date("%d/%m/%Y %H:%M:%S", _FORV_15_) .. "**)"
        else
          ({})[_FORV_9_] = ({})[_FORV_9_] .. [[

> **]] .. ({})[_FORV_9_] + 1 .. "\194\176** " .. _FORV_14_ .. " (**" .. os.date("%d/%m/%Y %H:%M:%S", _FORV_15_) .. "**)"
        end
        ;({})[_FORV_9_] = ({})[_FORV_9_] + 1
      end
    end
    for _FORV_9_, _FORV_10_ in pairs({}) do
      if _FORV_9_ == "serial" and _FORV_10_ >= 2 then
        for _FORV_15_, _FORV_16_ in pairs({}) do
        end
        exports.destiny_discord:send("AC_ACCOUNT", {
          content = "### Múltiplos serials detectados",
          embeds = {
            {
              title = "Informa\195\167\195\181es",
              description = ([[
:identification_card: **%s#%s**
%s]]):format(getPlayerName(localPlayer), _ARG_0_.serial, "" .. "\n" .. _FORV_16_ .. "\n"),
              color = 65280
            }
          }
        })
      end
    end
    setSetting("AC_DATA", (getSetting("AC_DATA")))
  else
    setSetting("AC_DATA", {
      ip = {
        [_ARG_0_.ip] = getRealTime().timestamp
      },
      serial = {
        [_ARG_0_.serial] = getRealTime().timestamp
      },
      video_card = {
        [dxGetStatus().VideoCardName] = getRealTime().timestamp
      }
    })
  end
end)
addEventHandler("destiny_anticheat:clearClientLogs", root, function(_ARG_0_, _ARG_1_)
  if _ARG_0_ == "account" then
    if getSetting("AC_DATA").account_history then
      getSetting("AC_DATA").account_history[getElementData(localPlayer, "account:user")] = nil
    end
    setSetting("AC_DATA", (getSetting("AC_DATA")))
  elseif _ARG_0_ == "banned" then
    if getSetting("AC_DATA").account_banned then
      getSetting("AC_DATA").account_banned = nil
    end
    setSetting("AC_DATA", (getSetting("AC_DATA")))
  elseif _ARG_0_ == "ip" then
    if _ARG_1_ then
      if getSetting("AC_DATA").ip then
        getSetting("AC_DATA").ip[_ARG_1_] = nil
      end
    else
      getSetting("AC_DATA").ip = {}
    end
    setSetting("AC_DATA", (getSetting("AC_DATA")))
  elseif _ARG_0_ == "serial" then
    if _ARG_1_ then
      if getSetting("AC_DATA").serial then
        getSetting("AC_DATA").serial[_ARG_1_] = nil
      end
    else
      getSetting("AC_DATA").serial = {}
    end
    setSetting("AC_DATA", (getSetting("AC_DATA")))
  elseif _ARG_0_ == "all" then
    setSetting("AC_DATA", {})
  end
end)
addEventHandler("onClientReceiveCharacters", localPlayer, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if not getSetting("AC_DATA").account_history then
    getSetting("AC_DATA").account_history = {
      [getElementData(localPlayer, "account:user")] = getRealTime().timestamp
    }
  end
  if not getSetting("AC_DATA").account_history[getElementData(localPlayer, "account:user")] then
    getSetting("AC_DATA").account_history[getElementData(localPlayer, "account:user")] = getRealTime().timestamp
  end
  if _ARG_1_ then
    if not getSetting("AC_DATA").account_banned then
      getSetting("AC_DATA").account_banned = {
        [getElementData(localPlayer, "account:user")] = getRealTime().timestamp
      }
    end
    if not getSetting("AC_DATA").account_banned[getElementData(localPlayer, "account:user")] then
      getSetting("AC_DATA").account_banned[getElementData(localPlayer, "account:user")] = getRealTime().timestamp
    end
  end
  if getSetting("AC_DATA").account_banned then
    for _FORV_9_ in pairs(getSetting("AC_DATA").account_banned) do
      table.insert({}, _FORV_9_)
    end
    exports.destiny_discord:send("AC_ACCOUNT", {
      content = "### Contas banidas",
      embeds = {
        {
          title = "Informa\195\167\195\181es",
          description = ("O usuário **%s** está banido em outras contas.\n\n**Contas banidas:**\n%s"):format(getElementData(localPlayer, "account:user"), table.concat({}, "\n")),
          color = 16711680
        }
      }
    })
  end
  setSetting("AC_DATA", (getSetting("AC_DATA")))
end)
addEventHandler("onClientResourceStart", resourceRoot, function()
  loadSettings()
end)
