/proc/CreateShallows()
	var/turf/T

	for(var/curX in 1 to world.maxx)
		for(var/curY in 1 to world.maxy)
			T = locate(curX, curY, 1)
			if(istype(T, /turf/unsimulated/outside/sand))
				if(locate(/turf/unsimulated/outside/water/deep) in oview(T, 1))
					new /turf/unsimulated/outside/water/shallow(T)
					new /area/warhammer/water(T)


/proc/CreateRocks()
	var/turf/T

	for(var/i in 1 to ROCK_TURFS)
		var/holdType
		while(1)
			T = locate(rand(1, world.maxx), rand(1, world.maxy), 1)
			if(istype(T, /turf/unsimulated/outside/water/deep) \
			|| istype(T, /turf/unsimulated/outside/water/shallow))
				holdType = T.type
				new /turf/unsimulated/outside/gentest/rock(T)
				T.underlays += holdType
				break

/proc/CleanupSpace(var/datum/map/active/ASS) //We clean space up
	var/turf/T
	var/base_turf = get_base_turf(1)

	for(var/curX in 1 to world.maxx)
		for(var/curY in 1 to world.maxy)
			T = locate(curX, curY, 1)
			if(istype(T, /turf/space/)) //If T is a space turf
				if(locate(/turf/unsimulated/outside/water/deep) in oview(T, 1))
					if(prob(50)) //We have a 50% probability to be either shallow water or
						new /turf/unsimulated/outside/water/shallow(T)
						new /area/warhammer/water(T)
					else
						T.ChangeTurf(base_turf)
				else
					T.ChangeTurf(base_turf)