-----------------------------------
-- Draco Lizard
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(MOBMOD_EXP_BONUS, -100)
    mob:setMobMod(MOBMOD_GIL_BONUS, -100)
    mob:setMod(MOD_ICERES, -25)
    mob:setMod(MOD_WINDRES, -25)
    mob:setMod(MOD_CHARMRES, 95)
end;

function onMobEngaged(mob,target)
    local mobid = mob:getID()

    if mobid == 17076299 or mobid == 17076301 or
        mobid == 17076302 or mobid == 17076304 then -- NE Dracos
        SetDropRate(784, 5367, 100)
        SetDropRate(784, 5370, 1000)
        SetDropRate(784, 5371, 450)
        SetDropRate(784, 5372, 450)
    elseif mobid == 17076308 or mobid == 17076310 or
            mobid == 17076311 or mobid == 17076313 then -- SE Dracos
        SetDropRate(784, 5367, 100)
        SetDropRate(784, 5368, 1000)
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
        local dCount = player:getLocalVar("Salvage-ZhayolmFL2-DracoKills")
        player:setLocalVar("Salvage-ZhayolmFL2-DracoKills", (dCount + 1))
        mob:getInstance():setProgress(progress + 3)
    end
end;
