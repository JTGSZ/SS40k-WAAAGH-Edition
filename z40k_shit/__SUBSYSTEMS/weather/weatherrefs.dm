/*    Snow_Test_B()
        set desc = "Snow Test"
        set category = "Testing"


        add_hud("SOUTH","WEST",0,/obj/HUD/Snow/SNOW)
        add_hud("SOUTH","WEST",0,/obj/HUD/Snow/SNOW)
        add_hud("SOUTH","WEST",0,/obj/HUD/Snow/SNOW)
        add_hud("SOUTH","WEST",0,/obj/HUD/Snow/SNOW)

        add_hud("SOUTH","WEST",0,/obj/HUD/Snow/SNOW)
        add_hud("SOUTH","WEST",0,/obj/HUD/Snow/SNOW)
        add_hud("SOUTH","WEST",0,/obj/HUD/Snow/SNOW)
        add_hud("SOUTH","WEST",0,/obj/HUD/Snow/SNOW)

        add_hud("SOUTH","WEST",0,/obj/HUD/Snow/SNOW)
        add_hud("SOUTH","WEST",0,/obj/HUD/Snow/SNOW)
        add_hud("SOUTH","WEST",0,/obj/HUD/Snow/SNOW)
        add_hud("SOUTH","WEST",0,/obj/HUD/Snow/SNOW)

        add_hud("SOUTH","WEST",0,/obj/HUD/Snow/SNOW)
        add_hud("SOUTH","WEST",0,/obj/HUD/Snow/SNOW)
        add_hud("SOUTH","WEST",0,/obj/HUD/Snow/SNOW)
        add_hud("SOUTH","WEST",0,/obj/HUD/Snow/SNOW)

        var/s_x = 0
        var/s_y = 0

        for(var/obj/HUD/Snow/SNOW/S in usr.client.screen)
            var/matrix/M = matrix()
            M.Translate(s_x*320,s_y*320)
            S.transform = M

            if(s_x == 3)
                s_x = 0
                s_y++
            else
                s_x++
        return
		if(H.client)
			if(!istype(OL,/turf/unsimulated/floor/snow))
				H << sound(snowstorm_ambience[snow_state+1], repeat = 1, wait = 0, channel = CHANNEL_WEATHER, volume = snowstorm_ambience_volumes[snow_state+1])

		if(!istype(newloc,/turf/unsimulated/floor/snow))
			H.clear_fullscreen("snowfall_average",0)
			H.clear_fullscreen("snowfall_hard",0)
			H.clear_fullscreen("snowfall_blizzard",0)
			H << sound(null, 0, 0, channel = CHANNEL_WEATHER)

		switch(snow_state)
			if(SNOW_CALM)
				H.clear_fullscreen("snowfall_average",0)
				H.clear_fullscreen("snowfall_hard",0)
				H.clear_fullscreen("snowfall_blizzard",0)
			if(SNOW_AVERAGE)
				H.overlay_fullscreen("snowfall_average", /obj/abstract/screen/fullscreen/snowfall_average)
				H.clear_fullscreen("snowfall_hard",0)
				H.clear_fullscreen("snowfall_blizzard",0)
			if(SNOW_HARD)
				H.clear_fullscreen("snowfall_average",0)
				H.overlay_fullscreen("snowfall_hard", /obj/abstract/screen/fullscreen/snowfall_hard)
			if(SNOW_BLIZZARD)
				H.clear_fullscreen("snowfall_average",0)
				H.clear_fullscreen("snowfall_hard",0)
				H.overlay_fullscreen("snowfall_blizzard", /obj/abstract/screen/fullscreen/snowfall_blizzard)

*/
