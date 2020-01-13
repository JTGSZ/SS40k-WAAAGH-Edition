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



/obj/helper/badliner
	name = "badliner"
	density = 0

	var/list/cardinalDirs = list(1, 2, 4, 8)

/obj/helper/nodeliner
	name = "nodeliner"
	desc = "he a badboy"
	density = 0

/obj/helper/badliner/proc/roam2node(var/node)
	var/turf/T = get_step(src, NORTH)
	if(T)
		loc = T
	for(var/turf/unsimulated/outside/NIG in orange(1,src))
		if(!NIG.density || istype(NIG, /turf/unsimulated/outside/sand)) 
			new /turf/unsimulated/outside/gentest/water(NIG)
	
/proc/CreateRiver(var/rivercount)
	var/list/badliner = list()
	var/list/badnodes = list()
	var/turf/TT
	var/turf/PP
	var/obj/helper/badliner/bline
	var/obj/helper/nodeliner/node

	for(var/i in 1 to rivercount)
		PP = locate(rand(1, world.maxx), world.maxy, 1) //PP needs to be at the top/end
		TT = locate(rand(1,world.maxx), 1, 1) //TT needs to be at the bottom/start
		node = new(PP)
		badnodes += node
		bline = new(TT)
		badliner += bline
		break
		
	for(var/i in 1 to get_dist(bline,node))
		bline.roam2node(node)
		if(bline.loc == PP)
			break
