
/*
	Projectile		---------------------------------------
				*/

/obj/item/projectile/bullet/heavybolter
	name = "heavy bolt round"
	desc = "This is going to hurt"
	icon = 'z40k_shit/icons/obj/projectiles.dmi'
	icon_state = "hbolter"
	damage = 45

/*
	Equipment Segment		--------------------------------------
						*/

/obj/item/device/vehicle_equipment/weaponry/heavybolter
	name = "Heavy Bolter"
	desc = "for testing"
	icon_state = "hbolter_cannon"
	projectile_type = /obj/item/projectile/bullet/heavybolter
	projectiles_per_shot = 3
	tied_action = /datum/action/complex_vehicle_equipment/toggle_heavybolter //Action tied to weapon
	weapon_online = FALSE
	fire_delay = 3 //Delay on when next action can be done.
	fire_sound = list('z40k_shit/sounds/HeavyBolter3.ogg')

/obj/item/device/vehicle_equipment/weaponry/heavybolter/New()
	..()

/obj/item/device/vehicle_equipment/weaponry/heavybolter/action(atom/target)
	if(next_firetime > world.time)
		return
	var/turf/targloc = get_turf(target) //Target location is the turf of the target
	var/olddir //Basically a holder outside the for loop, so we break if they turn.
	var/changedloc_variant = get_turf(my_atom) // A holder for height
	var/obj/complex_vehicle/DICKMASTER = my_atom

	for(var/i=1 to projectiles_per_shot) //For 1 to minimum 1 to protections per shot
		var/turf/curloc = get_turf(my_atom) //Our current location is gotten from our source turf
		dir = my_atom.dir //Direction is the direction of our atom
		if(!olddir)
			olddir = dir //olddirection is our direction
		switch(dir) //We enter a switch based on the direction
			if(NORTH) //If its north
				changedloc_variant = get_turf(my_atom)
				for(var/p=1 to DICKMASTER.vehicle_height+1) //Our actual object will always be in the bottom left corner
					changedloc_variant = get_step(changedloc_variant, NORTH) //Then we get the turf to the north of that one
				changedloc_variant = get_step(changedloc_variant, EAST)
			if(SOUTH)
				changedloc_variant = get_turf(my_atom)
				changedloc_variant = get_step(changedloc_variant, SOUTH)
				changedloc_variant = get_step(changedloc_variant, SOUTH)
				changedloc_variant = get_step(changedloc_variant, EAST)
			if(EAST)
				changedloc_variant = get_turf(my_atom)
				for(var/q=1 to DICKMASTER.vehicle_width+1)
					changedloc_variant = get_step(changedloc_variant, EAST)
				changedloc_variant = get_step(changedloc_variant, NORTH)
			if(WEST)
				changedloc_variant = get_turf(my_atom)
				changedloc_variant = get_step(changedloc_variant, WEST)
				changedloc_variant = get_step(changedloc_variant, WEST)
				changedloc_variant = get_step(changedloc_variant, NORTH)
		if(!targloc || !curloc)
			continue
		if(targloc == curloc)
			continue
		if(dir != olddir) //If old direction is not the same as our current direction
			break //We break
		playsound(src, pick(fire_sound), 50, 1, 12)
		var/obj/item/projectile/A = new projectile_type(changedloc_variant)
		A.vehicle = my_atom
		A.firer = usr
		A.original = target
		A.current = changedloc_variant
		A.starting = changedloc_variant
		A.yo = targloc.y - curloc.y
		A.xo = targloc.x - curloc.x
		A.OnFired()
		A.process()
		sleep(2)
	
	next_firetime = world.time + fire_delay
	return