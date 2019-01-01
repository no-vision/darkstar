----------------------------
-- Fourth_Rampart.lua
----------------------------
local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")

function onMobInitialize(mob)
    mob:setMobMod(MOBMOD_EXP_BONUS, -100)
    mob:setMobMod(MOBMOD_GIL_BONUS, -100)
    mob:setMobMod(MOBMOD_NO_MOVE, 1)
    mob:setMod(MOD_ICERES, -25)
end;

function onMobEngaged(mob, target)
    mob:setMobMod(MOBMOD_NO_MOVE, 0)
end;

function onMobEngaged(mob,target)
	local instance = mob:getInstance()
    local stage = instance:getStage()

	if stage == 4 then
		local flEvent = target:getLocalVar("Salvage-FloorEventID")
		for id = Zhayolm.mob[4][flEvent-199].rampart_start, Zhayolm.mob[4][flEvent-199].rampart_end do
			if id ~= mob:getID() then
                DespawnMob(id, instance)
            else
				printf(".. Resetting killed Rampart reset time.")
				mob:setRespawnTime(0, true)
			end
		end
    end
    mob:setRespawnTime(0, true)
end;

function onMobDeath(mob,player,isKiller)
    local instance = mob:getInstance()
    local stage = instance:getStage()
    local progress = instance:getProgress()

    if stage == 4 then
        local dayEntered = player:getVar("Salvage-DayEntered")
        printf("Day Entered: " .. dayEntered)

        if dayEntered >= 6 and dayEntered <= 7 then
            printf("Debug]: Success! Day check passed Light/Dark | Setting pass to 1")
			player:setLocalVar("Salvage-ZhayolmFL4-Pass", 1)
        else
            printf("[Debug]: Failed day check: Light/Dark | Setting pass to 10")
			player:setLocalVar("Salvage-ZhayolmFL4-Pass", 10)
        end
	end
	instance:setProgress(10)
end;