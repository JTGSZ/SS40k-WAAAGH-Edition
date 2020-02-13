
//Toggle Passenger Allowance
/datum/action/complex_vehicle_equipment/toggle_passengers
	name = "Toggle Passenger Allowance"
	button_icon_state = "lock_open"

/datum/action/complex_vehicle_equipment/toggle_passengers/Trigger()
	..()
	var/obj/groundtank/S = target
	S.toggle_passengers()
	if(S.passengers_allowed)
		button_icon_state = "lock_open"
	else
		button_icon_state = "lock_closed"
	UpdateButtonIcon()

//Toggle Passenger Weaponry
/datum/action/complex_vehicle_equipment/toggle_passenger_weaponry
	name = "Toggle Passenger Weaponry"
	button_icon_state = "weapons_off"

/datum/action/complex_vehicle_equipment/toggle_passenger_weaponry/Trigger()
	..()
	var/obj/groundtank/S = target
	S.toggle_passenger_guns()
	if(S.passenger_fire)
		button_icon_state = "weapons_on"
	else
		button_icon_state = "weapons_off"
	UpdateButtonIcon()

/datum/action/complex_vehicle_equipment/passenger/Trigger()
	..()
	var/obj/groundtank/S = target
	if(!S || !S.occupants.Find(owner))
		to_chat(owner, "<span class = 'warning'>How did you get control of this button?</span>")
		qdel(src)
		return


//Toggle Lights
/datum/action/complex_vehicle_equipment/toggle_lights
	name = "Toggle lights"
	button_icon_state = "toggle_lights"

/datum/action/complex_vehicle_equipment/toggle_lights/Trigger()
	..()
	var/obj/groundtank/S = target
	S.toggle_lights()
	