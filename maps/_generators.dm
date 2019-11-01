/*
	MAP GENERATOR INITS
						*/

//This file is where all the generation is stored.
//To activate it just use the zLevel path on your map loading file.
/datum/zLevel/desert

	name = "desert"
	teleJammed = 1
	movementJammed = 1
	base_turf = /turf/unsimulated/beach/sand

/datum/zLevel/snow
	name = "snow"
	base_turf = /turf/unsimulated/floor/snow

/datum/zLevel/snow/post_mapload()
	var/lake_density = rand(2,8)
	for(var/i = 0 to lake_density)
		var/turf/T = locate(rand(1, world.maxx),rand(1, world.maxy), z)
		if(!istype(T, base_turf))
			continue
		var/generator = pick(typesof(/obj/structure/radial_gen/cellular_automata/ice))
		new generator(T)

	var/tree_density = rand(25,45)
	for(var/i = 0 to tree_density)
		var/turf/T = locate(rand(1,world.maxx),rand(1, world.maxy), z)
		if(!istype(T, base_turf))
			continue
		var/generator = pick(typesof(/obj/structure/radial_gen/movable/snow_nature/snow_forest) + typesof(/obj/structure/radial_gen/movable/snow_nature/snow_grass))
		new generator(T)