/spell/targeted/terrify
	name = "Terrify"
	desc = "Malediction - Weakens the target and everyone around it."
	abbreviation = "ENF"
	user_type = USER_TYPE_PSYKER
	specialization = SSTELEPATHY
	school = "evocation"
	charge_max = 100
	invocation_type = SpI_NONE
	range = 20
	spell_flags = WAIT_FOR_CLICK
	hud_state = "terrify"

/spell/targeted/terrify/cast(var/list/targets, var/mob/living/user)
	var/terrify_amount = (6+user.attribute_willpower)
	for(var/atom/target in targets)
		for(var/mob/living/carbon/C in view(3, target))
			to_chat(C, "<span class='sinister'>Visions your nightmares, your fears, and your failures assault you.</span>")
			C.movement_speed_modifier -= 1.0
			for(var/i=1 to terrify_amount)
				step(C,get_dir(user,C))

			spawn(12 SECONDS)
				to_chat(C, "<span class='sinister'>The terror leaves your mind, letting you calm yourself.</span>")
				C.movement_speed_modifier += 1.0
