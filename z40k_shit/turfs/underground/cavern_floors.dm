/turf/unsimulated/floor/asteroid/air/deepcave
	name = "cave floor"
	icon = 'z40k_shit/icons/turfs/cavernfloors.dmi'
	icon_state = "deepcave_1"
	sand_type = /obj/item/stack/ore/glass/cave

/turf/unsimulated/floor/asteroid/underground/New()
	..()
	icon_state = "deepcave_[rand(1,4)]"

/turf/unsimulated/floor/asteroid/air
	name = "cavern floor"
	oxygen = MOLES_O2STANDARD
	nitrogen = MOLES_N2STANDARD
	temperature = T20C