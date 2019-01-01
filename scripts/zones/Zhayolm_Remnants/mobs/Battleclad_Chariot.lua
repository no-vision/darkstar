-----------------------------------
-- Area: Zhayolm Remnants
-- MOB : Battleclad Chariot
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")

-----------------------------------
-- onMobInitialize
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(MOBMOD_NO_MOVE, 1)
end;

function onMobEngaged(mob, target)
    mob:setLocalVar("Salvage-ZhayolmR-SkillUseRate", math.random(100, 300))
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

function onMobFight(mob, target)
    if mob:getMobMod(MOBMOD_NO_MOVE) then
        mob:setMobMod(MOBMOD_NO_MOVE, 0)
    end

    local chariotSkills = { 2054, 2055, 2056, 2057, 2059, 2060 }
    local skillToUseChoice = math.random(1, 5)
    local skillUseRate = mob:getLocalVar("Salvage-ZhayolmR-SkillUseRate")
    local skillToUse = chariotSkills[skillToUseChoice]

    local mobTP = mob:getTP()
    printf("[Zhayolm Remnants: mobTP: " .. mobTP .. " at a skillUseRate: " .. skillUseRate)
    if mobTP >= skillUseRate then
        mob:useMobAbility(skillToUse)
    end
end;

function onMobDeath(mob,player,isKiller)
    player:addTitle(STAR_CHARIOTEER)
    player:setLocalVar("Salvage-ZhayolmR-Completed", 1)
end;
