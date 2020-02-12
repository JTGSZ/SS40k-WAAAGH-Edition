/datum/action/complex_vehicle_equipment
	icon_icon = 'icons/pods/button_icons.dmi'
	background_icon_state = "bg_pod"
	var/pilot_only = FALSE //Is this restricted to the pilot/driver only?

/datum/action/complex_vehicle_equipment/Trigger()
	..()
	var/obj/groundtank/S = target
	if(!istype(S))
		qdel(src)
		return

