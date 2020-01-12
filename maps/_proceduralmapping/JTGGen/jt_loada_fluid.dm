//STAGE 1 - Generate any mountains/hills and other shits.
//STAGE 2 - Random ruin and wreckage templates.
//STAGE 3 - spawnloada1 is ran placing the spawns.
//STAGE TURF INIT - Copy and pasted floragen shit from the halloween ball.

/proc/jt_loada_lakes3(var/datum/map/active/ASS)
	CreateDeeps()
	CreateShallows()
	
	if(ASS.dd_debug)
		log_startup_progress("LAKE LOADA 3 SUCCESSFUL")

/proc/jt_loada_rivers1(var/datum/map/active/ASS, var/rivercount)
	CreateRiver(rivercount)
	
	if(ASS.dd_debug)
		log_startup_progress("RIVER LOADA 1 SUCCESSFUL")