#ifndef MAP_OVERRIDE
//**************************************************************
// Map Datum -- maptestdesert
// testbed of the first proc gen ork vs ig map
//**************************************************************

/datum/map/active
	nameShort = "maptestdesert"
	nameLong = "Sandtest IG vs ORK"
	map_dir = "maptestdesert"
	tDomeX = 128
	tDomeY = 58
	tDomeZ = 2
	zLevels = list(
		/datum/zLevel/desert{
			name = "station"
		},
		)
	enabled_jobs = list()

	load_map_elements = list()

	center_x = 100
	center_y = 100
	only_spawn_map_exclusive_vaults = FALSE
	can_enlarge = FALSE

//loada_spawn variables
	spawn_overwrite = TRUE //EX: This being true means template 2 can overwrite template 1
	spawn_template_1 = /datum/map_element/vault/test_ig_spawn
	spawn_template_2 = /datum/map_element/vault/test_ork_spawn
	spawn_alignment = "horizontals"
	
	//Debug textvar on all the mapgen 
	//so you can just read it out on dream daemon instead of actually joining game.
	dd_debug = TRUE

/datum/map/active/map_specific_init()
	jt_loada_spawns(src)

	jt_loada_river2lake1(src)
////////////////////////////////////////////////////////////////
#include "maptestdesert.dmm"
#endif
