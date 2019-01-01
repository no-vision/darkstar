-----------------------------------
-- Bull Bugard
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(MOBMOD_EXP_BONUS, -100)
    mob:setMobMod(MOBMOD_GIL_BONUS, -100)
    mob:setMod(MOD_ICERES, -25)
    mob:setMod(MOD_CHARMRES, 95)
end;

function onMobEngaged(mob,target)
    local mobid = mob:getID()
    local itmid = { 5365, 5373, 5374, 5375, } -- Incus, Duplicatus, Opacus, Praecipitatio Cells

    if mobid == 17076279 then
        SetDropRate(427, itmid[1], 1000)  -- Incus Cell
        SetDropRate(427, itmid[2], 1000)  -- Duplicatus Cell
        SetDropRate(427, itmid[3], 0)     -- Opacus Cell
        SetDropRate(427, itmid[4], 0)     -- Praecipitatio Cell
    elseif mobid == 17076281 then
        SetDropRate(427, itmid[1], 0)     -- Incus Cell
        SetDropRate(427, itmid[2], 0)     -- Duplicatus Cell
        SetDropRate(427, itmid[3], 1000)  -- Opacus Cell
        SetDropRate(427, itmid[4], 1000)  -- Praecipitatio Cell
    elseif mobid == 17076283 or mobid == 17076284 or
            mobid == 17076287 or mobid == 17076288 or
            mobid == 17076291 or mobid == 17076292 then
            SetDropRate(427, itmid[1], 0)     -- Incus Cell
            SetDropRate(427, itmid[2], 1000)  -- Duplicatus Cell
            SetDropRate(427, itmid[3], 0)     -- Opacus Cell
            SetDropRate(427, itmid[4], 0)     -- Praecipitatio Cell
    else
        SetDropRate(427, itmid[1], 0)     -- Incus Cell
        SetDropRate(427, itmid[2], 0)     -- Duplicatus Cell
        SetDropRate(427, itmid[3], 0)     -- Opacus Cell
        SetDropRate(427, itmid[4], 0)     -- Praecipitatio Cell
    end
end;

function onMobFight(mob,target)
end;

function onMobDeath(mob,player,isKiller)
    local instance = mob:getInstance()
    local progress = instance:getProgress()
    local stage = instance:getStage()
    local chars = instance:getChars()
    local random = math.random(100)

    if stage == 1 then
        for _,v in pairs(chars) do
            v:setLocalVar("Salvage-ZhayolmFL1-BugardCount", (v:getLocalVar("Salvage-ZhayolmFL1-BugardCount") + 1))
        end
	    instance:setProgress(progress + 7)
    end
end;
