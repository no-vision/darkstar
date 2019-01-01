-----------------------------------
-- Puk
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(MOBMOD_EXP_BONUS, -100)
    mob:setMobMod(MOBMOD_GIL_BONUS, -100)
    mob:setMod(MOD_WIND_ABSORB, 100)
    mob:setMod(MOD_DRAGON_KILLER, -25)
    mob:setMod(MOD_CHARMRES, 95)
end;

function onMobEngaged(mob,target)
    local mobid = mob:getID()
    local itmid = { 5365, 5373, 5374, 5375 } -- Incus, Duplicatus, Opacus, Praecipitatio Cells

    if mobid == 17076228 then
        SetDropRate(2863, itmid[1], 1000)  -- Incus Cell
        SetDropRate(2863, itmid[2], 1000)  -- Duplicatus Cell
        SetDropRate(2863, itmid[3], 0)     -- Opacus Cell
        SetDropRate(2863, itmid[4], 0)     -- Praecipitatio Cell
    elseif mobid == 17076226 then
        SetDropRate(2863, itmid[1], 0)     -- Incus Cell
        SetDropRate(2863, itmid[2], 0)     -- Duplicatus Cell
        SetDropRate(2863, itmid[3], 1000)  -- Opacus Cell
        SetDropRate(2863, itmid[4], 1000)  -- Praecipitatio Cell
    elseif mobid == 17076229 or mobid == 17076230 or
            mobid == 17076233 or mobid == 17076234 or
            mobid == 17076237 or mobid == 17076238 then
            SetDropRate(2863, itmid[1], 1000)  -- Incus Cell
            SetDropRate(2863, itmid[2], 0)     -- Duplicatus Cell
            SetDropRate(2863, itmid[3], 0)     -- Opacus Cell
            SetDropRate(2863, itmid[4], 0)     -- Praecipitatio Cell
    else
        SetDropRate(2863, itmid[1], 0)     -- Incus Cell
        SetDropRate(2863, itmid[2], 0)     -- Duplicatus Cell
        SetDropRate(2863, itmid[3], 0)     -- Opacus Cell
        SetDropRate(2863, itmid[4], 0)     -- Praecipitatio Cell
    end
end;

function onMobFight(mob,target)
end;

function onMagicHit(caster,target,spell)
    local dayElem = VanadielDayElement()
    local spellElem = spell:getElement()

    if dayElem == spellElem then
        if math.random(100) >= 35 then
            target:setTP(target:getTP() + 1000)
        end
        if spellElem == WINDSDAY and caster:isPC() then
            target:setHP(target:getHP())
        end
    end
    return 1
end;

function onMobDeath(mob,player,isKiller)
    local instance = mob:getInstance()
    local progress = instance:getProgress()
    local stage = instance:getStage()
    local chars = instance:getChars()
    local random = math.random(100)

    if stage == 1 then
        for _,v in pairs(chars) do
            v:setLocalVar("Salvage-ZhayolmFL1-PukCount", (v:getLocalVar("Salvage-ZhayolmFL1-PukCount") + 1))
        end
        instance:setProgress(progress + 1)
    end
end;