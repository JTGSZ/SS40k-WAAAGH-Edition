/obj/groundturret/MouseDropTo(mob/M, mob/user)
	if(M != user)
		return
	if(!Adjacent(M) || !Adjacent(user))
		return
	attempt_move_inside(M, user)

/obj/groundturret/proc/click_action_control(atom/target,mob/user)
	if(user != get_pilot()) //If user is not pilot return false
		return
	if(user.stat)
		return
	if(src == target)
		return
	var/dir_to_target = get_dir(src,target)
	if(dir_to_target && !(dir_to_target & src.dir))//wrong direction
		return
		if(!target)
			return
	if(get_dist(src, target)>1)
		if(ES.equipment_systems.len)
			for(var/obj/item/device/vehicle_equipment/weaponry/COCK in ES.equipment_systems)
				if(COCK.systems_online)
					COCK.action(target)
					sleep(1)
