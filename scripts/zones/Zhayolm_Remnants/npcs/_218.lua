
-- Floor 2
-- Southwest Wyvern Box

local Zhayolm = require("scripts/zones/Zhayolm_Remnants/IDs")

function onTrigger(entity, npc)
	printf("Zhayolm Remnants: _218.lua Gilded Door onTrigger")
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
		if ne_gate + sw_gate == 2 then
			for id = Zhayolm.mob[2][3].mobs_start, Zhayolm.mob[2][3].mobs_end do
				SpawnMob(id, instance)
			end
		end

		if sw_gate == 1 then
			entity:startEvent(300)
		else
			entity:messageSpecial(Zhayolm.text.DOOR_IS_SEALED)
		end
	end
end

function onEventFinish(entity, eventid, result, door)
	printf("Zhayolm Remnants: _218.lua Gilded Door onEventFinish")
    if eventid == 300 and result == 1 then
        door:setAnimation(8)
        door:untargetable(true)
    end
end