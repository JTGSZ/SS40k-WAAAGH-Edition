/spell/aoe_turf/warbosswaaagh	//Raaagh
	name = "WAAAGH!"
	abbreviation = "WG"
	desc = "Makes ya faster and stronger.(Along with ya boyz)"
	panel = "Racial Abilities"
	override_base = "racial"
	hud_state = "racial_waagh"
	spell_flags = INCLUDEUSER
	charge_type = Sp_RECHARGE
	charge_max = 100
	invocation_type = SpI_NONE
	range = 8
	cast_sound = 'z40k_shit/sounds/waagh1.ogg'
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"

/spell/aoe_turf/warbosswaaagh/cast(list/targets, mob/user)
	for(var/T in targets)
		var/mob/living/carbon/human/H = T
		H.vis_contents += new /obj/effect/overlay/strong_green_circle(H,12 SECONDS)
		H.movement_speed_modifier += 1.0
		H.attribute_strength += 5
		to_chat(H,"Your body courses with power.")
		spawn(12 SECONDS)
			H.attribute_strength -= 5
			H.movement_speed_modifier -= 1.0

	user.say("WAAAAGH!")
	playsound(user, 'z40k_shit/sounds/warbosswaaagh.ogg', 100)

/spell/aoe_turf/warbosswaaagh/choose_targets(var/mob/user = usr)
	var/list/targets = list()
	for(var/mob/living/carbon/C in view(8, user))
		if(isork(C))
			targets += C

	if (!targets.len)
		to_chat(user, "<span class='warning'>There are no targets.</span>")
		return FALSE

	return targets
	