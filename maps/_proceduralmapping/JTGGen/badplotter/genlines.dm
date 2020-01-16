/*

     NW(9)  N(1) NE(5)
		\	|   /
W(8)---- *****  ---- E(4)
		/	|	\
   SE(6)  S(2)  SW(10)

*/
//We will start at a edge.
//The goal is to move the object north, have it generate turfs, repeat.
//If a node exists, we will instead step to it.

//1-12-2020
//TODO: River Deviation.


/proc/CreateRiver(var/datum/map/active/ASS)
	var/turf/TT
	var/turf/PP
	var/obj/helper/badliner/bline
	var/obj/helper/nodeliner/node

	for(var/i in 1 to ASS.rivercount)
		PP = locate(rand(1, world.maxx), world.maxy, 1) //PP needs to be at the top/end
		TT = locate(rand(1,world.maxx), 1, 1) //TT needs to be at the bottom/start
		node = new(PP)
		bline = new(TT)
		break
		
	for(var/i in 1 to world.maxy + world.maxx)
		bline.roam2node(node)
		if(bline.loc == PP)
			break
	
	if(ASS.dd_debug)
		log_startup_progress("---------LOADA RIVER----------")
		log_startup_progress("LINEPLOTSTART: X: [TT.x], Y: [TT.y]")

/proc/CreateRiver2Lake(var/datum/map/active/ASS, var/deviant) //Deviant is river deviation
	var/list/badplotter = list()
	var/turf/T
	var/turf/TT
	var/obj/helper/badplotter/bplot
	var/obj/helper/nodeliner/node
	var/obj/helper/badliner/bline

	for(var/i in 1 to SEEDS)
		//make a new single segment
		while(1)
			T = locate(rand(1, world.maxx), rand(1, world.maxy), 1)
			if(istype(T, /turf/unsimulated/outside/water/deep)) 
				continue
			else
				new /turf/unsimulated/outside/water/deep(T)
				node = new(T)
				for(var/botCount in 1 to rand(1, MAX_BADPLOTTER_PER_SEED))
					bplot = new(T)
					badplotter += bplot
				break

	for(var/i in 1 to SEEDS)
		TT = locate(rand(1,world.maxx), world.maxy, 1) //we flow from top
		bline = new(TT)
		break

	//add on to existing segments
	for(var/j in 1 to EXPANSIONS)
		while(1)
			bplot = pick(badplotter)
			if(bplot.roam()) 
				break

	for(var/i in 1 to 2000) //2000 loops should be good enough for us.
		bline.roam2node(node, ASS.deviant)
		if(bline.y == node.y && bline.x == node.x)
			if(ASS.dd_debug)
				log_startup_progress("NODE AND LINE COMPLETED AND DELETED AT X: [bline.x], Y: [bline.y]")
			qdel(bline)
			qdel(node)
			break //We break if we get there before that

	for(bplot in badplotter) 
		qdel(bplot)

	if(ASS.dd_debug)
		log_startup_progress("---LOADA RIVER2LAKE(Deeps&Shallows&River)---")
		log_startup_progress("LAKE NODE: X: [T.x], Y: [T.y] LINEPLOTSTART: X: [TT.x], Y: [TT.y]")
		log_startup_progress("Seeds: [SEEDS]")