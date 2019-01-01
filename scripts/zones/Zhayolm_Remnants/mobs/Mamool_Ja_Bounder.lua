----------------------------
-- Mamool_Ja_Bounder.lua
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
        if mob:getID() == 17076324 then
            SetDropRate(2155, 5366, 1000)
            SetDropRate(2155, 5367, 450)
        end
    end
end;

function onMobFight(mob, target)
end;

function onMagicHit(caster, target, spell)
    return 1;
end;

function onMobDeath(mob, player, isKiller)
    local instance = mob:getInstance()
    local stage = instance:getStage()
    local progress = instance:getProgress()
    local random = math.random(1, 100)

    if stage == 3 then
        local chars = instance:getChars()
        for _,v in ipairs(chars) do
            local MjBounder = v:getLocalVar("Salvage-ZhayolmFL3-MjBounderCount")
            v:setLocalVar("Salvage-ZhayolmFL3-MjBounderCount", (MjBounder + 1))
        end
        instance:setProgress(progress + 1)
    end
end;
