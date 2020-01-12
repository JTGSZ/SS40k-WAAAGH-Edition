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
	for(var/turf/unsimulated/outside/sand/NIG in orange(1,src))
		step_to(src, node)
		if(!NIG.density || istype(NIG, /turf/unsimulated/outside/sand)) 
			NIG = new /turf/unsimulated/outside/gentest/water
			return 1

/proc/CreateRiver(var/rivercount)
	var/list/badliner = list()
	var/list/badnodes = list()
	var/turf/TT
	var/turf/PP
	var/obj/helper/badliner/bline
	var/obj/helper/nodeliner/node

	for(var/i in 1 to rivercount)
		while(1)
			PP = locate(rand(1, world.maxx), world.maxy, 1) //PP needs to be at the top/end
			TT = locate(rand(1,world.maxx), 1, 1) //TT needs to be at the bottom/start
			node = new(PP)
			badnodes += node
			bline = new(TT)
			badliner += bline
			break
