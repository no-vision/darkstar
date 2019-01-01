-----------------------------------------
-- ID: 18721
-- Soultrapper
-- Used to snap pictures of monsters
-----------------------------------------

function onItemCheck(target, item, param, caster)
    print("Soultrapper onItemCheck(): Soultrapper pre-use item check.")
    -- Do we have a blank soul plate in the ammo slot?
    local soulplate = caster:getStorageItem(0, 0, dsp.slot.AMMO)
    if soulplate:getItemID() == 18722 or soulplate:getItemID() == 18725 then
        print("Soultrapper: Soulplate itemID found in ammo slot: " .. soulplate:getItemID() .. ", Ok to use.")
        -- Get distance of target from caster bonus
        local distanceBonus = (1 / caster:checkDistance(target))
        print("Soultrapper: distanceBonus: " .. distanceBonus)
        caster:setLocalVar("Soultrap-DistanceBonus", distanceBonus)
        -- Get states of target, Notorious?, Using ability or spell?
        local notoriousBonus = target:isMobType(MOBTYPE_NOTORIOUS)
        print("Soultrapper: notoriousBonus: " .. notoriousBonus)
        caster:setLocalVar("Soultrap-NotoriousBonus", notoriousBonus)
        -- Get target mob family attribute pool
        target:setLocalVar("Soultrap-User", caster:getName())
        return 0
    end
    print("Soultrapper: An invalid soulplate itemId was found in the ammo slot: " .. soulplate:getItemID() .. ", Not ok to use.")
    return 1
end

function onItemUse(target, item)
    print("Soultrapper onItemUse(): Soultrapper is being used.")
    local caster = target:getLocalVar("Soultrap-User")
    print("Soultrapper onItemUse(): Target: " .. target:getID() .. " | caster: " .. caster)
    if caster ~= nil then
        -- Get bonuses and attribute pool
        -- Encode soul plate with Attribute, FP, and Mob Name
    end
    print("Soultrapper onItemUse(): Soultrapper use complete.")
end