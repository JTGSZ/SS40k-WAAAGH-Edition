

//See: human.dm: Line 1174 for where we stick species base stats onto the mob.

//Yes, we have stats. Strength doesn't do much atm.
//It also helps me do some inhand objects that are large with awkward positions.
//Its mostly stat_strength because theres too many vars in the codebase that are already named strength.
/*
	DESIGN AS OF 3/5/2020
							*/
/*
	Range - 1 to 24
	Starting Species Cap - 12

----Stats Currently Active--- 
	Strength

*/

/*
	STRENGTH
			*/
/*
Basically we return TRUE or FALSE when called, this proc is a appended check.
---Variables----
stat_strength - Contained on the mob itself, dynamic built strength. Starting at species core strength.
base_strength - Contained on the species datum, starting core strength. Transferred to stat strength.

stat_strength_check(var/difficulty) - a check of the dynamic strength stat. Which can be raised.
base_strength_check(var/difficulty) - a check of the latent species strength. 
						Used to check for strong body icon template.

*/
/mob/proc/stat_strength_check()
	return FALSE

/mob/proc/base_strength_check()
	return FALSE

/mob/living/stat_strength_check()
	return FALSE

/mob/living/base_strength_check()
	return FALSE

/mob/living/carbon/stat_strength_check()
	return FALSE

//--------------------------------------------------------//
/mob/living/carbon/human/stat_strength_check(var/difficulty)
	if(!stat_strength) //We have no strength
		return FALSE

	if(stat_strength > difficulty)
		return TRUE
	else
		return FALSE

//--------------------------------------------------------//
/mob/living/carbon/human/base_strength_check(var/difficulty)
	if(!species.base_strength)
		return FALSE

	if(species.base_strength >= difficulty)
		return TRUE
	else
		return FALSE

//TODO: More Stats, More Integrations.
