//STAGE 1 - Generate any mountains/hills and other shits.
//STAGE 2 - Random ruin and wreckage templates.
//STAGE 3 - spawnloada1 is ran placing the spawns.
//STAGE TURF INIT - Copy and pasted floragen shit from the halloween ball.


///proc/spawnloada2()
//	var/lake_density = rand(2,8)
//	for(var/i = 0 to lake_density)
//		var/turf/T = locate(rand(1, world.maxx),rand(1, world.maxy), z)
//		if(!istype(T, base_turf))
//			continue
//		var/generator = pick(typesof(/obj/structure/radial_gen/cellular_automata/ice))
//		new generator(T)