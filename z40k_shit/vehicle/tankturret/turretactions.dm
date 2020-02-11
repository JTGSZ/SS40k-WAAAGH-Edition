/datum/action/groundturret
	icon_icon = 'icons/pods/button_icons.dmi'
	background_icon_state = "bg_pod"

/datum/action/groundturret/Trigger()
	..()
	var/obj/groundturret/S = target
	if(!istype(S))
		qdel(src)
		return

/datum/action/groundturret/pilot //Subtype for space pod pilots only

//area

