/turf/unsimulated/outside/sand
	name = "Sand"
	icon = 'icons/misc/beach.dmi'
	icon_state = "sand"
	dynamic_lighting = 0
	luminosity = 1
	plane = PLATING_PLANE

	temperature = T_ARCTIC
	oxygen = MOLES_O2STANDARD_ARCTIC
	nitrogen = MOLES_N2STANDARD_ARCTIC
	can_border_transition = 1
	plane = PLATING_PLANE
	var/real_snow_tile = TRUE //Set this to false if you want snowfall/blizzard overlay but no texture updating nor ability to pick up snowballs.
	var/initial_snowballs = -1 //-1 means random.
	var/snowballs = 0
	var/snow_state = SNOW_CALM
	var/snowprints = TRUE //if false, do not set up a snowprint parent, do not make snowprints
	var/obj/effect/sandprint_holder/snowprint_parent
	var/ignore_blizzard_updates = FALSE //if true, don't worry about global blizzard events
	var/obj/effect/sandstorm_holder/blizzard_parent
	turf_speed_multiplier = 1
	gender = PLURAL
	var/list/snowsound = list('sound/misc/snow1.ogg', 'sound/misc/snow2.ogg', 'sound/misc/snow3.ogg', 'sound/misc/snow4.ogg', 'sound/misc/snow5.ogg', 'sound/misc/snow6.ogg')

/turf/unsimulated/outside/sand/ChangeTurf(var/turf/N, var/tell_universe=1, var/force_lighting_update = 0, var/allow = 1)
	global_snowtiles -= src
	if(snowprint_parent)
		qdel(snowprint_parent)
	if(blizzard_parent)
		qdel(blizzard_parent)
	..()

/turf/unsimulated/outside/sand/New()
	..()
	blizzard_parent = new /obj/effect/sandstorm_holder(src)
	blizzard_parent.parent = src
	if(!snowtiles_setup)
		for(var/i = 0 to 3)
			snow_state = i
			blizzard_parent.UpdateSnowfall()
		snowtiles_setup = 1
	if(map && map.climate && istype(map.climate.current_weather,/datum/weather/snow))
		var/datum/weather/snow/S = map.climate.current_weather
		snow_state = S.snow_intensity
	else
		snow_state = SNOW_CALM
	if(real_snow_tile)
		if(initial_snowballs == -1)
			snowballs = rand(5, 10)
		else
			snowballs = initial_snowballs
		icon_state = "snow[rand(0, 6)]"
		if(snowprints)
			snowprint_parent = new /obj/effect/sandprint_holder(src)
	update_environment()
	global_snowtiles += src

/turf/unsimulated/outside/sand/Destroy()
	global_snowtiles -= src
	if(snowprint_parent)
		qdel(snowprint_parent)
	if(blizzard_parent)
		qdel(blizzard_parent)

/turf/unsimulated/outside/sand/proc/update_environment()
	if(real_snow_tile)
		if(snowballs)
			icon_state = "snow[rand(0,6)]"
		else
			icon_state = "permafrost_full"
			if(snowprint_parent)
				snowprint_parent.ClearSnowprints()
	blizzard_parent.UpdateSnowfall()
	switch(snow_state)
		if(SNOW_CALM)
			temperature = T_ARCTIC
			turf_speed_multiplier = 1 //higher numbers mean slower
		if(SNOW_AVERAGE)
			temperature = T_ARCTIC-5
			turf_speed_multiplier = 1
		if(SNOW_HARD)
			temperature = T_ARCTIC-10
			turf_speed_multiplier = 1.4
		if(SNOW_BLIZZARD)
			temperature = T_ARCTIC-20
			turf_speed_multiplier = 2.8
	turf_speed_multiplier *= 1+(snowballs/10)

/turf/unsimulated/outside/sand/Exited(atom/A, atom/newloc)
	..()
	if(istype(A,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = A
		if(snowprint_parent && snowballs && !H.flying)
			if(!H.locked_to && !H.lying) //Our human is walking or at least standing upright, create footprints
				snowprint_parent.AddSnowprintGoing(H.get_footprint_type(), H.dir)
			else //Our human is down on his ass or in a vehicle, create tracks
				snowprint_parent.AddSnowprintGoing(/obj/effect/decal/cleanable/blood/tracks/wheels, H.dir)

		if(!istype(newloc,/turf/unsimulated/floor/snow))
			H.clear_fullscreen("snowfall_average",0)
			H.clear_fullscreen("snowfall_hard",0)
			H.clear_fullscreen("snowfall_blizzard",0)
			H << sound(null, 0, 0, channel = CHANNEL_WEATHER)


/turf/unsimulated/outside/sand/Entered(atom/A, atom/OL)
	..()
	if(istype(A,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = A
		if(snowprint_parent && snowballs && !H.flying)
			if(!H.locked_to && !H.lying) //Our human is walking or at least standing upright, create footprints
				snowprint_parent.AddSnowprintComing(H.get_footprint_type(), H.dir)
			else //Our human is down on his ass or in a vehicle, create tracks
				snowprint_parent.AddSnowprintComing(/obj/effect/decal/cleanable/blood/tracks/wheels, H.dir)
		switch(snow_state)
			if(SNOW_CALM)
				H.clear_fullscreen("snowfall_average",0)
				H.clear_fullscreen("snowfall_hard",0)
				H.clear_fullscreen("snowfall_blizzard",0)
			if(SNOW_AVERAGE)
				H.overlay_fullscreen("snowfall_average", /obj/abstract/screen/fullscreen/snowfall_average)
				H.clear_fullscreen("snowfall_hard",0)
				H.clear_fullscreen("snowfall_blizzard",0)
			if(SNOW_HARD)
				H.clear_fullscreen("snowfall_average",0)
				H.overlay_fullscreen("snowfall_hard", /obj/abstract/screen/fullscreen/snowfall_hard)
			if(SNOW_BLIZZARD)
				H.clear_fullscreen("snowfall_average",0)
				H.clear_fullscreen("snowfall_hard",0)
				H.overlay_fullscreen("snowfall_blizzard", /obj/abstract/screen/fullscreen/snowfall_blizzard)
		if(H.client)
			if(!istype(OL,/turf/unsimulated/floor/snow))
				H << sound(snowstorm_ambience[snow_state+1], repeat = 1, wait = 0, channel = CHANNEL_WEATHER, volume = snowstorm_ambience_volumes[snow_state+1])
			if(isliving(H) && !H.locked_to && !H.lying && !H.flying)
				if(snowsound?.len)
					playsound(src, pick(snowsound), 10, 1, -1, channel = 123)


/turf/unsimulated/outside/sand/cultify()
	return //It's already pretty red out in nar-sie universe.

/obj/effect/sandstorm_holder //Exists to make it unclickable
	name = "blizzard"
	desc = "Brrr."
	density = 0
	anchored = 1
	plane = ABOVE_TURF_PLANE
	mouse_opacity = 0
	var/turf/unsimulated/outside/sand/parent

/obj/effect/sandstorm_holder/Destroy()
	parent = null
	..()

/obj/effect/sandstorm_holder/proc/UpdateSnowfall()
	if(!snow_state_to_texture["[parent.snow_state]"])
		cache_snowtile()
	appearance = snow_state_to_texture["[parent.snow_state]"]

/obj/effect/sandstorm_holder/proc/cache_snowtile()
	overlays.Cut()
	var/list/snowfall_overlays = list("snowfall_calm","snowfall_average","snowfall_hard","snowfall_blizzard")
	var/list/overlay_counts = list(2,2,2,3)
	for(var/i = 1 to overlay_counts[parent.snow_state+1])
		var/image/snowfx = image('icons/turf/snowfx.dmi', "[snowfall_overlays[parent.snow_state+1]][i]",SNOW_OVERLAY_LAYER)
		snowfx.plane = EFFECTS_PLANE
		overlays += snowfx
	snow_state_to_texture["[parent.snow_state]"] = appearance



/obj/effect/sandprint_holder
	name = "snowprint"
	desc = "Brrr."
	density = 0
	anchored = 1
	plane = ABOVE_TURF_PLANE
	mouse_opacity = 0 //Unclickable
	var/snowprint_color = "#BEBEBE"
	var/list/existing_prints = list()

/obj/effect/sandprint_holder/proc/AddSnowprintComing(var/obj/effect/decal/cleanable/blood/tracks/footprints/footprint_type, var/dir)
	if(existing_prints["[initial(footprint_type.coming_state)]-[dir]"])
		return
	existing_prints["[initial(footprint_type.coming_state)]-[dir]"] = 1
	var/icon/footprint = icon('icons/effects/fluidtracks.dmi', initial(footprint_type.coming_state), dir)
	footprint.SwapColor("#FFFFFF",snowprint_color)
	overlays += footprint

/obj/effect/sandprint_holder/proc/AddSnowprintGoing(var/obj/effect/decal/cleanable/blood/tracks/footprints/footprint_type, var/dir)
	if(existing_prints["[initial(footprint_type.going_state)]-[dir]"])
		return
	existing_prints["[initial(footprint_type.going_state)]-[dir]"] = 1
	var/icon/footprint = icon('icons/effects/fluidtracks.dmi', initial(footprint_type.going_state), dir)
	footprint.SwapColor("#FFFFFF",snowprint_color)
	overlays += footprint

/obj/effect/sandprint_holder/proc/ClearSnowprints()
	overlays.Cut()
	existing_prints.len = 0



/turf/unsimulated/outside/sand/attackby(obj/item/weapon/W as obj, mob/user as mob)

	..()

	if(snowballs && isshovel(W))
		user.visible_message("<span class='notice'>[user] digs out some snow with \the [W].</span>", \
		"<span class='notice'>You dig out some snow with \the [W].</span>")
		user.delayNextAttack(20)
		extract_snowballs(5, FALSE, user)
	else if(snowballs && istype(W,/obj/item/stack/sheet/snow))
		user.visible_message("<span class='notice'>[user] reaches down and gathers more snow.</span>", \
		"<span class='notice'>You reach down and bolster your snowball.</span>")
		user.delayNextAttack(10)
		extract_snowballs(1, TRUE, user, W)


/turf/unsimulated/outside/sand/CtrlClick(mob/user)

	if(snowballs)
		//Reach down and make a snowball
		user.visible_message("<span class='notice'>[user] reaches down and forms a snowball.</span>", \
		"<span class='notice'>You reach down and form a snowball.</span>")
		user.delayNextAttack(10)
		extract_snowballs(1, TRUE, user)

	..()

/turf/unsimulated/outside/sand/examine(var/mob/user)
	..()
	if(real_snow_tile)
		if(snowballs)
			to_chat(user,"<span class='info'>It seems to be [snowballs*2]cm high.</span>")
		else
			to_chat(user,"<span class='info'>It seems almost entirely devoid of snow, exposing the permafrost below.</span>")

/turf/unsimulated/outside/sand/proc/change_snowballs(var/delta, var/limit) //Changes snowball count by delta, but to be no lower/greater than limit. Updates texture, too.
	snowballs += delta //this can be negative, in which case it subtracts
	if(delta>=0)
		snowballs = min(snowballs, limit) //no more than the limit
	else
		snowballs = max(snowballs, 0)
	//This is a rare situation where we can't use Clamp(), because we don't want the limit to apply if subtracting
	update_environment()

/turf/unsimulated/outside/sand/proc/extract_snowballs(var/snowball_amount = 0, var/pick_up = FALSE, var/mob/user, var/obj/item/stack/sheet/snow/snowball_stack = null)
	if(!Adjacent(user))
		to_chat(user,"<span class='warning'>You're too far away to scoop snow.</span>")
		return
	if(!snowball_amount)
		return

	var/extract_amount = min(snowballs, snowball_amount)

	for(var/i = 0; i < extract_amount, i++)
		if(snowball_stack)
			snowball_stack.add(1)
			snowballs--
			break
		var/obj/item/stack/sheet/snow/snowball = new /obj/item/stack/sheet/snow(user.loc)
		snowball.pixel_x = rand(-16, 16) * PIXEL_MULTIPLIER //Would be wise to move this into snowball New() down the line
		snowball.pixel_y = rand(-16, 16) * PIXEL_MULTIPLIER

		if(pick_up)
			user.put_in_hands(snowball)

		snowballs--

	update_environment()

//In the future, catwalks should be the base to build in the arctic, not lattices
//This would however require a decent rework of floor construction and deconstruction
/turf/unsimulated/outside/sand/canBuildCatwalk()
	return BUILD_FAILURE

/turf/unsimulated/outside/sand/canBuildLattice()
	if(x >= (world.maxx - TRANSITIONEDGE) || x <= TRANSITIONEDGE)
		return BUILD_FAILURE
	else if (y >= (world.maxy - TRANSITIONEDGE || y <= TRANSITIONEDGE ))
		return BUILD_FAILURE
	else if(!(locate(/obj/structure/lattice) in contents))
		return BUILD_SUCCESS
	return BUILD_FAILURE

/turf/unsimulated/outside/sand/canBuildPlating()
	if(x >= (world.maxx - TRANSITIONEDGE) || x <= TRANSITIONEDGE)
		return BUILD_FAILURE
	else if (y >= (world.maxy - TRANSITIONEDGE || y <= TRANSITIONEDGE ))
		return BUILD_FAILURE
	else if(locate(/obj/structure/lattice) in contents)
		return BUILD_SUCCESS
	return BUILD_FAILURE