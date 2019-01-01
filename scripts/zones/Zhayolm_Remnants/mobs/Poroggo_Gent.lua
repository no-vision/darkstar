-----------------------------------
-- Poroggo Gent
-----------------------------------

function onMobInitialize(mob)
	mob:setMobMod(MOBMOD_EXP_BONUS, -100)
	mob:setMobMod(MOBMOD_GIL_BONUS, -100)
	mob:setMod(MOD_WATERRES, 100)
	mob:setMod(MOD_ICERES, -25)
	mob:setMod(MOD_THUNDERRES, -25)
	mob:setMod(MOD_LULLABYRES, 100)
	mob:setMod(MOD_LIGHTRES, 100)
	mob:setMod(MOD_CHARMRES, 100)
end;

function onMobEngaged(mob,target)
	local stage = mob:getInstance():getStage()
	local mobid = mob:getID()
	local itmid = { 5365, 5373, 5374, 5375 } -- Incus, Duplicatus, Opacus, Praecipitatio Cells

	if stage == 1 then
		if mobid == 17076242 then
			SetDropRate(2820, itmid[1], 1000)	-- Incus Cell
			SetDropRate(2820, itmid[2], 0)		-- Duplicatus Cell
			SetDropRate(2820, itmid[3], 0)		-- Opacus Cell
			SetDropRate(2820, itmid[4], 0)		-- Praecipitatio Cell
		elseif mobid == 17076260 then
			SetDropRate(2820, itmid[1], 0)		-- Incus Cell
			SetDropRate(2820, itmid[2], 0)		-- Duplicatus Cell
			SetDropRate(2820, itmid[3], 0)		-- Opacus Cell
			SetDropRate(2820, itmid[4], 1000)	-- Praecipitatio Cell
		elseif mobid == 17076278 then
			SetDropRate(2820, itmid[1], 0)		-- Incus Cell
			SetDropRate(2820, itmid[2], 0)		-- Duplicatus Cell
			SetDropRate(2820, itmid[3], 1000)	-- Opacus Cell
			SetDropRate(2820, itmid[4], 0)		-- Praecipitatio Cell
		elseif mobid == 17076296 then
			SetDropRate(2820, itmid[1], 0)		-- Incus Cell
			SetDropRate(2820, itmid[2], 1000)	-- Duplicatus Cell
			SetDropRate(2820, itmid[3], 0)		-- Opacus Cell
			SetDropRate(2820, itmid[4], 0)		-- Praecipitatio Cell
		else
			SetDropRate(2820, itmid[1], 0)		-- Incus Cell
			SetDropRate(2820, itmid[2], 0)		-- Duplicatus Cell
			SetDropRate(2820, itmid[3], 0)		-- Opacus Cell
			SetDropRate(2820, itmid[4], 0)		-- Praecipitatio Cell
		end
	end
end;

function onMobFight(mob,target)
end;

function onMobDeath(mob, player, isKiller)
    local stage = player:getInstance():getStage()

	if stage == 1 then
		local chars = player:getInstance():getChars()
		local cells = false
		-- Did players use cells?
		for _,v in pairs(chars) do
			if v:getVar("Salvage-ZhayolmFL1-CellUsed") == 1 then
				printf("Zhayolm Remnants: Floor 1 Poroggo Gent - Cells used.")
				cells = true
			end
		end
		if not cells then
			printf("Zhayolm Remnants: Floor 1 Poroggo Gent - No cells used.")
			player:setLocalVar("Salvage-ZhayolmFL1-PoroggoMadame", 1)
		end
    end
end;