addEventHandler("onClientRender", root, function()
  if getElementData(localPlayer, "character.allowedToSpeedHack") then
    return false
  end
  setPedAnimationSpeed(localPlayer, "sprint_civi", 1)
  setPedAnimationSpeed(localPlayer, "sprint_panic", 1)
  setPedAnimationSpeed(localPlayer, "sprint_wuzi", 1)
end, false, "low+5")
