//This ones actually pretty simple in comparison to most.
/*
Yes the option is there to scan map elements and just dump a objective into a open turf in them.
Instead we are going to use a object.


*/
//Why is this just a bare object? Probably because other stuff appends itself to lists/etc

var/list/objective_markers = list()

/obj/jectie_time
	name = "Objective Spawner"
	desc = "Spawns objects that could be objectives."
	icon = 'z40k_shit/icons/abstract_markers.dmi'
	icon_state = "objective_marker"
	alpha = 255
	invisibility = 101
	mouse_opacity = 0

/obj/jectie_time/New()
	..()
	objective_markers += src

/obj/jectie_time/Destroy()
	..()

/datum/loada_gen/proc/loada_objectivegen()
	var/amount_of_objectives = 6
	for(var/i=1 to amount_of_objectives)
		var/obj/jectie_time/pick_jectie = pick(objective_markers)
		var/turf/T = get_turf(pick_jectie)
		new jectie_object(T) //we need objective objects before i go any further here.
		objective_markers -= pick_jectie //Thus the above line errors out.
		qdel(pick_jectie) //Not like anyone other than me works on this project anyways.

