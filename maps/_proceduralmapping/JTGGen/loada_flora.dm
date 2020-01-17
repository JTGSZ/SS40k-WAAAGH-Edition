//Desert biome
/proc/loada_floragen(var/datum/map/active/ASS)
	var/datum/mapGenerator/desert/N = new()
	var/start = locate(1,1,1)
	var/end = locate(world.maxx,world.maxy,1)
	N.defineRegion(start, end)
	N.generate()
	
	if(ASS.dd_debug)
		log_startup_progress("FLORA LOAD SUCCESSFUL")
