--------------------------------
-- Slot - Jakko
--------------------------------
local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")

function onTrigger(player, npc)
end;

function onTrade(player, npc, trade)
    printf("Socket onTrade for player: " .. player:getName())
    local instance = npc:getInstance()
    local stage = instance:getStage()
    local chars = instance:getChars()

    if stage == 2 then
        local nw_gate
        for _,v in pairs(chars) do
            if v:getID() == player:getID() then
                nw_gate = v:getLocalVar("Salvage-ZhayolmFL2-NWGateUnlock")
            end
        end
        if trade:hasItemQty(2378, 1) and nw_gate == 1 then
            player:tradeComplete()
            player:setLocalVar("Salvage-ZhayolmFL2-Jakko-Spawned", 1)
            npc:setStatus(STATUS_DISAPPEAR)
            SpawnMob(Zhayolm.mob[2].jakko, instance):setPos(npc:getXPos(), npc:getYPos(), npc:getZPos(), 0)
        end
    end
end;