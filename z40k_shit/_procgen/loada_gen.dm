/*
	Basically below is the procedural generation datum.
														*/

/* 
You may ask, why would we handle it this way?
Well the answer is that we need the coordinates of certain things to build off each other.
When I do it via just using global procs, it works yes, but what if I need,
Information from one of the procedures? I'd have to pass it somewhere, so we might as well hold
All the information I need in a datum. As for why its in this folder now? Mostly so Its relicensed,
And so I can find it easily.

As for the plan here, we will do things in stages like before except now we can use information!.
Heres a rough outline relevant as of 4/27/2020. The stages are basically markers of the steps
Of the old way.
Appends are what we can do using information saved in the datum/other thoughts.

Stage 1 - We generate random templates
Append - We can run through and place objective objects.
Stage 2 - We generate the Spawns
Append - We can now generate a town
Stage 3 - We generate rivers/lakes
Stage 4 - We do cleanup and detailing
Stage 5 - We load all the flora in.
Append - We load in some Fauna
*/

/datum/loada_gen
	var/datum/map/active/ASS

/datum/loada_gen/New(var/datum/map/active/map_datum,var/gen_cycle) //We pass the map datum, and what cycle to pick.
	ASS = map_datum
	
	switch(gen_cycle)
		if("prototype_desert")
			loada_prototype_desert(ASS)
			log_startup_progress("Prototype Desert Generation Selected")


/datum/loada_gen/proc/loada_prototype_desert()
	
	var/watch2 = start_watch()
	loada_generate_template()
	log_startup_progress("Finished with generating templates in [stop_watch(watch2)]s.")

	var/watch1 = start_watch()
	loada_spawns()
	log_startup_progress("Finished with generating spawns in [stop_watch(watch1)]s.")

	var/watch3 = start_watch()
	loada_river2lake1(src)
	log_startup_progress("Finished with rivers and lakes in [stop_watch(watch3)]s.")

	var/watch5 = start_watch()
	loada_cleanup_and_detailing(src)
	log_startup_progress("Finished with cleanup/detailing. [stop_watch(watch5)]s.")

	var/watch4 = start_watch()
	loada_floragen(src)
	log_startup_progress("Finished with floragen in [stop_watch(watch4)]s.")
