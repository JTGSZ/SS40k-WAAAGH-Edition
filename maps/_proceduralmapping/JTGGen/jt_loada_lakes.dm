//STAGE 1 - Generate any mountains/hills and other shits.
//STAGE 2 - Random ruin and wreckage templates.
//STAGE 3 - spawnloada1 is ran placing the spawns.
//STAGE TURF INIT - Copy and pasted floragen shit from the halloween ball.


/proc/jt_loada_lakes(var/datum/map/active/ASS)
	var/primary_x = rand(1, world.maxx)
	var/primary_y = rand(1, world.maxy)
	var/lake_density = rand(2,8)
	
	for(var/i = 0 to lake_density)
		var/turf/T = locate(primary_x, primary_y, 1)
		if(!istype(T, /turf/unsimulated/outside/sand))
			continue
		var/generator = pick(typesof(/obj/structure/radial_gen/cellular_automata/waterlake))
		new generator(T)

	if(ASS.dd_debug)
		log_startup_progress("---------LAKE GEN--------------")
		log_startup_progress("Lake Density: [lake_density]") 
		log_startup_progress("Primary X: [primary_x], Primary Y: [primary_y]")
