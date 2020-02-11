
//The turrets another object, ayep.
/obj/groundturret
	name = "\improper groundturret"
	desc = "A turret attached to a tank."
	icon = 'z40k_shit/icons/lemanruss.dmi'
	icon_state = "turret"
	density = 0 //Dense. To raise the heat.
	opacity = 0
	anchored = 1
	lockflags = NO_DIR_FOLLOW

/obj/groundturret/New()
	. = ..()
	
