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
	var/border_range_x = 0
	var/border_range_y = 0
	var/spawn_alignment = "horizontals"

	var/list/spawns = list(
					/datum/map_element/vault/test_ig_spawn,
					/datum/map_element/vault/test_ork_spawn
					)
	
	//map_vault_area = /area/warhammer/desert

/datum/map/active/map_specific_init()
	spawn_loada1(src)

//Can_enlarge determines whether we clamp by edgelimit or it just extends the map.
//Border_range determines additional distance from edges on all sides 

/proc/spawn_loada1(var/datum/map/active/ASS)
	var/datum/map_element/ME
	var/z_coord = 1 //Z level will always be 1
	var/x_coord = 0 //Holder for calculated x - horizontal
	var/y_coord = 0 //Holder for calculated y - vertical
	
	//Primary Placement coordinates for the origin position on the map.
	var/primary_x = 1 //the main X value sent through
	var/primary_y = 1 //the main Y value sent through
	
	var/primary_opposition_x = 1 //The opposing template placement
	var/primary_opposition_y = 1 //The opposing template placement

	var/rand_x = rand(1, world.maxx) //The initial random x coordinate
	var/rand_y = rand(1, world.maxy) //The initial random y coordinate

	if(ASS.spawn_alignment)
		switch(ASS.spawn_alignment)
			if("horizontals")
				primary_x = rand_x
				primary_y = clamp(rand_y, 1, round(world.maxy/4))
			if("verticals")
				primary_x = clamp(rand_x, 1, round(world.maxx/4))
				primary_y = rand_y
			if("random")
				primary_x = rand_x
				primary_y = rand_y

	ME = new /datum/map_element/vault/test_ig_spawn // This needs unhardcoded later anyways
	var/list/template_dimensions = ME.get_dimensions() //Gets dimensions of template, assigns them to vars
	var/template_x = template_dimensions[1] //Max horizontal Dimension of the template we have
	var/template_y = template_dimensions[2] //Max vertical Dimension

	//We start counting from the bottom left, so the maximum number is our boundary and min is static at 1
	var/edgelimit_max_x = (world.maxx - template_x) - ASS.border_range_x //How far we are from right
	var/edgelimit_max_y = (world.maxy - template_y) - ASS.border_range_y //How far we are from north
	var/edgelimit_min_x = 1 + ASS.border_range_x //How far we are from left side
	var/edgelimit_min_y = 1 + ASS.border_range_y //How far we are from bottom

	//Since we start at the bottom left corner
	if(!ASS.can_enlarge) //Can enlarge is false, so template deletes if it can't fit
		x_coord = clamp(primary_x, edgelimit_min_x, edgelimit_max_x) //x coord is rng clamped between 1 and edgelimit x
		y_coord = clamp(primary_y, edgelimit_min_y, edgelimit_max_y)
		ME.load(x_coord, y_coord, z_coord)
	//world.maxy Max Y - Vertical - Columns
	//world.maxx Max X - Horizontal - Rows
	// Min will always be 1 and 1 ofc

////////////////////////////////////////////////////////////////
#include "maptestdesert.dmm"
#endif
