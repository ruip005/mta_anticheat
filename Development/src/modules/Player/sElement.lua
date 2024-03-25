addEventHandler("onElementDataChange", getRootElement(),function(theKey, oldValue) -- Element Change (Arrumar)
    if ac.modules.element == false then
        return end
    if getElementType(source) ~= "player" then
        return end
	if not isStaff(source)  then
	if (getElementType(source) == "player") then
        for i,v in ipairs(ac.elementdata) do
            if theKey == tostring(v) then
                setElementData(source, theKey, oldValue)
                addBan(source, "element", false)
            end
        end
    end
    end
end)