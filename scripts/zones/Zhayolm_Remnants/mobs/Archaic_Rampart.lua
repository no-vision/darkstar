----------------------------
-- Archaic_Rampart.lua
----------------------------
local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")

function onMobInitialize(mob)
    mob:setMobMod(MOBMOD_EXP_BONUS, -100)
    mob:setMobMod(MOBMOD_GIL_BONUS, -100)
    mob:setMobMod(MOBMOD_NO_MOVE, 1)
    mob:setMod(MOD_ICERES, -25)
end;

function onMobEngaged(mob, target)
    mob:setMobMod(MOBMOD_NO_MOVE, 0)
end;

function onMobFight(mob, target)
end;

function onMagicPrecast(mob, target, spell)
end;

function onMagicHit(caster, target, spell)
    return 1;
end;

function onMobDeath(mob, player, isKiller)
    local instance = mob:getInstance()
    local stage = instance:getStage()
    local progress = instance:getProgress()
    local random = math.random(100)

    if stage == 3 then
        local chars = instance:getChars()
        for _,v in ipairs(chars) do
            v:setLocalVar("Salvage-ZhayolmFL3-ARampartCount", (v:getLocalVar("Salvage-ZhayolmFL3-ARampartCount") + 1))
        end
        instance:setProgress(progress + 1)
    end
end;