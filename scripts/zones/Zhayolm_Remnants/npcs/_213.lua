
-- Floor 1

local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")

function onTrigger(entity, npc)
    printf("Zhayolm Remnants: _213.lua Gilded Door onTrigger")
    if npc:getInstance():getStage() == 1 and entity:getLocalVar("Zhayolm-FL1-DoorOpen") == 0 then
        entity:startEvent(300);
    else
        entity:messageSpecial(Zhayolm.text.DOOR_IS_SEALED)
    end
end

function onEventFinish(entity, eventid, result, door)
    printf("Zhayolm Remnants: _213.lua Gilded Door onEventFinish")
    if eventid == 300 and result == 1 then
        door:setAnimation(8)
        door:untargetable(true)

        local chars = entity:getInstance():getChars()
        for _,v in pairs(chars) do
            v:setLocalVar("Zhayolm-FL1-DoorOpen", 1)
        end
    end
end