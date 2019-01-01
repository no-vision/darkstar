-----------------------------------
-- Area: Alzadaal Undersea Ruins
-- Door: Gilded Gateway (Zhayolm)
-- !pos -580 0 -159 72
-----------------------------------
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/besieged")

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    printf("AzaldaalUR: Zhayolm Remnants _20v.lua onTrigger()")
    printf(". Player triggering: " .. player:getName())
    if player:hasKeyItem(dsp.ki.REMNANTS_PERMIT) then
	    local mask = -2
        if player:getMainLvl() >= 65 then
            mask = -6
        end
	if player:checkImbuedItems() then
	    printf(".. Player: " .. player:getName() .. " has imbued items.")
	    player:messageText(player,ID.text.MEMBER_IMBUED_ITEM, false)
	    return
	end
        player:startEvent(407, 0, mask, 0, 0, 7)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end;

function onEventUpdate(player,csid,option,target)
    printf("CSID: %u",csid)
    printf("RESULT: %u",option)
    printf("AlzadaalUR: Zhayolm Remnant _20v.lua onEventUpdate()")

    local instanceid = (bit.rshift(option, 19) + 72)
    local alliance = player:getAlliance()
    --local party = player:getParty();

    if (alliance ~= nil) then
        for _,v in ipairs(alliance) do
            printf("Checking party member: " .. v:getName())
            if v:getZone() == player:getZone() then
                if v:checkdistance(player) > 50 then
                    printf(".. Member too far but in zone. Member: " .. v:getName())
                    player:messageText(target,ID.text.MEMBER_TOO_FAR, false)
                    player:instanceEntry(target,1)
                    return
                elseif not v:hasKeyItem(dsp.ki.REMNANTS_PERMIT) or v:getMainLvl() < 65 then
                    printf(".. Member has no permit or lower than Lv65. Member: " .. v:getName())
                    player:messageText(target,ID.text.MEMBER_NO_REQS, false)
                    player:instanceEntry(target,1)
                    return
        		elseif v:checkImbuedItems() then
        		    printf(".. Member has imbued items. Member: " .. v:getName())
        		    player:messageText(target,ID.text.MEMBER_IMBUED_ITEM, false)
        		    player:instanceEntry(target,1)
        		    return
                end
                printf(".. Member passed entry check. Member: " .. v:getName())
            end
        end
	    printf("All party members passed entry check.")
    end
    printf("Creating Zhayolm Instance: %u", instanceid)
    player:createInstance(instanceid,73)
end;

function onEventFinish(player,csid,option,target)
    printf("CSID: %u",csid)
    printf("RESULT: %u",option)
    printf("AzaldaalUR: Zhayolm Remnants _20v.lua onEventFinish()")

    if csid == 407 and option == 4 then
	    printf("onEventFinish() " .. player:getName() .. " Initiator of event to Zhayolm Remnants.")
        player:setPos(0,0,0,0,73)
    elseif csid == 0x73 then
	    printf("onEventFinish() " .. player:getName() .. " Party member to Zhayolm Remnants.")
        player:setPos(0,0,0,0,73)
    end
end;

function onInstanceCreated(player,target,instance)
    printf("AzaldaalUR: Zhayolm Remnants _20v.lua onInstanceCreated()")
    --printf(" -- Target: %u", target)
    printf(". Instance initiator: " .. player:getName())

    local entryDay = VanadielDayElement()
    local alliance = player:getAlliance()
    --local party = player:getParty()

    if instance then
        instance:setStage(1)
        instance:setProgress(0)

        player:setInstance(instance)
        player:instanceEntry(target,4)
        player:delKeyItem(dsp.ki.REMNANTS_PERMIT)
	    player:setVar("Salvage-DayEntered", entryDay)
        if alliance ~= nil then
            for _,v in ipairs(alliance) do
		        printf(".. Alliance member: " .. v:getName())
                if v:getID() ~= player:getID() then
--                    v:startEvent(0x73, 2)
                    v:setInstance(instance)
                    v:delKeyItem(dsp.ki.REMNANTS_PERMIT)
                    v:setVar("Salvage-DayEntered", entryDay)
                    v:setVar("Salvage-InstanceId", 73)
		            v:setPos(0, 0, 0, 0, 73)
                end
            end
        end
    else
	    printf(".. No instance cannot enter.")
        player:messageText(target,ID.text.CANNOT_ENTER, false)
        player:instanceEntry(target,3)
    end
end;