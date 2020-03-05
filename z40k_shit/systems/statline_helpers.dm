

//See: human.dm: Line 1174 for where we stick species base stats onto the mob.

//Yes, we have stats. Strength doesn't do much atm.
//It also helps me do some inhand objects that are large with awkward positions.
//Its mostly stat_strength because theres too many vars in the codebase that are already named strength.
/*
	STRENGTH
			*/
//basically we return TRUE or FALSE when called
/mob/proc/strength_check()
	return FALSE

/mob/living/carbon/human/strength_check(var/difficulty)
	if(!stat_strength) //We have no strength
		return FALSE

//TODO: More Stats, More Integrations.
