/datum/action/complex_vehicle_equipment/toggle_demolisher
	name = "Toggle Weapon"
	button_icon_state = "weapons_off"
	var/attached_part = /obj/item/device/vehicle_equipment/weaponry/punisher //Weapon tied to action
	var/weapon_toggle = FALSE

/datum/action/complex_vehicle_equipment/toggle_demolisher/Trigger()
	..()
	var/obj/complex_vehicle/S = target
	
	weapon_toggle = !weapon_toggle
	
	if(weapon_toggle)
		button_icon_state = "weapons_on"
	else
		button_icon_state = "weapons_off"
	UpdateButtonIcon()
	S.toggle_weapon(weapon_toggle, attached_part, id)

