/spell/aoe_turf/assail
	name = "Assail"
	desc = "Witchfire(Beam) - Sends forth earth, and a lot of it."
	abbreviation = "GOKU"
	user_type = USER_TYPE_PSYKER
	specialization

	charge_type = Sp_RECHARGE
	charge_max = 500
	spell_flags = 0
	spell_aspect_flags = SPELL_GROUND
	range = 20
	invocation_type = SpI_NONE
	var/beam_length = 20
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"

	hud_state = "assail"

/spell/aoe_turf/assail/cast(list/targets, mob/living/user)
	set waitfor = 0
	user.anchored = TRUE

	var/turf/user_turf = get_turf(user)
	var/turf/starting_turf = get_step(user_turf, user.dir)
	var/turf/bound_adjustment

	if(do_after(user,user,30))
		if(user.attribute_sensitivity >= 800 && user.attribute_willpower >= 15)
			/*Logic: 	3 2 1 $ 1 2 3
						& & & & & & &				
						$ 1 2 3 4 5 6
										*/	
			switch(user.dir)
				if(NORTH)
					bound_adjustment = get_step(starting_turf,turn(user.dir,90))
					for(var/i=1 to 2) //2 and 3.
						bound_adjustment = get_step(bound_adjustment,turn(user.dir,90))
				if(SOUTH)
					bound_adjustment = get_step(starting_turf,turn(user.dir,-90))
					for(var/i=1 to 2) //2 and 3.
						bound_adjustment = get_step(bound_adjustment,turn(user.dir,-90))
				if(EAST)
					bound_adjustment = get_step(starting_turf,turn(user.dir,-90))
					for(var/i=1 to 2) //2 and 3.
						bound_adjustment = get_step(bound_adjustment,turn(user.dir,-90))
				if(WEST)
					bound_adjustment = get_step(starting_turf,turn(user.dir,90))
					for(var/i=1 to 2) //2 and 3.
						bound_adjustment = get_step(bound_adjustment,turn(user.dir,90))

			new /obj/effect/super_thrown_rock/head(bound_adjustment,user.dir,beam_length)

		else
			/*Logic:	1 $ 1
						& & &
						$ 1 2		*/
			switch(user.dir)
				if(NORTH)
					bound_adjustment = get_step(starting_turf,turn(user.dir, 90)) //1
				if(SOUTH)
					bound_adjustment = get_step(starting_turf,turn(user.dir,-90)) //1
				if(EAST)
					bound_adjustment = get_step(starting_turf,turn(user.dir,-90)) //1
				if(WEST)
					bound_adjustment = get_step(starting_turf,turn(user.dir, 90)) //1
			new /obj/effect/thrown_rock/head(bound_adjustment,user.dir,beam_length)
	else
		to_chat(user,"<span class='bad'> Your casting was disrupted</span>")

/spell/aoe_turf/assail/choose_targets(var/mob/user = usr)
	return list(user)

/*
	SUPER MOLTEN BEAM
						*/

/obj/effect/super_thrown_rock
	name = "ascended molten beam"
	desc = "What a psyker whom is high powered can do"
	density = 1
	w_type = NOT_RECYCLABLE
	anchored = 1

/obj/effect/super_thrown_rock/to_bump(atom/A)
	consume(A)

/obj/effect/super_thrown_rock/Bumped(atom/A)
	consume(A)

/obj/effect/super_thrown_rock/Crossed(atom/movable/A)
	consume(A)

/obj/effect/super_thrown_rock/proc/consume(atom/A)
	var/obj/item/O = A
	if(istype(A,/obj/item))
		qdel(O)

	var/obj/complex_vehicle/CV = A
	if(istype(A,/obj/complex_vehicle))
		CV.health -= 1000

	if(iscarbon(A))
		var/mob/living/carbon/C = A
		C.gib()

	var/obj/structure/ST = A
	if(istype(A, /obj/structure))
		qdel(ST)

	var/obj/machinery/MACH = A
	if(istype(A,/obj/machinery))
		qdel(MACH)

/obj/effect/super_thrown_rock/head
	var/list/segments = list() //we recordo ur segments
	var/traveled_length = 0 //How much of it we have done

/obj/effect/super_thrown_rock/head/New(var/turf/T, var/direction, var/beam_length)
	..()

	switch(direction)
		if(NORTH)
			icon = 'z40k_shit/icons/224x32assail.dmi'
			icon_state = "beamhead_north"
			bound_width = 7 * WORLD_ICON_SIZE
		if(SOUTH)
			icon = 'z40k_shit/icons/224x32assail.dmi'
			icon_state = "beamhead_south"
			bound_width = 7 * WORLD_ICON_SIZE
		if(EAST)
			icon = 'z40k_shit/icons/32x224assail.dmi'
			icon_state = "beamhead_east"
			bound_height = 7 * WORLD_ICON_SIZE
		if(WEST)
			icon = 'z40k_shit/icons/32x224assail.dmi'
			icon_state = "beamhead_west"
			bound_height = 7 * WORLD_ICON_SIZE

	var/turf/ARGH
	for(var/i=1 to beam_length)
		traveled_length++
		if(beam_length > traveled_length)
			if(step(src,direction))
				ARGH = get_step(src,turn(direction,180))
				var/obj/effect/super_thrown_rock/tail/AH = new(ARGH, direction)
				segments += AH			
				ARGH.ChangeTurf(get_base_turf(src.z))
				sleep(3)

	if(traveled_length <= beam_length)
		beam_end()

/obj/effect/super_thrown_rock/head/proc/beam_end()
	for(var/obj/effect/super_thrown_rock/tail/AH in segments)
		qdel(AH)

	qdel(src)

/obj/effect/super_thrown_rock/tail

/obj/effect/super_thrown_rock/tail/New(var/turf/T,direction)
	..()
	
	switch(direction)
		if(NORTH)
			icon = 'z40k_shit/icons/224x32assail.dmi'
			icon_state = "beammiddle"
			bound_width = 7 * WORLD_ICON_SIZE
		if(SOUTH)
			icon = 'z40k_shit/icons/224x32assail.dmi'
			icon_state = "beammiddle"
			bound_width = 7 * WORLD_ICON_SIZE
		if(EAST)
			icon = 'z40k_shit/icons/32x224assail.dmi'
			icon_state = "beammiddle"
			bound_height = 7 * WORLD_ICON_SIZE
		if(WEST)
			icon = 'z40k_shit/icons/32x224assail.dmi'
			icon_state = "beammiddle"
			bound_height = 7 * WORLD_ICON_SIZE

/*
	REGULAR MOLTEN BEAM
						*/

/obj/effect/thrown_rock
	name = "regular molten beam"
	desc = "What a psyker whom is high powered can do"
	density = 1
	w_type = NOT_RECYCLABLE
	anchored = 1

/obj/effect/thrown_rock/to_bump(atom/A)
	consume(A)

/obj/effect/thrown_rock/Bumped(atom/A)
	consume(A)

/obj/effect/thrown_rock/Crossed(atom/movable/A)
	consume(A)

/obj/effect/thrown_rock/proc/consume(atom/A)
	var/obj/item/O = A
	if(istype(A,/obj/item))
		qdel(O)

	var/mob/living/carbon/C = A
	if(istype(A,/mob/living/carbon))
		C.gib()

	var/obj/structure/ST = A
	if(istype(A, /obj/structure))
		qdel(ST)

/obj/effect/thrown_rock/head
	var/list/segments = list() //record our segments
	var/traveled_length = 0

/obj/effect/thrown_rock/head/New(var/turf/T, var/direction, var/beam_length)
	..()

	switch(direction)
		if(NORTH)
			icon = 'z40k_shit/icons/96x32assail.dmi'
			icon_state = "beamhead_north"
			bound_width = 3 * WORLD_ICON_SIZE
		if(SOUTH)
			icon = 'z40k_shit/icons/96x32assail.dmi'
			icon_state = "beamhead_south"
			bound_width = 3 * WORLD_ICON_SIZE
		if(EAST)
			icon = 'z40k_shit/icons/32x96assail.dmi'
			icon_state = "beamhead_east"
			bound_height = 3 * WORLD_ICON_SIZE
		if(WEST)
			icon = 'z40k_shit/icons/32x96assail.dmi'
			icon_state = "beamhead_west"
			bound_height = 3 * WORLD_ICON_SIZE

	var/turf/ARGH
	for(var/i=1 to beam_length)
		traveled_length++
		if(beam_length > traveled_length)
			if(step(src,direction))
				ARGH = get_step(src,turn(direction,180))
				var/obj/effect/assail/tail/AH = new(ARGH, direction)
				segments += AH			
				ARGH.ChangeTurf(get_base_turf(src.z))
				sleep(3)
	
	if(traveled_length <= beam_length)
		beam_end()

/obj/effect/thrown_rock/head/proc/beam_end()
	for(var/obj/effect/assail/tail/AH in segments)
		qdel(AH)

	qdel(src)

/obj/effect/thrown_rock/tail

/obj/effect/thrown_rock/tail/New(var/turf/T,direction)
	..()

	switch(direction)
		if(NORTH)
			icon = 'z40k_shit/icons/96x32assail.dmi'
			icon_state = "beammiddle"
			bound_width = 3 * WORLD_ICON_SIZE
		if(SOUTH)
			icon = 'z40k_shit/icons/96x32assail.dmi'
			icon_state = "beammiddle"
			bound_width = 3 * WORLD_ICON_SIZE
		if(EAST)
			icon = 'z40k_shit/icons/32x96assail.dmi'
			icon_state = "beammiddle"
			bound_height = 3 * WORLD_ICON_SIZE
		if(WEST)
			icon = 'z40k_shit/icons/32x96assail.dmi'
			icon_state = "beammiddle"
			bound_height = 3 * WORLD_ICON_SIZE