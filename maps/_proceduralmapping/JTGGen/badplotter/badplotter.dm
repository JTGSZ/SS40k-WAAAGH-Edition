#define MAP_AREA (world.maxx * world.maxy) //Map area

//customization is handled by calculating percentages of map area, so a given set of settings
//should scale to larger or smaller maps.
#define PERCENT_LAND 0.20
#define MAX_BADPLOTTER_PER_SEED 32
#define SEED_FACTOR 0.002
//setting SEED_FACTOR lower will reduce the likelihood of many islands.
//to define a specific number of seeds, define it as "(n / MAP_AREA)" where n is the desired number of seeds.

#define MAP_SCALE 3

#define SEEDS round(MAP_AREA * SEED_FACTOR, 1)
#define LAND_TURFS (MAP_AREA * PERCENT_LAND)
#define EXPANSIONS (LAND_TURFS) - SEEDS

//Rocks if you ever wanted them bitches in this.
#define ROCK_TURFS LAND_TURFS * PERCENT_ROCKS
#define PERCENT_ROCKS 0.04

/obj/helper/badplotter/ //This is basically an object that moves around and does stuff on its own.
	name = "badplotter"
	desc = "he plottin somein real bad"
	density = 0
	var/list/cardinalDirs = list(1, 2, 4, 8)

/obj/helper/badplotter/proc/roam()
	var/newDir = pick(cardinalDirs)
	var/turf/T = get_step(src, newDir)
	if(T)
		loc = T

		if(istype(T, /turf/unsimulated/outside/sand)) 
			T = new /turf/unsimulated/outside/gentest/water(T) 
			return 1

/proc/CreateDeeps()
	var/list/badplotter = list()
	var/turf/T
	var/obj/helper/badplotter/bplot

	for(var/i in 1 to SEEDS)
		//make a new single segment
		while(1)
			T = locate(rand(1, world.maxx), rand(1, world.maxy), 1)
			if(istype(T, /turf/unsimulated/outside/gentest/water)) 
				continue
			else
				T = new /turf/unsimulated/outside/gentest/water(locate(T.x, T.y, 1))
				for(var/botCount in 1 to rand(1, MAX_BADPLOTTER_PER_SEED))
					bplot = new(T)
					badplotter += bplot
				break

	//add on to existing segments
	for(var/j in 1 to EXPANSIONS)
		while(1)
			bplot = pick(badplotter)
			if(bplot.roam()) 
				break

	for(bplot in badplotter) 
		qdel(bplot)


/proc/CreateShallows()
	var/turf/T

	for(var/curX in 1 to world.maxx)
		for(var/curY in 1 to world.maxy)
			T = locate(curX, curY, 1)
			if(istype(T, /turf/unsimulated/outside/sand))
				if(locate(/turf/unsimulated/outside/gentest/water) in oview(T, 1))
					T = new /turf/unsimulated/outside/gentest/watershallow(T)


/proc/CreateRocks()
	var/turf/T

	for(var/i in 1 to ROCK_TURFS)
		var/holdType
		while(1)
			T = locate(rand(1, world.maxx), rand(1, world.maxy), 1)
			if(istype(T, /turf/unsimulated/outside/gentest/water) \
			|| istype(T, /turf/unsimulated/outside/gentest/watershallow))
				holdType = T.type
				T = new /turf/unsimulated/outside/gentest/rock(T)
				T.underlays += holdType
				break

//Test objects below.
/turf/unsimulated/outside/gentest
	name = "Gentest"
	icon = 'icons/turf/gentest.dmi'

/turf/unsimulated/outside/gentest/water
	name = "WATER DEEP"
	icon_state = "water2"

/turf/unsimulated/outside/gentest/rock
	name = "PLACEHOLDER"

/turf/unsimulated/outside/gentest/watershallow
	name = "WATERSHALLOW"
	icon_state = "water"