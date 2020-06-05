//See: mine_turfs.dm for our parent file.
/turf/unsimulated/mineral/perspective_rock
	name = "rock wall"
	icon = 'z40k_shit/icons/turfs/walls.dmi'
	icon_state = "cliff_top"
	base_icon_state = "cliff_top"
	mined_type = /turf/unsimulated/outside/sand
	overlay_state = "perspective_cliff_overlay"
	legacywalls = FALSE

/turf/unsimulated/mineral/perspective_rock/bottom //mostly a map helper honestly.
	icon_state = "cliff_bottom"

/turf/unsimulated/mineral/perspective_rock/New()
	..()

/turf/unsimulated/mineral/perspective_rock/scan_change(var/wherewegoin)
	switch(wherewegoin)
		if(SOUTH)
			var/turf/T = get_step(src,SOUTH)
			if(!istype(T,/turf/unsimulated/mineral/perspective_rock))
				base_icon_state = "cliff_bottom"
				icon_state = "cliff_bottom"
				opacity = 0
		if(NORTH)
			var/turf/T = get_step(src,NORTH)
			if(istype(T,/turf/unsimulated/mineral/perspective_rock))
				var/turf/unsimulated/mineral/US = T
				US.base_icon_state = "cliff_bottom"
				US.icon_state = "cliff_bottom"
				US.opacity = 0

/turf/unsimulated/mineral/add_rock_overlay()
	return
/*	This unironically works at adding shadow borders, but fuck that shit yo.
	var/image/img = image('z40k_shit/icons/turfs/turf_outline_overlays.dmi',"main",layer = SIDE_LAYER)
	var/offset=-4
	img.pixel_x = offset*PIXEL_MULTIPLIER
	img.pixel_y = offset*PIXEL_MULTIPLIER
	img.plane = BELOW_TURF_PLANE
	overlays += img

	var/turf/T1 = get_turf(get_step(src,EAST))
	if(!istype(T1,src))
		var/turf/T1T2 = get_turf(get_step(src,SOUTH))
		var/decision1
		if(istype(T1T2,src))
			decision1 = "bot_right_ns"
		else
			decision1 = "bot_right"
		var/image/img1 = image('z40k_shit/icons/turfs/turf_outline_overlays.dmi',decision1,layer = SIDE_LAYER)
		img1.pixel_x = offset*PIXEL_MULTIPLIER
		img1.pixel_y = offset*PIXEL_MULTIPLIER
		img1.plane = BELOW_TURF_PLANE
		overlays += img1

	var/turf/T2 = get_turf(get_step(src,WEST))
	if(!istype(T2,src))
		var/turf/T1T2 = get_turf(get_step(src,SOUTH))
		var/decision2
		if(istype(T1T2,src))
			decision2 = "bot_left_ns"
		else
			decision2 = "bot_left"
		var/image/img2 = image('z40k_shit/icons/turfs/turf_outline_overlays.dmi',decision2,layer = SIDE_LAYER)
		img2.pixel_x = offset*PIXEL_MULTIPLIER
		img2.pixel_y = offset*PIXEL_MULTIPLIER
		img2.plane = BELOW_TURF_PLANE
		overlays += img2
*/

