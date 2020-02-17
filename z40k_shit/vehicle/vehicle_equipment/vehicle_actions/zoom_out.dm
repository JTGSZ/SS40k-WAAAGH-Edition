//Toggle Engine
/datum/action/complex_vehicle_equipment/zoom
	name = "Zoom"
	button_icon_state = "engine_off"
	pilot_only = TRUE

/datum/action/complex_vehicle_equipment/zoom/Trigger()
	..()
	var/obj/complex_vehicle/S = target
	S.zoom_action()
	if(S.engine_toggle)
		button_icon_state = "engine_on"
	else
		button_icon_state = "engine_off"
	UpdateButtonIcon()

/obj/complex_vehicle/proc/zoom_action()
	if(usr!=get_pilot())
		return
	
	var/mob/user = get_pilot()

	if(!pilot_zoom)
		if(user && user.client) 
			usr.regenerate_icons()
			var/client/C = user.client
			C.changeView(C.view + 7)
			pilot_zoom = TRUE
	else
		if(user && user.client) 
			user.regenerate_icons()
			var/client/C = user.client
			C.changeView(C.view - 7)
			pilot_zoom = FALSE
