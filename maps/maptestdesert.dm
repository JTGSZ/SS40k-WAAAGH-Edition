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

	map_vault_area = /area/warhammer/desert

//loada_spawn variables
	spawn_overwrite = TRUE //EX: This being true means template 2 can overwrite template 1
	spawn_template_1 = /datum/map_element/vault/test_ig_spawn
	spawn_template_2 = /datum/map_element/vault/test_ork_spawn
	spawn_alignment = "horizontals"
	
	//Debug textvar on all the mapgen 
	//so you can just read it out on dream daemon instead of actually joining game.
	dd_debug = FALSE

/datum/map/active/map_specific_init()

	var/watch2 = start_watch()
	loada_generate_template()
	log_startup_progress("Finished with generating templates in [stop_watch(watch2)]s.")

	var/watch1 = start_watch()
	loada_spawns(src)
	log_startup_progress("Finished with generating spawns in [stop_watch(watch1)]s.")

	var/watch3 = start_watch()
	loada_river2lake1(src)
	log_startup_progress("Finished with rivers and lakes in [stop_watch(watch3)]s.")

	var/watch5 = start_watch()
	loada_cleanup_and_detailing(src)
	log_startup_progress("Finished with cleanup/detailing. [stop_watch(watch5)]s.")

	var/watch4 = start_watch()
	loada_floragen(src)
	log_startup_progress("Finished with floragen in [stop_watch(watch4)]s.")
////////////////////////////////////////////////////////////////
#include "maptestdesert.dmm"
#endif
