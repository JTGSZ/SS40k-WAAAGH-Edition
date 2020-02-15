/datum/action/complex_vehicle_equipment/toggle_testweapon
	name = "Toggle Testweapon"
	button_icon_state = "weapon_off"
	var/attached_part = /obj/item/device/vehicle_equipment/weaponry/testgun //Weapon tied to action
	var/weapon_toggle = FALSE

/datum/action/complex_vehicle_equipment/toggle_testweapon/Trigger()
	..()
	var/obj/complex_vehicle/S = target
	
	weapon_toggle = !weapon_toggle
	
	if(weapon_toggle)
		button_icon_state = "weapon_on"
	else
		button_icon_state = "weapon_off"
	UpdateButtonIcon()
	S.toggle_weapon(weapon_toggle, attached_part, id)

/obj/complex_vehicle/proc/toggle_weapon(var/weapon_toggle, var/obj/item/device/vehicle_equipment/weaponry/testgun/mygun, var/datum/action/complex_vehicle_equipment/actionid)
	if(usr!=get_pilot())
		return
		
	for(mygun in ES.equipment_systems)
		if(mygun.id == actionid)
			if(weapon_toggle)
				mygun.weapon_online = TRUE
				to_chat(src.get_pilot(), "<span class='notice'>[mygun.name] switched off.</span>")
				playsound(src, 'sound/items/flashlight_on.ogg', 50, 1)
			else
				mygun.weapon_online = FALSE
				to_chat(src.get_pilot(), "<span class='notice'>[mygun.name] switched on.</span>")
				playsound(src, 'sound/items/flashlight_on.ogg', 50, 1)
	
/obj/item/device/vehicle_equipment/weaponry/testgun
	name = "\improper test ballistics system"
	desc = "for testing"
	icon_state = "pod_w_laser"
	projectile_type = /obj/item/projectile/bullet/weakbullet
	projectiles_per_shot = 2
	tied_action = /datum/action/complex_vehicle_equipment/toggle_testweapon //Action tied to weapon
	weapon_online = FALSE

/obj/item/device/vehicle_equipment/weaponry/testgun/New()
	..()

/obj/item/device/vehicle_equipment/weaponry/testgun/action(atom/target)
	to_chat(world, "We are firing the testgun action and weapon online is [weapon_online]")
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

