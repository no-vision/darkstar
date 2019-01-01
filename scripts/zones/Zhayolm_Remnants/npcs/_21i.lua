
-- Floor 7

local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")

function onTrigger(entity, npc)
    printf("Zhayolm Remnants: _21i.lua Gilded Door onTrigger")
    printf(".. Stage: " .. entity:getInstance():getStage())
    if entity:getInstance():getStage() == 7 or entity:getInstance():getStage() == 8 then
        SpawnMob(Zhayolm.mob[7].battleclad_chariot, entity:getInstance())
        npc:setAnimation(8)
        entity:startEvent(300)
    else
        entity:messageSpecial(Zhayolm.text.DOOR_IS_SEALED)
    end
end

function onEventFinish(entity, eventid, result, door)
    printf("Zhayolm Remnants: _21i.lua Gilded Door onEventFinish")
    if eventid == 300 and result == 1 then
        --door:setAnimation(8)
        door:setAnimationSub(1);
        --door:untargetable(true)
        entity:setPos(-339, -4, 523, 191)
    end
end
