/turf/unsimulated/outside //THE OUTSIDE WORLD, WHERE WE FUCKING BELONG.
	name = "floor"
	icon = 'icons/turf/floors.dmi'
	icon_state = "Floor3"
	plane = FLOOR_PLANE

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