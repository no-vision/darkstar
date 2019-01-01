-----------------------------------
--
-- Zone: Zhayolm Remnants
--
-----------------------------------
local ID = require("scripts/zones/Zhayolm_Remnants/IDs")

--require("scripts/globals/settings")
require("scripts/globals/zone")

function onInitialize(zone)
    -- Floor 1 Portals
    zone:registerRegion(1, 420, 5, -340, 0, 0, 0) 	-- Portal 1 (NE)
    zone:registerRegion(2, 420, 5, -500, 0, 0, 0) 	-- Portal 2 (SE)
    zone:registerRegion(3, 260, 5, -500, 0, 0, 0) 	-- Portal 3 (SW)
    zone:registerRegion(4, 260, 5, -340, 0, 0, 0) 	-- Portal 4 (NW)
    -- Floor 2 Portals
    zone:registerRegion(5, 340, 5,-60, 0, 0, 0) 	-- Portal 5 (Central)
    -- Floor 3 Portals
    zone:registerRegion(6, 340, 5, 419, 0, 0, 0) 	-- Portal 6 (S)
    zone:registerRegion(7, 340, 5, 499, 0, 0, 0) 	-- Portal 7 (N)
    -- Floor 4 Portals
    zone:registerRegion(8, -379, 5, -620, 0, 0, 0)	-- Portal 8 (S)
    zone:registerRegion(9, -300, 5, -460, 0, 0, 0)	-- Portal 9 (N)
    -- Floor 5 Portals
    zone:registerRegion(10, -340, 5, -99, 0, 0, 0) -- Portal 10 (Central)
    -- Floor 6 Portals
    zone:registerRegion(11, -340, 5, 140, 0, 0, 0) -- Portal 11 (Boss)
    -- Floor 7 Portals
    zone:registerRegion(12, -367, 7, 566, 0, 0, 0)	-- Portal 12 (Exit)
end;

function onInstanceZoneIn(player,instance)
    local pos = player:getPos()
    if pos.x == 0 and pos.y == 0 and pos.z == 0 then
        local entrypos = instance:getEntryPos()
        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end
    player:addTempItem(5398)
end;

function onRegionEnter(player,region)
end;

function onEventUpdate(player,csid,option)
    -- printf("CSID: %u",csid)
    -- printf("RESULT: %u",option)
end;

function onEventFinish(player,csid,option)
    --printf("CSID: %u",csid)
    --printf("RESULT: %u",option)
    if (csid == 0x66) then
        player:setPos(-580, 0, -460, 63, 72)
    end
end;

function onInstanceLoadFailed()
    return 73
end;
