

//See: human.dm: Line 1174 for where we stick species base stats onto the mob.

//Yes, we have stats. Strength doesn't do much atm.
//It also helps me do some inhand objects that are large with awkward positions.
//Its mostly stat_strength because theres too many vars in the codebase that are already named strength.
//What I will do is I will make the probability proc and everything here, mostly so.
//There is a central location to train up the stat itself.


/*
	DESIGN AS OF 3/5/2020
							*/
/*
	Range - 1 to 30
	Natural Range - 1 to 20
	Normal range - 4 to 12

----Stats Currently Active--- 
	Strength

*/

/*
	STRENGTH
			*/
/*
Basically we return TRUE or FALSE when called, this proc is a appended check.
---Variables----
attribute_strength - Contained on the mob itself, dynamic built strength. Starting at species core strength.
base_strength - Contained on the species datum, starting core strength. Transferred to stat strength.

attribute_strength_check(var/difficulty) - a check of the dynamic strength stat. Which can be raised.
base_strength_check(var/difficulty) - a check of the latent species strength. 
						Used to check for strong body icon template.

*/
/mob/proc/basic_dyn_strength_check()
	return FALSE

/mob/proc/basic_species_strength_check()
	return FALSE

/mob/living/basic_dyn_strength_check()
	return FALSE

/mob/living/basic_species_strength_check()
	return FALSE

/mob/living/carbon/basic_dyn_strength_check()
	return FALSE

//--------------------------------------------------------//
/mob/living/carbon/human/basic_dyn_strength_check(var/difficulty)
	if(!attribute_strength) //We have no strength
		return FALSE

	if(attribute_strength > difficulty)
		return TRUE
	else
		return FALSE

//--------------------------------------------------------//
/mob/living/carbon/human/basic_species_strength_check(var/difficulty)
	if(!species.base_strength)
		return FALSE

	if(species.base_strength >= difficulty)
		return TRUE
	else
		return FALSE


/*
	Relevant Species Max Table
								*/
/* Species		|Strength|Agility|Dexterity|Constitution|Willpower|Warp Sensitivity|Total:

	Ork Warboss		20		14		14			20			16		120					84
	Ork Nob			16		13		11			17			12		50					68
	Ork				13		12		11			14			8		10					58

	Human			12		12		12			12			12		1000				60

	Space Marine	15		14		16			15			14		1000				74
*/
//Cooldown variable is known as : stat_increase_cooldown.
//Gameplan:
//Basically we have a minimum probability for a stat to increase as long as we are within natural limits of a species.
//The closer we get to the maximum cap the lower the probability modifier gets.
//After that we will swap to a static value before it unlocks a probability modifier for the next tier.
/mob/living/proc/stat_increase(var/chosen_attribute, var/attr_trained_value)
	//if(stat_increase_cooldown > world.time)
	//	return 0
	//Probability our stat increases
	var/increase_probability
	//localvar to dictate we already entered a check... to cut down on checks

	//parameter input variable
	switch(chosen_attribute)
		if(ATTR_STRENGTH) //Maximum cap 20
			attribute_strength_trained_integer += attr_trained_value
			if(attribute_strength <= attribute_strength_natural_limit) //If our stat is lesser than the natural limit
				if(attribute_strength <= attribute_strength_natural_limit-4) //If we are still lesser than 4 away from cap
					increase_probability = round(1+attribute_strength_trained_integer/100) //increased probability + rounded number(amount we trained to 1000 divided by 100)
				if(attribute_strength <= attribute_strength_natural_limit-10) //If we are still lesser than 10 away from cap
					increase_probability = round(10+attribute_strength_trained_integer/50)
			else
				if(attribute_strength_trained_integer >= 800) //If we have trained up greater than or equal to 800
					increase_probability = 2
					if(attribute_strength_trained_integer >= 1000) //If we are over 1000
						increase_probability += 3 //Add another 2
			if(prob(increase_probability)) //If we hit the probability
				attribute_strength += 1 //Increase our strength by 1
				to_chat(src,"You feel stronger.")
				attribute_strength_trained_integer = 0 //Set strength trained integer to nothing
				return 1 //Return true
			else
				return 0
		if(ATTR_AGILITY) //Maximum cap 20
			attribute_agility_trained_integer += attr_trained_value
			if(attribute_agility <= attribute_agility_natural_limit) //If our stat is lesser than the natural limit
				if(attribute_agility <= attribute_agility_natural_limit-4) //If we are still lesser than 4 away from cap
					increase_probability = round(1+attribute_agility_trained_integer/100) //increased probability + rounded number(amount we trained to 1000 divided by 100)
				if(attribute_agility <= attribute_agility_natural_limit-10) //If we are still lesser than 10 away from cap
					increase_probability = round(10+attribute_agility_trained_integer/50)
			else
				if(attribute_agility_trained_integer >= 800) //If we have trained up greater than or equal to 800
					increase_probability = 2
					if(attribute_agility_trained_integer >= 1000) //If we are over 1000
						increase_probability += 3 //Add another 2
			if(prob(increase_probability))
				attribute_agility += 1
				to_chat(src,"You feel a bit faster.")
				attribute_agility_trained_integer = 0
				return 1
			else
				return 0
		if(ATTR_DEXTERITY) //Maximum cap 20
			attribute_dexterity_trained_integer += attr_trained_value
			if(attribute_dexterity <= attribute_dexterity_natural_limit) //If our stat is lesser than the natural limit
				if(attribute_dexterity <= attribute_dexterity_natural_limit-4) //If we are still lesser than 4 away from cap
					increase_probability = round(1+attribute_dexterity_trained_integer/100) //increased probability + rounded number(amount we trained to 1000 divided by 100)
				if(attribute_dexterity <= attribute_dexterity_natural_limit-10) //If we are still lesser than 10 away from cap
					increase_probability = round(10+attribute_dexterity_trained_integer/50)
			else
				if(attribute_dexterity_trained_integer >= 800) //If we have trained up greater than or equal to 800
					increase_probability = 2
					if(attribute_dexterity_trained_integer >= 1000) //If we are over 1000
						increase_probability += 3 //Add another 2
			if(prob(increase_probability))
				attribute_dexterity += 1
				to_chat(src,"Your coordination seems better.")
				attribute_dexterity_trained_integer = 0
				return 1
			else
				return 0
		if(ATTR_CONSTITUTION) //Maximum cap 20
			attribute_constitution_trained_integer += attr_trained_value
			if(attribute_constitution <= attribute_constitution_natural_limit) //If our stat is lesser than the natural limit
				if(attribute_constitution <= attribute_constitution_natural_limit-4) //If we are still lesser than 4 away from cap
					increase_probability = round(1+attribute_constitution_trained_integer/100) //increased probability + rounded number(amount we trained to 1000 divided by 100)
				if(attribute_constitution <= attribute_constitution_natural_limit-10) //If we are still lesser than 10 away from cap
					increase_probability = round(10+attribute_constitution_trained_integer/50)
			else
				if(attribute_constitution_trained_integer >= 800) //If we have trained up greater than or equal to 800
					increase_probability = 2
					if(attribute_constitution_trained_integer >= 1000) //If we are over 1000
						increase_probability += 3 //Add another 2		
			if(prob(increase_probability))
				attribute_constitution += 1
				to_chat(src,"You feel tougher.")
				maxHealth += 10
				health += 10
				attribute_constitution_trained_integer = 0
				return 1
			else
				return 0
		if(ATTR_WILLPOWER) //Maximum cap 20
			attribute_willpower_trained_integer += attr_trained_value
			if(attribute_willpower <= attribute_willpower_natural_limit) //If our stat is lesser than the natural limit
				if(attribute_willpower <= attribute_willpower_natural_limit-4) //If we are still lesser than 4 away from cap
					increase_probability = round(1+attribute_willpower_trained_integer/100) //increased probability + rounded number(amount we trained to 1000 divided by 100)
				if(attribute_willpower <= attribute_willpower_natural_limit-10) //If we are still lesser than 10 away from cap
					increase_probability = round(10+attribute_willpower_trained_integer/50)
			else
				if(attribute_willpower_trained_integer >= 800) //If we have trained up greater than or equal to 800
					increase_probability = 2
					if(attribute_willpower_trained_integer >= 1000) //If we are over 1000
						increase_probability += 3 //Add another 2				
			if(prob(increase_probability))
				attribute_willpower += 1
				to_chat(src,"You feel more willful.")
				attribute_willpower_trained_integer = 0
				return 1
			else
				return 0
		if(ATTR_SENSITIVITY) //Maximum cap 1000
			attribute_sensitivity_trained_integer += attr_trained_value
			if(attribute_sensitivity <= attribute_sensitivity_natural_limit) //If our stat is lesser than the natural limit
				if(attribute_sensitivity_trained_integer >= 800) //If we have trained up greater than or equal to 800			
					attribute_sensitivity += 5
					to_chat(src,"You feel more in touch with reality.")
					attribute_sensitivity_trained_integer = 0
					return 1
				else
					return 0
			else
				return 0

	//stat_increase_cooldown = world.time + 50

