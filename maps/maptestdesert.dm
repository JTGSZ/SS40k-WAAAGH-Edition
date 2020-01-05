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
	spawn_loada1()

/proc/spawn_loada1()
	var/datum/map_element/ME
	var/x_coord = 100
	var/y_coord = 100
	var/z_coord = 1

	ME = /datum/map_element/vault/test_ig_spawn // This needs unhardcoded later anyways
	var/list/template_dimensions = ME.get_dimensions()
	var/template_x = template_dimensions[1] //Max horizontal Dimension of the template we have
	var/template_y = template_dimensions[2] //Max vertical Dimension

	//We start counting from the bottom left, so the maximum number is our boundary and min is static at 1
	var/edgelimit_x = world.maxx - template_x //World dimension minus, template dimension
	var/edgelimit_y = world.maxy - template_y //To determine what area we shouldn't load into
	
	//Since we start at the bottom left corner

	ME.load(x_coord - 1, y_coord - 1, z_coord)
	//world.maxy Max Y - Vertical - Columns
	//world.maxx Max X - Horizontal - Rows
	// Min will always be 1 and 1 ofc

////////////////////////////////////////////////////////////////
#include "maptestdesert.dmm"
#endif
