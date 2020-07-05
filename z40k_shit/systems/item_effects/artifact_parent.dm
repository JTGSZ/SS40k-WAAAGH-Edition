
//40k MARKED - ITEM_ARTIFACT is the tag for our entries everywhere.
/datum/item_artifact
	var/name = "generic effect"   //Name
	var/desc = "doesn't exist"    //Help text
	var/charge = 0                //How much energy the item uses, in spells determines charge time, in objects determines charge time for infusing the object with a effect.
	var/max_uses = 25             //How many times the effect will activate until it wears off. Set to -1 or 0 for infinite.
	var/uses = 0
	var/trigger = "NOTHING"
	var/list/compatible_mobs = list(/mob/living)

/obj/item
	var/list/item_effects = list()
/mob
	var/list/item_effects = list()

/datum/item_artifact/proc/item_init(var/obj/item/O)    //What the effect does to an object upon laying the curse on it.
	O.item_effects.Add(src)

/datum/item_artifact/proc/item_act(var/mob/living/M) //What the effect does to a human upon laying the curse on the human or activating it from an object.
	M.item_effects.Add(src)

/datum/item_artifact/proc/neutralize_obj(var/obj/item/O)
	O.item_effects.Remove(src)

/datum/item_artifact/proc/neutralize_mob(var/mob/living/M)
	M.item_effects.Remove(src)
	
/*
	Basically these just hand out abilities, they don't normally appear on stuff.
*/
/datum/item_power
	var/name = ""
	var/desc = ""

/datum/item_power/proc/init(var/obj/O)
	return

/datum/item_power/proc/init_mob(var/mob/living/carbon/H)
	return //If it modifies the person.

/*
	This is p extreme shitcode, I'll include a snippit below
*/
//Ex:
/*
	spawn()
		src.passive()
/our/object/proc/passive()
	set background = BACKGROUND_ENABLED
	while(1)
		sleep(20)
		if(target)
			passive_effect.runmob(src.target)
*/
/datum/passive_effect
	var/name = ""
	var/desc = ""

/datum/passive_effect/proc/runmob(var/mob/living/carbon/M)
	return