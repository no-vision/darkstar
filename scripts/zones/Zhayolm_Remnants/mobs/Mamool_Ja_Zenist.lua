----------------------------
-- Mamool_Ja_Zenist.lua
----------------------------
local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")

function onMobInitialize(mob)
    mob:setMobMod(MOBMOD_EXP_BONUS, -100)
    mob:setMobMod(MOBMOD_GIL_BONUS, -100)
    mob:setMod(MOD_ICERES, -25)
    mob:setMod(MOD_CHARMRES, 100)
end;

function onMobEngaged(mob, target)
    local stage = mob:getInstance():getStage()

    if stage == 2 then
        if mob:getID() == 17076306 then
            SetDropRate(2183, 5367, 450)
            SetDropRate(2183, 5368, 1000)
        end
    elseif stage == 3 then
        local item_list = { 5376, 5377, 5378, 5379, 5380, 5381, 5382 }
        local itemid = item_list[math.random(1, 7)]
        SetDropRate(2183, itemid, 1000)
    end
end;

function onMobFight(mob, target)
end;

function onMagicHit(caster, target, spell)
    return 1
end;

function onMobDeath(mob, player, isKiller)
    local instance = mob:getInstance()
    local stage = instance:getStage()
    local progress = instance:getProgress()
    local random = math.random(100)

    if stage == 2 then
        local ne_gate = player:getLocalVar("Salvage-ZhayolmFL2-NEGateUnlock")
        local sw_gate = player:getLocalVar("Salvage-ZhayolmFL2-SWGateUnlock")
        local se_gate = player:getLocalVar("Salvage-ZhayolmFL2-SEGateUnlock")
        if ne_gate + sw_gate + se_gate == 3 then
            local chars = instance:getChars()
            for _,v in ipairs(chars) do
                v:setLocalVar("Salvage-ZhayolmFL2-NWGateUnlock", 1)
            end
        end
    elseif stage == 3 then
        local chars = instance:getChars()
        for _,v in ipairs(chars) do
            local MjZenist = v:getLocalVar("Salvage-ZhayolmFL3-MjZenistCount")
            v:setLocalVar("Salvage-ZhayolmFL3-MjZenistCount", (MjZenist + 1))
        end
        instance:setProgress(progress + 1)
    end
end;
