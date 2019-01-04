-----------------------------------------
-- ID: 18721
-- Soultrapper
-- Used to snap pictures of monsters
-- Notes:
-- 1. Soultrapper can be used outside of battle
-- 2. Not facing the target will result in a failure to capture image
-- 3. Distance, HP Level are very subjective
-----------------------------------------

function onItemCheck(target, unknown, caster)
    print("Soultrapper onItemCheck(): Soultrapper pre-use item check.")
    -- Do we have a blank soul plate in the ammo slot?
    local soulplate = caster:getStorageItem(0, 0, dsp.slot.AMMO)
    if soulplate == nil then
        return 1
    end

    if soulplate:getID() == 18722 or soulplate:getID() == 18725 then
        print("Soultrapper: Soulplate itemID found in ammo slot: " .. soulplate:getID() .. ", Ok to use.")
        -- Are we facing the target?
        if caster:isFacing(target) then
            -- Get distance of target from caster bonus
            local distanceBonus = (1 / caster:checkDistance(target))
            print("Soultrapper: distanceBonus: " .. distanceBonus)
            -- Get states of target, Notorious?, Using ability or spell?
            local notoriousBonus = 0
            if target:isMobType(MOBTYPE_NOTORIOUS) then
                notoriousBonus = 1
            end
            print("Soultrapper: notoriousBonus: " .. notoriousBonus)
            local mobHPBonus = 0
            if target:getHPP() < 50 then
                mobHPBonus = 1
            end
            print("Soultrapper: mobHPBonus: " .. mobHPBonus)
            -- Get target mob family attribute pool
        else
            print("Soultrapper: Caster is not facing the target")
        end
        return 0
    end
    print("Soultrapper: An invalid soulplate itemId was found in the ammo slot: " .. soulplate:getItemID() .. ", Not ok to use.")
    return 1
end

function onItemUse(target)
    print("Soultrapper onItemUse(): Soultrapper is being used.")

    -- Pack item extra data for storage,
    --
    print("Soultrapper packing mob name to extra data.")
    local mobName = target:getName()
    print("Soultrapper Name Pack: " .. mobName)
    mobName = mobName:gsub("[".."_' ":gsub("%W", "%%%1").."]", '') -- Remove special characters
    print("Soultrapper Name Pack Underscore: " .. mobName)
    -- Remove punctuation
    if #mobName > 13 then
        mobName = string.sub(mobName, 1, 13) -- Truncate
        print("Soultrapper Name Pack Truncate: " .. mobName)
    end

    print("Soultrapper extra data Name Pack: " .. extra)
    print("Soultrapper onItemUse(): Soultrapper use complete.")

end