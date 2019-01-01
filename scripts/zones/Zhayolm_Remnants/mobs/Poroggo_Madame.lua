-----------------------------------
-- Poroggo Madame
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(MOBMOD_EXP_BONUS, -100)
    mob:setMobMod(MOBMOD_GIL_BONUS, -100)
	mob:setMod(MOD_ICERES, -25)
	mob:setMod(MOD_THUNDERRES, -25)
	mob:setMod(MOD_LULLABYRES, 100)
	mob:setMod(MOD_LIGHTRES, 100)
    mob:setMod(MOD_CHARMRES, 100)
end;

function onMobSpawn(mob)
    local chars = mob:getInstance():getChars()
    local dayEntered = 99
    for _,v in pairs(chars) do
        local dayEntered = v:getVar("Salvage-DayEntered")
    end
    if dayEntered >= 0 and dayEntered <= 7 then
        switch (dayEntered): caseof
        {
            [0] = function(x)
                printf("[Poroggo Madame: Setting Fire Spell Immunity.")
                mob:setMod(MOD_FIRE_NULL, 100)
            end,
            [1] = function(x)
                printf("[Poroggo Madame: Setting Earth Spell Immunity.")
                mob:setMod(MOD_EARTH_NULL, 100)
            end,
            [2] = function(x)
                printf("[Poroggo Madame: Setting Water Spell Immunity.")
                mob:setMod(MOD_WATER_NULL, 100)
            end,
            [3] = function(x)
                printf("[Poroggo Madame: Setting Wind Spell Immunity.")
                mob:setMod(MOD_WIND_NULL, 100)
            end,
            [4] = function(x)
                printf("[Poroggo Madame: Setting Ice Spell Immunity.")
                mob:setMod(MOD_ICE_NULL, 100)
            end,
            [5] = function(x)
                printf("[Poroggo Madame: Setting Thunder Spell Immunity.")
                mob:setMod(MOD_LTNG_NULL, 100)
            end,
            [6] = function(x)
                printf("[Poroggo Madame: Setting Light Spell Immunity.")
                mob:setMod(MOD_LIGHT_NULL, 100)
            end,
            [7] = function(x)
                printf("[Poroggo Madame: Setting Dark Spell Immunity.")
                mob:setMod(MOD_RDEF, 50)
                mob:setMod(MOD_DARK_NULL, 100)
            end,
        }
    end
end;

function onMobEngaged(mob, target)
    local mobid = mob:getID()
    local stage = mob:getInstance():getStage()

    printf("Poroggo Madame ID: " .. mobid)

    if stage == 1 then
        SetDropRate(4900, 14962, 460)  -- Enyo Gauntlets
        SetDropRate(4900, 14978, 460)  -- Nemain's Cuffs
        SetDropRate(4900, 16089, 460)  -- Njord's Mask
        SetDropRate(4900, 15720, 460)  -- Hoshikazu Kyahan
        SetDropRate(4900, 15638, 460)  -- Anus Brias
        SetDropRate(4900, 14561, 0)    -- Enlil'l Gambison
        SetDropRate(4900, 14972, 0)    -- Hikazu Gote
        SetDropRate(4900, 15632, 0)    -- Freya's Trousers
        SetDropRate(4900, 15730, 0)    -- Macha's Pigaches
        SetDropRate(4900, 15714, 0)    -- Deimos's Leggings
        SetDropRate(4900, 16099, 0)    -- Enlil's Tiara
        SetDropRate(4900, 5383, 0)     -- Humilus Cell
        SetDropRate(4900, 5384, 0)     -- Spissatus Cell
        SetDropRate(4900, 5735, 500)   -- Coin Purse
    elseif stage == 2 then
        local chars = mob:getInstance():getChars()
        local tradedCell = 0
        for _,v in pairs(chars) do
            tradedCell = v:getLocalVar("Salvage-ZhayolmFL2-PTraded-Cell")
            if tradedCell >= 5365 and tradedCell <= 5384 then
                for i = 5365, 5384 do
                    if i == tradedCell then
                        printf(".. Poroggo Madame -- Set Cell to Drop")
                        SetDropRate(4900, tradedCell, 1000)
                    else
                        SetDropRate(4900, i, 0)
                    end
                end
            end
        end
        if tradedCell == 0 then
            printf(".. Poroggo Madame engaged but didn't get cell to drop from a player")
        end
    elseif stage == 3 then
        local thirdFloorMadame = target:getLocalVar("Salvage-ZhayolmFL3-Madame")
        if mobid == 17076411 then
            if thirdFloorMadame == 1 then -- North Madame
                SetDropRate(4900, 14962, 1000) -- Enyo Gauntlets
                SetDropRate(4900, 14978, 1000) -- Nemain's Cuffs
                SetDropRate(4900, 16089, 0)    -- Njord's Mask
                SetDropRate(4900, 15720, 0)    -- Hoshikazu Kyahan
                SetDropRate(4900, 15638, 0)    -- Anus Brias
                SetDropRate(4900, 14561, 0)    -- Enlil'l Gambison
                SetDropRate(4900, 14972, 0)    -- Hikazu Gote
                SetDropRate(4900, 15632, 0)    -- Freya's Trousers
                SetDropRate(4900, 15730, 0)    -- Macha's Pigaches
                SetDropRate(4900, 15714, 0)    -- Deimos's Leggings
                SetDropRate(4900, 16099, 0)    -- Enlil's Tiara
                SetDropRate(4900, 5383, 0)     -- Humilus Cell
                SetDropRate(4900, 5384, 0)     -- Spissatus Cell
                SetDropRate(4900, 5735, 0)     -- Coin Purse
            elseif thirdFloorMadame == 2 then
                SetDropRate(4900, 14962, 0)    -- Enyo Gauntlets
                SetDropRate(4900, 14978, 0)    -- Nemain's Cuffs
                SetDropRate(4900, 16089, 0)    -- Njord's Mask
                SetDropRate(4900, 15720, 0)    -- Hoshikazu Kyahan
                SetDropRate(4900, 15638, 0)    -- Anus Brias
                SetDropRate(4900, 14561, 0)    -- Enlil'l Gambison
                SetDropRate(4900, 14972, 0)    -- Hikazu Gote
                SetDropRate(4900, 15632, 0)    -- Freya's Trousers
                SetDropRate(4900, 15730, 0)    -- Macha's Pigaches
                SetDropRate(4900, 15714, 0)    -- Deimos's Leggings
                SetDropRate(4900, 16099, 0)    -- Enlil's Tiara
                SetDropRate(4900, 5383, 980)   -- Humilus Cell
                SetDropRate(4900, 5384, 980)   -- Spissatus Cell
                SetDropRate(4900, 5735, 0)     -- Coin Purse
            end
        end
    elseif stage == 4 then
        if mobid == 17076486 then
            SetDropRate(4900, 14962, 0)    -- Enyo Gauntlets
            SetDropRate(4900, 14978, 0)    -- Nemain's Cuffs
            SetDropRate(4900, 16089, 1000) -- Njord's Mask
            SetDropRate(4900, 15720, 1000) -- Hoshikazu Kyahan
            SetDropRate(4900, 15638, 1000) -- Anus Brias
            SetDropRate(4900, 14561, 0)    -- Enlil'l Gambison
            SetDropRate(4900, 14972, 0)    -- Hikazu Gote
            SetDropRate(4900, 15632, 0)    -- Freya's Trousers
            SetDropRate(4900, 15730, 0)    -- Macha's Pigaches
            SetDropRate(4900, 15714, 0)    -- Deimos's Leggings
            SetDropRate(4900, 16099, 0)    -- Enlil's Tiara
            SetDropRate(4900, 5383, 0)     -- Humilus Cell
            SetDropRate(4900, 5384, 0)     -- Spissatus Cell
            SetDropRate(4900, 5735, 500)   -- Coin Purse
        end
    elseif stage == 5 then
        SetDropRate(4900, 14962, 0)    -- Enyo Gauntlets
        SetDropRate(4900, 14978, 0)    -- Nemain's Cuffs
        SetDropRate(4900, 16089, 0)    -- Njord's Mask
        SetDropRate(4900, 15720, 0)    -- Hoshikazu Kyahan
        SetDropRate(4900, 15638, 0)    -- Anus Brias
        SetDropRate(4900, 14561, 84)   -- Enlil'l Gambison
        SetDropRate(4900, 14972, 74)   -- Hikazu Gote
        SetDropRate(4900, 15632, 84)   -- Freya's Trousers
        SetDropRate(4900, 15730, 0)    -- Macha's Pigaches
        SetDropRate(4900, 15714, 0)    -- Deimos's Leggings
        SetDropRate(4900, 16099, 0)    -- Enlil's Tiara
        SetDropRate(4900, 5383, 0)     -- Humilus Cell
        SetDropRate(4900, 5384, 0)     -- Spissatus Cell
        SetDropRate(4900, 5735, 980)   -- Coin Purse
    elseif stage == 6 then
        SetDropRate(4900, 14962, 0)    -- Enyo Gauntlets
        SetDropRate(4900, 14978, 0)    -- Nemain's Cuffs
        SetDropRate(4900, 16089, 0)    -- Njord's Mask
        SetDropRate(4900, 15720, 0)    -- Hoshikazu Kyahan
        SetDropRate(4900, 15638, 0)    -- Anus Brias
        SetDropRate(4900, 14561, 0)    -- Enlil'l Gambison
        SetDropRate(4900, 14972, 0)    -- Hikazu Gote
        SetDropRate(4900, 15632, 0)    -- Freya's Trousers
        SetDropRate(4900, 15730, 81)   -- Macha's Pigaches
        SetDropRate(4900, 15714, 121)  -- Deimos's Leggings
        SetDropRate(4900, 16099, 71)   -- Enlil's Tiara
        SetDropRate(4900, 5383, 0)     -- Humilus Cell
        SetDropRate(4900, 5384, 0)     -- Spissatus Cell
        SetDropRate(4900, 5735, 803)   -- Coin Purse
    end
end;

function onMobFight(mob,target)
end;

function onMobDeath(mob,player,isKiller)
end;