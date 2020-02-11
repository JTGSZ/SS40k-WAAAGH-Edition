/datum/action/groundturret
	icon_icon = 'icons/pods/button_icons.dmi'
	background_icon_state = "bg_pod"

/datum/action/groundturret/Trigger()
	..()
	var/obj/groundturret/S = target
	if(!istype(S))
		qdel(src)
		return

/datum/action/groundturret/fire_weapons
	name = "Fire weapons"
	button_icon_state = "weapon"

/datum/action/groundturret/fire_weapons/Trigger()
	..()
	var/obj/groundturret/S = target
	if(S.ES && S.ES.weapon_system)
		var/obj/item/device/groundtank_equipment/weaponry/W = S.ES.weapon_system
		W.fire_weapons()

/datum/action/groundturret/pilot //Subtype for space pod pilots only

//area



/obj/item/device/groundtank_equipment/weaponry/proc/action(atom/target)
	return

/obj/item/device/groundtank_equipment/weaponry/testgun
	name = "\improper test ballistics system"
	desc = "for testing"
	icon_state = "pod_w_laser"
	projectile_type = /obj/item/projectile/bullet/weakbullet
	shot_cost = 0
	shots_per = 20
	var/projectiles_per_shot = 2
	
/obj/item/device/groundtank_equipment/weaponry/proc/fire_weapons2test()
	if(my_atom.next_firetime > world.time)
		to_chat(usr, "<span class='warning'>Your weapons are recharging.</span>")
		return
	var/turf/firstloc
	var/turf/secondloc
	if(!my_atom.ES || !my_atom.ES.weapon_system)
		to_chat(usr, "<span class='warning'>Missing equipment or weapons.</span>")
		my_atom.verbs -= /obj/item/device/groundtank_equipment/weaponry/proc/fire_weapon_system
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

/obj/item/device/groundtank_equipment/weaponry/testgun/action(atom/target)
	if(my_atom.next_firetime > world.time)
		to_chat(usr, "<span class='warning'>Your weapons are recharging.</span>")
		return
	var/originaltarget = target
	var/turf/targloc = get_turf(target)
	spawn(0)
		for(var/i=1 to min(1, projectiles_per_shot))
			var/turf/curloc = get_turf(src)
			if(defective)
				target = get_inaccuracy(originaltarget, 2, src)
				targloc = get_turf(target)
			if (!targloc || !curloc)
				continue
			if (targloc == curloc)
				continue
			playsound(src, fire_sound, 50, 1)
			var/obj/item/projectile/A = new projectile_type(curloc)
			A.firer = usr
			A.original = target
			A.current = curloc
			A.starting = curloc
			A.yo = targloc.y - curloc.y
			A.xo = targloc.x - curloc.x
			A.OnFired()
			A.process()
			sleep(2)
	//do_after_cooldown()
	return
