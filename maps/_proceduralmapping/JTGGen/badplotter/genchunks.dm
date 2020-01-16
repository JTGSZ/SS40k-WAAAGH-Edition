//Stolen from some dumb zip i had on my desktop for archipalegos
//I realized I could just reverse the islands and ocean, and work with it.
//Ironically pathed objects has better performance/quality than just doing large calculations.

#define MAP_AREA (world.maxx * world.maxy) //Map area

//customization is handled by calculating percentages of map area, so a given set of settings
//should scale to larger or smaller maps.

//Sets - Marsh
//#define PERCENT_LAND 0.20
//#define MAX_BADPLOTTER_PER_SEED 32
//#define SEED_FACTOR 0.002

#define PERCENT_LAND 0.20
#define MAX_BADPLOTTER_PER_SEED 32
#define SEED_FACTOR (1 / MAP_AREA)

//setting SEED_FACTOR lower will reduce the likelihood of many islands.
//to define a specific number of seeds, define it as "(n / MAP_AREA)" where n is the desired number of seeds.

#define MAP_SCALE 3

#define SEEDS round(MAP_AREA * SEED_FACTOR, 1)
#define LAND_TURFS (MAP_AREA * PERCENT_LAND)
//#define EXPANSIONS (LAND_TURFS) - SEEDS //This is the default setting - 1/13/2020
//500 kind of acceptable
#define EXPANSIONS 800

//Rocks if you ever wanted them bitches in this.
#define ROCK_TURFS LAND_TURFS * PERCENT_ROCKS
#define PERCENT_ROCKS 0.04



/proc/CreateDeeps(var/datum/map/active/ASS)
	var/list/badplotter = list()
	var/turf/T
	var/obj/helper/badplotter/bplot

	for(var/i in 1 to SEEDS)
		//make a new single segment
		while(1)
			T = locate(rand(1, world.maxx), rand(1, world.maxy), 1)
			if(istype(T, /turf/unsimulated/outside/water/deep)) 
				continue
			else
				new /turf/unsimulated/outside/water/deep(T)
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

	if(ASS.dd_debug)
		log_startup_progress("------Loada Lakes(Deeps&Shallows)----")
		log_startup_progress("Seeds: [SEEDS] A Location: [T]")
		log_startup_progress("Expansions: [EXPANSIONS]")


/proc/CreateShallows()
	var/turf/T

	for(var/curX in 1 to world.maxx)
		for(var/curY in 1 to world.maxy)
			T = locate(curX, curY, 1)
			if(istype(T, /turf/unsimulated/outside/sand))
				if(locate(/turf/unsimulated/outside/water/deep) in oview(T, 1))
					new /turf/unsimulated/outside/water/shallow(T)


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
