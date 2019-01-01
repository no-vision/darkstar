-----------------------------------
-- Ziz
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(MOBMOD_EXP_BONUS, -100)
    mob:setMobMod(MOBMOD_GIL_BONUS, -100)
    mob:setMod(MOD_WINDRES, -25)
    mob:setMod(MOD_ICERES, -25)
    mob:setMod(MOD_CHARMRES, 95)
end;

function onMobEngaged(mob,target)
    local mobid = mob:getID()
    local itmid = { 5365, 5373, 5374, 5375 } -- Incus, Duplicatus, Opacus, Praecipitatio Cells

    if mobid == 17076243 then
        SetDropRate(4354, itmid[1], 1000)  -- Incus Cell
        SetDropRate(4354, itmid[2], 1000)  -- Duplicatus Cell
        SetDropRate(4354, itmid[3], 0)     -- Opacus Cell
        SetDropRate(4354, itmid[4], 0)     -- Praecipitatio Cell
    elseif mobid == 17076245 then
        SetDropRate(4354, itmid[1], 0)     -- Incus Cell
        SetDropRate(4354, itmid[2], 0)     -- Duplicatus Cell
        SetDropRate(4354, itmid[3], 1000)  -- Opacus Cell
        SetDropRate(4354, itmid[4], 1000)  -- Praecipitatio Cell
    elseif mobid == 17076247 or mobid == 17076248 or
            mobid == 17076251 or mobid == 17076252 or
            mobid == 17076255 or mobid == 17076256 then
            SetDropRate(4354, itmid[1], 0)     -- Incus Cell
            SetDropRate(4354, itmid[2], 0)     -- Duplicatus Cell
            SetDropRate(4354, itmid[3], 0)     -- Opacus Cell
            SetDropRate(4354, itmid[4], 1000)  -- Praecipitatio Cell
    else
        SetDropRate(4354, itmid[1], 0)     -- Incus Cell
        SetDropRate(4354, itmid[2], 0)     -- Duplicatus Cell
        SetDropRate(4354, itmid[3], 0)     -- Opacus Cell
        SetDropRate(4354, itmid[4], 0)     -- Praecipitatio Cell
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
            v:setLocalVar("Salvage-ZhayolmFL1-ZizCount", (v:getLocalVar("Salvage-ZhayolmFL1-ZizCount") + 1))
        end
	    instance:setProgress(progress + 3)
    end
end;