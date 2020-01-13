
/*
	BAD PLOTTER
				*/

//Basically handles chunk generation
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
/*
	BAD LINER
				*/

//Basically good for doing lines
/obj/helper/badliner
	name = "badliner"
	density = 0

	var/list/cardinalDirs = list(1, 2, 4, 8)
															//Deviant is deviation.
/obj/helper/badliner/proc/roam2node(var/node, var/deviant) //Node is the node it roams to
	var/turf/BALLS //THIS PROC SUCKS BALLS

	if(deviant)
		if(prob(80)) //Probability to DEVIATE
			BALLS = get_step_rand(src)
		else
			BALLS = get_step_towards(src, node)
	else
		BALLS = get_step_towards(src, node)
	
	if(BALLS) //Our location is BALLS
		loc = BALLS
	
	for(var/turf/unsimulated/outside/NIG in orange(1,src))
		if(!NIG.density || istype(NIG, /turf/unsimulated/outside/sand)) 
			new /turf/unsimulated/outside/gentest/water(NIG)
/*
	NODE LINER
				*/

//Basically a node helper for badliner
/obj/helper/nodeliner
	name = "nodeliner"
	desc = "he a badboy"
	density = 0

/*
	TEST OBJECTS
				*/

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