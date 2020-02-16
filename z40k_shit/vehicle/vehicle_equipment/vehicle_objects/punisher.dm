
/obj/item/device/vehicle_equipment/weaponry/punisher
	name = "Punisher Cannon"
	desc = "for testing"
	icon_state = "pod_w_laser"
	projectile_type = /obj/item/projectile/bullet/weakbullet
	projectiles_per_shot = 5
	tied_action = /datum/action/complex_vehicle_equipment/toggle_punisher //Action tied to weapon
	weapon_online = FALSE
	fire_delay = 1 //Delay on when next action can be done.
	fire_sound = list('z40k_shit/sounds/punisher1.wav',
					'z40k_shit/sounds/punisher2.wav',
					'z40k_shit/sounds/punisher3.wav',
					'z40k_shit/sounds/punisher4.wav'
					)
	

/obj/item/device/vehicle_equipment/weaponry/punisher/New()
	..()

/obj/item/device/vehicle_equipment/weaponry/punisher/action(atom/target)
	if(next_firetime > world.time)
		return
	var/turf/targloc = get_turf(target) //Target location is the turf of the target
	var/olddir //Basically a holder
	var/changedloc_variant = get_turf(my_atom) // A holder for height
	var/obj/complex_vehicle/DICKMASTER = my_atom
	dir = my_atom.dir //Direction is direction of the thing we are firing from
	for(var/i=1 to projectiles_per_shot) //For 1 to minimum 1 to protections per shot
		var/turf/curloc = get_turf(my_atom) //Our current location is gotten from our source turf
		if(olddir != dir) //If olddir is not our direction, aka null.
			dir = my_atom.dir //our direction is now our src containers direction
			switch(dir) //We enter a switch based on the direction
				if(NORTH) //If its north
					for(i=1 to DICKMASTER.vehicle_height) //Our actual object will always be in the bottom left corner
						changedloc_variant = get_step(changedloc_variant, NORTH) //Then we get the turf to the north of that one
					changedloc_variant = get_step(changedloc_variant, EAST)
				if(SOUTH)
					changedloc_variant = get_turf(my_atom)
					changedloc_variant = get_step(changedloc_variant, EAST)
				if(EAST)
					for(i=1 to DICKMASTER.vehicle_width)
						changedloc_variant = get_step(changedloc_variant, EAST)
					changedloc_variant = get_step(changedloc_variant, NORTH)
				if(WEST)
					changedloc_variant = get_turf(my_atom)
					changedloc_variant = get_step(changedloc_variant,NORTH)
			if (!targloc || !curloc)
				continue
			if (targloc == curloc)
				continue 
			olddir = dir
			playsound(src, pick(fire_sound), 50, 1)
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
			sleep(1)
	
	next_firetime = world.time + fire_delay
	return

