-----------------------------------
-- Wyvern
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(MOBMOD_EXP_BONUS, -100)
    mob:setMobMod(MOBMOD_GIL_BONUS, -100)
    mob:setMod(MOD_FIRERES, 25)
    mob:setMod(MOD_WINDRES, 25)
    mob:setMod(MOD_LIGHT_NULL, 1)
    mob:setMod(MOD_DARKRES, -25)
    mob:setMod(MOD_CHARMRES, 95)
end;

function onMobEngaged(mob,target)
    local mobid = mob:getID()

    if mobid == 17076326 or mobid == 17076329 or
        mobid == 17076330 or mobid == 17076331 then -- NW Wyverns
        SetDropRate(4198, 5366, 1000)
        SetDropRate(4198, 5367, 100)
    elseif mobid == 17076316 or mobid == 17076318 or
            mobid == 17076320 or mobid == 17076322 then -- SW Wyverns
        SetDropRate(4198, 5367, 100)
        SetDropRate(4198, 5369, 1000)
    end
end;

function onMobFight(mob,target)
end;

function onMobDeath(mob,player,isKiller)
    local instance = mob:getInstance()
    local progress = instance:getProgress()
    local stage = instance:getStage()
    local random = math.random(100)

    if stage == 2 then
        local wCount = player:getLocalVar("Salvage-ZhayolmFL2-WyvernKills")
        player:setLocalVar("Salvage-ZhayolmFL2-WyvernKills", (wCount + 1))
        mob:getInstance():setProgress(progress + 4)
    end
end;