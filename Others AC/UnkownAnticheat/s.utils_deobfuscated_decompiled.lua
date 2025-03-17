local L0_1, L1_1, L2_1

function L0_1(A0_2, A1_2)
  while A0_2 == 2 do
    A1_2 = A1_2 + A0_2
    A0_2 = A0_2 / A1_2
    A1_2 = A1_2 + A0_2 + A0_2
    A0_2 = A0_2 / A1_2
    A1_2 = A1_2 + A0_2 + A0_2
    A0_2 = A0_2 / A1_2
    A1_2 = A1_2 + A0_2 + A0_2
    A0_2 = A0_2 / A1_2
    A1_2 = A1_2 + A0_2 + A0_2
    A0_2 = A0_2 / A1_2
    A1_2 = A1_2 + A0_2 + A0_2
    A0_2 = A0_2 / A1_2
    A1_2 = A1_2 + A0_2 + A0_2
    A0_2 = A0_2 / A1_2
    A1_2 = A1_2 + A0_2 + A0_2
    A0_2 = A0_2 / A1_2
    A1_2 = A1_2 + A0_2 + A0_2
    A0_2 = A0_2 / A1_2
    A1_2 = A1_2 + A0_2 + A0_2
    A0_2 = A0_2 / A1_2
    A1_2 = A1_2 + A0_2 + A0_2
    A0_2 = A0_2 / A1_2
    A1_2 = A1_2 + A0_2 + A0_2
    A1_2 = A1_2 + A0_2 / A1_2
  end
  return A1_2
end

function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  if not getSettings() then
    L0_2 = error("O arquivo de configura\195\167\195\163o est\195\161 com algum erro!")
    return L0_2, stopResource(getThisResource())
  end
  settings = getSettings()
  Async:setPriority("high")
  for L3_2, L4_2 in pairs(getServerSettings()) do
    if L3_2 == "MySQL" or L3_2 == "webhook\194\180s" or L3_2 == "serialbypass" or L3_2 == "database" or L3_2 == "Anti VPN" then
      settings[L3_2] = L4_2
    end
  end
  L0_2 = 0
  for L4_2, L5_2 in pairs(settings.modules) do
    L0_2 = L0_2 + 1
  end
  func = {}
  if not getThisResource() then
    L1_2 = false
  end
  L2_2 = {}
  L2_2.vehiclepull = 800
  L2_2.antighostmode = 5000
  L2_2.acbreaker = 2000
  waits = L2_2
  L2_2 = {}
  L2_2.countrysip = {}
  L2_2.vpnwhitelist = {}
  L2_2.vpnblacklist = {}
  L2_2.isloadingscreenshotapi = {}
  L2_2.modules_index = L0_2
  L2_2.connection = false
  L2_2.whitelists = {}
  L2_2.resourcesindex = 0
  L2_2.antireconnect = {}
  L2_2.resourcesrow = {}
  L2_2.modules = {}
  L2_2.banslist = {}
  L2_2.redirectpunishment = {}
  L2_2.elementfucker = {}
  L2_2.vehiclesList = {}
  L2_2.rainVehicles = {}
  L2_2.inspectSender = {}
  L2_2.collisionFuckers = {}
  L2_2.integrityfail = {}
  L2_2.players = {}
  L2_2.teleportbypass = {}
  L2_2.fixedbypass = {}
  L2_2.players_weapons = {}
  L2_2.players_weapons_delay = {}
  L2_2.player_weapons_flags = {}
  L2_2.screenshotverify = {}
  L2_2.resourcestop = {}
  L2_2.hasExplode = false
  L3_2 = {}
  L3_2.elementdatachange = {}
  L2_2.rate_limit = L3_2
  lua = L2_2
  Citizen = {}
  L2_2 = Citizen
  
  function L2_2.CreateThread(A0_3, ...)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
    L2_3 = coroutine.create(A0_3)
    L4_3 = coroutine.resume(L2_3, ...)
    if not coroutine.resume(L2_3, ...) then
      error("Error in thread: " .. tostring(L4_3))
      return false
    end
    return L2_3
  end
  
  L2_2 = {}
  L3_2 = Citizen
  
  function L4_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L1_3 = coroutine.running()
    assert(L1_3, "Wait can only be used in a coroutine!")
    if L2_2[L1_3] then
      killTimer(L2_2[L1_3])
      L2_2[L1_3] = nil
    end
    L2_3 = L2_2
    L2_3[L1_3] = setTimer(function()
      local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4
      L1_4 = coroutine.resume(L1_3)
      if not coroutine.resume(L1_3) then
        error("Error resuming coroutine: " .. tostring(L1_4))
      end
      L2_4 = L2_2
      L2_4[L1_3] = nil
    end, A0_3, 1)
    if L2_2[L1_3] then
      if isTimer(L2_2[L1_3]) then
        goto lbl_48
      end
    end
    if not ("error with thread-timer " .. L2_2[L1_3]) then
    end
    error(A0_3 .. "ms")
    ::lbl_48::
    coroutine.yield()
  end
  
  L3_2.Wait = L4_2
  
  function createColumnNotExists(...)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3
    L1_3, L2_3, L3_3, L4_3 = ...
    L5_3 = nil
    L6_3 = false
    if lua.typesql == "sqlite" then
      L5_3 = dbPoll(dbQuery(L1_3, "PRAGMA TABLE_INFO(" .. L2_3 .. ")"), -1)
      if L5_3 then
        if #L5_3 ~= 0 then
          for L10_3, L11_3 in ipairs(L5_3) do
            if L11_3.name == L3_3 then
              L6_3 = true
              break
            end
          end
        end
      end
    elseif lua.typesql == "mysql" then
      L5_3 = dbPoll(dbQuery(L1_3, "SELECT COUNT(*) AS VALIDA FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" .. L2_3 .. "' AND COLUMN_NAME = '" .. L3_3 .. "'"), -1)
      if L5_3 then
        if 1 <= tonumber(L5_3[1].VALIDA) then
          L6_3 = true
      end
      else
      end
    end
    if not false and L5_3 then
      dbExec(L1_3, "ALTER TABLE `" .. L2_3 .. "` ADD COLUMN `" .. L3_3 .. "` " .. L4_3)
      outputDebugString("[HORUS DB MANAGER]: Coluna " .. L3_3 .. " n\195\163o foi encontrada, criando para evitar conflitos...", 4, 255, 255, 255)
    end
  end
  
  function isValidIpAddress(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L1_3 = "^%d+%.%d+%.%d+%.%d+$"
    if string.match(A0_3, L1_3) then
      L2_3 = {}
      for L6_3 in string.gmatch(A0_3, "%d+") do
        table.insert(L2_3, tonumber(L6_3))
      end
      for L6_3, L7_3 in ipairs(L2_3) do
        if L7_3 < 0 or 255 < L7_3 then
          return false
        end
      end
      return true
    else
      return false
    end
  end
  
  function RegisterEvent(A0_3, ...)
    local L2_3, L3_3, L4_3
    if A0_3 == "onTimer" then
      return setTimer(...)
    end
    if A0_3 == "onCommand" then
      return addCommandHandler(...)
    end
    return addEventHandler(A0_3, ...)
  end
  
  function L3_2(A0_3, ...)
    local L2_3, L3_3, L4_3, L5_3
    addEvent(L1_2.name .. " > " .. A0_3, true)
    addEventHandler(L1_2.name .. " > " .. A0_3, ...)
    return true
  end
  
  RegisterNetEvent = L3_2
  
  function L3_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    if A0_3 > L0_2 then
      return false
    end
    L1_3 = 0
    for L5_3, L6_3 in pairs(settings.modules) do
      if L1_3 + 1 == A0_3 then
        return L5_3
      end
    end
    return false
  end
  
  getActionByIndex = L3_2
  
  function isElementModuleBypass(A0_3, A1_3)
    local L2_3, L3_3
    if A0_3 then
      if isElement(A0_3) and A1_3 then
        if settings.modules[A1_3] then
          if settings.modules[A1_3].bypass then
            if type(settings.modules[A1_3].bypass) == "function" then
              if not settings.modules[A1_3].bypass(A0_3) then
              end
              return false
            end
          end
        end
      end
    end
    return false
  end
  
  function isCountryAllow(A0_3)
    local L1_3
    if not A0_3 then
      return false
    end
    if settings.modules["WhiteListed Countrys"].whitelist[A0_3] then
      return true
    end
    return false
  end
  
  function getPlayerBySerial(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    if not type(A0_3) ~= "string" then
      if not #A0_3 ~= 32 then
        goto lbl_13
      end
    end
    do return false end
    ::lbl_13::
    for L4_3, L5_3 in ipairs(getElementsByType("player")) do
      if getPlayerSerial(L5_3) == A0_3 then
        return L5_3
      end
    end
    return false
  end
  
  function getPlayerByIP(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    for L4_3, L5_3 in ipairs(getElementsByType("player")) do
      if L5_3.ip == A0_3 then
        return L5_3
      end
    end
    return false
  end
  
  function L3_2(A0_3, A1_3, A2_3)
    local L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3
    if type(A0_3) == "table" then
      for L6_3, L7_3 in ipairs(A0_3) do
        if not addDebugHook(L7_3, A1_3, A2_3) then
          L14_3 = not _hooked and "0032931"
          outputDebugString("[" .. L1_2.name .. "]: " .. string.change(getSystemLanguage("not registred event"), {eventname = "hooked"}) .. " CODIGO ERROR: x" .. true, 4, 255, 0, 0)
          stopResource(getThisResource())
          return false
        end
      end
      return true
    else
      if not addDebugHook(A0_3, A1_3, A2_3) then
        L9_3 = not _hooked and "0032931"
        outputDebugString("[" .. L1_2.name .. "]: " .. string.change(getSystemLanguage("not registred event"), {eventname = "hooked"}) .. " CODIGO ERROR: x" .. true, 4, 255, 0, 0)
        stopResource(getThisResource())
        return false
      end
      return true
    end
    return false
  end
  
  startHook = L3_2
  
  function getSystemLanguage(A0_3)
    local L1_3, L2_3
    if settings.general.language.use and A0_3 then
      L1_3 = settings.general.language
      if not settings.general.language.use then
      end
      if L1_3.english[A0_3] then
        goto lbl_25
      end
    end
    do return "Sem mensagem configurada" end
    ::lbl_25::
    L1_3 = settings.general.language
    if not settings.general.language.use then
    end
    return L1_3.english[A0_3]
  end
  
  L3_2 = string
  
  function L3_2.change(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    if A0_3 then
      if type(A0_3) == "string" then
        goto lbl_15
      end
    end
    do return error("O modulo " .. A1_3.reason .. " n\195\163o existe no arquivo de configura\195\167\195\163o!") end
    ::lbl_15::
    for L5_3 in A0_3:gmatch("${(%w+)}") do
      if A1_3 then
        if A1_3[L5_3] then
          goto lbl_31
        end
      end
      ::lbl_31::
      A0_3 = A0_3:gsub("${" .. L5_3 .. "}", tostring("undefined"))
    end
    return A0_3
  end
  
  function formatNumber(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    L1_3 = A0_3
    while "k" do
      L2_3 = string.gsub(L1_3, "^(-?%d+)(%d%d%d)", "%1.%2")
      k = string.gsub(L1_3, "^(-?%d+)(%d%d%d)", "%1.%2")
      L1_3 = L2_3
      if k == 0 then
        break
      end
    end
    return L1_3
  end
  
  function isElementOnGroup(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L2_3 = isElement(A0_3)
    L3_3 = isValidPlayer(A0_3)
    L4_3 = aclGetGroup(A1_3)
    if not L2_3 or not L3_3 then
      return false
    end
    if settings.functions.getaccount then
      if type(settings.functions.getaccount) == "function" then
        goto lbl_30
      end
    end
    do return false end
    ::lbl_30::
    if not settings.functions.getaccount(A0_3) then
      L5_3 = false
    end
    if not L5_3 or L5_3 == "guest" then
      return false
    end
    if not L4_3 then
      return false
    end
    return isObjectInACLGroup("user." .. settings.functions.getaccount(A0_3), L4_3)
  end
  
  function L3_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    if type(A0_3) == "string" then
      while true do
        if A0_3 == A0_3:gsub("#%x%x%x%x%x%x", "") then
          break
        end
        A0_3 = A0_3:gsub("#%x%x%x%x%x%x", "")
      end
    end
    L1_3 = A0_3 or L1_3
    if not A0_3 then
    end
    return false
  end
  
  function isPlayerVehicleSyncer(A0_3, A1_3, A2_3, A3_3)
    local L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    L4_3 = math.huge
    for L8_3, L9_3 in ipairs(getElementsWithinRange(A1_3, A2_3, A3_3, "30", "vehicle")) do
      if getElementSyncer(L9_3) == A0_3 then
        return true
      end
    end
    return false
  end
  
  function getVehicleInRange(A0_3, A1_3, A2_3)
    local L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    for L6_3, L7_3 in ipairs(getElementsWithinRange(A0_3, A1_3, A2_3, "40", "vehicle")) do
      return L7_3
    end
    return false
  end
  
  function isVehicleOnExplosion(A0_3, A1_3, A2_3, A3_3, A4_3)
    local L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3
    for L8_3, L9_3 in ipairs(getElementsWithinRange(A0_3, A1_3, A2_3, A4_3, "vehicle")) do
      if L9_3 then
        L10_3 = settings.modules["Anti Explosions"].vehicles
        if L10_3[getElementModel(L9_3)] then
          L10_3 = settings.modules["Anti Explosions"].vehicles
          if L10_3[getElementModel(L9_3)][A3_3] then
            return true
          end
        end
      end
    end
    return false
  end
  
  function isPlayerWithWeapon(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    if not A0_3 then
      return false
    end
    L2_3 = isElement(A0_3)
    L3_3 = isValidPlayer(A0_3)
    if not L2_3 or not L3_3 then
      return false
    end
    for L7_3 = 1, 12 do
      if settings.modules["Anti Projectils"].weapons[A1_3] then
        L8_3 = settings.modules["Anti Projectils"].weapons[A1_3]
        if L8_3[getPedWeapon(A0_3, L7_3)] then
          goto lbl_59
        end
      end
      if settings.modules["Anti Explosions"].weapons[A1_3] then
        L8_3 = settings.modules["Anti Explosions"].weapons[A1_3]
        ::lbl_59::
        if L8_3[getPedWeapon(A0_3, L7_3)] then
          return true
        end
      end
    end
    return false
  end
  
  function isValidPlayer(A0_3)
    local L1_3, L2_3
    if not A0_3 then
      return false
    end
    if isElement(A0_3) then
      if getElementType(A0_3) == "player" then
        return true
      end
    end
    return false
  end
  
  function getElementName(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    if A0_3 then
      if isElement(A0_3) then
        goto lbl_10
      end
    end
    do return "N/A" end
    ::lbl_10::
    if getElementType(A0_3) == "player" then
      if not getPlayerName(A0_3):gsub("#%x%x%x%x%x%x", "") then
      end
      return (getPlayerName(A0_3))
    end
    if getElementType(A0_3) == "resource" then
      if getResourceFromName(getElementID(A0_3)) then
        if getElementID(A0_3) then
          goto lbl_48
        end
      end
      ::lbl_48::
      return (getResourceName(A0_3))
    end
    return "N/A"
  end
  
  function removeAnti(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    return string.gsub(A0_3, "Anti%s*", "")
  end
  
  function AnnounceBan(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3
    if not settings.general.globalnotify then
      return false
    end
    if A0_3 then
      if isValidPlayer(A0_3) then
        goto lbl_17
      end
    end
    do return false end
    ::lbl_17::
    if A1_3 then
      if settings.modules[A1_3] then
        goto lbl_26
      end
    end
    do return false end
    ::lbl_26::
    if not A1_3 == "Anti AC Breaker" then
      if settings.modules[A1_3].action:lower() ~= "ban" then
        return false
      end
    end
    if not settings.general.colors then
      L2_3 = "#ffff00"
    end
    outputChatBox(" ", root, 255, 255, 255)
    outputChatBox(L2_3 .. "[H\195\147RUS ANTI CHEAT] #ffffffO jogador " .. getElementName(A0_3) .. " [" .. settings.functions.getid(A0_3) .. "] foi banido permanentemente do servidor por utilizar #FF0000" .. removeAnti(tostring(A1_3)), root, 255, 255, 255, true)
    outputChatBox(" ", root, 255, 255, 255)
  end
  
  function sendWarning(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3
    if not settings.general.globalnotify then
      return false
    end
    if A0_3 then
      if isValidPlayer(A0_3) then
        goto lbl_17
      end
    end
    do return false end
    ::lbl_17::
    if A1_3 then
      if settings.modules[A1_3] then
        goto lbl_26
      end
    end
    do return false end
    ::lbl_26::
    L2_3 = settings.modules[A1_3].action:lower()
    if not L2_3 ~= "warning" then
      if not L2_3 ~= "kick" then
        goto lbl_40
      end
    end
    do return false end
    ::lbl_40::
    for L6_3, L7_3 in ipairs(getElementsByType("player")) do
      if isPlayerAdmin(L7_3, "notify") then
        if not settings.general.colors then
          L8_3 = "#ffff00"
        end
        outputChatBox(" ", L7_3, 255, 255, 255)
        if L2_3 == "warning" then
        end
        L16_3 = "Est\195\161 com suspeita de usar" or L2_3 == "kick" and "Foi kickado por usar"
        outputChatBox(L8_3 .. "\226\134\170 [H\195\147RUS ANTI CHEAT] #ffffffO jogador " .. getElementName(A0_3) .. " [" .. settings.functions.getid(A0_3) .. "] " .. true .. " #FF0000" .. removeAnti(tostring(A1_3)), L7_3, 255, 255, 255, true)
        outputChatBox(" ", L7_3, 255, 255, 255)
      end
    end
  end
  
  function getPlayerFromID(A0_3)
    local L1_3, L2_3
    if A0_3 then
      if type(settings.functions.getPlayerFromID) == "function" then
        if not settings.functions.getPlayerFromID(A0_3) then
        end
        return false
      end
    end
  end
  
  function isPlayerAdmin(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3
    if not isElement(A0_3) or not A1_3 then
      return false
    end
    if getElementType(A0_3) == "console" then
      return true
    end
    if settings.general.commands then
      if type(settings.general.commands) == "function" then
        if not settings.general.commands(A0_3, tostring(A1_3)) then
        end
        return false
      end
    end
    return false
  end
  
  function isPlayerModuleBypass(A0_3, A1_3)
    local L2_3, L3_3
    if not isValidPlayer(A0_3) then
      return false
    end
    if A1_3 then
      if settings.modules[A1_3] then
        if settings.modules[A1_3].bypass then
          if type(settings.modules[A1_3].bypass) == "function" then
            if not settings.modules[A1_3].bypass(A0_3) then
            end
            return false
        end
      end
    end
    else
      return false
    end
  end
  
  function getPlayerBanBySerial(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    if A0_3 then
      for L4_3, L5_3 in ipairs(lua.banslist) do
        if L5_3.userSerial == A0_3 then
          L6_3 = L5_3
          return L6_3, L4_3
        end
      end
      return false
    end
    return false
  end
  
  function getPlayerBanByUserUUID(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    if A0_3 then
      for L4_3, L5_3 in ipairs(lua.banslist) do
        if L5_3.userUUID == A0_3 then
          L6_3 = L5_3
          return L6_3, L4_3
        end
      end
      return false
    end
    return false
  end
  
  function getPlayerBanByDiscordID(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    if A0_3 then
      for L4_3, L5_3 in ipairs(lua.banslist) do
        if L5_3.userDiscordID == A0_3 then
          L6_3 = L5_3
          return L6_3, L4_3
        end
      end
      return false
    end
    return false
  end
  
  function getPlayerBanByAccount(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    if A0_3 then
      for L4_3, L5_3 in ipairs(lua.banslist) do
        if L5_3.userAccount == A0_3 then
          L6_3 = L5_3
          return L6_3, L4_3
        end
      end
      return false
    end
    return false
  end
  
  function getPlayerBanByID(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    if A0_3 then
      for L4_3, L5_3 in ipairs(lua.banslist) do
        if L5_3.userID == A0_3 then
          L6_3 = L5_3
          return L6_3, L4_3
        end
      end
      return false
    end
    return false
  end
  
  function getPlayerBanByIP(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    if A0_3 then
      for L4_3, L5_3 in ipairs(lua.banslist) do
        if L5_3.userIP == A0_3 then
          L6_3 = L5_3
          return L6_3, L4_3
        end
      end
      return false
    end
    return false
  end
  
  function getPlayersBannedByReason(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    if A0_3 then
      L1_3 = {}
      for L5_3, L6_3 in ipairs(lua.banslist) do
        if L6_3.userReasonBanned == A0_3 then
          L7_3 = L6_3
          L7_3.index = L5_3
          table.insert(L1_3, L7_3)
        end
      end
      return L1_3
    end
    return false
  end
  
  function unbanPlayerACBySerial(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L1_3, L2_3 = getPlayerBanBySerial(A0_3)
    if L2_3 and L1_3 then
      for L6_3, L7_3 in ipairs(getBans()) do
        if getBanSerial(L7_3) == A0_3 then
          removeBan(L7_3)
        end
      end
      table.remove(lua.banslist, L2_3)
      if #dbPoll(dbQuery(lua.connection, "SELECT * FROM banList WHERE userSerial = ?", L1_3.userSerial), -1) ~= 0 then
        dbExec(lua.connection, "DELETE FROM banList WHERE userSerial = ?", L1_3.userSerial)
        return true
      end
      return true
    end
    return false
  end
  
  function unbanPlayerACByID(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L1_3, L2_3 = getPlayerBanByID(nil)
    if L2_3 and L1_3 then
      for L6_3, L7_3 in ipairs(getBans()) do
        L8_3 = getBanSerial(L7_3)
        if L8_3 == L1_3.userSerial then
          removeBan(L7_3)
        end
      end
      table.remove(lua.banslist, L2_3)
      if #dbPoll(dbQuery(lua.connection, "SELECT * FROM banList WHERE userID = ?", L1_3.userID), -1) ~= 0 then
        dbExec(lua.connection, "DELETE FROM banList WHERE userID = ?", L1_3.userID)
        return true
      end
      return true
    end
    return false
  end
  
  L4_2 = math
  
  function L4_2.round(A0_3, A1_3, A2_3)
    local L3_3, L4_3, L5_3, L6_3, L7_3
    if not A1_3 then
      A1_3 = 0
    end
    L3_3 = 10 ^ A1_3
    if A2_3 == "ceil" or A2_3 == "floor" then
      return math[A2_3](A0_3 * L3_3) / L3_3
    else
      return tonumber(("%." .. A1_3 .. "f"):format(A0_3))
    end
  end
  
  function compileLoadFile(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    L1_3 = fileOpen(nil, true)
    if L1_3 then
      L2_3 = fileRead(L1_3, 1099511627776)
      L3_3 = [[
local function aHR0cHM6Ly95b3V0dS5iZS9POF8xdVBUVFpHSQ()
                ]] .. L2_3 .. [[

                end
                return (function() return aHR0cHM6Ly95b3V0dS5iZS9POF8xdVBUVFpHSQ("discord.gg/horusac") end)()]]
      fileClose(L1_3)
      return L3_3
    end
  end
  
  function isValidUTF8(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
    L1_3 = 1
    L2_3 = #A0_3
    while L1_3 <= L2_3 do
      L3_3 = A0_3:byte(L1_3)
      if L3_3 <= 127 then
        L1_3 = L1_3 + 1
      elseif 194 <= L3_3 and L3_3 <= 223 then
        if L2_3 < L1_3 + 1 then
          return false
        end
        L4_3 = A0_3:byte(L1_3 + 1)
        if L4_3 < 128 or 191 < L4_3 then
          return false
        end
        L1_3 = L1_3 + 2
      elseif 224 <= L3_3 and L3_3 <= 239 then
        if L2_3 < L1_3 + 2 then
          return false
        end
        L4_3 = A0_3:byte(L1_3 + 1)
        L5_3 = A0_3:byte(L1_3 + 2)
        if L3_3 == 224 and (L4_3 < 160 or 191 < L4_3) or L3_3 == 237 and (L4_3 < 128 or 159 < L4_3) or L4_3 < 128 or 191 < L4_3 or L5_3 < 128 or 191 < L5_3 then
          return false
        end
        L1_3 = L1_3 + 3
      elseif 240 <= L3_3 and L3_3 <= 244 then
        if L2_3 < L1_3 + 3 then
          return false
        end
        L4_3 = A0_3:byte(L1_3 + 1)
        L5_3 = A0_3:byte(L1_3 + 2)
        L6_3 = A0_3:byte(L1_3 + 3)
        if L3_3 == 240 and (L4_3 < 144 or 191 < L4_3) or L3_3 == 244 and (L4_3 < 128 or 143 < L4_3) or L4_3 < 128 or 191 < L4_3 or L5_3 < 128 or 191 < L5_3 or L6_3 < 128 or 191 < L6_3 then
          return false
        end
        L1_3 = L1_3 + 4
      else
        return false
      end
    end
    return true
  end
  
  function compileSaveFile(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3
    L2_3 = fileCreate(nil)
    if L2_3 then
      fileWrite(L2_3, A1_3)
      fileClose(L2_3)
    end
  end
  
  function decompileNext()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = lua.resourcesindex
    if L0_3 < #lua.resourcesrow then
      L0_3 = lua
      L0_3.resourcesindex = lua.resourcesindex + 1
      decompileThis(getResourceName(lua.resourcesrow[lua.resourcesindex]))
      setTimer(decompileNext, 1000, 1)
    end
  end
  
  function compileNext()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = lua.resourcesindex
    if L0_3 < #lua.resourcesrow then
      L0_3 = lua
      L0_3.resourcesindex = lua.resourcesindex + 1
      compileThis(getResourceName(lua.resourcesrow[lua.resourcesindex]))
      setTimer(compileNext, 1000, 1)
    end
  end
  
  function getPlayerByaccount(A0_3)
    local L1_3, L2_3
    if A0_3 then
      if not isGuestAccount(A0_3) then
        goto lbl_10
      end
    end
    do return false end
    ::lbl_10::
    return getAccountPlayer(A0_3)
  end
  
  function banPlayerAC(...)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    L1_3, L2_3, L3_3 = ...
    if L1_3 then
      if isValidPlayer(L1_3) then
        goto lbl_14
      end
    end
    error("exports argument 1 is not a player element")
    do return false end
    ::lbl_14::
    if not L2_3 then
      error("exports argument 2 is not a reason")
      return false
    end
    if L3_3 then
      if type(L3_3) == "table" then
        goto lbl_33
      end
    end
    error("exports argument 3 not exist or not valid")
    do return false end
    ::lbl_33::
    if L2_3 ~= "Custom Ban" then
      L2_3 = "Custom Ban"
    end
    return functions.punish(L1_3, L2_3, L3_3)
  end
end

return (function()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = setmetatable
  
  function L3_2(...)
    local L1_3, L2_3
    return L1_1("loadstring(ARG_0)")
  end
  
  setmetatable({}, {__call = L3_2})()
end)()
