/datum/action/complex_vehicle_equipment/toggle_testweapon
	name = "Toggle Testweapon"
	button_icon_state = "engine_off"
	var/attached_part = /obj/item/device/vehicle_equipment/weaponry/testgun //Weapon tied to action
	var/weapon_toggle = FALSE

/datum/action/complex_vehicle_equipment/toggle_testweapon/Trigger()
	..()
	var/obj/complex_vehicle/S = target
	S.toggle_testcaseweapon(weapon_toggle)
	if(weapon_toggle)
		weapon_toggle = TRUE
		S.ES.weapon_toggle(attached_part, TRUE)
		button_icon_state = "engine_on"
	else
		weapon_toggle = FALSE
		S.ES.weapon_toggle(attached_part, FALSE)
		button_icon_state = "engine_off"
	UpdateButtonIcon()

/obj/complex_vehicle/proc/toggle_testcaseweapon(var/OnOrOff)
	if(usr!=get_pilot())
		return

	to_chat(src.get_pilot(), "<span class='notice'>Weapon Toggle [OnOrOff?"switched on":"switched off"].</span>")
	playsound(src, 'sound/items/flashlight_on.ogg', 50, 1)

/obj/item/device/vehicle_equipment/weaponry/testgun
	name = "\improper test ballistics system"
	desc = "for testing"
	icon_state = "pod_w_laser"
	projectile_type = /obj/item/projectile/bullet/weakbullet
	projectiles_per_shot = 2
	tied_action = /datum/action/complex_vehicle_equipment/toggle_testweapon //Action tied to weapon
	
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

