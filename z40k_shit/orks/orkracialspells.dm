/spell/waaagh1	//Slime people
	name = "Waaagh!"
	abbreviation = "RL"
	desc = "WAAAGH!."
	panel = "Racial Abilities"
	override_base = "racial"
	hud_state = "racial_waagh"
	spell_flags = INCLUDEUSER
	charge_type = Sp_RECHARGE
	charge_max = 100
	range = SELFCAST
	cast_sound = 'z40k_shit/sounds/waagh1.ogg'
	still_recharging_msg = "<span class='notice'>You're still regaining your strength.</span>"

/spell/waaagh1/cast(list/targets, mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.movement_speed_modifier += 0.5

/spell/waaagh1/stop_casting(list/targets, mob/user)
	var/mob/living/carbon/human/H = user
	H.movement_speed_modifier -= 0.5

/spell/waaagh1/choose_targets(mob/user = usr)
	var/list/targets = list()
	targets += user
	return targets

/spell/waaagh1/is_valid_target(var/target, mob/user, options)
	return(target == user)

/spell/warbosswaaagh
	name = "Waaagh!"
	abbreviation = "RL"
	desc = "WAAAGH!."
	panel = "Racial Abilities"
	override_base = "racial"
	hud_state = "racial_waagh"
	spell_flags = INCLUDEUSER
	charge_type = Sp_RECHARGE
	charge_max = 100
	range = SELFCAST
	cast_sound = 'z40k_shit/sounds/warbosswaaagh.ogg'
	still_recharging_msg = "<span class='notice'>You're still regaining your strength.</span>"

/spell/waaagh1/cast(list/targets, mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
