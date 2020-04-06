/spell/targeted/haemorrage
	name = "Haemorrage"
	desc = "Witchfire(Profileless) - Tests the targets constitution by boiling their blood, If they fail it will spread to another."
	abbreviation = "HMG"
	user_type = USER_TYPE_PSYKER
	specialization = BIOMANCY
	school = "transmutation"
	charge_max = 600
	spell_flags = WAIT_FOR_CLICK
	range = 20
	max_targets = 1
	invocation_type = SpI_NONE
	cooldown_min = 200 //100 deciseconds reduction per rank
	hud_state = "haemorrhage"

/spell/targeted/haemorrage/cast(var/list/targets, mob/user)
	set waitfor = 0
	var/single_check = FALSE //We already pop someone?
	for(var/mob/living/target in targets)
		if(target.attribute_constitution >= 12)
			if(prob(16))
				target.adjustBruteLoss(15)
				to_chat(target, "<span class='danger'> Your blood is boiling inside of your flesh. </span>")
				target.vis_contents += new /obj/effect/overlay/red_radiating(target,10)
				sleep(1 SECONDS)
				if(single_check)
					target.visible_message("<span class='danger'>\The [target] explodes in a burst of scalding blood!</span>")	
					for(var/mob/living/victim in range(2,target))
						if(victim.stat != DEAD)
							targets += victim
					target.gib()
					targets -= target
					sleep(1)
				else if(prob(16))
					target.visible_message("<span class='danger'>\The [target] explodes in a burst of scalding blood!</span>")		
					single_check = TRUE
					for(var/mob/living/victim in range(2,target))
						if(victim.stat != DEAD)
							targets += victim
					target.gib()
					targets -= target
					sleep(1)
				else //We failed here.
					break
			else
				break
		else
			var/con_percent = abs((target.attribute_constitution*6) - 100)
			if(prob(con_percent))
				target.adjustBruteLoss(15)
				to_chat(target, "<span class='danger'> Your blood is boiling inside of your flesh. </span>")
				target.vis_contents += new /obj/effect/overlay/red_radiating(target,10)
				sleep(1 SECONDS)
				if(single_check)
					target.visible_message("<span class='danger'>\The [target] explodes in a burst of scalding blood!</span>")		
					for(var/mob/living/victim in range(2,target))
						if(victim.stat != DEAD)
							targets += victim
					target.gib()
					targets -= target
					sleep(1)
				else if(prob(con_percent))
					target.visible_message("<span class='danger'>\The [target] explodes in a burst of scalding blood!</span>")		
					single_check = TRUE
					for(var/mob/living/victim in range(2,target))
						if(victim.stat != DEAD)
							targets += victim
					target.gib()
					targets -= target
					sleep(1)
				else
					break
			else
				break

