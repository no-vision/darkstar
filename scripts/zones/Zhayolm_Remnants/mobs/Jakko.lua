----------------------------
-- Jakko.lua
----------------------------
local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")

function onMobInitialize(mob)
    mob:setMobMod(MOBMOD_EXP_BONUS, -100)
    mob:setMobMod(MOBMOD_GIL_BONUS, -100)
    mob:setMod(MOD_FIRERES, -25)
    mob:setMod(MOD_LIGHTRES, -25)
    mob:setMod(MOD_PIERCERES, -25)
    mob:setMod(MOD_DARKRES, 25)
    mob:setMod(MOD_MDEF, 75)
    mob:setMod(MOD_MEVA, 25)
    mob:setMod(MOD_DEF, -5)
    mob:setMod(MOD_VIT, -10)

    local chars = mob:getInstance():getChars()
    for _,v in pairs(chars) do
        if v:getLocalVar("Salvage-ZhayolmFL2-Jakko-Spawned") == 1 then
            GetMobByID(17076335, instance):updateEnmity(v)
            break
        end
    end
end;

function onMobEngaged(mob, target)
end;

function onMobFight(mob, target)
end;

function onMagicPrecast(mob, target, spell)
end;

function onMagicHit(caster, target, spell)
    return 1
end;

function onMobDeath(mob, player, isKiller)
    local instance = mob:getInstance()
    local stage = instance:getStage()
    local chars = instance:getChars()

    if stage == 2 then
        for _,v in pairs(chars) do
            v:setLocalVar("Salvage-ZhayolmFL2-Jakko-Dead", 1)
        end
    end
end;