/*
	FLORA GEN PROCEDURE
						*/

//============> Current Set value // JTGSZ Tuned Reference Value <==============
/* //Good for a forest
#define GRASS_SPONTANEOUS 		2//2 //chance it appears on the tile on its own
#define GRASS_WEIGHT 			4//4 //multiplier increase if theres some nearby
#define TREE_SPONTANEOUS		4//4
#define TREE_WEIGHT				4//4
#define AUSFLORA_SPONTANEOUS	2//2
#define AUSFLORA_WEIGHT			3//3
#define ROCKS_SPONTANEOUS		2//2 //Technically this can be moved to the desolate spawn list tied to grass.
#define ROCKS_WEIGHT			1//1 //Lower weight cause rock clusters were too common...But cool honestly.
#define DEBRIS_SPONTANEOUS		2//2
#define DEBRIS_WEIGHT			2//2
*/

//==========> Current Set Value // JTGSZ Tuned Reference Value <===================
//Desert
#define GRASS_SPONTANEOUS 		2//2
#define GRASS_WEIGHT 			4//4
#define TREE_SPONTANEOUS		0//4
#define TREE_WEIGHT				0//4
#define AUSFLORA_SPONTANEOUS	0//2
#define AUSFLORA_WEIGHT			0//3
#define ROCKS_SPONTANEOUS		0//2 
#define ROCKS_WEIGHT			0//1 
#define DEBRIS_SPONTANEOUS		0//2
#define DEBRIS_WEIGHT			0//2

//#define LUSH_PLANT_SPAWN_LIST list(/obj/structure/flora/grass/wasteland = 10, /obj/structure/flora/tree/wasteland = 1)
//#define DESOLATE_PLANT_SPAWN_LIST list(/obj/structure/flora/grass/wasteland = 1)



//These are basically what can spawn in the lists, the number is the weight.
//The weight dictates how likely it is to spawn over other things in the lists. If you were to use pickweight.
#define LUSH_GRASS_SPAWN_LIST list()								   
#define TREE_SPAWN_LIST 	list()
#define AUSFLORA_SPAWN_LIST list()
#define ROCKS_SPAWN_LIST	list()
#define DEBRIS_SPAWN_LIST	list()
//Lists that occur when the cluster doesn't happen but probability dictates it tries.
#define DESOLATE_SPAWN_LIST list()

//I just kinda made it worse... Like a lot worse. Ngl man.
/turf/unsimulated/outside/proc/floraGen()
	var/grassWeight = 0 //grassWeight holders for each individual layer
	var/treeWeight = 0
	var/ausfloraWeight = 0
	var/rocksWeight = 0
	var/debrisWeight = 0

	var/randGrass = null //The random plant picked
	var/randTree = null //The random deadtree picked
	var/randAusflora = null //The random Ausflora picked
	var/randRocks = null //The random rock picked
	var/randDebris = null //The random wood debris picked

	//spontaneously spawn the objects based on probability from the define.
	//Ngl, a lot of this is going to be have to generate in certain orders later in this proc.
	if(length(LUSH_GRASS_SPAWN_LIST))
		if(prob(GRASS_SPONTANEOUS)) //If probability THE DEFINE NUMBER
			randGrass = pickweight(LUSH_GRASS_SPAWN_LIST) //randgrass is assigned a obj from the weighted list
			turfGrass = new randGrass(src) //The var on the turf now has a new randgrass from the list.

	if(length(TREE_SPAWN_LIST))
		if(prob(TREE_SPONTANEOUS))
			randTree = pickweight(TREE_SPAWN_LIST)
			turfTree = new randTree(src)

	if(length(AUSFLORA_SPAWN_LIST))
		if(prob(AUSFLORA_SPONTANEOUS))
			randAusflora = pickweight(AUSFLORA_SPAWN_LIST)
			turfAusflora = new randAusflora(src)

	if(length(ROCKS_SPAWN_LIST))
		if(prob(ROCKS_SPONTANEOUS))
			randRocks = pickweight(ROCKS_SPAWN_LIST)
			turfRocks = new randRocks(src)

	if(length(DEBRIS_SPAWN_LIST))
		if(prob(DEBRIS_SPONTANEOUS))
			randDebris = pickweight(DEBRIS_SPAWN_LIST)
			turfDebris = new randDebris(src)


	//loop through neighbouring turfs, if they have grass, then increase weight, cluster prep.
	for(var/turf/unsimulated/outside/T in RANGE_TURFS(3, src))
		if(length(LUSH_GRASS_SPAWN_LIST))
			if(T.turfGrass) //We check what is around our turf
				grassWeight += GRASS_WEIGHT //The weight is increased by grass weight per every grass we find
		if(length(TREE_SPAWN_LIST))
			if(T.turfTree)
				treeWeight += TREE_WEIGHT
		if(length(AUSFLORA_SPAWN_LIST))
			if(T.turfAusflora)
				ausfloraWeight += AUSFLORA_WEIGHT
		if(length(ROCKS_SPAWN_LIST))
			if(T.turfRocks)
				rocksWeight += ROCKS_WEIGHT
		if(length(DEBRIS_SPAWN_LIST))
			if(T.turfDebris)
				debrisWeight += DEBRIS_WEIGHT


	//Below is where we handle clusters really.
	//use weight to try to spawn grass
	if(length(LUSH_GRASS_SPAWN_LIST))
		if(prob(grassWeight)) //Basically the probability goes by the DEFINE WEIGHT the more of it is around.
			//If surrounded on 5+ sides, pick from lush
			if(grassWeight == (5 * GRASS_WEIGHT)) //If we are five times the define value, aka 5 detected.
				randGrass = pickweight(LUSH_GRASS_SPAWN_LIST) //We weighted pick from the lush list, aka boys that can be together.
			else //Else.
				randGrass = pickweight(DESOLATE_SPAWN_LIST) //We weighted pick from boys that are fine being alone.
			turfGrass = new randGrass(src) //And at the end we set the turfgrass to this object.
	
	if(length(TREE_SPAWN_LIST))
		if(prob(treeWeight)) //We can technically redirect individuals down here too, but lets just focus on clumps.
			randTree = pickweight(TREE_SPAWN_LIST)
			turfTree = new randTree(src)

	if(length(AUSFLORA_SPAWN_LIST))
		if(prob(ausfloraWeight))
			randAusflora = pickweight(AUSFLORA_SPAWN_LIST)
			turfAusflora = new randAusflora(src)

	if(length(ROCKS_SPAWN_LIST))
		if(prob(rocksWeight))
			randRocks = pickweight(ROCKS_SPAWN_LIST)
			turfRocks = new randRocks(src)

	if(length(DEBRIS_SPAWN_LIST))
		if(prob(debrisWeight))
			randDebris = pickweight(DEBRIS_SPAWN_LIST)
			turfDebris = new randDebris(src)

