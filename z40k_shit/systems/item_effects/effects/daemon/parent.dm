/datum/item_artifact/daemon_effect
	name = "Daemon Effect"
	desc = "Literally the essence of a daemon. Handle with caution, it will probably try to utterly destroy you."
	charge = 0
	max_uses = -1
	uses = 1
	trigger = IE_EQP
	compatible_mobs = list(/mob/living/carbon)
	var/datum/item_power/item_power
	var/datum/passive_effect/passive_effect
	var/mob/living/carbon/target
	var/mob/living/simple_animal/shade/spirit
	var/obj/item/myitem
	var/chaosgod

/datum/item_artifact/daemon_effect/item_act(var/mob/living/M)
	if(target != M)
		item_power.init_mob(M)
		src.target = M
		to_chat(target, "<font color=\"purple\"> <i><b>Hello. You are in fact now bound to my will. Serve [chaosgod].</i></b></font>")

/datum/item_artifact/daemon_effect/item_init(var/obj/item/O)
	..()
	myitem = O
	if(!chaosgod)  //Make these things randomize
		chaosgod = pick("nurgle","tzeench","khorne","slaanesh")
	if(!item_power)
		var/path = pick(/datum/item_power/phase,/datum/item_power/hulk,/datum/item_power/dodge,/datum/item_power/tele)
		item_power = new path
	if(!passive_effect)
		var/path = pick(/datum/passive_effect/unstunnable,/datum/passive_effect/regen,/datum/passive_effect/immunity,/datum/passive_effect/speed)
		passive_effect = new path
	item_power.init(O)
	spirit = new /mob/living/simple_animal/shade(O.loc)
	spirit.loc = O //put shade in object
	spirit.status_flags |= GODMODE //So they won't die inside the stone somehow
	spirit.canmove = 0//Can't move out of the object
	spirit.item = O
	var/shadename
	switch(chaosgod)
		if("nurgle")
			shadename = "plague bearer"
		if("khorne")
			shadename = "bloodletter"
		if("tzeench")
			shadename = "horror of tzeench"
		if("slaanesh")
			shadename = "daemonette"
	spirit.name = shadename
	spirit.real_name = shadename
	spirit.key = null //Need to find a ghost.
	var/list/candidates = get_candidates(BE_TRAITOR)
	if(candidates.len)
		var/client/C = pick_n_take(candidates)
		spirit.key = C.key
	spirit.verbs.Add(/mob/living/simple_animal/shade/proc/healbearer,/mob/living/simple_animal/shade/proc/harmbearer,/mob/living/simple_animal/shade/proc/showbearer,/mob/living/simple_animal/shade/proc/telepathbearer)
	//Shade should have the power to use the weapon as if clicking for the player. Technically you could hold a daemon weapon in your off hand and a regular one in your main one and both would fire simulatenously if the daemon handled one.
	//Note that this also means the daemon can make the weapon attack itself.
	//Daemon also may heal/destun target player, telepath with them, and harm them.
	spawn()
		src.passive()

/datum/item_artifact/daemon_effect/proc/passive()
	set background = BACKGROUND_ENABLED
	while(1)
		sleep(20)
		if(target)
			passive_effect.runmob(src.target)
			if(prob(5)) //Some background automated messaging in case we didn't find a shade or just to improve the general roleplay of these.
				var/message = ""
				switch(pick(1,2,3,4,5,6,7))
					if(1)
						message = "Praise [chaosgod]."
					if(2)
						message = "Kill..."
					if(3)
						message = "Send more souls to [chaosgod]."
					if(4)
						switch(chaosgod)
							if("khorne")
								message = "BLOOD FOR THE BLOOD GOD! SKULLS FOR THE SKULL THRONE!"
							if("slaanesh")
								message = "SHOW THE UNBELIEVERS PAIN"
							if("tzeench")
								message = "Tzeench grants you sight."
							if("nurgle")
								message = "Nurgle loves us..."
					if(5)
						switch(chaosgod)
							if("khorne")
								message = "KILL! MAIM! BURN!"
							if("slaanesh")
								message = "Slaanesh thirsts for their souls..."
							if("tzeench")
								message = "You are part of Tzeench's plan."
							if("nurgle")
								message = "Spread nurgle's blessings!"
					if(6)
						message = "This world must burn..."
					if(7)
						message = "Destroy those who do not know [chaosgod]."
				to_chat(target, "<font color=\"purple\"> <i><b>[message]</i></b></font>")
				to_chat(spirit, "The item projects '[message]' to [target.name].")
			if(prob(10))
				for(var/mob/living/carbon/person in viewers(get_turf(myitem)))
					if(person!=target)
						if(person.mind.special_role != "Cultist" & person.mind.special_role != "Changeling") //Don't want to attack one of your own kind...
							to_chat(target, "<font color=\"purple\"> <i><b>Kill [person.name].</i></b></font>")
							to_chat(spirit, "The item projects 'Kill [person.name].' to [target.name].")