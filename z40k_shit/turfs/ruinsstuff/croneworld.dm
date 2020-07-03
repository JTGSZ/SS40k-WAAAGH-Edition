/turf/unsimulated/croneworldfloors/crone
	name = "Croneworld Ground"
	desc = "Normally you could trust the ground beneath your feet, but what you see here would make anyone reconsider."
	icon = 'z40k_shit/icons/turfs/cronefloors.dmi'
	icon_state = "s1"
	plane = PLATING_PLANE

/turf/unsimulated/croneworldfloors/crone/New()
	..()

/turf/unsimulated/croneworldfloors/crone/initialize()
	icon_state = "s[rand(1,10)]"

/turf/unsimulated/croneworldfloors/crone/ex_act(severity)
	return
