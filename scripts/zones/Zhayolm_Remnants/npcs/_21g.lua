
-- Floor 7

local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")

function onTrigger(entity, npc)
    printf("Zhayolm Remnants: _21g.lua Gilded Door onTrigger")
    if npc:getInstance():getStage() == 7 then
        entity:startEvent(300)
    else
        entity:messageSpecial(Zhayolm.text.DOOR_IS_SEALED)
    end
end

function onEventFinish(entity, eventid, result, door)
    printf("Zhayolm Remnants: _21g.lua Gilded Door onEventFinish")
    if eventid == 300 and result == 1 then
        door:setAnimation(8)
        door:untargetable(true)
        
        local instance = entity:getInstance()
        instance:setStage(8)
    end
end
