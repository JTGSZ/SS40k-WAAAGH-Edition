/*
	Basically a counter teleporter.
	We ref the map_scenario_controller
*/
/obj/effect/step_trigger/teleporter/counter
	teleport_x = 0	// teleportation coordinates (if one is null, then no teleport!)
	teleport_y = 0
	teleport_z = 0

/obj/effect/step_trigger/teleporter/Trigger(var/atom/movable/A)
	if(map_scenario_controller.S1_currently_sealed)
		return

	if(teleport_x && teleport_y && teleport_z)
		A.x = teleport_x
		A.y = teleport_y
		A.z = teleport_z

	map_scenario_controller.tick_segment_one(A)
