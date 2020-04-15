/obj/effect/overlay/viscons/generic
	name = "Special Effect"
	desc = "For when you want it to be extra special"

	vis_flags = VIS_INHERIT_ICON|VIS_UNDERLAY|VIS_INHERIT_ICON_STATE

/obj/effect/overlay/viscons/generic/New(var/mob/M, var/effect_duration)
	set waitfor = 0
	..()

	sleep(effect_duration)
	M.vis_contents -= src
	qdel(src)

/obj/effect/overlay/viscons/afterimages
	name = "Afterimage"
	desc = "H-hes fast!"

	vis_flags = VIS_INHERIT_ICON|VIS_UNDERLAY|VIS_INHERIT_ICON_STATE

/obj/effect/overlay/viscons/afterimages/New(var/mob/M,var/effect_duration)
	set waitfor = 0
	..()
	switch(M.dir)
		if(NORTH)
			pixel_y = -24
		if(SOUTH)
			pixel_y = 24
		if(WEST)
			pixel_x = 24
		if(EAST)
			pixel_x = -24

	sleep(effect_duration)
	M.vis_contents -= src
	qdel(src)
