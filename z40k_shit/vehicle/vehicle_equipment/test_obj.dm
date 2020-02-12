/datum/action/complex_vehicle_equipment/pilot/toggle_testweapon
	name = "Toggle Testweapon"
	button_icon_state = "engine_off"
	var/attached_part = /obj/item/device/vehicle_equipment/weaponry/testgun //Weapon tied to action

/datum/action/complex_vehicle_equipment/pilot/toggle_testweapon/Trigger()
	..()
	var/obj/groundturret/S = target
	S.toggle_testcaseweapon(attached_part)
	if(S.weapon_toggle)
		button_icon_state = "engine_on"
	else
		button_icon_state = "engine_off"
	UpdateButtonIcon()

/obj/groundturret/proc/toggle_testcaseweapon(var/attached_part)
	if(usr!=get_pilot())
		return

	if(weapon_toggle)
		selected_equipment -= attached_part
		weapon_toggle = FALSE
	else
		selected_equipment += attached_part
		weapon_toggle = TRUE
	
	to_chat(src.get_pilot(), "<span class='notice'>Weapon Toggle [weapon_toggle?"switched on":"switched off"].</span>")
	playsound(src, 'sound/items/flashlight_on.ogg', 50, 1)

/obj/item/device/vehicle_equipment/weaponry/testgun
	name = "\improper test ballistics system"
	desc = "for testing"
	icon_state = "pod_w_laser"
	projectile_type = /obj/item/projectile/bullet/weakbullet
	projectiles_per_shot = 2
	tied_action = /datum/action/complex_vehicle_equipment/pilot/toggle_testweapon //Action tied to weapon
	
/obj/item/device/vehicle_equipment/weaponry/testgun/action(atom/target)
	var/originaltarget = target
	var/turf/targloc = get_turf(target)
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

