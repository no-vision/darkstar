-----------------------------------
-- Area: Zhayolm_Remnants
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[dsp.zone.ZHAYOLM_REMNANTS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CELL_OFFSET             = 7212, -- Main Weapon/Sub-Weapon restriction removed.

        DOOR_IS_SEALED              = 7423,	-- The door is sealed...
        DEVICE_DOESNT_RESPOND       = 7428,	-- The device doesn't respond...
        NOTHING_HAPPENS             = 7429, -- Nothing happens... (7433)
		DOOR_IS_SEALED_MYSTERIOUS   = 7430,	-- The door is sealed with a mysterious force.

        SALVAGE_START           = 7232,
        TIME_TO_COMPLETE        = 7404,
        MISSION_FAILED          = 7405,
		TIME_REMAINING_MINUTES  = 7409,
		TIME_REMAINING_SECONDS  = 7410,
        PARTY_FALLEN            = 7412,
    },
    mob =
    {
        [1] = { 
			mobs_start = 17076225, mobs_end = 17076296, 
			puk_poroggo = 17076242, ziz_poroggo = 17076260, lindwurm_poroggo = 17076278, bugard_poroggo = 17076296, 
			puk_mamool = 17076241, ziz_mamool = 17076259, lindwurm_mamool = 17076277, bugard_mamool = 17076295, 
			poroggo_madame = 17076297, 
		},
		[2] = {
			[1] = { mobs_start = 17076298, mobs_end = 17076305, }, -- NE Draco
			[2] = { mobs_start = 17076307, mobs_end = 17076314, }, -- SE Draco
			[3] = { mobs_start = 17076316, mobs_end = 17076323, }, -- NW Wyvern
			[4] = { mobs_start = 17076325, mobs_end = 17076332, }, -- SW Wyvern
			northeast_draco_mamool = 17076315, southeast_draco_mamool = 17076306,
			northwest_wyvern_mamool = 17076324, southwest_wyvern_mamool = 17076333,
			poroggo_madame = 17076336, jakko = 17076335,
		},
		[3] = { 
			mobs_start = 17076337, mobs_end = 17076409, 
			mpet_wyverns = { 17076342, 17076344, 17076346, 17076348, 17076361, 17076367, 17076373, },
			mpet_lizards = { 17076353, 17076354, 17076355, 17076356, 17076362, 17076368, 17076374, },
			rpet_tigers = { 17076376, 17076410, },
			poroggo_madame = 17076411,
		},
		[4] = { 
			[6] = { 
				mamool_start = 17076412, mamool_end = 17076415,
				mpet_wyvern = 17076416, mpet_lizard = 17076417,
				poroggo_start = 17076426, poroggo_end = 17076433, 
				rampart_start = 17076418, rampart_end = 17076421, 
			},
			[7] = {
				mamool_start = 17076434, mamool_end = 17076439, 
				poroggo_start = 17076462, poroggo_end = 17076473, 
				rampart_start = 17076446, rampart_end = 17076449,  
			},
			poroggo_madame_north = 17076486,
			poroggo_madame_south = 17076487,
		},
		[5] = { 
			[8] = { mobs_start = 17076488, mobs_end = 17076515, archaic_chariot = 17076535, },
			[9] = { mobs_start = 17076517, mobs_end = 17076557, archaic_chariot = 17076502, },
			south_poroggo_madame = 17076558, north_poroggo_madame = 17076559,
		},
		[6] = { 
				gears_start = 17076561, gears_end = 17076570,
				rampart_nw = 17076573, rampart_se = 17076575, 
				archaic_chariot = 17076560, 
				gear_one = 17076571, gear_two = 17076572, 
				poroggo_madame = 17076577, 
		},
		[7] = { battleclad_chariot = 17076578, },
    },
    npc =
    {
        [1] = {
			[1] = { DOOR1 = 17076949, },
			[2] = { ARMOURY_CRATE = 17076579, },
			[3] = { ARMOURY_CHEST = 17076585, },
		},
		[2] = {
			[2] = { SOCKET = 17076916, SLOT = 17076917, }
		},
    },
}

return zones[dsp.zone.ZHAYOLM_REMNANTS]