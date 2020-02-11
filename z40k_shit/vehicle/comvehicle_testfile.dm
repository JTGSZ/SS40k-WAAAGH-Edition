
/obj/item/device/vehicle_equipment/weaponry/testgun
	name = "\improper test ballistics system"
	desc = "for testing"
	icon_state = "pod_w_laser"
	projectile_type = /obj/item/projectile/bullet/weakbullet
	shot_cost = 0
	shots_per = 20
	var/projectiles_per_shot = 2
	
/obj/item/device/vehicle_equipment/weaponry/testgun/action(atom/target)
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
	return

