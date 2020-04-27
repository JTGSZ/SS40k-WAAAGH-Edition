
/datum/loada_gen/proc/loada_cleanup_and_detailing()
	CleanupSpace(ASS)

	CreateCoastline()
	
	if(ASS.dd_debug)
		log_startup_progress("CLEANUP AND DETAILING LOADA INITIATED")
