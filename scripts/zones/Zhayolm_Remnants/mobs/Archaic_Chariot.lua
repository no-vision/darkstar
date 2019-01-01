----------------------------
-- Archaic_Chariot.lua
----------------------------
local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")

function onMobInitialize(mob)
    mob:setMobMod(MOBMOD_NO_MOVE, 1)
    mob:setMobMod(MOBMOD_EXP_BONUS, -100)
    mob:setMobMod(MOBMOD_GIL_BONUS, -100)
    mob:setMod(MOD_ICERES, -25)
    mob:setLocalVar("Chariot-Gear-Spawned", 0)
end;

function onMobEngaged(mob, target)
    if mob:getMobMod(MOBMOD_NO_MOVE) then
        mob:setMobMod(MOBMOD_NO_MOVE, 0)
    end

    local instance = mob:getInstance()
    local stage = instance:getStage()
    
    if stage == 6 then
        if (mob:getLocalVar("Chariot-Gear-Spawned") == 0) then
            SpawnMob(Zhayolm.mob[6].gear_one, instance):updateEnmity(target)
            SpawnMob(Zhayolm.mob[6].gear_two, instance):updateEnmity(target)
            mob:setLocalVar("Chariot-Gear-Spawned", 1)
        end
        for id = Zhayolm.mob[6].gears_start, Zhayolm.mob[6].gears_end do
            printf(".. Spawning Mob: " .. id)
            SpawnMob(id, instance)
        end
    end
end;

----------------------------
-- onMobFight
----------------------------
function onMobFight(mob, target)
    local chariotSkills = { 2054, 2055, 2056, 2057 }
    local skillToUseChoice = math.random(1, 4)
    local skillUseRate = mob:getLocalVar("Salvage-ZhayolmR-SkillUseRate")
    local skillToUse = chariotSkills[skillToUseChoice]

    local mobTP = mob:getTP()
    printf("[Zhayolm Remnants: mobTP: " .. mobTP .. " at a skillUseRate: " .. skillUseRate)
    if mobTP >= skillUseRate then
        useMobAbility(skillToUse)
    end
end;

function onMagicPrecast(mob, target, spell)
end;

function onMagicHit(caster, target, spell)
    if caster:isPC() or caster:isPet() then
        if spell:getID() == 252 then -- Stun spell
            local prevSR = target:getLocalVar("Chariot-StunResist")
            if prevSR < 10 then
                target:setLocalVar("Chariot-StunResist", (prevSR + 1))
                target:setMod(MOD_STUNRES, (prevSR * 10))
            else
                return 0
            end
        end
    end
    return 1
end;

function onMobDeath(mob, player, isKiller)
    local instance = mob:getInstance()
    local stage = instance:getStage()
    local chars = instance:getChars()
    local random = math.random(100)

    if stage == 6 then
        for _,v in pairs(chars) do
            v:setLocalVar("Salvage-ZhayolmFL6-ChariotDead", 1)
        end
    end
end;