
-- Floor 2
-- Southeast Draco Box

local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")

function onTrigger(entity, npc)
	printf("Zhayolm Remnants: _215.lua Gilded Door onTrigger")
    local instance = npc:getInstance()
    local stage = instance:getStage()
    local progress = instance:getProgress()

	printf(".. SW Gate Unlock: " .. entity:getLocalVar("Salvage-ZhayolmFL2-SWGateUnlock"))
	printf(".. NW Gate Unlock: " .. entity:getLocalVar("Salvage-ZhayolmFL2-NWGateUnlock"))
	printf(".. SE Gate Unlock: " .. entity:getLocalVar("Salvage-ZhayolmFL2-SEGateUnlock"))
	printf(".. NE Gate Unlock: " .. entity:getLocalVar("Salvage-ZhayolmFL2-NEGateUnlock"))
	if stage == 2 then
		local ne_gate = entity:getLocalVar("Salvage-ZhayolmFL2-NEGateUnlock")
		local sw_gate = entity:getLocalVar("Salvage-ZhayolmFL2-SWGateUnlock")
		local se_gate = entity:getLocalVar("Salvage-ZhayolmFL2-SEGateUnlock")
		if ne_gate + sw_gate + se_gate == 3 then
			for id = Zhayolm.mob[2][2].mobs_start, Zhayolm.mob[2][2].mobs_end do
				SpawnMob(id, instance)
			end
		end

		if se_gate == 1 then
			entity:startEvent(300)
		else
			entity:messageSpecial(Zhayolm.text.DOOR_IS_SEALED)
		end
    end
end

function onEventFinish(entity, eventid, result, door)
	printf("Zhayolm Remnants: _215.lua Gilded Door onEventFinish")
    if eventid == 300 and result == 1 then
        door:setAnimation(8)
        door:untargetable(true)
    end
end