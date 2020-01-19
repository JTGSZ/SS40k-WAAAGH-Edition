/obj/structure/flora/desertrock
	name = "rock"
	desc = "a rock"
	icon = 'z40k_shit/icons/doodads/desertrocks32x32.dmi'
	anchored = 1
	shovelaway = TRUE

/obj/structure/flora/desertrock/New()
	..()
	icon_state = "desertrock[rand(1,4)]"

	if(prob(50))
		qdel(src)