/datum/action/groundtank
	icon_icon = 'icons/pods/button_icons.dmi'
	background_icon_state = "bg_pod"

/datum/action/groundtank/Trigger()
	..()
	var/obj/groundtank/S = target
	if(!istype(S))
		qdel(src)
		return

/datum/action/groundtank/fire_weapons
	name = "Fire weapons"
	button_icon_state = "weapon"

/datum/action/groundtank/fire_weapons/Trigger()
	..()
	var/obj/groundtank/S = target
	if(S.ES && S.ES.weapon_system)
		var/obj/item/device/groundtank_equipment/weaponry/W = S.ES.weapon_system
		var/list/passengers = S.get_passengers()
		if(passengers.Find(owner) && !S.passenger_fire)
			to_chat(owner, "<span class = 'warning'>Passenger gunner system disabled.</span>")
			return
		W.fire_weapons()

/datum/action/groundtank/pilot //Subtype for space pod pilots only

/datum/action/groundtank/pilot/toggle_passengers
	name = "Toggle Passenger Allowance"
	button_icon_state = "lock_open"

/datum/action/groundtank/pilot/toggle_passengers/Trigger()
	..()
	var/obj/groundtank/S = target
	S.toggle_passengers()
	if(S.passengers_allowed)
		button_icon_state = "lock_open"
	else
		button_icon_state = "lock_closed"
	UpdateButtonIcon()

/datum/action/groundtank/pilot/toggle_passenger_weaponry
	name = "Toggle Passenger Weaponry"
	button_icon_state = "weapons_off"

/datum/action/groundtank/pilot/toggle_passenger_weaponry/Trigger()
	..()
	var/obj/groundtank/S = target
	S.toggle_passenger_guns()
	if(S.passenger_fire)
		button_icon_state = "weapons_on"
	else
		button_icon_state = "weapons_off"
	UpdateButtonIcon()

/datum/action/groundtank/passenger //Subtype for passengers only

/datum/action/groundtank/passenger/Trigger()
	..()
	var/obj/groundtank/S = target
	if(!S || !S.occupants.Find(owner))
		to_chat(owner, "<span class = 'warning'>How did you get control of this button?</span>")
		qdel(src)
		return

/datum/action/groundtank/pilot/toggle_lights
	name = "Toggle lights"
	button_icon_state = "toggle_lights"

/datum/action/groundtank/pilot/toggle_lights/Trigger()
	..()
	var/obj/groundtank/S = target
	S.toggle_lights()
	