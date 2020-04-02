/mob/living/proc/soul_blaze_append()
	//We will append a vis_contents effect.
	//Then the soulblaze thing pops after a bit
	//Dealing damage
	set waitfor = 0
	//Here would be the vis_contents append
	sleep(3 SECONDS)
	adjustFireLoss(40-attribute_constitution)

