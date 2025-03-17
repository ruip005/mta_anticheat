local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1

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
    A0_2 = A0_2 / A1_2
    A1_2 = A1_2 + A0_2 + A0_2
    A1_2 = A1_2 + A0_2 / A1_2
  end
  return A1_2
end

return (function()
  local L0_2, L1_2
  L0_2 = {}
  L0_2.threads = {}
  L0_2.execdelay = 1100
  dbmanager = L0_2
  Citizen.CreateThread(function(...)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    while true do
      L1_3 = false
      if #dbmanager.threads >= 1 then
        dbmanager.threads[1].connection:exec(dbmanager.threads[1].sql, unpack(dbmanager.threads[1].params))
        table.remove(dbmanager.threads, 1)
        L1_3 = true
        Citizen.Wait(dbmanager.execdelay)
      end
      if not L1_3 then
        Citizen.Wait(300)
      end
    end
  end)
  L0_2 = dbmanager
  
  function L0_2.exec(...)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L1_3, L2_3, L3_3 = ...
    L4_3 = dbmanager.threads
    L5_3 = #dbmanager.threads + 1
    L6_3 = {}
    L6_3.connection = L1_3
    L6_3.sql = L2_3
    L6_3.params = L3_3
    L4_3[L5_3] = L6_3
    return true
  end
end)("marlonzemella.dev.br", "start sql-query", true, false, true, true, "low-99", "NETWORKLOW", "RADIUS = 1;")
