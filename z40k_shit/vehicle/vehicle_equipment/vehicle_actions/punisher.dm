/datum/action/complex_vehicle_equipment/toggle_punisher
	name = "Toggle Weapon"
	button_icon_state = "weapons_off"
	var/attached_part = /obj/item/device/vehicle_equipment/weaponry/punisher //Weapon tied to action
	var/weapon_toggle = FALSE

/datum/action/complex_vehicle_equipment/toggle_punisher/Trigger()
	..()
	var/obj/complex_vehicle/S = target
	
	weapon_toggle = !weapon_toggle
	
	if(weapon_toggle)
		button_icon_state = "weapons_on"
	else
		button_icon_state = "weapons_off"
	UpdateButtonIcon()
	S.toggle_weapon(weapon_toggle, attached_part, id)

/obj/complex_vehicle/proc/toggle_punisher(var/weapon_toggle, var/obj/item/device/vehicle_equipment/weaponry/mygun, var/datum/action/complex_vehicle_equipment/actionid)
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