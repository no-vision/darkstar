-----------------------------------
-- Area: Zhayolm Remnants
-- NPC:  Armoury_Chest
-- @zone 73
-----------------------------------
package.loaded["scripts/zones/Zhayolm_Remnants/IDs"] = nil
local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")
-----------------------------------
require("scripts/globals/treasure")

function Dec2Hex(dec)
    local bit = 16
    local key = "0123456789ABCDEF"
    local D = 0
    local hex = ""
    while (dec > 0) do
        dec = math.floor(dec / bit)
        D = (math.mod(dec, bit) + 1)
        hex = string.sub(key, D, D) .. hex
    end
    return hex
end;

function Hex2Dec(hex)
end;

function onTrigger(player,npc)
    printf("Zhayolm Remnants: Armoury_Chest.lua onTrigger")

    local tloot_a = {
        4146, -- Revitalizer
        4147, -- Body Boost
        4200, -- Mana Boost
        4254, -- Magalixir
        4255, -- Mana Powder
        5253, -- Hermes quencher
        5322, -- Healing Powder
    }

    local tloot_b = {
        5327, -- Potion drops
        5328, -- Hi-potion drops
        5385, -- Barbarians drink
        5386, -- Fighters drink
        5387, -- Oracles drink
        5388, -- Assassins drink
        5389, -- Spys drink
        5390, -- Bravers drink
        5391, -- Soldiers drinks
        5392, -- Champions drink
        5393, -- Monarchs drink
        5394, -- Gnostics drink
        5395, -- Clerics drink
        5396, -- Shepherds drink
        5397, -- Sprinters drink
    }

    local tloot_c = {
        5431, -- Dusty Potion
        5432, -- Dusty Ether
        5433, -- Dusty Elixir
        5434, -- Fanatics drink
        5435, -- Fools drink
        5436, -- Dusty Reraise Scroll
        5437, -- Strange Milk
        5438, -- Strange Juice
        5439, -- Vicars drink
        5440, -- Dusty Wing
    }

    local lootGroup = npc:getLocalVar("Salvage-TChest-LootGroup")
    local totalFromPool = 0
    local chest_items = {}

    player:startEvent(2, 5431, 0xC0)

    printf(".. LootGroup: " .. lootGroup)
    if (lootGroup == 0) then
        lootGroup = math.random(1, 3)
        npc:setLocalVar("Salvage-TChest-LootGroup", lootGroup)
        -- Generate loot
        switch (lootGroup): caseof
        {
            [1] = function(x)
                totalFromPool = math.random(1, 7) -- Loot pool A
                local lootID = ""
                local lootQty = 0
                chest_items = npc:getLocalVar("Salvage-TChest-LootItem")
                local save = true
                for i = 1, totalFromPool do
                    lootID = tloot_a[math.random(7)]
                    lootQty = math.random(1, math.random(1, 18))
                    printf("Zhayolm Remnants: LootID: " .. lootID .. " | LootQTY: " .. lootQty)
                    --if chest_items ~= nil then
                    --    for _,k in ipairs(chest_items) do
                    --        if (k == lootID) then
                    --            save = false
                    --        end
                    --    end
                    --end
                    if save then
                        npc:setLocalVar("Salvage-TChest-LootItem", lootID)
                        npc:setLocalVar("Salvage-TChest-LootQty", lootQty)
                        --npc:setLocalVar(("Salvage-TChest-LootItem" .. i), lootID)
                    end
                end
            end,
            [2] = function(x)
                totalFromPool = math.random(1, 15) -- Loot pool B
                local lootID = ""
                local lootQty = 0
                chest_items = npc:getLocalVar("Salvage-TChest-LootItem")
                local save = true
                for i = 1, totalFromPool do
                    lootID = tloot_b[math.random(15)]
                    lootQty = math.random(1, math.random(1, 18))
                    printf("Zhayolm Remnants: LootID: " .. lootID .. " | LootQTY: " .. lootQty)
                    --if chest_items ~= nil then
                    --    for _,k in ipairs(chest_items) do
                    --        if (k == lootID) then
                    --            save = false
                    --        end
                    --    end
                    --end
                    if save then
                        npc:setLocalVar("Salvage-TChest-LootItem", lootID)
                        npc:setLocalVar("Salvage-TChest-LootQty", lootQty)
                        --npc:setLocalVar(("Salvage-TChest-LootItem" .. i), lootID)
                    end
                end
            end,
            [3] = function(x)
                totalFromPool = math.random(1, 10) -- Loot pool C
                local lootID = ""
                local lootQty = 0
                chest_items = npc:getLocalVar("Salvage-TChest-LootItem")
                local save = true
                for i = 1, totalFromPool do
                    lootID = tloot_c[math.random(10)]
                    lootQty = math.random(1,math.random(1, 18))
                    printf("Zhayolm Remnants: LootID: " .. lootID .. " | LootQTY: " .. lootQty)
                    --if chest_items ~= nil then
                    --    for _,k in ipairs(chest_items) do
                    --        if (k == lootID) then
                    --            save = false
                    --        end
                    --    end
                    --end
                    if save then
                        npc:setLocalVar("Salvage-TChest-LootItem", lootID)
                        npc:setLocalVar("Salvage-TChest-LootQty", lootQty)
                        --npc:setLocalVar(("Salvage-TChest-LootItem" .. i), lootID)
                    end
                end
            end,
        }
    end

    local LootID = npc:getLocalVar("Salvage-TChest-LootItem")
    local LootQty = npc:getLocalVar("Salvage-TChest-LootQty")
    printf("Zhayolm Remnants: LootID: " .. LootID)
    printf("Zhayolm Remnants: LootQty: " .. LootQty)
    if (LootID ~= 0) then
        local loot = Dec2Hex(LootQty + LootID)
        player:startEvent(2, loot)
    end
end;

function onEventUpdate(player,csid,option)
    --printf("CSID: %u",csid)
    --printf("RESULT: %u",option)
end;

function onEventFinish(player,csid,option)
    --printf("CSID: %u",csid);
    --printf("RESULT: %u",option);

    if csid == 0x02 and option == 1 then
        -- Nothing atm.
    end
end;
