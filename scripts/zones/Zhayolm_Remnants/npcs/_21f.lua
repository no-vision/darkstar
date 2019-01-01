
-- Floor 6

local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")

function onTrigger(entity, npc)
    printf("Zhayolm Remnants: _21f.lua Gilded Door onTrigger")
    local stage = npc:getInstance():getStage()
    local chariotDead = entity:getLocalVar("Salvage-ZhayolmFL6-ChariotDead")
    local gCount = entity:getLocalVar("Salvage-ZhayolmFL6-GearsKilled")

    local num_pl = 0
    local instance = entity:getInstance()
    for _,v in ipairs(instance:getChars()) do
        num_pl = num_pl + 1
    end

    printf("[Debug]: Num people: " .. num_pl)

    if stage == 6 and chariotDead == 1 and (gCount == num_pl * 12) then
        entity:startEvent(300)
    else
        printf(".. Door check failed, Chariot: " .. chariotDead .. " | Gears killed: " .. gCount)
        entity:messageSpecial(Zhayolm.text.DOOR_IS_SEALED_MYSTERIOUS)
    end
end

function onEventFinish(entity, eventid, result, door)
    printf("Zhayolm Remnants: _21f.lua Gilded Door onEventFinish")
    if eventid == 300 and result == 1 then
        door:setAnimation(8)
        door:untargetable(true)
    end
end