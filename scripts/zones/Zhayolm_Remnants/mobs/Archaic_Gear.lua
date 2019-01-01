----------------------------
-- Archaic_Gear.lua
----------------------------
local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")

function onMobInitialize(mob)
    mob:setMobMod(MOBMOD_EXP_BONUS, -100);
    mob:setMobMod(MOBMOD_GIL_BONUS, -100);
    mob:setMod(MOD_ICERES, -25);
    mob:setMod(MOD_THUNDERRES, 25);
end;

function onMobEngaged(mob, target)
end;

function onMobFight(mob, target)
    local gearSkills = { 2038, 2039, 2040, 2041, 2042, 2043, 2044 }
    local skillToUseChoice = math.random(1, 7)
    local skillUseRate = mob:getLocalVar("Salvage-ZhayolmR-SkillUseRate")
    local skillToUse = gearSkills[skillToUseChoice]

    local mobTP = mob:getTP()
    printf("[Zhayolm Remnants: mobTP: " .. mobTP .. " at a skillUseRate: " .. skillUseRate)
    if mobTP >= skillUseRate then
        useMobAbility(skillToUse)
    end
end;

function onMagicHit(caster, target, spell)
    return 1
end;

function onMobDeath(mob, player, isKiller)
    local instance = mob:getInstance()
    local stage = instance:getStage()
    local chars = instance:getChars()
    local random = math.random(100)

    if stage == 6 then
        local gCount = player:getLocalVar("Salvage-ZhayolmFL6-GearsKilled")
        for _,v in pairs(chars) do
            v:setLocalVar("Salvage-ZhayolmFL6-GearsKilled", (gCount + 1))
        end
    end
end;