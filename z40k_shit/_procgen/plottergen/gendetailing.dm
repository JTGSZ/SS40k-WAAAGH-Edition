/datum/loada_gen/proc/CreateShallows()
	var/turf/T

	for(var/curX in 1 to world.maxx)
		for(var/curY in 1 to world.maxy)
			T = locate(curX, curY, 1)
			if(istype(T, /turf/unsimulated/outside/sand))
				if(locate(/turf/unsimulated/outside/water/deep) in oview(T, 1))
					new /turf/unsimulated/outside/water/shallow(T)
					new /area/warhammer/water(T)

/datum/loada_gen/proc/CleanupSpace() //We clean space up
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

/datum/loada_gen/proc/CreateCoastline()
	var/turf/T

	for(var/curX in 1 to world.maxx)
		for(var/curY in 1 to world.maxy) 
			T = locate(curX, curY, 1)
			if(istype(T, /turf/unsimulated/outside/sand)) //If we are sand
				if(locate(/turf/unsimulated/outside/water/shallow) in oview(T, 1)) //And we see Shallow water around us
					T.ChangeTurf(/turf/unsimulated/outside/smoothingcoastline) //Then we form smoothing coastline turfs in place.

//Wow its like the coastlines except not.
/datum/loada_gen/proc/CreatePathline()
	var/turf/T
	for(var/curX in 1 to world.maxx)
		for(var/curY in 1 to world.maxy) 
			T = locate(curX, curY, 1)
			if(istype(T, /turf/unsimulated/outside/sand)) //If we are sand
				if(locate(/turf/unsimulated/outside/footpath) in oview(T, 1)) //And we see footpath centers around us
					T.ChangeTurf(/turf/unsimulated/outside/smoothingfootpath) //Then we form smoothing turflines around us.

