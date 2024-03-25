local antispamINVWEAPON = false

function disableMinigunOnSwitch(prevSlot, curSlot)
    for i,v in ipairs(ac.armas) do
        if getPedWeapon(localPlayer, curSlot) == ac.armas[i][1] then
			if ac.armas[i][2] then
            triggerServerEvent('onBANWEAPONCHEATER', localPlayer, ac.armas[i][1])
			end
        end
    end
---- git new 2 (anti arma invisivel)
local arma = getPedWeapon(localPlayer, curSlot)
local ant = getPedWeapon(localPlayer, prevSlot)
    --exports.vrp_info:addBox(arma, "info")
    if antispamINVWEAPON then
        return end
        triggerServerEvent('onCHECKWEAPONEXIST', localPlayer, arma, ant)
        antispamINVWEAPON = true 
    end
    addEventHandler("onClientPlayerWeaponSwitch", localPlayer, disableMinigunOnSwitch)

    ------

    local tiross = 0
local banirT = false
function contarTiros(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
    if weapon == 38 or weapon == 37 or weapon == 28 or weapon == 32 then
        return end
        tiross = tiross + 1
        if tiross > 27 then
            if banirT then
                return end
                triggerServerEvent("onFireRateCHEAT", localPlayer)
            end
        end
        addEventHandler ( "onClientPlayerWeaponFire", localPlayer, contarTiros )

        setTimer(function()
            tiross = 0
        end, 2000, 0)