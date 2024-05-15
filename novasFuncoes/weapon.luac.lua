addEventHandler("onClientPlayerWeaponSwitch", localPlayer, function(_ARG_0_, _ARG_1_)
  if getPedWeapon(localPlayer) > 0 and getPedTotalAmmo(localPlayer) > 0 and getPedWeapon(localPlayer) ~= 32 and getPedWeapon(localPlayer) ~= 16 and not getElementData(localPlayer, "character:weapon") and not getElementData(localPlayer, "character:desmaiado") then
    print(_ARG_0_, _ARG_1_)
    setPedWeaponSlot(localPlayer, 0)
  end
end, false, "high+999")
