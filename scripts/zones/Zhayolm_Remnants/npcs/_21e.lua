
-- Floor 5

local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")

function onTrigger(entity, npc)
    printf("Zhayolm Remnants: _21e.lua Gilded Door onTrigger")
    local ZR_Floor5_DoorOpen = entity:getLocalVar("Salvage-ZhayolmFL5-DoorOpen")
    if ZR_Floor5_DoorOpen == 0 then
        entity:startEvent(300)
    else
        entity:messageSpecial(Zhayolm.text.DOOR_IS_SEALED)
    end
end

function onEventFinish(entity, eventid, result, door)
    printf("Zhayolm Remnants: _21e.lua Gilded Door onEventFinish")
    if eventid == 300 and result == 1 then
        door:setAnimation(8)
        door:untargetable(true)
        
        local players = entity:getInstance():getChars()
        for _,p in ipairs(players) do
            p:setLocalVar("Salvage-ZhayolmFL5-DoorOpen", 1)
        end
    end
end