--------------------------------
-- Socket - Poroggo Madame
--------------------------------
local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")

function onTrigger(player, npc)
end;

function onTrade(player, npc, trade)
    printf("Socket onTrade for player: " .. player:getName())
    local instance = npc:getInstance()
    local stage = instance:getStage()

    if stage == 2 then
        local item_list = {
                5365, 5366, 5367, 5368, 5369, 5370, 5371, 5372,
                -- Incus, Castellanus, Cumulus, Radatus, Stratus, Cirrocumulus, Undulatus, Virga
                5373, 5374, 5375,
                -- Duplicatus, Opacus, Praecipitatio
                5376, 5377, 5378, 5379, 5380, 5381, 5382, 
                -- Pannus, Fractus, Congestus, Numbus, Velum, Pileus, Mediocris
                5383, 5384,
                -- Humilus, Spissatus
        }
        for i = 1, 20 do
            if trade:hasItemQty(item_list[i], 1) then
                local itemid = item_list[i]
                player:tradeComplete()
                npc:setStatus(STATUS_DISAPPEAR)
                printf(".. ItemID for traded cell: " .. itemid)
                SpawnMob(Zhayolm.mob[2].poroggo_madame, instance):setPos(npc:getXPos(), npc:getYPos(), npc:getZPos(), 0)
                player:setLocalVar("Salvage-ZhayolmFL2-PTraded-Cell", itemid)
                player:setLocalVar("Salvage-ZhayolmFL2-PoroggoMadame-Spawned", 1)
            else
                printf(".. Invalid item traded to socket.")
            end
        end
    end
end;