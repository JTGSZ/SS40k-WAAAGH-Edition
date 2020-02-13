
//Toggle Engine
/datum/action/complex_vehicle_equipment/toggle_engine
	name = "Toggle Engine"
	button_icon_state = "engine_off"

/datum/action/complex_vehicle_equipment/toggle_engine/Trigger()
	..()
	var/obj/complex_vehicle/S = target
	S.toggle_engine_yeah()
	if(S.engine_toggle)
		button_icon_state = "engine_on"
	else
		button_icon_state = "engine_off"
	UpdateButtonIcon()

/obj/complex_vehicle/proc/toggle_engine_yeah()
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