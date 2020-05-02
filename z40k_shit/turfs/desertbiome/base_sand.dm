/turf/unsimulated/outside/sand
	name = "Sand"
	//icon = 'icons/misc/beach.dmi'
	//icon_state = "sand"
	icon = 'z40k_shit/icons/turfs/desertsand.dmi'
	icon_state = "sand1"
	dynamic_lighting = 0
	//luminosity = 1
	plane = PLATING_PLANE

	can_border_transition = 0
	floragen = TRUE
	footprint_color = "#BC8F4B" 


/turf/unsimulated/outside/sand/New()
	..()
	if(prob(1))
		if(prob(5))
			icon_state = "sand[rand(2,4)]"
	else
		icon_state = "sand1"
