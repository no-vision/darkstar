-----------------------------------
-- Salvage: Zhayolm Remnants
-- Pos	  :
-----------------------------------
package.loaded["scripts/zones/Zhayolm_Remnants/TextIDs"] = nil
local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/status")

function onRegionEnter(player, region)
	printf("Zhayolm Remnants: onRegionEnter(): Initiated by player: " .. player:getName())
	local instance = player:getInstance()
	local stage = instance:getStage()
	local eventId = (region:GetRegionID() + 199)
	local completed = player:getLocalVar("Salvage-ZhayolmR-Completed")

	if eventId == 211 and completed == 1 then
		player:startEvent(211)
	else
		printf(".. Calling event: " .. eventId .. " | stage: " .. stage)
		--ZhayolmR_Transport_Portal_Locked = 0
		if ZhayolmR_Transport_Portal_Locked == 0 then
			-- No one has activated the portal.
			local floorId = player:getLocalVar("Salvage-FloorEventID")
			local stage = instance:getStage()
			local passReceived = player:getLocalVar("Salvage-ZhayolmFL4-Pass")

			if (stage >= 1 and stage <= 3) or (stage >= 5 and stage <= 7) then
				printf("Zhayolm Remnants: onRegionEnter(): Stage 1, 2, 3, 5, 6, 7 events called.")
				player:startEvent(eventId)
			elseif stage == 4 and passReceived == 1 then
				printf("Zhayolm Remnants: onRegionEnter(): Stage 4 successful rampart called.")
				player:startEvent(eventId);
			elseif stage == 4 and passReceived == 10 then
				printf("Zhayolm Remnants: onRegionEnter(): Stage 4 unsuccessful rampart called.")
				player:startEvent(floorId);
				loadSalvageFloorByMobGroup(instance, Zhayolm.mob[stage][floorId-199].rampart_start, Zhayolm.mob[stage][floorId-199].rampart_end)
				--for id = Zhayolm.mobs[stage][fEID-199].rampart_start, Zhayolm.mobs[stage][fEID-199].rampart_end do
				--	SpawnMob(id, instance);
				--end
				instance:setProgress(0)
			else
				printf("Zhayolm Remnants: onRegionEnter(): Stage 4: Device doesn't respond message sent.")
				player:messageSpecial(Zhayolm.text.DEVICE_DOESNT_RESPOND)
				return
			end
			--player:startEvent(eventId);
			ZhayolmR_Transport_Portal_Locked = 1
		else
			printf("Zhayolm Remnants: onRegionEnter(): Device doesn't respond message sent.")
			player:messageSpecial(Zhayolm.text.DEVICE_DOESNT_RESPOND)
		end
	end
end;

function onInstanceCreated(instance)
    printf("Zhayolm Remnants: onInstanceCreated()")

	-- Globals
	DespawnTime = os.time()
	ZhayolmR_Number_Player = 0
		-- Event Zones
	ZhayolmR_Floor1_Loaded = 0
	ZhayolmR_Floor2_Loaded = 0
	ZhayolmR_Floor3_Loaded = 0
	ZhayolmR_Floor4_Loaded = 0
	ZhayolmR_Floor4_Respawn = 0
	ZhayolmR_Floor5_Loaded = 0
	ZhayolmR_Floor6_Loaded = 0
	ZhayolmR_Floor7_Loaded = 0
		-- Special Mobs
	ZhayolmR_FL1_Poroggo_Gent = 0
	ZhayolmR_FL2_NE_MamoolJa = 0
	ZhayolmR_FL2_SE_MamoolJa = 0
	ZhayolmR_FL2_NW_MamoolJa = 0
	ZhayolmR_FL2_SW_MamoolJa = 0
	ZhayolmR_FL2_Jakko = 0
		-- Poroggo Madames
	ZhayolmR_FL1_Poroggo_Madame = 0
	ZhayolmR_FL2_Poroggo_Madame = 0
	ZhayolmR_FL3_Poroggo_Madame = 0
	ZhayolmR_FL4_Poroggo_Madame = 0
	ZhayolmR_FL5_Poroggo_Madame = 0
	ZhayolmR_FL6_Poroggo_Madame = 0
		-- Archaic Chariots
	ZhayolmR_FL5_Archaic_Chariot = 0
	ZhayolmR_FL6_Archaic_Chariot = 0
	ZhayolmR_FL7_Battleclad_Chariot = 0

	ZhayolmR_Transport_Portal_Locked = 0
end;

function afterInstanceRegister(player)
    printf("Zhayolm Remnants: afterInstanceRegister()")
    local instance = player:getInstance()

    player:messageSpecial(Zhayolm.text.TIME_TO_COMPLETE, instance:getTimeLimit())
	player:messageSpecial(Zhayolm.text.SALVAGE_START, 1)
	-- Remove status effects except Signet or Sanction.
	if player:getVar("GodMode") == 0 then
		for status = 2, 801 do -- 2, 801
			if player:hasStatusEffect(status) then
				--printf(".. Removing status effect: " .. status)
				if status ~= dsp.effect.SIGNET and status ~= dsp.effect.SANCTION and
					status ~= dsp.effect.RERAISE and status ~= dsp.effect.FOOD then -- 253, 256, 113
					player:delStatusEffect(status)
				end
			end
		end
	end
	--
	-- Salvage survivable variables reset
	player:setVar("Salvage-EncumbranceI-Removed", 0)
	player:setVar("Salvage-EncumbranceI-Power", 0xFFFF)
		--
	player:setVar("Salvage-Obliviscence-Removed", 0)
	player:setVar("Salvage-Obliviscence-Power", 0)
		--
	player:setVar("Salvage-Omerta-Removed", 0)
	player:setVar("Salvage-Omerta-Power", 0)
		--
	player:setVar("Salvage-Impairment-Removed", 0)
	player:setVar("Salvage-Impairment-Power", 0)
		--
	player:setVar("Salvage-Debilitation-Removed", 0)
	player:setVar("Salvage-Debilitation-Power", 0x1FF)
	-- Zhayolm Remnants specific variables reset
	player:setVar("Salvage-ZhayolmFL1-CellUsed", 0)
	--player:setVar("Salvage-ZhayolmFL1-PoroggoMadame", 0)

	player:addStatusEffectEx(dsp.effect.ENCUMBRANCE_I, dsp.effect.ENCUMBRANCE_I, 0xFFFF, 0, 0)
	player:addStatusEffectEx(dsp.effect.OBLIVISCENCE, dsp.effect.OBLIVISCENCE, 0, 0, 0)
	player:addStatusEffectEx(dsp.effect.OMERTA, dsp.effect.OMERTA, 0, 0, 0)
	player:addStatusEffectEx(dsp.effect.IMPAIRMENT, dsp.effect.IMPAIRMENT, 0, 0, 0)
	player:addStatusEffectEx(dsp.effect.DEBILITATION, dsp.effect.DEBILITATION, 0x1FF, 0, 0)
    for i = 0,15 do
        player:unequipItem(i)
	end

	player:setLocalVar("Salvage-ZhayolmFL4-Pass", 99)

	player:setHP(10000)
	player:setMP(10000)
	player:setTP(0)
	ZhayolmR_Number_Player = ZhayolmR_Number_Player + 1
end;

function onInstanceComplete(instance)
    printf("Zhayolm Remnants: onInstanceComplete() .. MISSION SUCCESS!")
    local chars = instance:getChars()
	for _,v in pairs(chars) do
		v:setVar("Salvage-LAT-VanaYear", VanadielYear())
		v:setVar("Salvage-LAT-VanaDay", VanadielDayOfTheYear())
		v:setVar("Salvage-InstanceId", 0)
		v:setPos(-580, 0, -460, 63, 72)
    end
end;

function onInstanceFailure(instance)
    printf("Zhayolm Remnants: onInstanceFailure() .. MISSION FAILED!")
    local chars = instance:getChars()
	for _,v in pairs(chars) do
		v:release()
		v:messageSpecial(Zhayolm.text.MISSION_FAILED)
		v:setVar("Salvage-LAT-VanaYear", VanadielYear())
		v:setVar("Salvage-LAT-VanaDay", VanadielDayOfTheYear())
		v:setPos(-580, 0, -460, 63, 72)
    end
end;

function onInstanceTimeUpdate(instance, elapsed)
	-- updateInstanceTime(instance, elapsed, Zhayolm.text)
    local lastTimeUpdate = instance:getLastTimeUpdate()
    local timeRemaining = ((instance:getTimeLimit() * 60) - (elapsed / 1000))
    local timeWipe = instance:getWipeTime()
	local msgTime = 0

	local stage = instance:getStage()
	local chars = instance:getChars()

	for _,v in pairs(chars) do
		if not v:hasStatusEffect(dsp.effect.ENCUMBRANCE_I) and v:getVar("Salvage-EncumbranceI-Removed") == 0 then
			v:addStatusEffectEx(dsp.effect.ENCUMBRANCE_I, dsp.effect.ENCUMBRANCE_I, v:getVar("Salvage-EncumbranceI-Power"), 0, 0)
		end
		if not v:hasStatusEffect(dsp.effect.OBLIVISCENCE) and v:getVar("Salvage-Obliviscence-Removed") == 0 then
			v:addStatusEffectEx(dsp.effect.OBLIVISCENCE, dsp.effect.OBLIVISCENCE, v:getVar("Salvage-Obliviscence-Power"), 0, 0)
		end
		if not v:hasStatusEffect(dsp.effect.OMERTA) and v:getVar("Salvage-Omerta-Removed") == 0 then
			v:addStatusEffectEx(dsp.effect.OMERTA, dsp.effect.OMERTA, v:getVar("Salvage-Omerta-Power"), 0, 0)
		end
		if not v:hasStatusEffect(dsp.effect.IMPAIRMENT) and v:getVar("Salvage-Impairment-Removed") == 0 then
			v:addStatusEffectEx(dsp.effect.IMPAIRMENT, dsp.effect.IMPAIRMENT, v:getVar("Salvage-Impairment-Power"), 0, 0)
		end
		if not v:hasStatusEffect(dsp.effect.DEBILITATION) and v:getVar("Salvage-Debilitation-Removed") == 0 then
			v:addStatusEffectEx(dsp.effect.DEBILITATION, dsp.effect.DEBILITATION, v:getVar("Salvage-Debilitation-Power"), 0, 0)
		end
	end

    if timeRemaining < 0 then
		instance:fail()
		return
	end

    if timeWipe == 0 then
		local wipe = true
		for _,v in pairs(chars) do
			if v:getHP() > 0 then
				wipe = false
				break
			end
		end
		if wipe then
			for _,v in pairs(chars) do
				v:messageSpecial(Zhayolm.text.PARTY_FALLEN, 3)
			end
			instance:setWipeTime(math.abs(elapsed))
			return
		end
	else
		if elapsed / 1000 >= math.abs(timeWipe) / 1000 + 180 then
			instance:fail()
			return
		elseif elapsed / 1000 == math.abs(timeWipe) / 1000 + 120 then
			for _,v in pairs(chars) do
				v:messageSpecial(Zhayolm.text.PARTY_FALLEN, 1)
			end
			return
		else
			for _,v in pairs(chars) do
				if v:getHP() > 0 then
					instance:setWipeTime(0)
					break
				end
			end
		end
	end

	-- Handle certain Notorious monster spawns here since updating is faster and more consistent,
	if stage == 1 and ZhayolmR_FL1_Poroggo_Madame == 0 then
		if ZhayolmR_FL1_Poroggo_Gent == 1 then
			local allPlayersAlive = false
			for _,v in pairs(chars) do
				if v:getHP() ~= 0 then
					allPlayersAlive = true
				else
					allPlayersAlive = false
				end
			end
			if allPlayersAlive then
				local popMadame = 0
				for _,v in pairs(chars) do
					popMadame = v:getLocalVar("Salvage-ZhayolmFL1-PoroggoMadame")
					if popMadame == 1 then
						SpawnMob(Zhayolm.mob[1].poroggo_madame, instance)
						ZhayolmR_FL1_Poroggo_Madame = 1
					end
				end
			end
		end
	elseif stage == 2 and ZhayolmR_FL2_Poroggo_Madame == 0 then
		local ne_gate = 0
		for _,v in pairs(chars) do
			ne_gate = v:getLocalVar("Salvage-ZhayolmFL2-NEGateUnlock")
			if ne_gate == 1 then
				local poroggoMadame = v:getLocalVar("Salvage-ZhayolmFL2-PoroggoMadame-Spawned")
				if poroggoMadame == 1 then
					ZhayolmR_FL2_Poroggo_Madame = 1
					break
				end
			end
		end
	elseif stage == 2 and ZhayolmR_FL2_Jakko == 0 then
		for _,v in pairs(chars) do
			if v:getLocalVar("Salvage-ZhayolmFL2-Jakko-Dead") == 1 then
				ZhayolmR_FL2_Jakko = 1
			end
		end
	elseif stage == 4 and ZhayolmR_FL4_Poroggo_Madame == 0 then
		local fEID = 0
		for _,v in pairs(chars) do
			fEID = v:getLocalVar("Salvage-FloorEventID")
			if fEID == 205 then
				if timeRemaining >= 2820 then
					printf(".. Attempting to pop Floor 4 South Poroggo Madame, timeRemaining: " .. timeRemaining)
					SpawnMob(Zhayolm.mob[4].poroggo_madame_south, instance)
					ZhayolmR_FL4_Poroggo_Madame = 1
				end
			elseif fEID == 206 then
				if timeRemaining >= 1800 then
					printf(".. Attempting to pop Floor 4 North Poroggo Madame, timeRemaining: " .. timeRemaining)
					SpawnMob(Zhayolm.mob[4].poroggo_madame_north, instance)
					ZhayolmR_FL4_Poroggo_Madame = 1
				end
			end
		end
	elseif stage == 5 and ZhayolmR_FL5_Poroggo_Madame == 0 then
		local cleared = 0
		local fEID = 0
		for _,v in pairs(chars) do
			if v:getVar("Salvage-EncumbranceI-Removed") == 1 then
				if v:getVar("Salvage-Obliviscence-Removed") == 1 then
					if v:getVar("Salvage-Omerta-Removed") == 1 then
						if v:getVar("Salvage-Impairment-Removed") == 1 then
							if v:getVar("Salvage-Debilitation-Removed") == 1 then
								cleared = cleared + 1
							end
						end
					end
				end
			end
			fEID = v:getLocalVar("Salvage-FloorEventID")
			if fEID == 208 then
				if cleared == 3 then
					-- Pop North Poroggo Madame
					SpawnMob(Zhayolm.mob[5].north_poroggo_madame, instance)
					ZhayolmR_FL5_Poroggo_Madame = 1
				end
			elseif fEID == 207 then
				if cleared == 1 then
					-- Pop South Poroggo Madame
					SpawnMob(Zhayolm.mob[5].south_poroggo_madame, instance)
					ZhayolmR_FL5_Poroggo_Madame = 1
				end
			end
			if cleared == 0 then
				ZhayolmR_FL5_Poroggo_Madame = -1
			end
		end
	end
	-- end Notorious monster spawn handler

    if (lastTimeUpdate == 0 and ((elapsed / 1000) >= 900)) then
		msgTime = 2700;
    elseif (lastTimeUpdate == 2700 and timeRemaining < 1800) then
		msgTime = 1800;
    elseif (lastTimeUpdate == 1800 and timeRemaining < 600) then
		msgTime = 600;
    elseif (lastTimeUpdate == 600 and timeRemaining < 300) then
		msgTime = 300;
    elseif (lastTimeUpdate == 300 and timeRemaining < 60) then
		msgTime = 60;
    elseif (lastTimeUpdate == 60 and timeRemaining < 30) then
		msgTime = 30;
    elseif (lastTimeUpdate == 30 and timeRemaining < 10) then
		msgTime = 10;
    end

    if msgTime ~= 0 then
        printf("Zhayolm Remnants: onInstanceTimeUpdate()")
		printf(".. Sending time remaining messages.")
        printf(".. lastTimeUpdate: " .. lastTimeUpdate)
		printf(".. elapsed time  : " .. ((elapsed / 1000) / 60))
		
		-- Cleanup stale instances.
		--local testInstanceCleanup = 0
		--for _,v in pairs(chars) do
		--	if v:getZone() == 73 then
		--		testInstanceCleanup = testInstanceCleanup + 1
		--		break
		--	end
		--end
		--if testInstanceCleanup == 0 then
		--	instance:fail()
		--	return
		--end

    	for _,v in pairs(chars) do
	    	if timeRemaining >= 60 then
        		printf(".. time remaining: " .. (timeRemaining / 60))
	       		v:messageSpecial(Zhayolm.text.TIME_REMAINING_MINUTES, ((timeRemaining / 60) + 1))
	    	else
        		printf(".. time remaining: " .. timeRemaining)
	        	v:messageSpecial(Zhayolm.text.TIME_REMAINING_SECONDS, (timeRemaining + 1))
	    	end
        end
        instance:setLastTimeUpdate(msgTime)
    end
end;

function onInstanceProgressUpdate(instance, progress)
    printf("Zhayolm Remnants: onInstanceProgressUpdate()")
    local stage = instance:getStage()
    local chars = instance:getChars()
    local num_pl = 0
    for _,v in pairs(chars) do
		num_pl = num_pl + 1
    end
    if (num_pl == 0) then
		num_pl = 1
	end
	printf(".. Stage: " .. stage .. " | Progress: " .. progress .. " | Num players: " .. num_pl)

	-- Floor 1 -- Mob/Chest Updates
	if stage == 1 then
		if progress > 0 then
			for _,v in pairs(chars) do
				if v:getLocalVar("Salvage-ZhayolmFL1-PukCount") == 16 then
					if ZhayolmR_FL1_Poroggo_Gent == 0 then
						SpawnMob(Zhayolm.mob[1].puk_poroggo, instance)
						ZhayolmR_FL1_Poroggo_Gent = 1
					end
					v:setLocalVar("Salvage-ZhayolmFL1-ZizCount", 0);
				elseif v:getLocalVar("Salvage-ZhayolmFL1-ZizCount") == 16 then
					if ZhayolmR_FL1_Poroggo_Gent == 0 then
						SpawnMob(Zhayolm.mob[1].ziz_poroggo, instance)
						ZhayolmR_FL1_Poroggo_Gent = 1
					end
					v:setLocalVar("Salvage-ZhayolmFL1-ZizCount", 0);
				elseif v:getLocalVar("Salvage-ZhayolmFL1-LindwurmCount") == 16 then
					if ZhayolmR_FL1_Poroggo_Gent == 0 then
						SpawnMob(Zhayolm.mob[1].lindwurm_poroggo, instance)
						ZhayolmR_FL1_Poroggo_Gent = 1
					end
					v:setLocalVar("Salvage-ZhayolmFL1-LundwurmCount", 0);
				elseif v:getLocalVar("Salvage-ZhayolmFL1-BugardCount") == 16 then
					if ZhayolmR_FL1_Poroggo_Gent == 0 then
						SpawnMob(Zhayolm.mob[1].bugard_poroggo, instance)
						ZhayolmR_FL1_Poroggo_Gent = 1
					end
					v:setLocalVar("Salvage-ZhayolmFL1-BugardCount", 0)
				end
			end
		end
	-- Floor 2 -- Mob/Chest Updates
	elseif stage == 2 then
		if progress > 0 then
			-- Draco Lizard
			local dCount = 0
			local ne_gate = 0
			local se_gate = 0
			-- Wyvern
			local wCount = 0
			local nw_gate = 0
			local sw_gate = 0
			for _,v in pairs(chars) do
				-- Draco Lizard
				dCount = v:getLocalVar("Salvage-ZhayolmFL2-DracoKills")
				ne_gate = v:getLocalVar("Salvage-ZhayolmFL2-NEGateUnlock")
				se_gate = v:getLocalVar("Salvage-ZhayolmFL2-SEGateUnlock")
				-- Wyvern
				wCount = v:getLocalVar("Salvage-ZhayolmFL2-WyvernKills")
				nw_gate = v:getLocalVar("Salvage-ZhayolmFL2-NWGateUnlock")
				sw_gate = v:getLocalVar("Salvage-ZhayolmFL2-SWGateUnlock")

				printf(".. NE: " .. ne_gate .. ", SE: " .. se_gate .. ", NW: " .. nw_gate .. ", SW: " .. sw_gate)
				printf(".. Draco Count: " .. dCount .. ", Wyvern Count: " .. wCount)
				-- Mamool Ja
				if ne_gate == 1 and se_gate == 0 and dCount == 8 then
					if ZhayolmR_FL2_NE_MamoolJa == 0 then
						printf(".. Spawning Northeast Mamool Ja Savant")
						SpawnMob(Zhayolm.mob[2].northeast_draco_mamool, instance)
						ZhayolmR_FL2_NE_MamoolJa = 1
					end
					v:setLocalVar("Salvage-ZhayolmFL2-DracoKills", 0)
				elseif se_gate == 1 and dCount == 8 then
					if ZhayolmR_FL2_SE_MamoolJa == 0 then
						printf(".. Spawning Southeast Mamool Ja Zenist")
						SpawnMob(Zhayolm.mob[2].southeast_draco_mamool, instance)
						ZhayolmR_FL2_SE_MamoolJa = 1
					end
					v:setLocalVar("Salvage-ZhayolmFL2-DracoKills", 0)
				elseif nw_gate == 1 and wCount == 8 then
					if ZhayolmR_FL2_NW_MamoolJa == 0 then
						printf(".. Spawning Northwest Mamool Ja Bounder")
						SpawnMob(Zhayolm.mob[2].northwest_wyvern_mamool, instance)
						ZhayolmR_FL2_NW_MamoolJa = 1
					end
					v:setLocalVar("Salvage-ZhayolmFL2-WyvernKills", 0);
				elseif sw_gate == 1 and wCount == 8 then
					if ZhayolmR_FL2_SW_MamoolJa == 0 then
						printf(".. Spawning Southwest Mamool Ja Spearman")
						SpawnMob(Zhayolm.mob[2].southwest_wyvern_mamool, instance)
						ZhayolmR_FL2_SW_MamoolJa = 1
					end
					v:setLocalVar("Salvage-ZhayolmFL2-WyvernKills", 0)
				end
			end
		end
	-- Floor 3 -- Mob/Chest Updates
	elseif stage == 3 and progress > 0 then
		local MjSavant = 0
		local MjSophist = 0
		local MjMimicker = 0
		local MjSpearman = 0
		local MjStrapper = 0
		local MjBounder = 0
		local MjZenist = 0
		local ARampart = 0
		if ZhayolmR_FL3_Poroggo_Madame == 0 then
			for _,v in ipairs(instance:getChars()) do
				-- North Path
				MjSavant = v:getLocalVar("Salvage-ZhayolmFL3-MjSophistCount")
				MjSophist = v:getLocalVar("Salvage-ZhayolmFL3-MjSavantCount")
				MjMimicker = v:getLocalVar("Salvage-ZhayolmFL3-MjMimickerCount")
				-- South Path
				MjSpearman = v:getLocalVar("Salvage-ZhayolmFL3-MjSpearmanCount")
				MjStrapper = v:getLocalVar("Salvage-ZhayolmFL3-MjStrapperCount")
				MjBounder = v:getLocalVar("Salvage-ZhayolmFL3-MjBounderCount")
				MjZenist = v:getLocalVar("Salvage-ZhayolmFL3-MjZenistCount")
				ARampart = v:getLocalVar("Salvage-ZhayolmFL3-ARampartCount")
			end

			local north_poroggo = (MjSavant + MjSophist + MjMimicker + ARampart)
			local south_poroggo = (MjSpearman + MjStrapper + MjBounder + MjZenist + ARampart)
			printf("[Debug]: North Poroggo: " .. north_poroggo .. " | South Poroggo: " .. south_poroggo)

			if north_poroggo == num_pl * 33 then
				printf(".. Popping Floor 3 North Poroggo Madame")
				for _,v in ipairs(chars) do
					v:setLocalVar("Salvage-ZhayolmFL3-Madame", 1)
				end
				SpawnMob(Zhayolm.mob[3].poroggo_madame, instance):setPos(300,-4, 541, 181)
				ZhayolmR_FL3_Poroggo_Madame = 1
				instance:setProgress(0)
			elseif south_poroggo == num_pl * 25 then
				printf(".. Popping Floor 3 South Poroggo Madame")
				for _,v in ipairs(chars) do
					v:setLocalVar("Salvage-ZhayolmFL3-Madame", 2)
				end
				SpawnMob(Zhayolm.mob[3].poroggo_madame, instance):setPos(379, -4, 378, 64)
				ZhayolmR_FL3_Poroggo_Madame = 1
				instance:setProgress(0)
			end
		end
	-- Floor 4 -- Mob/Chest Updates
    elseif stage == 4 and progress > 0 then
		local chars = instance:getChars()
		local fEID = 0
		local dayEntered = 99
		local mobRespawned = 0
		local passReceived = 99
		for _,v in ipairs(chars) do
			dayEntered = v:getVar("Salvage-DayEntered")
			fEID = v:getLocalVar("Salvage-FloorEventID")
			mobRespawned = v:getLocalVar("Salvage-ZhayolmFL4-Respawn")
			passReceived = v:getLocalVar("Salvage-ZhayolmFL4-Pass")
			if dayEntered >= 0 and dayEntered <= 7 then
				break
			else
				printf("[Debug]: Invalid Salvage-DayEntered character variable detected!")
			end
		end

		printf("[Debug]: EventID: " .. fEID .. " | Pass Received: " .. passReceived)
	-- Floor 5 -- Mob/Chest Updates
	elseif stage == 5 then
		-- Do nothing atm.
    end
end;

function onEventUpdate(entity, eventid, result)
	printf("Zhayolm Remnants: onEventUpdate(): Initiated by player: " .. entity:getName())
	--printf("-- CSID: %u", eventid)
	--printf("-- RESULT: %u", result)
end;

function onEventFinish(entity, eventid, result)
	printf("Zhayolm Remnants: onEventFinish(): Initiated by player: " .. entity:getName())
	printf("-- CSID: %u", eventid)
	printf("-- RESULT: %u", result)

	if eventid == 100 or result == 0 then
		ZhayolmR_Transport_Portal_Locked = 0
		return
	end

	local instance = entity:getInstance()
	local chars = instance:getChars()

	if eventid >= 200 and eventid <= 210 and result == 1 then
		entity:setLocalVar("Salvage-FloorEventID", eventid)
		switch (eventid): caseof
		{
			[200] = function(x)
				entity:setLocalVar("Salvage-ZhayolmFL2-NEGateUnlock", 1) -- Northeast Gate Unlock.
			end,
			[201] = function(x)
				entity:setLocalVar("Salvage-ZhayolmFL2-SEGateUnlock", 1) -- Southeast Gate Unlock.
			end,
			[202] = function(x)
				entity:setLocalVar("Salvage-ZhayolmFL2-SWGateUnlock", 1) -- Southwest Gate Unlock.
			end,
			[203] = function(x)
				entity:setLocalVar("Salvage-ZhayolmFL2-NWGateUnlock", 1) -- Northwest Gate Unlock.
			end,
		}
		transportPlayersToNextSalvageFloor(instance, entity, eventid)
	end

	if eventid >= 200 and eventid <= 203 and result == 1 then
		printf(".. Checking if Floor 2 has been loaded: " .. ZhayolmR_Floor2_Loaded)
		if ZhayolmR_Floor2_Loaded == 0 then
			printf(".. Zhayolm Remnants: Floor 2 -- EventID: " .. eventid .. " | mob_groups[2][" .. (eventid-199) .. "]")
			printf(".. First to arrive: " .. entity:getName() .. " is loading the next event space.")
			loadSalvageFloorByMobGroup(instance, Zhayolm.mob[2][eventid-199].mobs_start, Zhayolm.mob[2][eventid-199].mobs_end)
			for _,v in pairs(Zhayolm.npcs[2][2]) do
				local npc = instance:getEntity(bit.band(v, 0xFFF), TYPE_NPC)
				npc:setStatus(STATUS_NORMAL)
			end
			ZhayolmR_Floor2_Loaded = 1
		end
		if allPresentOnSameEventFloor(chars, eventid) then
			unloadSalvageFloorByMobGroup(instance, Zhayolm.mob[1].mobs_start, Zhayolm.mob[1].mobs_end)
			instance:setStage(2)
			instance:setProgress(0)
		end
	elseif eventid == 204 and result == 1 then
		printf(".. Checking if Floor 3 has been loaded: " .. ZhayolmR_Floor3_Loaded)
		if ZhayolmR_Floor3_Loaded == 0 then
			printf(".. Zhayolm Remnants: Floor 3 -- EventID: " .. eventid .. " | mob_groups[3]")
			printf(".. First to arrive: " .. entity:getName() .. " is loading the next event space.")
			--loadSalvageFloorByMobGroup(instance, Zhayolm.mobs[3].mobs_start, Zhayolm.mobs[3].mobs_end);
			local skip = false;
			for id = Zhayolm.mob[3].mobs_start, Zhayolm.mob[3].mobs_end do
				if id ~= 17076411 then -- Madame Poroggo
					for _,v in ipairs(Zhayolm.mob[3].mpet_wyverns) do
						if v == id then
							skip = true
							break
						end
					end
					for _,v in ipairs(Zhayolm.mob[3].mpet_lizards) do
						if skip then
							break
						end
						if v == id then
							skip = true
							break
						end
					end
					for _,v in ipairs(Zhayolm.mob[3].rpet_tigers) do
						if skip then
							break
						end
						if v == id then
							skip = true
							break
						end
					end
					if skip == false then
						printf("[Zhayolm Remnants Debug]: Spawning mob: " .. id)
						SpawnMob(id, instance)
					else
						skip = false
					end
				end
			end
			ZhayolmR_Floor3_Loaded = 1
		end
		if allPresentOnSameEventFloor(chars, eventid) then
			for zone = 1,4 do
				unloadSalvageFloorByMobGroup(instance, Zhayolm.mob[2][zone].mobs_start, Zhayolm.mob[2][zone].mobs_end)
			end
			instance:setStage(3)
			instance:setProgress(0)
		end
	elseif eventid >= 205 and eventid <= 206 and result == 1 then
		printf(".. Checking if Floor 4 has been loaded: " .. ZhayolmR_Floor4_Loaded)
		if ZhayolmR_Floor4_Loaded == 0 then
			printf(".. Zhayolm Remnants: Floor 4 -- EventID: " .. eventid .. " | mob_groups[4][" .. (eventid-199) .. "]")
			printf(".. First to arrive: " .. entity:getName() .. " is loading the next event space.")
			loadSalvageFloorByMobGroup(instance, Zhayolm.mob[4][eventid-199].poroggo_start, Zhayolm.mob[4][eventid-199].poroggo_end)
			loadSalvageFloorByMobGroup(instance, Zhayolm.mob[4][eventid-199].mamool_start, Zhayolm.mob[4][eventid-199].mamool_end)
			loadSalvageFloorByMobGroup(instance, Zhayolm.mob[4][eventid-199].rampart_start, Zhayolm.mob[4][eventid-199].rampart_end)
			ZhayolmR_Floor4_Loaded = 1
		end
		if allPresentOnSameEventFloor(chars, eventid) then
			unloadSalvageFloorByMobGroup(instance, Zhayolm.mob[3].mobs_start, Zhayolm.mob[3].mobs_end)
			instance:setStage(4)
			instance:setProgress(0)
		end
	elseif eventid >= 207 and eventid <= 208 and result == 1 then
		printf(".. Checking if Floor 5 has been loaded: " .. ZhayolmR_Floor5_Loaded)
		if ZhayolmR_Floor5_Loaded == 0 then
			printf(".. First to arrive: " .. entity:getName() .. " is loading the next event space.")
			printf(".. Zhayolm Remnants: Floor 5 -- EventID: " .. eventid .. " | mob_groups[5][" .. (eventid-199) .. "]")
			loadSalvageFloorByMobGroup(instance, Zhayolm.mob[5][eventid-199].mobs_start, Zhayolm.mob[5][eventid-199].mobs_end)
			SpawnMob(Zhayolm.mob[5][eventid-199].archaic_chariot, instance)
			ZhayolmR_Floor5_Loaded = 1
		end
		if allPresentOnSameEventFloor(chars, eventid) then
			for zone = 6,7 do
				unloadSalvageFloorByMobGroup(instance, Zhayolm.mob[4][zone].poroggo_start, Zhayolm.mob[4][zone].poroggo_end)
				unloadSalvageFloorByMobGroup(instance, Zhayolm.mob[4][zone].mamool_start, Zhayolm.mob[4][zone].mamool_end)
				unloadSalvageFloorByMobGroup(instance, Zhayolm.mob[4][zone].rampart_start, Zhayolm.mob[4][zone].rampart_end)
			end
			instance:setStage(5)
			instance:setProgress(0)
		end
	elseif eventid == 209 and result == 1 then
		printf(".. Checking if Floor 6has been loaded: " .. ZhayolmR_Floor6_Loaded)
		if ZhayolmR_Floor6_Loaded == 0 then
			printf(".. Zhayolm Remnants: Floor 6 -- EventID: " .. eventid .. " | mob_groups[6]")
			printf(".. First to arrive: " .. entity:getName() .. " is loading the next event space.")
			SpawnMob(Zhayolm.mob[6].rampart_nw, instance)
			SpawnMob(Zhayolm.mob[6].rampart_se, instance)
			SpawnMob(Zhayolm.mob[6].archaic_chariot, instance)

			printf("[Zhayolm Remnants: Floor 1 Poroggo Madame count: " .. ZhayolmR_FL1_Poroggo_Madame)
			printf("[Zhayolm Remnants: Floor 2 Poroggo Madame count: " .. ZhayolmR_FL2_Poroggo_Madame)
			printf("[Zhayolm Remnants: Floor 2 Jakko: " .. ZhayolmR_FL2_Jakko)
			printf("[Zhayolm Remnants: Floor 3 Poroggo Madame count: " .. ZhayolmR_FL3_Poroggo_Madame)
			printf("[Zhayolm Remnants: Floor 4 Poroggo Madame count: " .. ZhayolmR_FL4_Poroggo_Madame)
			printf("[Zhayolm Remnants: Floor 5 Poroggo Madame count: " .. ZhayolmR_FL5_Poroggo_Madame)

			ZhayolmR_FL6_Poroggo_Madame = (ZhayolmR_FL1_Poroggo_Madame + ZhayolmR_FL2_Poroggo_Madame +
				ZhayolmR_FL3_Poroggo_Madame + ZhayolmR_FL4_Poroggo_Madame + ZhayolmR_FL5_Poroggo_Madame + ZhayolmR_FL2_Jakko)

			printf("[Zhayolm Remnants: Floor 6 Poroggo Madame count: " .. ZhayolmR_FL6_Poroggo_Madame)
			if ZhayolmR_FL6_Poroggo_Madame >= 4 then
				SpawnMob(Zhayolm.mob[6].poroggo_madame, instance)
			end
			ZhayolmR_Floor6_Loaded = 1
		end
		if allPresentOnSameEventFloor(chars, eventid) then
			for zone = 8,9 do
				unloadSalvageFloorByMobGroup(instance, Zhayolm.mob[5][zone].mobs_start, Zhayolm.mob[5][zone].mobs_end)
			end
			instance:setStage(6)
			instance:setProgress(0)
		end
	elseif eventid == 210 and result == 1 then
		printf(".. Checking if Floor 7 has been loaded: " .. ZhayolmR_Floor7_Loaded)
		if ZhayolmR_Floor7_Loaded == 0 then
			printf(".. First to arrive: " .. entity:getName())
			ZhayolmR_Floor7_Loaded = 1
		end
		if allPresentOnSameEventFloor(chars, eventid) then
			unloadSalvageFloorByMobGroup(instance, Zhayolm.mob[6])
			instance:setStage(7)
			instance:setProgress(0)
		end
	elseif eventid == 211 and result == 1 then
		instance:complete()
	end

	if eventid >= 200 and eventid <= 211 then
		ZhayolmR_Transport_Portal_Locked = 0
	end
end;

function transportPlayersToNextSalvageFloor(instance, player, event)
	-- Transport all players to the next floor once a single person has activated the teleport.
	-- Lock out other persons ability to trigger the telepoint by global control variable. ZhayolmR_Teleport_Transfer_Lock
	
	local players = instance:getChars() -- Get all event players regardless of party or alliance make up.
	local instanceId = 0
	local playerId = player:getID()
	local targetId = 0
	local floorId = 0
	local skip = false

	for _,p in ipairs(players) do
		floorId = p:getLocalVar("Salvage-FloorEventID")
		instanceId = p:getVar("Salvage-InstanceId")
		playerName = p:getName()

		if instanceId ~= 73 and instanceId ~= 74 and instanceId ~= 75 and instanceId ~= 76 then
			printf("[Salvage: (Error) Player: " .. playerName .. " has attempted to be teleported but does not have an instanceId set.")
			printf("[Salvage: (Error) Player: " .. playerName .. " will be skipped from the teleport transfer.")
			skip = true
		end

		if skip ~= true then
			targetId = p:getID()
			if playerId ~= targetId then
				if instanceId == 73 then -- Zhayolm Remnants
					if floorId ~= event then
						printf("[Salvage: (Info) Player: " .. playerName .. " is being sent to the next eventId: " .. event)
						switch (event): caseof
						{
							[200] = function(x)
                                p:setLocalVar("Salvage-ZhayolmFL2-NEGateUnlock", 1) -- Northeast Gate Unlock.
								p:startEvent(100)
								p:setPos(420, 0, 20, 191) 		--
							end,
							[201] = function(x)
                                p:setLocalVar("Salvage-ZhayolmFL2-SEGateUnlock", 1) -- Southeast Gate Unlock.
								p:startEvent(100)
								p:setPos(420, 0, -140, 191) 	--
							end,
							[202] = function(x)
                                p:setLocalVar("Salvage-ZhayolmFL2-SWGateUnlock", 1) -- Southwest Gate Unlock.
								p:startEvent(100)
								p:setPos(260, 0, -140, 191)		--
							end,
							[203] = function(x)
                                p:setLocalVar("Salvage-ZhayolmFL2-NWGateUnlock", 1) -- Northwest Gate Unlock.
								p:startEvent(100)
								p:setPos(260, 0, 20, 191)		--
							end,
							[204] = function(x)
								p:startEvent(100)
								p:setPos(340, 0, 460, 191) 	--
							end,
							[205] = function(x)
								p:startEvent(100)
								p:setPos(-340, 0, -580, 191) 	--
							end,
							[206] = function(x)
								p:startEvent(100)
								p:setPos(340, 0, -500, 63) 	--
							end,
							[207] = function(x)
								p:startEvent(100)
								p:setPos(-380, 0, -180, 63) 	--
							end,
							[208] = function(x)
								p:startEvent(100)
								p:setPos(-300, 0, -20, 191) 	--
							end,
							[209] = function(x)
								p:startEvent(100)
								p:setPos(-340, 0, 220, 191)		--
							end,
							[210] = function(x)
								p:startEvent(100)
								p:setPos(-340, 0, 460, 191) 	--
							end,
						}
					end
				end
			end
			p:setHP(10000) -- Restore HP
			p:setMP(10000) -- Restore MP
			p:setLocalVar("Salvage-FloorEventID", event)
		else
			skip = false
		end
    end
    printf("Salvage: transportPlayersToNextSalvageFloor(): Operation completed.")
end;

function loadSalvageFloorByMobGroup(instance, group_start, group_end)
    --
    -- Examples:
    -- loadSalvageFloorByMobGroup(instance, Zhayolm.mobs[1].MOBB_START, Zhayolm.mobs[1].MOBB_END);
    -- loadSalvageFloorByMobGroup(instnace, Zhayolm.mobs[6]);
    --
    printf("[Zhayolm Remnants: loadSalvageFloorByMobGroup() started.")
    if instance == nil then
        printf(".. Instance is nil")
        return
    end
    if group_start == nil then
        printf(".. Group start Id is nil")
        return
    end
    if group_end == nil then
        -- Passed a single table group of mobs to spawn.
        for _,id in ipairs(group_start) do
            printf(".. Spawning mob: " .. id)
            SpawnMob(id, instance)
        end
    else
        for id = group_start, group_end do
            if DespawnTime < os.time() - 5 then
                printf(".. Spawning mob: " .. id)
                SpawnMob(id, instance)
            end
        end
    end
end;

function unloadSalvageFloorByMobGroup(instance, group_start, group_end)
    --
    -- Examples:
    -- unloadSalvageFloorByMobGroup(instance, Zhayolm.mobs[1].MOBB_START, Zhayolm.mobs[1].MOBB_END);
    -- unloadSalvageFloorByMobGroup(instnace, Zhayolm.mobs[6]);
    --
    printf("[Zhayolm Remnants: unloadSalvageFloorByMobGroup() started.");
    if instance == nil then
        printf(".. Instance is nil")
        return
    end
    if group_start == nil then
        printf(".. Group start Id is nil")
        return
	end
    if group_end == nil then
        -- Passed a single table group of mobs to despawn.
        for _,id in ipairs(group_start) do
            printf(".. Despawning mob: " .. id)
            DespawnMob(id, instance)
        end
    else
        for id = group_start, group_end do
            if DespawnTime < os.time() - 5 then
                printf(".. Despawning mob: " .. id)
                DespawnMob(id, instance)
            end
        end
    end
end;

function allPresentOnSameEventFloor(players, event)
    printf("[Zhayolm Remnants: allPresentOnSameEventFloor() started.")
    if players == nil then
        printf(".. Players list is nil")
    end
    if event == nil then
        printf(".. Event Id is nil")
        return
    end

    for _,p in ipairs(players) do
        local floorId = p:getLocalVar("Salvage-FloorEventID")
        if event ~= floorId then
            return false
        end
    end
    printf(".. All players are present on the same event floor.")
    return true
end;