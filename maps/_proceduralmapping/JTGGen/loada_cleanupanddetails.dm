
/proc/loada_cleanup_and_detailing(var/datum/map/active/ASS)
	CleanupSpace(ASS)
	
	if(ASS.dd_debug)
		log_startup_progress("CLEANUP AND DETAILING LOADA INITIATED")
