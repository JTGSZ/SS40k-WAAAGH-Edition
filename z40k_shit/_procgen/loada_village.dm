/*
	Basically this proc generates a small town out of tempaltes in a block.

*/
//Basically we want to be far away from spawn 2 or whatever the ork spawn is.
//So we will be on the side the IG are on, but we will be opposite from the y the ork base is.
/datum/loada_gen/proc/loada_village()
	var/center_x = round(world.maxx/2) //EX: 200/2 = 100
	var/center_y = round(world.maxy/2) //Exact center of a whole map.
	var/exact_center = locate(center_x,center_y,1) //The turf location.
	var/town_spread = 50 //The total amount of grid cells we can spread

	//These always occur on the bottom left of our templates, so block starts here
	var/lowleft_x1 = s1_x1_coord //Our X coordinate is going to be the same as template 1's
	var/lowleft_y1 = s2_y2_coord //Our Y coordinate is going to be the same as template 2's
	//Thus we are effectively in a triangle now in comparison to the other two.

	//Now we need to calculate the square we can place templates into.
	//The issue is we have to be careful not to go over the map border
	if(lowleft_x1+town_spread > world.maxx-1) //Basically our size to work with atm is 50, if our x+50 is greater than the world_max
		lowleft_x1 -= ((world.maxx-lowleft_x1)-rand(1,10)) //We have a variance of 1-10 on reduction.
	if(lowleft_y1+town_spread > world.maxy-1)
		lowleft_y1 -= ((world.maxy-lowleft_y1)-rand(1,10))

	//Now that that is settled, we calculate the top right border.
	//We know the bottom left safe coordinates, So now we just add our town spread to the bottom left coordinates
	var/topright_x1 = (lowleft_x1+town_spread) //EX: 140 + 50 = 190 X
	var/topright_y1 = (lowleft_y1+town_spread) //EX: 140 + 50 = 190 Y
	//Think of the four variables we have now as a miniature map for ease of thinking.

	//So whats next? Well, we need to pick our templates.
	//Except I have no motherfuckin templates.

	
