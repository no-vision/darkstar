-----------------------------------
-- Area: Zhayolm Remnants
-- NPC:  Armoury_Crate
-- @zone 73
-----------------------------------
package.loaded["scripts/zones/Zhayolm_Remnants/IDs"] = nil
require("scripts/zones/Zhayolm_Remnants/IDs")
-----------------------------------
require("scripts/globals/treasure")

function onTrigger(player, npc)
    printf("Zhayolm Remnants: Armoury_Crate.lua onTrigger")
    player:addTreasure(5365, npc) -- Incus
    player:addTreasure(5365, npc) -- Incus
    player:addTreasure(5373, npc) -- Duplicatus
    player:addTreasure(5374, npc) -- Praecipitatio
    player:addTreasure(5375, npc) -- Opacus
    
    local cell_pool_a = {
        5383, 
        5384,
        5371,
        5367,
    }

    local cell_pool_b = {
        5366,
        5368,
        5369,
        5370,
        5372,
        5376,
        5377,
        5378,
        5379,
        5380,
        5381,
        5382, 
    }

    local cell_pool_c = {
        5374,
        5375, 
    }

    local lootid = 0
    for i=0,(2-1),1 do
	    lootid = cell_pool_a[math.random(1,4)]
        player:addTreasure(lootid, npc)
    end
    lootid = 0
    for i=0,(2-1),1 do
	    lootid = cell_pool_b[math.random(1,12)]
	    player:addTreasure(lootid, npc)
    end
    player:addTreasure(cell_pool_c[math.random(1,2)],npc)

    npc:setAnimation(9)
    npc:AnimationSub(1)
    npc:untargetable(true)
end;

function onEventUpdate(player,csid,option)
    -- printf("CSID: %u",csid)
    -- printf("RESULT: %u",option)
end;

function onEventFinish(player,csid,option)
    -- printf("CSID: %u",csid)
    -- printf("RESULT: %u",option)
end;
