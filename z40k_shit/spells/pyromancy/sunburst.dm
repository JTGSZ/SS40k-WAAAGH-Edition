/spell/aoe_turf/sunburst
	name = "Sunburst"
	desc = "Witchfire (Nova) - Erupt into a firenova."
	abbreviation = "SBST"

	specialization = PYROMANCY
	user_type = USER_TYPE_PSYKER

	charge_type = Sp_RECHARGE
	charge_max = 5 MINUTES
	invocation_type = SpI_NONE
	range = 3
	spell_flags = STATALLOWED
	cooldown_min = 5 MINUTES

	hud_state = "sunburst"

/spell/aoe_turf/sunburst/choose_targets(var/mob/user = usr)

	var/list/targets = list()

	for(var/mob/living/carbon/C in view(user, 3))
		if(C == user)
			continue
		if(ishuman(C))
			targets += C

	return targets

/spell/aoe_turf/sunburst/cast(var/list/targets, var/mob/user)
	user.vis_contents += new /obj/effect/overlay/sunburst(user,10)
	for(var/mob/living/AUGH in targets)
		to_chat(AUGH, "<span class='danger'><font size='3'>You are engulfed by brilliant warp flames!</font></span>")
		AUGH.fire_stacks += 10
		AUGH.adjustFireLoss(30)


