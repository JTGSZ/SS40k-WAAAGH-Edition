//STAGE 1 - Generate any mountains/hills and other shits.
//STAGE 2 - Random ruin and wreckage templates.
//STAGE 3 - spawnloada1 is ran placing the spawns.
//STAGE TURF INIT - Copy and pasted floragen shit from the halloween ball.


/proc/jt_loada_lakes(var/datum/map/active/ASS) //This doesn't work worth a shit

	var/lake_num = 0 //Basically so we can number the lakes on the dd debug output.
	
	for(var/i = 0 to ASS.amount_of_lakes) //We set the amount of lakes
		var/primary_x = rand(1, world.maxx)
		var/primary_y = rand(1, world.maxy)
		var/turf/T = locate(primary_x, primary_y, 1)
		if(!istype(T, /turf/unsimulated/outside/sand))
			continue
		var/generator = pick(typesof(/obj/structure/radial_gen/cellular_automata/waterlake))
		new generator(T)

		if(ASS.dd_debug)
			lake_num++
			log_startup_progress("---------LAKE GEN--------------")
			log_startup_progress("Lake number: [lake_num]")
			log_startup_progress("Lake amounts: [ASS.amount_of_lakes]") 
			log_startup_progress("Primary X: [primary_x], Primary Y: [primary_y]")

/proc/jt_loada_lakes1(var/datum/map/active/ASS) //THIS MAKES A SQUARE
	var/datum/mapGenerator/lakeblock/N = new()
	var/start = locate(10,10,1)
	var/end = locate(40,40,1)
	N.defineRegion(start, end)
	N.generate()
	log_startup_progress("LAKE LOADA 1 SUCCESSFUL")

/proc/jt_loada_lakes2(var/datum/map/active/ASS) //THIS MAKES A CIRCLE
	var/datum/mapGenerator/lakeblock/N = new()
	var/start1 = locate(10,10,1)
	var/end1 = locate(20,20,1)
	var/start2 = locate(20,20,1)
	var/end2 = locate(30,30,1)
	var/start3 = locate(25,25,1)
	var/end3 = locate(15,15,1)
	N.defineCircularRegion(start1, end1)
	N.generate()
	N.defineCircularRegion(start2,end2)
	N.generate()
	N.defineCircularRegion(start3,end3)
	N.generate()
	log_startup_progress("LAKE LOADA 2 SUCCESSFUL")