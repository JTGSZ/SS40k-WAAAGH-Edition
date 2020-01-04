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
	//map_vault_area = /area/warhammer/desert

/datum/map/active/map_specific_init()
	spawn_loada()

/proc/spawn_loada()
	var/datum/map_element/ME
	var/x_coord = 100
	var/y_coord = 100
	var/z_coord = 1

	ME = new /datum/map_element/vault/test_ig_spawn
	ME.load(x_coord - 1, y_coord - 1, z_coord)

////////////////////////////////////////////////////////////////
#include "maptestdesert.dmm"
#endif
