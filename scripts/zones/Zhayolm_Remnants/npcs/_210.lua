--------------------------------------------------
-- Zhayolm Remnants: First Main Door (Entry)
--------------------------------------------------
local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")

function onTrigger(entity, npc)
    printf("Zhayolm Remnants: onTrigger - Main Entry - _210.lua")
    entity:startEvent(300)
end

function onEventFinish(entity, eventid, result, door)
    if eventid == 300 and result == 1 then
        printf("Zhayolm Remnants: onEventFinish - Main Entry - _210.lua")
        local instance = door:getInstance()
        -- spawn mobs, etc
        for _,v in pairs(Zhayolm.npc[1][2]) do
            printf("Zhayolm Remnants: Spawning NPC: " .. v)
            local npc = instance:getEntity(bit.band(v, 0xFFF), dsp.objType.NPC):setStatus(dsp.status.NORMAL)
        end
        for id = Zhayolm.mob[1].mobs_start, Zhayolm.mob[1].mobs_end do
            if id == Zhayolm.mob[1].puk_poroggo or 
                id == Zhayolm.mob[1].ziz_poroggo or 
                id == Zhayolm.mob[1].lindwurm_poroggo or 
                id == Zhayolm.mob[1].bugard_poroggo or
                id == Zhayolm.mob[1].poroggo_madame then
                -- Do nothing.
            else
                SpawnMob(id, instance)
            end
        end
        door:setAnimation(8)
        door:untargetable(true)
    end
end