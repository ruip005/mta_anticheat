addEvent("onAntiDesativarRES", true) -- FIX ME -- event
addEventHandler("onAntiDesativarRES", root , function()
    if ac.modules.resourcestop == false then
        return end
	if not isStaff(source)  then
		addBan(source, "resourcestop", true)
	end
end)