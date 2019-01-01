----------------------------
-- Mamool_Ja_Savant.lua
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
        if mob:getID() == 17076315 then
            SetDropRate(2173, 5370, 1000)
            if (math.random(100) > 50) then
                SetDropRate(2173, 5367, 450)
                SetDropRate(2173, 5372, 450)
            else
                SetDropRate(2173, 5371, 450)
            end
        end
    elseif stage == 4 then
        -- Do nothing atm.
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
    local random = math.random(1, 100)

    if stage == 2 then
        local ne_gate = player:getLocalVar("Salvage-ZhayolmFL2-NEGateUnlock")
        if ne_gate == 1 then
            local chars = instance:getChars()
            for _,v in pairs(chars) do
                v:setLocalVar("Salvage-ZhayolmFL2-SWGateUnlock", 1)
            end
        end
    elseif stage == 3 then
        local chars = instance:getChars();
        for _,v in ipairs(chars) do
            local MjSavant = v:getLocalVar("Salvage-ZhayolmFL3-MjSavantCount")
            v:setLocalVar("Salvage-ZhayolmFL3-MjSavantCount", (MjSavant + 1))
        end
        instance:setProgress(progress + 1)
    end
end;
