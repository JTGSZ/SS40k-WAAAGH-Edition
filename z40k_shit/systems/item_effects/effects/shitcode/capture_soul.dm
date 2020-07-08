/*
A slaanesh item. Much like a daemon weapon, but this one takes the souls of those it kills inside of itself, not a daemon.
*/

/datum/item_effect/captured_soul
	name = "Captured Soul"
	desc = "The soul of some poor person trapped inside of an object, their psychic energy fueling whatever contraption they are forced into."
	charge = 0
	max_uses = -1
	uses = 1
	trigger = "EQUIP"
	compatible_mobs = list(/mob/living/carbon)
	var/datum/item_power/item_power //Gives a new verb to the user and/or captured soul.
	var/datum/passive_effect/passive_effect //Gives a passive effect that improves the blade or the bearer.
	var/mob/living/carbon/target
	var/mob/living/carbon/victim
	var/mob/living/simple_animal/shade/spirit
	var/obj/item/myitem

/datum/item_effect/captured_soul/item_act(var/mob/living/M)
	if(!M) 
		return
	if(target != M)
		item_power.init_mob(M)
		src.target = M
		to_chat(spirit, "<span class='warning'> The new bearer of your spirit is [M]!</span>")

/datum/item_effect/captured_soul/item_init(var/obj/item/O)
	..()
	myitem = O
	var/active_path = pick(/datum/item_power/phase,/datum/item_power/dodge,/datum/item_power/tele,/datum/item_power/shield)
	item_power = new active_path
	var/passive_path = pick(/datum/passive_effect/unstunnable,/datum/passive_effect/regen,/datum/passive_effect/immunity,/datum/passive_effect/speed)
	passive_effect = new passive_path
	item_power.init(O)
	spirit = new /mob/living/simple_animal/shade(O.loc)
	spirit.loc = O //put shade in object
	spirit.status_flags |= GODMODE //So they won't die inside the stone somehow
	spirit.canmove = 0//Can't move out of the object
	spirit.item = O
	spirit.name = victim.real_name
	spirit.real_name = victim.real_name
	spirit.key = victim.key
	victim.drop_item()
	if(myitem.loc == victim) //Don't want to delete oneself because the victim is holding the blade (in the event of suicide when they have over 100 health and don't immediately fall down dead)
		myitem.loc = get_turf(victim)
	victim.dust()
	spirit.verbs.Add(/mob/living/simple_animal/shade/proc/showbearer,/mob/living/simple_animal/shade/proc/telepathbearer,/mob/living/simple_animal/shade/proc/telepathic_shout,/mob/living/simple_animal/shade/proc/throw_item,/mob/living/simple_animal/shade/proc/healbearer,/mob/living/simple_animal/shade/proc/harmbearer,/mob/living/simple_animal/shade/proc/energize_weapon)
	spawn()
		src.passive()
	
/datum/item_effect/captured_soul/proc/passive()
	set background = BACKGROUND_ENABLED
	while(1)
		sleep(20)
		if(target)
			passive_effect.runmob(src.target)
