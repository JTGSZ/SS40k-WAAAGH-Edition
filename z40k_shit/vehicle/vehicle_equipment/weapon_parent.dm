/obj/item/device/vehicle_equipment/weaponry
	name = "pod weapon"
	desc = "You shouldn't be seeing this"
	icon = 'icons/pods/ship.dmi'
	icon_state = "blank"
	var/projectile_type
	var/shot_cost = 0
	var/shots_per = 1
	var/fire_sound
	var/fire_delay = 10
	var/verb_name = "What the fuck?"
	var/verb_desc = "How did you get this?"

/obj/item/device/vehicle_equipment/weaponry/proc/action(atom/target)
	return //Basically when you click with the switch toggled on, it performs this proc.

/datum/groundtank/equipment
	var/obj/groundtank/my_atom
	var/movement_charge = 2
	var/weapons_allowed = 1
	var/obj/item/device/vehicle_equipment/weaponry/weapon_system // weapons system
	//var/obj/item/device/vehicle_equipment/engine/engine_system // engine system
	//var/obj/item/device/vehicle_equipment/shield/shield_system // shielding system

/datum/groundtank/equipment/New(var/obj/groundtank/SP)
	..()
	if(istype(SP))
		my_atom = SP

/obj/item/device/vehicle_equipment
	name = "equipment"
	var/obj/groundtank/my_atom
	
/*obj/item/device/vehicle_equipment/weaponry/proc/fire_weapon_system()
	var/obj/groundtank/S = src
	var/obj/item/device/vehicle_equipment/weaponry/SPE = S.ES.weapon_system
	set category = "groundtank"
	set name = SPE.verb_name
	set desc = SPE.verb_desc
	set src = usr.loc

	var/list/passengers = S.get_passengers()
	if(passengers.Find(usr) && !S.passenger_fire)
		to_chat(usr, "<span class = 'warning'>Passenger gunner system disabled.</span>")
		return
	SPE.fire_weapons()

/obj/item/device/vehicle_equipment/weaponry/proc/fire_weapons()
	if(my_atom.next_firetime > world.time)
		to_chat(usr, "<span class='warning'>Your weapons are recharging.</span>")
		return
	var/turf/firstloc
	var/turf/secondloc
	if(!my_atom.ES || !my_atom.ES.weapon_system)
		to_chat(usr, "<span class='warning'>Missing equipment or weapons.</span>")
		my_atom.verbs -= /obj/item/device/vehicle_equipment/weaponry/proc/fire_weapon_system
		return
	if(!my_atom.battery.use(shot_cost))
		to_chat(usr, "<span class='warning'>\The [my_atom]'s cell is too low on charge!</span>")
		return
	var/olddir
	dir = my_atom.dir
	for(var/i = 0; i < shots_per; i++)
		if(olddir != dir)
			switch(dir)
				if(NORTH)
					firstloc = get_turf(my_atom)
					firstloc = get_step(firstloc, NORTH)
					secondloc = get_step(firstloc,EAST)
				if(SOUTH)
					firstloc = get_turf(my_atom)
					secondloc = get_step(firstloc,EAST)
				if(EAST)
					firstloc = get_turf(my_atom)
					firstloc = get_step(firstloc, EAST)
					secondloc = get_step(firstloc,NORTH)
				if(WEST)
					firstloc = get_turf(my_atom)
					secondloc = get_step(firstloc,NORTH)
		olddir = dir
		var/obj/item/projectile/projone = new projectile_type(firstloc)
		var/obj/item/projectile/projtwo = new projectile_type(secondloc)
		projone.starting = get_turf(firstloc)
		projone.shot_from = my_atom
		projone.firer = usr
		projone.def_zone = LIMB_CHEST
		projtwo.starting = get_turf(secondloc)
		projtwo.shot_from = my_atom
		projtwo.firer = usr
		projtwo.def_zone = LIMB_CHEST
		spawn(0)
			playsound(my_atom, fire_sound, 50, 1)
			projone.dumbfire(dir)
		spawn(0)
			projtwo.dumbfire(dir)
		sleep(1)
	my_atom.next_firetime = world.time + fire_delay
*/

