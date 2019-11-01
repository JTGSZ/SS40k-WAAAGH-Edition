#ifndef MAP_OVERRIDE
//**************************************************************
// Map Datum -- maptestmk1
// testbed of the first proc gen ork vs ig map
//**************************************************************

/datum/map/active
	nameShort = "maptestmk1"
	nameLong = "Snowtest IG vs ORK"
	map_dir = "maptestmk1"
	tDomeX = 128
	tDomeY = 58
	tDomeZ = 2
	zLevels = list(
		/datum/zLevel/snow{
			name = "station"
		},
		)
	enabled_jobs = list(/datum/job/trader)

	load_map_elements = list(
	/datum/map_element/dungeon/holodeck
	)

	holomap_offset_x = list(0,0,0,86,4,0,0,)
	holomap_offset_y = list(0,0,0,94,10,0,0,)

	center_x = 226
	center_y = 254
	only_spawn_map_exclusive_vaults = TRUE


////////////////////////////////////////////////////////////////
#include "maptestmk1.dmm"
#endif
