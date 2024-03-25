function isJetpack()
    if ac.modules.jetpack == false then
        return end
    if not isStaff(source) then
        if isPedWearingJetpack(source) then
        addBan(source, "jetpack", false)
        setPedWearingJetpack(source, false)
        end
    end
end

setTimer(isJetpack, 3000, 0)