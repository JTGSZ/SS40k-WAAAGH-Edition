//STAGE 1 - Generate any mountains/hills and other shits.
//STAGE 2 - Random ruin and wreckage templates.
//STAGE 3 - spawnloada1 is ran placing the spawns.
//STAGE TURF INIT - Copy and pasted floragen shit from the halloween ball.

/proc/loada_lakes3(var/datum/map/active/ASS)
	CreateDeeps(ASS)
	CreateShallows()
	
	if(ASS.dd_debug)
		log_startup_progress("LAKE LOADA 3 INITIATED")

/proc/loada_rivers1(var/datum/map/active/ASS)
	CreateRiver(ASS)
	
	if(ASS.dd_debug)
		log_startup_progress("RIVER LOADA 1 INITIATED")

/proc/loada_river2lake1(var/datum/map/active/ASS)
	CreateRiver2Lake(ASS) //
	CreateShallows()

	if(ASS.dd_debug)
		log_startup_progress("RIVER 2 LAKE LOADA INITIATED")

/proc/loada_floragen(var/datum/map/active/ASS)
	var/datum/mapGenerator/desert/N = new()
	var/start = locate(1,1,1)
	var/end = locate(world.maxx,world.maxy,1)
	N.defineRegion(start, end)
	N.generate()
	log_startup_progress("FLORA LOAD SUCCESSFUL")