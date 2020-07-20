/*
	One might ask what is this?
	Well If we wanted to control a lot of specifics about certain segments of the map or objects.
	We need a container for variables/references to draw from.
	This is for the scenario someone would enter a area, and we didn't want other people to also
	enter
	Or we wanted like, teleporters/other stuff to become active etc.
	I've tied it to a global variable.
	its in global_vars.dm, you can reference it with map_scenario_controller
	We create the object in world.dm line 119 or around that
*/

/datum/map_scenario_controller
	var/name = "Map Scenario Controller"
	var/desc = "A controller used to just control map segments etc towards certain goals."

/*
	SEGMENT 1 - Mask Retrieval Dungeon
										*/
	var/S1_people_entered = 0 //Amount of people who have entered the teleporter
	var/S1_currently_sealed = FALSE //Whether we are currently sealing them in, aka teleport is off.
	var/list/S1_firetrap_room_vertical = list() //The firetraps we have added for the firetrap room
	var/list/S1_firetrap_room_horizontal = list() //Horizontal firetraps in the room
	var/S1_ticker_vertical = 0
	var/S1_ticker_horizontal = 0
/*
	Teleporter calls this, we tick up.
	If the people entered is greater than or equal to 3, we seal it until they die or complete it.
*/
/datum/map_scenario_controller/proc/tick_segment_one(var/atom/movable/A)
	if(ismob(A))
		if(iscarbon(A))
			var/mob/living/carbon/M = A
			if(M.client)
				S1_people_entered++
			
	if(S1_people_entered >= 2)
		spawn(30 SECONDS)
			S1_currently_sealed = TRUE
			spawn(10 MINUTES)
				S1_currently_sealed = FALSE
		
	//	processing_objects.Add(src)
/*
/datum/map_scenario_controller/proc/process()
	S1_ticker_vertical++
	S1_ticker_horizontal++
	for(var/obj/structure/traps/traps in S1_firetrap_room_vertical)
		if(traps.scenario_controller_id == S1_ticker_vertical)
			traps.turn_my_ass_over()

	for(var/obj/structure/traps/traps in S1_firetrap_room_horizontal)
		if(traps.scenario_controller_id == S1_ticker_horizontal)
			traps.turn_my_ass_over()*/


