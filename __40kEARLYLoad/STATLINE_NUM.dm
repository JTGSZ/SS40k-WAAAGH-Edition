
//See: human.dm: Line 1174 for where we stick species base attributes onto the mob.
//How it will be done.
//Basically theres the attribute itself, which is given from our base starting val located in species.
//To increase the attribute you do an action that uses a check of the attribute.
//The amount the attribute builds to the next level depends on the action difficulty.

//Basically we are going to have stat increases on a cooldown.

#define ATTR_STRENGTH 		"strength"
#define ATTR_AGILITY 		"agility"
#define ATTR_DEXTERITY 		"dexterity"
#define ATTR_CONSTITUTION 	"constitution"
#define ATTR_WILLPOWER		"willpower"
#define ATTR_SENSITIVITY	"sensitivity"

/mob/living
	var/stat_increase_cooldown = FALSE
/*
	Strength
				*/
//What strength is is basically raw muscle man.
//Strength determines force additions in melee(1.5x), and active blocking success chances.
/*

*/
	var/attribute_strength = 1
	var/attribute_strength_natural_limit = 1
	var/attribute_strength_trained_integer = 1

/*
	Agility
			*/
//What agility is is basically how fast something can move.
//Agility determines speed, also partially covers reactions.
//Some movespeed and Parrying and deflecting.
	var/attribute_agility = 1
	var/attribute_agility_natural_limit = 1
	var/attribute_agility_trained_integer = 1
/*
	Dexterity
				*/
//What dexterity is is basically how well something can manipulate things.
//Dexterity also covers reactions. Aka Parrying and Deflecting
	var/attribute_dexterity = 1
	var/attribute_dexterity_natural_limit = 1
	var/attribute_dexterity_trained_integer = 1
/*
	Constitution
				*/
//Constitution is basically how durable something is
//It covers additions to our total health amount (+10 per lvl)
//We train it by doing painful things, or recovering from injuries.
/*Appends: 

*/
	var/attribute_constitution = 1
	var/attribute_constitution_natural_limit = 1
	var/attribute_constitution_trained_integer = 1
/*
	Willpower
				*/
//Willpower is basically how much resistance we have to magic shit.
//Also how strong we can cast.
	var/attribute_willpower = 1
	var/attribute_willpower_natural_limit = 1
	var/attribute_willpower_trained_integer = 1
/*
	Sensitivity
				*/
//Sensitivity is basically how much LESS resistance we have to magic shit.
//Also how strong we can cast.
	var/attribute_sensitivity = 1
	var/attribute_sensitivity_natural_limit = 1
	var/attribute_sensitivity_trained_integer = 1