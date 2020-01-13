/*

     NW(9)  N(1) NE(5)
		\	|   /
W(8)---- *****  ---- E(4)
		/	|	\
   SE(6)  S(2)  SW(10)

*/


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
	var/delayset = 0 //How many loops before we are back on track
	var/setdir = 0 // Basically a rng direction we can lock in
	var/lockin = FALSE //WE LOCKED IN COME ALONG FOR THE RIDE
	var/curvemyballs = FALSE //We make a curve
	var/ballcurve1 = 0 //How long before we swap dirs in a curve

	var/list/cardinalDirs = list(1, 2, 4, 8)

/obj/helper/badliner/proc/roam2nodeNEWDIR()
	setdir = pick(10,6) //EAST, SOUTHEAST, WEST, SOUTHWEST.

/*

     NW(9)  N(1) NE(5)
		\	|   /
W(8)---- *****  ---- E(4)
		/	|	\
   SW(6)  S(2)  SE(10)

*/															//Deviant is deviation.
/obj/helper/badliner/proc/roam2node(var/node, var/deviant) //Node is the node it roams to
	var/turf/BALLS //THIS PROC SUCKS BALLS
	var/verydeviant = TRUE //idc I can just move this up one day or some shit, its testing.

	if(deviant)
		if(prob(80)) //Probability to DEVIATE
			BALLS = get_step_rand(src)
		else
			if(verydeviant)
				if(prob(5))
					lockin = TRUE
				if(lockin)
					if(curvemyballs) //We use delayset to do a proper curve
						if(setdir == 10) //If we SE
							if(ballcurve1 < 3)
								BALLS = get_step(src,setdir)
								ballcurve1++
						if(setdir == 6) //If we SW
					
					else
						BALLS = get_step(src,setdir) //WE ARE ALONG FOR THE RIDE
						delayset++ //WE ADD UP
				else
					BALLS = get_step_towards(src, node) //If we ain't locked in we movin norm
				if(delayset >= 5) //If delayset is greater than or equal to 5
					lockin = FALSE //lockin turns to false again
					delayset = 0 // delayset is back to 0
					roam2nodeNEWDIR() //And we pick a new direction
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