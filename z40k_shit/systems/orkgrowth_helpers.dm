/*
Basically this file kinda holds a lot of the helpers for orks.
How they grow and shit in our overhaul to make this a bit slower.
For now we will shift in species every 500.
So the idea is like.

			250			500	  		1000
Gretchin 	->	 Ork 	->	 Nob	 -> 	Warboss
*/

/mob/living/carbon/human/ork
	var/ork_growth = 0 //A symbol of our orks growth from beating peoples asses.

/mob/living/carbon/human/ork/proc/grow_nigga(var/gainedrate)
	ork_growth += gainedrate
	if(ork_growth >= 500)
		to_chat(src, "<span class='good'>You feel a bit bigga and meana.</span>")
		if(set_species("Ork Nob"))
			regenerate_icons()
			ork_growth = 0
			respawn_modifier = 3 MINUTES //deciseconds
			return 1

/mob/living/carbon/human/ork/nob/grow_nigga(var/gainedrate)
	ork_growth += gainedrate
	if(ork_growth >= 1000)
		to_chat(src, "<span class='good'>You feel a lot bigga and meana. Nothings gonna stop ya.</span>")
		if(set_species("Ork Warboss"))
			regenerate_icons()
			ork_growth = 0
			respawn_modifier = 4 MINUTES
			return 1

/mob/living/carbon/human/ork/warboss/grow_nigga(var/gainedrate)
	ork_growth += gainedrate
	if(ork_growth >= 200)
		if(attribute_strength <= 16)
			to_chat(src, "<span class='good'>You grow a bit bigger, but not a ton.</span>")
			stat_increase(ATTR_STRENGTH,100)
			ork_growth = 0
			respawn_modifier = 3600
		return 1 //We maxed out here, just hand some stat help i guess.
	