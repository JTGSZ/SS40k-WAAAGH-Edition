/turf/unsimulated/outside //THE OUTSIDE WORLD, WHERE WE FUCKING BELONG.
	name = "floor"
	icon = 'icons/turf/floors.dmi'
	icon_state = "Floor3"
	plane = PLATING_PLANE
	
	var/footprints = TRUE //if false, do not set up a footprint parent, do not make footprints
	var/obj/effect/footprint_holder/footprint_parent //null object holder
	
	turf_speed_multiplier = 1
	gender = PLURAL
	var/footprint_color = "#ff0808" //This sets the color of the footprints.

/turf/unsimulated/outside/ex_act(severity)
	switch(severity)
		if(1.0)
			new/obj/effect/decal/cleanable/soot(src)
		if(2.0)
			if(prob(65))
				new/obj/effect/decal/cleanable/soot(src)
		if(3.0)
			if(prob(20))
				new/obj/effect/decal/cleanable/soot(src)

/turf/unsimulated/outside/attack_paw(user as mob)
	return src.attack_hand(user)

/turf/unsimulated/outside/add_dust()
	if(!(locate(/obj/effect/decal/cleanable/dirt) in contents))
		new/obj/effect/decal/cleanable/dirt(src)

/turf/unsimulated/outside/cultify()
	if((icon_state != "cult")&&(icon_state != "cult-narsie"))
		name = "engraved floor"
		icon_state = "cult"
		turf_animation('icons/effects/effects.dmi',"cultfloor",0,0,MOB_LAYER-1,anim_plane = OBJ_PLANE)

//--------------------OUTSIDE EFFECTS ------------------------------------

/turf/unsimulated/outside/ChangeTurf(var/turf/N, var/tell_universe=1, var/force_lighting_update = 0, var/allow = 1)
	if(footprint_parent)
		qdel(footprint_parent)
	..()

/turf/unsimulated/outside/New()
	..()

	if(footprints)
		footprint_parent = new /obj/effect/footprint_holder(src)
		footprint_parent.color_holder = footprint_color
	
/turf/unsimulated/outside/Destroy()
	if(footprint_parent)
		qdel(footprint_parent)

/turf/unsimulated/outside/proc/update_environment()
	if(footprint_parent)
		footprint_parent.Clearfootprints()

/turf/unsimulated/outside/Exited(atom/A, atom/newloc)
	..()
	if(istype(A,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = A
		if(footprint_parent && !H.flying)
			if(!H.locked_to && !H.lying) //Our human is walking or at least standing upright, create footprints
				footprint_parent.AddfootprintGoing(H.get_footprint_type(), H.dir)
			else //Our human is down on his ass or in a vehicle, create tracks
				footprint_parent.AddfootprintGoing(/obj/effect/decal/cleanable/blood/tracks/wheels, H.dir)

/turf/unsimulated/outside/Entered(atom/A, atom/OL)
	..()
	if(istype(A,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = A
		if(footprint_parent && !H.flying)
			if(!H.locked_to && !H.lying) //Our human is walking or at least standing upright, create footprints
				footprint_parent.AddfootprintComing(H.get_footprint_type(), H.dir)
			else //Our human is down on his ass or in a vehicle, create tracks
				footprint_parent.AddfootprintComing(/obj/effect/decal/cleanable/blood/tracks/wheels, H.dir)

/turf/unsimulated/outside/cultify()
	return //It's already pretty red out in nar-sie universe.

/obj/effect/footprint_holder
	name = "footprint"
	desc = "Brrr."
	density = 0
	anchored = 1
	plane = ABOVE_TURF_PLANE
	mouse_opacity = 0 //Unclickable
	var/color_holder = "#BEBEBE"
	var/list/existing_prints = list()

/obj/effect/footprint_holder/proc/AddfootprintComing(var/obj/effect/decal/cleanable/blood/tracks/footprints/footprint_type, var/dir)
	if(existing_prints["[initial(footprint_type.coming_state)]-[dir]"])
		return
	existing_prints["[initial(footprint_type.coming_state)]-[dir]"] = 1
	var/icon/footprint = icon('icons/effects/fluidtracks.dmi', initial(footprint_type.coming_state), dir)
	footprint.SwapColor("#FFFFFF",color_holder)
	overlays += footprint

/obj/effect/footprint_holder/proc/AddfootprintGoing(var/obj/effect/decal/cleanable/blood/tracks/footprints/footprint_type, var/dir)
	if(existing_prints["[initial(footprint_type.going_state)]-[dir]"])
		return
	existing_prints["[initial(footprint_type.going_state)]-[dir]"] = 1
	var/icon/footprint = icon('icons/effects/fluidtracks.dmi', initial(footprint_type.going_state), dir)
	footprint.SwapColor("#FFFFFF",color_holder)
	overlays += footprint

/obj/effect/footprint_holder/proc/Clearfootprints()
	overlays.Cut()
	existing_prints.len = 0



/turf/unsimulated/outside/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()

//In the future, catwalks should be the base to build in the arctic, not lattices
//This would however require a decent rework of floor construction and deconstruction
/turf/unsimulated/outside/canBuildCatwalk()
	return BUILD_FAILURE

/turf/unsimulated/outside/canBuildLattice()
	if(x >= (world.maxx - TRANSITIONEDGE) || x <= TRANSITIONEDGE)
		return BUILD_FAILURE
	else if (y >= (world.maxy - TRANSITIONEDGE || y <= TRANSITIONEDGE ))
		return BUILD_FAILURE
	else if(!(locate(/obj/structure/lattice) in contents))
		return BUILD_SUCCESS
	return BUILD_FAILURE

/turf/unsimulated/outside/canBuildPlating()
	if(x >= (world.maxx - TRANSITIONEDGE) || x <= TRANSITIONEDGE)
		return BUILD_FAILURE
	else if (y >= (world.maxy - TRANSITIONEDGE || y <= TRANSITIONEDGE ))
		return BUILD_FAILURE
	else if(locate(/obj/structure/lattice) in contents)
		return BUILD_SUCCESS
	return BUILD_FAILURE
