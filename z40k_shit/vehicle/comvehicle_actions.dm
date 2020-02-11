/datum/action/groundtank
	icon_icon = 'icons/pods/button_icons.dmi'
	background_icon_state = "bg_pod"

/datum/action/groundtank/Trigger()
	..()
	var/obj/groundtank/S = target
	if(!istype(S))
		qdel(src)
		return

/datum/action/groundtank/pilot //Subtype for space pod pilots only

//Toggle Passenger Allowance
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

//Toggle Passenger Weaponry
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


//Toggle Lights
/datum/action/groundtank/pilot/toggle_lights
	name = "Toggle lights"
	button_icon_state = "toggle_lights"

/datum/action/groundtank/pilot/toggle_lights/Trigger()
	..()
	var/obj/groundtank/S = target
	S.toggle_lights()
	

//Toggle Engine
/datum/action/groundtank/pilot/toggle_engine
	name = "Toggle Engine"
	button_icon_state = "engine_off"

/datum/action/groundtank/pilot/toggle_engine/Trigger()
	..()
	var/obj/groundtank/S = target
	S.toggle_engine_yeah()
	if(S.engine_toggle)
		button_icon_state = "engine_on"
	else
		button_icon_state = "engine_off"
	UpdateButtonIcon()

/obj/groundtank/proc/toggle_engine_yeah()
	if(usr!=get_pilot())
		return
	
	src.engine_toggle = !engine_toggle
	
	if(engine_toggle) //If Engine toggle is true, and we are not on cooldown
		if(!engine_cooldown) //if engine cooldown is false
			to_chat(src.get_pilot(), "Engine Cooldown is now [engine_cooldown]")
			engine_cooldown = TRUE //Engine cooldown becomes true
			spawn(10) //we spawn to give everything time to finish so we don't lock them up
				trigger_engine() //Then we trigger engine which has a while loop (that would lock them up)
				to_chat(src.get_pilot(), "Engine Triggered")
			spawn(30)
				engine_cooldown = FALSE
				to_chat(src.get_pilot(), "Engine Cooldown is now [engine_cooldown]")
	else
		acceleration = 500 //We set acceleration back to neutral if the engine is turned off.
	
	to_chat(src.get_pilot(), "<span class='notice'>Engine [engine_toggle?"starting up":"shutting down"].</span>")
	playsound(src, 'sound/items/flashlight_on.ogg', 50, 1)