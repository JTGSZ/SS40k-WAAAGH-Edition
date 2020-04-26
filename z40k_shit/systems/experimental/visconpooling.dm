//So, i'm going to try a vis_contents pooling system right here.
/datum/visconpooler
	
/datum/visconpooler/New()
	load_barricades()

/datum/visconpooler/proc/load_barricades()
	barricadepool[1] = new /obj/effect/overlay/viscons/aegisline/north
	barricadepool[2] = new /obj/effect/overlay/viscons/aegisline/south
	barricadepool[3] = new /obj/effect/overlay/viscons/aegisline/east_one
	barricadepool[4] = new /obj/effect/overlay/viscons/aegisline/east_two
	barricadepool[5] = new /obj/effect/overlay/viscons/aegisline/west_one
	barricadepool[6] = new /obj/effect/overlay/viscons/aegisline/west_two

